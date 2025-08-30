# Dotfiles Setup with Chezmoi

This repository contains your **exact** dotfiles configuration using [Chezmoi](https://chezmoi.io) for managing configuration files across multiple machines (macOS and Linux).

## 📋 Table of Contents

- [Your Exact Configurations](#your-exact-configurations)
- [Quick Start](#quick-start)
- [Features](#features)
- [Structure](#structure)
- [Installation](#installation)
- [Usage](#usage)
- [Customization](#customization)

---

## 🎯 Your Exact Configurations

### Neovim Configuration
- **Framework**: NvChad v2.5 with Lazy.nvim
- **Theme**: Custom with bufferline configuration
- **Plugins**: All your existing plugins and customizations
- **Features**:
  - Custom bufferline with sorting by modification time
  - Pinned buffers support
  - LSP integration
  - Treesitter folding
  - Custom key mappings

### Oh My Zsh Configuration
- **Theme**: Agnoster
- **Plugins**:
  - git
  - dotenv
  - macos
  - ruby
  - rbenv
  - rake
  - bundler
  - docker
  - zsh-syntax-highlighting
  - zsh-autosuggestions
- **Tools Integration**:
  - Google Cloud SDK
  - Jenv (Java)
  - pnpm
  - Pyenv
  - NVM
  - Bun
  - PostgreSQL
  - WezTerm
  - FZF
  - Zoxide
  - Task Master
  - OpenCode

### Yabai Configuration
- **Location**: `~/.config/yabai/yabairc` (correct path)
- **Layout**: BSP (Binary Space Partitioning)
- **Window Management**:
  - 8px padding and gaps
  - Mouse follows focus
  - Alt + drag to move/resize
  - Custom rules for excluded apps
  - Raycast integration for space changes

### Enhanced Tool Configurations
- **Zoxide**: Smarter `cd` with learning capabilities
- **Bat**: Enhanced `cat` with syntax highlighting
- **FZF**: Fuzzy finder with comprehensive integrations

### 1Password Integration
- **API Keys**: OPENAI, CLAUDE (securely managed)
- **Git Credentials**: SSH keys and signing
- **Custom Functions**: op-env, op-secret, op-ssh

---

## 📁 Structure

```
~/.local/share/chezmoi/
├── GUIDE.md                           # 📚 Comprehensive usage guide
├── .chezmoi.toml.tmpl                # Main configuration
├── .chezmoiignore                    # Platform-specific ignores
├── dot_zshrc                         # Your exact .zshrc (Oh My Zsh)
├── dot_zshrc.d/                      # Modular ZSH configs
│   ├── 00-common.zsh                 # Basic settings
│   ├── 10-aliases.zsh.tmpl           # Essential aliases
│   ├── 20-exports.zsh.tmpl           # Environment variables
│   ├── 40-languages/                 # Language-specific configs
│   │   ├── golang.zsh.tmpl
│   │   ├── rust.zsh.tmpl
│   │   └── nodejs.zsh.tmpl
│   ├── 50-tools/                     # Tool-specific configs
│   │   ├── 1password.zsh.tmpl        # 1Password integration
│   │   ├── zoxide.zsh                # Zoxide configuration
│   │   ├── bat.zsh                   # Bat configuration
│   │   └── fzf.zsh                   # FZF configuration
│   └── 60-macos.zsh.tmpl             # macOS-specific
├── dot_config/
│   ├── nvim/                         # Your exact Neovim config
│   │   └── init.lua                  # NvChad setup with customizations
│   └── yabai/                        # Your exact Yabai config
│       └── yabairc                   # Window manager configuration
└── dot_bootstrap/ansible/            # System automation
```

---

## 🚀 Quick Start

### Prerequisites

- [Chezmoi](https://chezmoi.io/install/) installed
- [Git](https://git-scm.com/) installed
- [1Password CLI](https://developer.1password.com/docs/cli/) (optional, for secrets management)

### Installation

1. **Install Chezmoi**
   ```bash
   # macOS
   brew install chezmoi

   # Linux
   curl -sfL https://git.io/chezmoi | sh
   ```

2. **Initialize with your exact config**
   ```bash
   chezmoi init --apply
   ```

3. **Configure 1Password**
   ```bash
   op account add --address YOUR_SUBDOMAIN.1password.com
   ```

4. **Install tools**
   ```bash
   # Install development tools based on your platform
   install-macos-tools  # or install-linux-tools
   ```

---

## 🔧 Features

### Cross-Platform Support
- **macOS**: Homebrew, Yabai, system integrations
- **Linux**: APT, systemd, native tools
- **Conditional Logic**: Automatic OS detection and configuration

### Development Tools
- **Languages**: Go, Rust, Node.js, Python, Ruby, Java
- **Package Managers**: pnpm, yarn, bun, pipenv, poetry
- **Version Managers**: nvm, pyenv, jenv, rbenv
- **Databases**: PostgreSQL, pgAdmin
- **Cloud**: Google Cloud SDK, AWS CLI

### Productivity Tools
- **Editors**: Neovim (NvChad), VS Code
- **Terminal**: WezTerm, iTerm2
- **Git**: Lazygit, GitHub CLI, GitHub Desktop
- **File Managers**: Yazi, Superfile, Ripgrep
- **Window Management**: Yabai (macOS)
- **Search**: Ripgrep, FZF, Zoxide
- **Task Management**: Task Master, Ansible

### Enhanced CLI Tools
- **Zoxide**: Smarter directory navigation
- **Bat**: Syntax-highlighted file viewing
- **FZF**: Fuzzy finding with rich integrations

### Security & Secrets
- **1Password Integration**: Secure API key management
- **SSH Keys**: Automatic key management
- **Git Signing**: GPG commit signing
- **Environment Variables**: Secure credential handling

---

## 🎮 Usage

### Daily Operations

```bash
# Check what files will be changed
chezmoi diff

# Apply changes
chezmoi apply

# Edit a managed file
chezmoi edit ~/.zshrc

# Update from repository
chezmoi update

# Show managed files
chezmoi managed
```

### Enhanced Tool Usage

#### Zoxide (Smart cd)
```bash
z projects        # Go to projects directory
z -i              # Interactive selection
zf                # Find directory with fzf
zp                # Go to project root
```

#### Bat (Enhanced cat)
```bash
bat file.txt      # View with syntax highlighting
batn file.txt     # Show line numbers
batjson data.json # Pretty print JSON
batdiff file.txt  # Show git diff
```

#### FZF (Fuzzy finder)
```bash
fe                # Find and edit file
fv                # Find and view file
fcd               # Find and cd to directory
frg pattern       # Find files with pattern
```

### 1Password Operations

```bash
# Load secrets into environment
op-env "Development"

# Get specific API key
op-secret "OPENAI" "api_key" "OPENAI_API_KEY"

# SSH key management
op-ssh create "my-key"
op-ssh get "my-key"
```

### Neovim Operations

```vim
# Your custom key mappings
<leader>w       # Save file
<leader>q       # Quit
<leader>e       # File explorer
<leader>ff      # Find files
<leader>gg      # LazyGit
gd              # Go to definition
K               # Hover documentation
```

### Yabai Operations (macOS)

```bash
# Your yabai configuration
# Alt + drag to move windows
# Mouse follows focus
# Custom padding and gaps
# Excluded apps: System Settings, Calculator, etc.
```

---

## 🛠️ Customization

### Adding New Tools

1. **Create configuration file**
   ```bash
   chezmoi add ~/.zshrc.d/50-tools/newtool.zsh
   ```

2. **Add platform-specific logic**
   ```bash
   {{ if lookPath "newtool" }}
   # Tool configuration
   {{ end }}
   ```

### Modifying Keybindings

1. **Neovim mappings**
   ```lua
   -- In lua/custom/mappings.lua
   map("n", "<leader>custom", ":CustomCommand<CR>", opts)
   ```

2. **ZSH keybindings**
   ```bash
   # In dot_zshrc.d/10-aliases.zsh.tmpl
   bindkey '^K' custom-function
   ```

### Environment Variables

1. **Add to exports**
   ```bash
   # In dot_zshrc.d/20-exports.zsh.tmpl
   export CUSTOM_VAR="value"
   ```

2. **Platform-specific**
   ```bash
   {{ if eq .chezmoi.os "darwin" }}
   export MAC_VAR="mac-value"
   {{ end }}
   ```

---

## 📊 Your Tool Stack

### Programming Languages
- **Go**: With custom GOPATH and Go modules
- **Rust**: With Cargo and rustup
- **Node.js**: With nvm, pnpm, yarn, bun
- **Python**: With pyenv, pipenv, poetry
- **Ruby**: With rbenv and bundler
- **Java**: With jenv

### Development Tools
- **Editors**: Neovim (NvChad), VS Code
- **Git**: Lazygit, GitHub CLI, GitHub Desktop
- **Containers**: Docker, Docker Compose, Lazydocker
- **Databases**: PostgreSQL, pgAdmin
- **Cloud**: Google Cloud SDK, AWS CLI

### Productivity
- **Terminal**: WezTerm, iTerm2
- **File Managers**: Yazi, Superfile, Ripgrep
- **Window Management**: Yabai (macOS)
- **Search**: Ripgrep, FZF, Zoxide
- **Task Management**: Task Master, Ansible

### Enhanced CLI
- **Zoxide**: Smart directory navigation
- **Bat**: Syntax-highlighted file viewing
- **FZF**: Fuzzy finding with rich integrations

### Security
- **Password Management**: 1Password CLI
- **SSH**: Multiple key management
- **Git Security**: GPG signing, credential helpers

---

## 🚀 Getting Started

1. **Copy the setup**
   ```bash
   cp -r /Volumes/S1/chezmoi-setup/* ~/.local/share/chezmoi/
   ```

2. **Initialize**
   ```bash
   chezmoi init --apply
   ```

3. **Configure 1Password**
   ```bash
   op account add --address your.1password.com
   ```

4. **Install tools**
   ```bash
   # Run the Ansible setup
   cd ~/.local/share/chezmoi/dot_bootstrap/ansible
   ./setup.sh
   ```

5. **Start using your enhanced tools**
   ```bash
   # Your exact configurations are now active
   nvim        # Your NvChad setup
   z projects  # Smart directory navigation
   bat file.txt # Enhanced file viewing
   fe          # Fuzzy file editing
   yazi        # Your file manager
   lg          # Your Lazygit setup
   ```

---

**Your exact configurations are preserved and enhanced with powerful new tools!** 🎉

This setup maintains all your existing configurations while adding the benefits of Chezmoi for management and powerful new CLI tools for enhanced productivity.