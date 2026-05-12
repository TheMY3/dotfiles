# Dotfiles

Personal dotfiles managed with GNU Stow. Multi-platform: macOS + Fedora/Hyprland.

## Structure

```
common/   # cross-platform: zshrc, vim, ideavim, git, kitty, nvim, starship, claude
linux/    # Linux/Hyprland-only: hyprland, hyprshade, gtk, themes, icons, backgrounds, ml4w-overrides
mac/      # macOS-specific: Brewfile, aerospace, sketchybar
```

## Install — macOS

```bash
git clone <repo> ~/dotfiles && cd ~/dotfiles

# 1. Install brew packages (stow, claude-code, peon-ping, ...)
brew bundle --file=mac/Brewfile

# 2. Remove default Mac dotfiles that conflict with stow
rm -f ~/.claude/settings.json   # default {"theme":"dark"}, replace with our config

# 3. Stow common packages
cd common && stow -t ~ claude
# add more as you need them: zshrc git ideavim kitty nvim starship vim

# 4. Stow macOS-only packages (window manager + status bar)
cd ../mac && stow -t ~ aerospace sketchybar

# 5. Start aerospace + sketchybar (or just log out / in)
open -a AeroSpace
brew services start sketchybar

# 6. Install peon-ping hooks + Russian sound pack only
peon-ping-setup --packs=peon_ru
```

After step 6, `peon-ping-setup` may rewrite hook paths in `settings.json` to absolute `/Users/...` paths. To restore portable `~/...` paths:
```bash
git -C ~/dotfiles checkout common/claude/.claude/settings.json
```

## Install — Linux (Fedora + ML4W)

```bash
cd ~/dotfiles

# 1. Stow cross-platform
cd common && stow -t ~ zshrc vim ideavim git kitty nvim starship claude

# 2. Stow Linux-only
cd ../linux && stow -t ~ hyprshade gtk themes icons backgrounds

# 3. ML4W overrides (can't stow — directories already exist)
cp -r ~/dotfiles/linux/ml4w-overrides/.config/* ~/.config/

# 4. Apply GTK + cursor
gsettings set org.gnome.desktop.interface gtk-theme 'Orchis-dark'
gsettings set org.gnome.desktop.interface cursor-theme 'Sweet-cursors'
~/.config/hypr/scripts/gtk.sh

# 5. peon-ping (install via curl from peonping.com)
```

In ML4W Settings select: Monitors → `my.conf`, Keybindings → `my.conf`, Windows → `my.conf`.

## Packages — common/

| Package | Description | Target |
|---------|-------------|--------|
| `claude` | Claude Code settings, statusline, ccstatusline | `~/.claude/`, `~/.config/ccstatusline/` |
| `git` | Git config | `~/.gitconfig` |
| `ideavim` | IdeaVim config | `~/.ideavimrc` |
| `kitty` | Kitty terminal | `~/.config/kitty/` |
| `nvim` | Neovim + Lazy plugins | `~/.config/nvim/` |
| `starship` | Starship prompt (Nord) | `~/.config/starship.toml` |
| `vim` | Vim config | `~/.vimrc` |
| `zshrc` | Zsh + aliases | `~/.zshrc` |

## Packages — mac/

| Package | Description | Target |
|---------|-------------|--------|
| `aerospace` | [AeroSpace](https://github.com/nikitabobko/AeroSpace) tiling window manager config | `~/.config/aerospace/` |
| `sketchybar` | [SketchyBar](https://github.com/FelixKratz/SketchyBar) status bar, vendored from [forteleaf/sketkchybar-with-aerospace](https://github.com/forteleaf/sketkchybar-with-aerospace) (Catppuccin palette; cpu/weather/wifi/svim modules disabled — re-enable in `sketchybarrc` after compiling the helper / adding API config) | `~/.config/sketchybar/` |

## Packages — linux/

| Package | Source |
|---------|--------|
| `backgrounds` | wallpapers |
| `gtk` | GTK 3.0 settings + bookmarks |
| `hyprland` | Hyprland scripts (gtk.sh) |
| `hyprshade` | Custom blue-light shader |
| `icons` | [Sweet-cursors](https://github.com/EliverLara/Sweet) |
| `themes` | [Orchis-dark](https://github.com/vinceliuice/Orchis-theme) |
| `ml4w-overrides` | ML4W variations (copy, not stow — see [linux/ml4w-overrides/README.md](linux/ml4w-overrides/README.md)) |
