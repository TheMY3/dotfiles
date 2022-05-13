## Installed packages

### Pacman
- ????? - noto-fonts-emoji ttf-fira-code
- pacman-contrib
- fontconfig
- man
- wget
- ranger
- flatpak
- thunderbird
- pulseaudio-bluetooth bluez bluez-utils blueman
- alacritty kitty
- zsh zsh-history-substring-search zsh-syntax-highlighting
- udisks2 udiskie
- rsync
- jq
- light
- pavucontrol
- gtk2
- pcsclite
- grim slurp swappy imv
- vim neovim
- powerline powerline-fonts
- npm yarn
- xorg-xwayland
- gnome-keyring
- openssh
- keybase keybase-gui
- dunst
- github-cli
- docker docker-compose
- ansible
- terraform
- python-gobject playerctl
- php php-intl php-sqlite xdebug composer

### AUR
- 1password
- sublime-text-4
- polkit
- phpstorm
- dropbox
- beekeeper-studio-bin
- lens-bin
- slack-desktop
- google-chrome
- twitch-cli-bin
- pamac-aur (optional)

### Flatpak
- ticktick
- birdtray


## Some hints

##### Suspend on Power-off button
```shell
nvim /etc/systemd/logind.conf
```
Uncomment:
```shell
HandlePowerKey=suspend
```

##### Clear cache after fonts changes
```shell
fc-cache -f
```
