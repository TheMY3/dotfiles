# ML4W Overrides

Custom settings for ML4W dotfiles. After ML4W update, copy these files to restore customizations.

## Quick restore

```bash
cp -r ~/dotfiles-new/ml4w-overrides/.config/* ~/.config/
```

## After restore

Select `my.conf` in ML4W Settings → Keybindings.

Note: Hyprland doesn't follow symlinks, so use `cp` not `ln -s`.

## Note: .zshrc

ML4W overwrites `~/.zshrc` on fresh install. Restore via stow:
```bash
cd ~/dotfiles-new && stow zshrc
```

## Files

### `.config/hypr/conf/custom.conf`
Hyprland customizations (auto-loaded by ML4W):
- Keyboard layout us,ru with Alt+Shift toggle
- Caps Lock as Escape
- Hyprshade blue-light-filter on startup

### `.config/hypr/conf/monitors/my.conf`
Monitor variation (select in ML4W Settings → Monitors):
- eDP-1, 1920x1080@60, scale 1

### `.config/hypr/conf/keybindings/my.conf`
Custom keybindings (select in ML4W Settings → Appearance → Keybindings):
- Ctrl+D — open app launcher
- Print — instant fullscreen screenshot (save + clipboard)
- Shift+Print — instant area screenshot (save + clipboard)

### `.config/ml4w/settings/dock-disabled`
Empty file - disables nwg-dock-hyprland (bottom dock panel)

### `.config/ml4w/settings/waybar-theme.sh`
Waybar theme: `ml4w-modern` (16px font instead of 14px in ml4w-glass)

### `.config/ml4w/settings/browser.sh`
Default browser: `google-chrome`

### `.config/hypr/hyprpaper.conf`
Wallpaper: `~/.config/backgrounds/girl.jpg`
