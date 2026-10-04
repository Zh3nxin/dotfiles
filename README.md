# Dotfiles

My macOS configuration: Zsh + Catppuccin/Powerlevel10k, Ghostty, AeroSpace,
Borders, tmux, Neovim (LazyVim), btop, Zed, and Karabiner.

Files are stored directly in this repository using their normal home-directory
paths. For example, `.zshrc` goes to `~/.zshrc`, and `.config/ghostty/config`
goes to `~/.config/ghostty/config`.

## Set up another MacBook

### 1. Install the apps and shell dependencies

Install [Homebrew](https://brew.sh/) first, then run:

```sh
brew install git antidote zsh-autosuggestions zsh-completions zsh-syntax-highlighting tmux neovim btop fd ripgrep fzf lazygit
brew install FelixKratz/formulae/borders
brew install --cask nikitabobko/tap/aerospace
brew install --cask ghostty font-jetbrains-mono-nerd-font zed karabiner-elements
```

Install Oh My Zsh and tmux's plugin manager if they aren't already present:

```sh
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### 2. Clone and copy the settings

```sh
git clone https://github.com/Zh3nxin/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

The following block backs up existing settings, then copies this snapshot into
your home directory. Run it from the cloned repository:

```sh
backup="$HOME/dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$backup"
for path in .zshrc .zprofile .zsh_plugins.txt .p10k.zsh \
  .p10k-catppuccin-overrides.zsh .zsh .aerospace.toml .tmux.conf \
  .config/ghostty .config/borders .config/btop .config/nvim \
  .config/zed .config/karabiner; do
  if [ -e "$HOME/$path" ] || [ -L "$HOME/$path" ]; then
    mkdir -p "$backup/$(dirname "$path")"
    mv "$HOME/$path" "$backup/$path" || break
  fi
  mkdir -p "$HOME/$(dirname "$path")"
  cp -R "$path" "$HOME/$path" || break
done
```

### 3. Finish setup

- Open a new terminal. Antidote downloads the plugins listed in
  `.zsh_plugins.txt` on first load; the generated `.zsh_plugins.zsh` stays local.
- In tmux, press the backtick prefix followed by **Shift+I** to install plugins.
- Open Neovim and let LazyVim install its plugins; use `:Lazy restore` to apply
  the versions in `lazy-lock.json`.
- Enable Accessibility for AeroSpace and the permissions requested by Karabiner.
- Install the Catppuccin theme/icon extensions in Zed if prompted.
- If Ghostty does not find the font, select `JetBrainsMono Nerd Font` as the
  installed font family in `.config/ghostty/config`.

## Machine-specific settings

These settings come from an Apple Silicon Mac and use `/opt/homebrew` in
`.zprofile`, `.zshrc`, `.aerospace.toml`, and `.config/borders/bordersrc`.
On an Intel Mac, adjust those paths to the output of `brew --prefix`.

AeroSpace assigns workspaces 3–5 to a secondary monitor. Adjust or remove those
assignments for a different display setup. Its app shortcuts expect apps such as
Zen, Discord, VS Code, ChatGPT, and Obsidian to be installed separately.

Karabiner includes Command/Option swaps and keyboard-specific rules. Review them
if the new Mac uses a different keyboard.

## Update the snapshot

Copy changed configuration files back into the matching paths in this repository,
then review and publish:

```sh
git status
git diff
git add <changed-files>
git commit -m "Update dotfiles"
git push
```

On the other Mac, run `git pull` in this repository and repeat the backup/copy
step. These are copies, so changes in your home directory aren't automatically
tracked by Git.

This repository contains configuration only. Credentials, SSH keys, shell
history, caches, generated plugins, and account/session data are excluded.
