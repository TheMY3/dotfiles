## Installed packages

### Pacman
- pacman-contrib
- unzip zip tar
- httpie
- wl-clipboard
- fontconfig
- man
- wget
- thunar
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
- wf-recorder
- grim
- slurp
- swappy
- imv
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
- polkit-gnome

### AUR
- clipman
- 1password
- sublime-text-4
- polkit
- phpstorm
- postman-bin
- dropbox
- beekeeper-studio-bin
- lens-bin
- slack-desktop
- google-chrome
- twitch-cli-bin
- swaync
- pamac-aur (optional)

### Flatpak
- ticktick
- birdtray


## Some hints

##### Howdy config
```shell
device_path="/dev/video2"
dark_threshold = 90
certainty = 4
timeout = 5
```

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

##### [Notification Control Center Shortcuts](https://github.com/ErikReider/SwayNotificationCenter#control-center-shortcuts)
```
Up/Down: Navigate notifications
Home: Navigate to the latest notification
End: Navigate to the oldest notification
Escape/Caps_Lock: Close notification panel
Return: Execute default action or close notification if none
Delete/BackSpace: Close notification
Shift+C: Close all notifications
Shift+D: Toggle Do Not Disturb
Buttons 1-9: Execute alternative actions
Left click button / actions: Activate notification action
Right click notification: Close notification
```

## Useful links

- https://www.fosskers.ca/en/blog/wayland
- https://shibumi.dev/posts/my-way-to-wayland/
