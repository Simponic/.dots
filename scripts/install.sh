#!/bin/sh
# after archinstall...

USER=lizzy
MACHINE_ZSH=~/scripts/machine-specific-zsh/$(hostname).zsh

# Some packages
sudo pacman -S git emacs vim \
  networkmanager firefox alacritty zsh \
  sway inetutils playerctl rustup tmux \
  openssl-1.1 bluez bluez-utils wget \
  base-devel dunst wofi noto-fonts-emoji \
  light brightnessctl pass

# rustup
rustup default stable

# Submodules - zsh stuff and pikaur
git submodule init
git submodule sync

# pikaur
cd ~/src/pikaur
makepkg -si
cd ~

# AUR packages
pikaur -S xremap-x11-bin spotify-tui-bin \
  betterdiscord-installer-bin discord obs-studio \
  nerd-fonts-cozette-ttf ttf-font-awesome

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

# Wallpapers
mkdir Wallpapers && cd Wallpapers
wget "https://github.com/FrenzyExists/wallpapers/raw/main/Gruv/gruv-temple.png"
wget "https://e0.pxfuel.com/wallpapers/885/812/desktop-wallpaper-i3-gaps-gruvbox-arch-love-r-unixporn.jpg"
wget "https://github.com/FrenzyExists/wallpapers/blob/main/Anime/anime-coffee-girl.jpg?raw=true"
wget -U "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)"  "https://wallpapers.com//images/hd/celeste-madeline-strawberry-2o1vy9t0faa9vwm0.jpg"

cd ..

# Setup asdf-vm, thefuck
pikaur -S asdf-vm thefuck
echo ". /opt/asdf-vm/asdf.sh" >> $MACHINE_ZSH
echo "eval \$(thefuck --alias)" >> $MACHINE_ZSH

# Now, generate ssh key
ssh-keygen -t ed25519

echo "Now, you still need to:"
echo "  . Import your GPG key and --edit-key with ultimate trust"
echo "  . pass --init <gpg-key-id>"
echo "  . Setup spotify-tui with client id from spotify.com"
echo "  . Put spotify password in `pass insert spotify` for spotifyd"
echo "  . Login to firefox"
echo "  . Put ssh key into GitHub, change remote origin in ~"
