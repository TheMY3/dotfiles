# Dotfiles

Personal dotfiles managed with GNU Stow.

## Quick Install

```bash
cd ~/dotfiles-new
stow zshrc kitty nvim starship icons themes
```

## Packages

| Package | Description | Stow |
|---------|-------------|------|
| `zshrc` | Zsh config with aliases | `stow zshrc` |
| `kitty` | Kitty terminal config | `stow kitty` |
| `nvim` | Neovim config | `stow nvim` |
| `starship` | Starship prompt | `stow starship` |
| `icons` | Sweet-cursors | `stow icons` |
| `themes` | Orchis-dark GTK theme | `stow themes` |

## Theme Sources

| Theme | Source |
|-------|--------|
| Orchis-dark | https://github.com/vinceliuice/Orchis-theme |
| Colloid-Dark (icons) | https://github.com/vinceliuice/Colloid-gtk-theme |
| Sweet-cursors | https://github.com/EliverLara/Sweet |
| `ideavim` | IdeaVim config | `stow ideavim` |
| `claude` | Claude Code settings | `stow claude` |
| `backgrounds` | Wallpapers | `stow backgrounds` |

## ML4W Overrides

ML4W doesn't work with stow (directories already exist). Use copy instead:

```bash
cp -r ~/dotfiles-new/ml4w-overrides/.config/* ~/.config/
```

Then in ML4W Settings select:
- Monitors → `my.conf`
- Keybindings → `my.conf`

See [ml4w-overrides/README.md](ml4w-overrides/README.md) for details.

## After Fresh Install

1. Install stow packages:
   ```bash
   cd ~/dotfiles-new
   stow zshrc kitty nvim starship icons themes
   ```

2. Copy ML4W overrides:
   ```bash
   cp -r ~/dotfiles-new/ml4w-overrides/.config/* ~/.config/
   ```

3. Apply GTK settings:
   ```bash
   gsettings set org.gnome.desktop.interface gtk-theme 'Orchis-dark'
   gsettings set org.gnome.desktop.interface cursor-theme 'Sweet-cursors'
   ~/.config/hypr/scripts/gtk.sh
   ```

4. Select variations in ML4W Settings
