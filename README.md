# Dotfiles

Personal dotfiles managed with [yadm](https://yadm.io/).

## Quick Start

### macOS

```bash
# Install Homebrew if needed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install packages
brew install yadm neovim tmux zsh ripgrep go python nvm \
  lua-language-server gopls pyright yaml-language-server clang-format \
  prettier black stylua
brew install --cask font-jetbrains-mono ghostty

# Clone dotfiles
yadm clone https://github.com/rsmith8917/dotfiles.git
yadm alt

# Install Oh My Zsh + plugins
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Open neovim to install plugins
nvim
```

### Arch Linux

```bash
# Install packages
pacman -S yadm neovim tmux zsh ripgrep go python nvm wl-clipboard \
  lua-language-server gopls pyright yaml-language-server clang \
  prettier python-black stylua ttf-jetbrains-mono ghostty

# Clone dotfiles
yadm clone https://github.com/rsmith8917/dotfiles.git
yadm alt

# Install Oh My Zsh + plugins
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Open neovim to install plugins
nvim
```

## What's Included

- **neovim** - LSP, autocompletion, telescope, treesitter
- **tmux** - Vim-style navigation, system clipboard integration
- **zsh** - Oh My Zsh with autosuggestions and syntax highlighting
- **ghostty** - Terminal config with TokyoNight theme
