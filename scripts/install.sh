#!/bin/sh
# after archinstall...

USER=lizzy
MACHINE_ZSH=~/scripts/machine-specific-zsh/$(hostname).zsh
CURSOR_THEME="Oxygen 19 Pink Blossom"

# Some packages
sudo pacman -S git vim \
  networkmanager firefox alacritty zsh \
  sway inetutils playerctl rustup tmux \
  openssl-1.1 bluez bluez-utils wget \
  base-devel dunst wofi noto-fonts-emoji \
  light brightnessctl pass docker \
  pavucontrol seahorse man xorg xorg-xwayland \
  lxappearance

# rustup
rustup default stable

# Submodules - zsh stuff and pikaur
git submodule init
git submodule sync
git submodule update

# pikaur
cd ~/src/pikaur
makepkg -si
cd ~

# AUR packages
pikaur -S xremap-x11-bin spotify-tui-bin \
  betterdiscord-installer-bin discord obs-studio \
  nerd-fonts-cozette-ttf ttf-font-awesome ttf-cozette \
  waybar swaybg emacs-gcc-wayland-devel-bin swaylock-corrupter

# Copy cursors
sudo cp -r ~/.icons/"$CURSOR_THEME" /usr/share/icons

# xremap
sudo groupadd input
lsmod | grep uinput || echo 'uinput' | sudo tee /etc/modules-load.d/uinput.conf && \
  echo 'KERNEL=="uinput", GROUP="input", MODE="0660"' | sudo tee /etc/udev/rules.d/99-input.rules
sudo usermod -aG input $USER
systemctl enable --user xremap

# spotifyd
pikaur -S spotifyd
systemctl enable --user spotifyd

# chsh to zsh
chsh $USER --shell /bin/zsh

# Docker
sudo systemctl enable --now docker
sudo groupadd docker
sudo usermod -aG docker $USER

# Setup asdf-vm, thefuck
pikaur -S asdf-vm thefuck
echo ". /opt/asdf-vm/asdf.sh" >> $MACHINE_ZSH
echo "eval \$(thefuck --alias)" >> $MACHINE_ZSH

# setup node versions
. /opt/asdf-vm/asdf.sh
asdf plugin add nodejs
asdf install nodejs lts-gallium
asdf global nodejs lts-gallium

# Now, generate ssh key
ssh-keygen -t ed25519

echo "Now, you still need to:"
echo "  . Import your GPG key and --edit-key with ultimate trust"
echo "  . pass --init <gpg-key-id>"
echo "  . Setup spotify-tui with client id from spotify.com"
echo "  . Put spotify password in `pass insert spotify` for spotifyd"
echo "  . Login to firefox"
echo "  . Put ssh key into GitHub, change remote origin in ~"
echo "  . Add waybar config in .config/waybar/local.d"
