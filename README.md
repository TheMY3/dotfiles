# Dotfiles

Personal dotfiles managed with GNU Stow.

## Quick Install

```bash
cd ~/dotfiles
stow zshrc vim ideavim git kitty nvim starship icons themes backgrounds hyprshade claude
```

## Packages

| Package | Description | Stow |
|---------|-------------|------|
| `zshrc` | Zsh config with aliases | `stow zshrc` |
| `vim` | Vim config | `stow vim` |
| `ideavim` | IdeaVim config for JetBrains IDEs | `stow ideavim` |
| `git` | Git config | `stow git` |
| `kitty` | Kitty terminal config | `stow kitty` |
| `nvim` | Neovim config | `stow nvim` |
| `starship` | Starship prompt | `stow starship` |
| `icons` | Sweet-cursors | `stow icons` |
| `themes` | Orchis-dark GTK theme | `stow themes` |
| `claude` | Claude Code settings | `stow claude` |
| `backgrounds` | Wallpapers | `stow backgrounds` |
| `hyprshade` | Custom blue-light-filter-soft shader | `stow hyprshade` |

## Theme Sources

| Theme | Source |
|-------|--------|
| Orchis-dark | https://github.com/vinceliuice/Orchis-theme |
| Colloid-Dark (icons) | https://github.com/vinceliuice/Colloid-gtk-theme |
| Sweet-cursors | https://github.com/EliverLara/Sweet |

## ML4W Overrides

ML4W doesn't work with stow (directories already exist). Use copy instead:

```bash
cp -r ~/dotfiles/ml4w-overrides/.config/* ~/.config/
```

Then in ML4W Settings select:
- Monitors → `my.conf`
- Keybindings → `my.conf`
- Windows → `my.conf`

### ML4W Overrides Contents

| Path | Description |
|------|-------------|
| `hypr/conf/custom.conf` | SSH_AUTH_SOCK, keyboard layout, autostart apps |
| `hypr/conf/keybindings/my.conf` | Super+D launcher, Print screenshots |
| `hypr/conf/monitors/my.conf` | Monitor scale 1 |
| `hypr/conf/windows/my.conf` | Reduced gaps (out=10, in=5) |
| `waybar/modules.json` | Workspaces icons, clock tooltip |
| `waybar/themes/ml4w-modern/*` | Language indicator with border next to clock |
| `ml4w/scripts/ml4w-now-playing` | VISIBLE_MIN=23 |
| `rofi/config.rasi` | 2 columns, no mode-switcher |
| `rofi/colors.rasi` | Nord colors |

See [ml4w-overrides/README.md](ml4w-overrides/README.md) for details.

## After Fresh Install

1. Install stow packages:
   ```bash
   cd ~/dotfiles
   stow zshrc vim ideavim git kitty nvim starship icons themes backgrounds hyprshade claude
   ```

2. Copy ML4W overrides:
   ```bash
   cp -r ~/dotfiles/ml4w-overrides/.config/* ~/.config/
   ```

3. Apply GTK settings:
   ```bash
   gsettings set org.gnome.desktop.interface gtk-theme 'Orchis-dark'
   gsettings set org.gnome.desktop.interface cursor-theme 'Sweet-cursors'
   ~/.config/hypr/scripts/gtk.sh
   ```

4. Select variations in ML4W Settings
