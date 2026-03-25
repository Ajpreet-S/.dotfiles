# Dotfiles

Arch Linux + Hyprland config files.

## Structure

- `.bashrc` — shell entry point, sources everything below
- `.config/shell/aliases.sh` — aliases
- `.config/shell/functions.sh` — shell functions
- `.config/shell/envs/` — API tokens and secrets (**not tracked, recreate manually**)
- `.config/hypr/` — Hyprland
- `.config/kitty/` — terminal
- `.config/nvim/` — editor
- `.config/waybar/` — status bar

## New machine setup

```bash
git clone --bare <repo-url> ~/.dotfiles.git
/usr/bin/git --git-dir="$HOME/.dotfiles.git/" --work-tree="$HOME" checkout
mkdir -p ~/.config/shell/envs  # then add your tokens
source ~/.bashrc
```

## Usage

```bash
dotfiles status
dotfiles add ~/.bashrc
dotfiles commit -m "message"
dotfiles push
```
