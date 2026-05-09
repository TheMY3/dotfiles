# ML4W Overrides

Custom settings for ML4W dotfiles. After ML4W update, copy these files to restore customizations.

## Quick restore

```bash
cp -r ~/dotfiles/ml4w-overrides/.config/* ~/.config/
```

## After restore

Select `my.conf` in ML4W Settings → Keybindings.

Note: Hyprland doesn't follow symlinks, so use `cp` not `ln -s`.

## Note: .zshrc

ML4W overwrites `~/.zshrc` on fresh install. Restore via stow:
```bash
cd ~/dotfiles && stow zshrc
```

## Files

### `.config/hypr/conf/custom.conf`
Hyprland customizations (auto-loaded by ML4W):
- SSH_AUTH_SOCK env variable for ssh-agent
- Keyboard layout us,ru with Alt+Shift toggle
- Caps Lock as Escape
- Touchpad disable while typing
- Hyprshade blue-light-filter on startup

### `.config/hypr/conf/monitors/my.conf`
Monitor variation (select in ML4W Settings → Monitors):
- eDP-1, 1920x1080@60, scale 1

### `.config/hypr/conf/keybindings/my.conf`
Custom keybindings (select in ML4W Settings → Appearance → Keybindings).

#### My Keybindings

| Bind | Action |
|------|--------|
| `Super+D` | App launcher |
| `Super+C` | Calculator |
| `Super+J` | Toggle split (horizontal/vertical) |
| `Super+K` | Swap split (swap windows) |
| `Print` | Screenshot fullscreen (save + clipboard + notify) |
| `Shift+Print` | Screenshot area (save + clipboard + notify) |

#### Sidepad (выдвижная боковая панель)

| Bind | Action |
|------|--------|
| `Super+S` | Init sidepad |
| `Super+Shift+S` | Select sidepad |
| `Super+Ctrl+Right` | Open sidepad |
| `Super+Ctrl+Left` | Hide sidepad |

#### Useful defaults

| Bind | Action |
|------|--------|
| `Super+Return` | Terminal |
| `Super+B` | Browser |
| `Super+E` | File manager |
| `Super+Q` | Kill window |
| `Super+F` | Fullscreen |
| `Super+T` | Toggle floating |
| `Super+V` | Clipboard history |
| `Super+Tab` | Next workspace |
| `Alt+Shift` | Switch keyboard layout |

### `.config/ml4w/settings/dock-disabled`
Empty file - disables nwg-dock-hyprland (bottom dock panel)

### `.config/ml4w/settings/waybar-theme.sh`
Waybar theme: `ml4w-modern` (16px font instead of 14px in ml4w-glass)

### `.config/ml4w/settings/browser.sh`
Default browser: `google-chrome`

### `.config/hypr/hyprpaper.conf`
Wallpaper: `~/.config/backgrounds/girl.jpg`
