#!/usr/bin/env python3
import argparse
import logging
import sys
import signal
import gi
import json
import threading
gi.require_version('Playerctl', '2.0')
from gi.repository import Playerctl, GLib

logger = logging.getLogger(__name__)

cache = {"i": 0, "stopped": True, "text": "Initializing"}

print_thread = None

def wrap_text(text, width, update):
    if len(text) <= width:
        return text
    t = text + " | "
    n = update % len(t)
    return "".join((t[n:] + t[:n])[0:width])

def print_from_cache():
    if cache["stopped"]:
        cache["text"] = "  " + cache["text"] 

    sys.stdout.write(json.dumps(cache) + '\n')
    sys.stdout.flush()

def print_every_second(width, period=1):
    global print_thread

    print_thread = threading.Timer(period, print_every_second, [width, period])
    print_thread.start()

    cache["i"] += 1
    cache["text"] = wrap_text(cache["formattedText"], width, cache["i"])

    print_from_cache()

def save_in_cache(formattedText, player):
    logger.info('Writing output')

    cache["formattedText"] = formattedText
    cache["class"] = f"custom-{player.props.player_name}"
    cache["alt"] = player.props.player_name


def on_play(player, status, manager):
    logger.info('Received new playback status')
    on_metadata(player, player.props.metadata, manager)

def on_metadata(player, metadata, manager):
    logger.info('Received new metadata')
    cache["stopped"] = False
    track_info = ''

    if player.props.player_name == 'spotify' and \
            'mpris:trackid' in metadata.keys() and \
            ':ad:' in player.props.metadata['mpris:trackid']:
        track_info = 'AD PLAYING'
    elif player.get_artist() != '' and player.get_title() != '':
        track_info = '{artist} - {title}'.format(artist=player.get_artist(),
                                                 title=player.get_title())
    else:
        track_info = player.get_title()

    if player.props.status != 'Playing' and track_info:
        cache["stopped"] = True

    save_in_cache(track_info, player)
    print_from_cache()


def on_player_appeared(manager, player, selected_player=None):
    if player is not None and (selected_player is None or player.name == selected_player):
        cache["stopped"] = False
        init_player(manager, player)
    else:
        logger.debug("New player appeared, but it's not the selected player, skipping")


def on_player_vanished(manager, player):
    logger.info('Player has vanished')
    cache["stopped"] = True
    sys.stdout.write('\n')
    sys.stdout.flush()


def init_player(manager, name):
    logger.debug('Initialize player: {player}'.format(player=name.name))
    player = Playerctl.Player.new_from_name(name)
    player.connect('playback-status', on_play, manager)
    player.connect('metadata', on_metadata, manager)
    manager.manage_player(player)
    on_metadata(player, player.props.metadata, manager)


def signal_handler(sig, frame):
    logger.debug('Received signal to stop, exiting')
    cache["stopped"] = True
    print_thread.cancel()
    sys.stdout.write('\n')
    sys.stdout.flush()
    # loop.quit()
    sys.exit(0)


def parse_arguments():
    parser = argparse.ArgumentParser()

    # Increase verbosity with every occurrence of -v
    parser.add_argument('-v', '--verbose', action='count', default=0)

    # Define for which player we're listening
    parser.add_argument('--player')

    parser.add_argument('--width', default=20)
    parser.add_argument('--period', default=1)

    return parser.parse_args()


def main():
    arguments = parse_arguments()

    # Initialize logging
    logging.basicConfig(stream=sys.stderr, level=logging.DEBUG,
                        format='%(name)s %(levelname)s %(message)s')

    # Logging is set by default to WARN and higher.
    # With every occurrence of -v it's lowered by one
    logger.setLevel(max((3 - arguments.verbose) * 10, 0))

    # Log the sent command line arguments
    logger.debug('Arguments received {}'.format(vars(arguments)))

    manager = Playerctl.PlayerManager()
    loop = GLib.MainLoop()

    manager.connect('name-appeared', lambda *args: on_player_appeared(*args, arguments.player))
    manager.connect('player-vanished', on_player_vanished)

    signal.signal(signal.SIGINT, signal_handler)
    signal.signal(signal.SIGTERM, signal_handler)
    signal.signal(signal.SIGPIPE, signal.SIG_DFL)

    for player in manager.props.player_names:
        if arguments.player is not None and arguments.player != player.name:
            logger.debug('{player} is not the filtered player, skipping it'
                         .format(player=player.name)
                         )
            continue

        init_player(manager, player)

    print_every_second(int(arguments.width), float(arguments.period))
    loop.run()


if __name__ == '__main__':
    main()

