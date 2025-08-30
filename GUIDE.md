# Dotfiles Tools Guide

This guide provides detailed instructions for using each tool configured in your dotfiles setup.

## 📋 Table of Contents

- [Chezmoi](#chezmoi) - Dotfile manager
- [ZSH](#zsh) - Shell configuration
- [Neovim](#neovim) - Code editor
- [1Password](#1password) - Password management
- [Git & Lazygit](#git--lazygit) - Version control
- [Yazi](#yazi) - File manager
- [Superfile](#superfile) - Alternative file manager
- [Ripgrep](#ripgrep) - Text search
- [Development Tools](#development-tools) - Language-specific tools
- [Ansible](#ansible) - System automation

---

## Chezmoi

### Basic Commands

```bash
# Initialize Chezmoi
chezmoi init

# Add a file to Chezmoi
chezmoi add ~/.zshrc

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

# Show unmanaged files
chezmoi unmanaged

# Check status
chezmoi status
```

### Advanced Usage

```bash
# Add file as template
chezmoi add --template ~/.gitconfig

# Add file with encryption
chezmoi add --encrypt ~/.ssh/id_rsa

# Apply only specific files
chezmoi apply ~/.zshrc ~/.config/nvim

# Dry run
chezmoi apply --dry-run

# Verbose output
chezmoi apply --verbose

# Force apply (ignore errors)
chezmoi apply --force
```

### Template Variables

```bash
# Show available template variables
chezmoi data

# Use variables in templates
{{ .chezmoi.os }}           # Operating system
{{ .chezmoi.arch }}         # Architecture
{{ .chezmoi.hostname }}     # Hostname
{{ .email }}                # Your email
{{ .github_username }}      # GitHub username
```

---

## ZSH

### Essential Aliases

```bash
# File operations
ll          # Long listing
la          # List all files
..          # Go up one directory
...         # Go up two directories

# Git shortcuts
gs          # git status
ga          # git add
gc          # git commit
gp          # git push
gl          # git pull
gd          # git diff
gco         # git checkout

# Docker
d           # docker
dc          # docker-compose
dps         # docker ps
di          # docker images

# Tools
lg          # lazygit
y           # yazi
rg          # ripgrep
```

### Directory Navigation

```bash
# Quick directory changes
..          # cd ..
...         # cd ../..
....        # cd ../../..

# Create and enter directory
mkcd myproject

# Go to project root
cdp         # Custom function to find project root
```

### History Management

```bash
# Search history
Ctrl+R      # Incremental search
↑/↓         # Navigate history

# History commands
history     # Show all history
hgrep       # Search history
```

### Completion

```bash
# Tab completion
Tab         # Complete commands/files
Ctrl+D      # List possible completions

# Git completion
git checkout <Tab>    # Branch completion
git log --<Tab>       # Option completion
```

---

## Neovim

### Basic Navigation

```vim
# Normal mode navigation
h j k l     # Left, down, up, right
w           # Next word
b           # Previous word
0           # Beginning of line
$           # End of line
gg          # Top of file
G           # Bottom of file
Ctrl+U      # Half page up
Ctrl+D      # Half page down

# Window navigation
Ctrl+h      # Left window
Ctrl+j      # Down window
Ctrl+k      # Up window
Ctrl+l      # Right window
```

### Essential Commands

```vim
# File operations
:write      # Save file
:quit       # Quit
:wq         # Save and quit
:q!         # Force quit

# Editing
i           # Insert mode
a           # Append after cursor
A           # Append at end of line
o           # New line below
O           # New line above
dd          # Delete line
yy          # Copy line
p           # Paste after cursor
P           # Paste before cursor
u           # Undo
Ctrl+r      # Redo
```

### Leader Key Mappings

```vim
<leader> = Space

# File operations
<leader>w       # Save file
<leader>q       # Quit
<leader>Q       # Quit all

# File explorer
<leader>e       # Toggle NvimTree

# Telescope (fuzzy finder)
<leader>ff      # Find files
<leader>fg      # Live grep
<leader>fb      # Find buffers
<leader>fh      # Help tags

# Git
<leader>gg      # Open LazyGit

# LSP (Language Server Protocol)
gD              # Go to declaration
gd              # Go to definition
K               # Hover documentation
<leader>rn      # Rename symbol
<leader>ca      # Code actions
<leader>f       # Format code

# Diagnostics
<leader>dd      # Show diagnostics
[d              # Previous diagnostic
]d              # Next diagnostic

# Terminal
<leader>tt      # Toggle terminal
```

### Advanced Features

```vim
# Multiple cursors
Ctrl+v          # Visual block mode
I               # Insert at beginning of selection
A               # Append at end of selection

# Search and replace
:%s/old/new/g   # Replace all in file
:s/old/new/g    # Replace all in line
:s/old/new/     # Replace first in line

# Macros
q a             # Start recording macro 'a'
q               # Stop recording
@ a             # Play macro 'a'
@@              # Repeat last macro

# Marks
m a             # Set mark 'a'
` a             # Jump to mark 'a'
' a             # Jump to beginning of line with mark 'a'

# Folds
za              # Toggle fold
zA              # Toggle fold recursively
zo              # Open fold
zc              # Close fold
zr              # Open all folds one level
zR              # Open all folds
zm              # Close all folds one level
zM              # Close all folds
```

### Plugin-Specific Commands

#### Telescope
```vim
# In Telescope window
Ctrl+j/k        # Navigate up/down
Enter           # Select
Ctrl+c          # Close
Esc             # Close
```

#### NvimTree
```vim
# Navigation
h               # Go up directory
l               # Open file/directory
Enter           # Open file
```

#### LazyGit
```vim
# Navigation
j/k             # Up/down
Enter           # Select
q               # Quit
```

---

## 1Password

### CLI Setup

```bash
# Install 1Password CLI
brew install --cask 1password-cli

# Sign in
op account add --address my.1password.com --email user@example.com
eval $(op signin --account my)

# Verify
op whoami
```

### Basic Commands

```bash
# List items
op item list

# Get item
op item get "Item Name"

# Create item
op item create --category login --title "My App" --generate-password

# Edit item
op item edit "Item Name"

# Delete item
op item delete "Item Name"
```

### Template Functions

```bash
# In Chezmoi templates
{{ onepasswordRead "op://vault/item/field" }}

# Examples
{{ onepasswordRead "op://Personal/GitHub/token" }}
{{ onepasswordRead "op://Work/AWS/access_key" }}
```

### Custom Functions

```bash
# Load secrets into environment
op-env "Development"

# Get specific secret
op-secret "Database" "password" "DB_PASSWORD"

# Generate password
op-genpass 32 complex

# SSH key management
op-ssh create "my-key"
op-ssh get "my-key"
```

---

## Git & Lazygit

### Git Basics

```bash
# Initialize repository
git init

# Clone repository
git clone https://github.com/user/repo.git

# Add files
git add .
git add filename

# Commit changes
git commit -m "Commit message"
git commit -a -m "Commit all changes"

# Push changes
git push origin main

# Pull changes
git pull origin main

# Check status
git status
git log --oneline
```

### Advanced Git

```bash
# Branching
git branch feature-branch
git checkout feature-branch
git checkout -b new-branch

# Merging
git merge feature-branch
git rebase main

# Stashing
git stash
git stash pop
git stash list

# Resetting
git reset --hard HEAD~1
git reset --soft HEAD~1

# Remote operations
git remote add origin url
git remote -v
git fetch origin
```

### Lazygit Interface

```bash
# Open LazyGit
lg

# Navigation
j/k             # Up/down
h/l             # Left/right
Enter           # Select
Esc             # Back

# Actions
c               # Commit
p               # Push
f               # Pull
s               # Stage files
u               # Unstage files
d               # Delete
r               # Rename
```

### Git Configuration

```bash
# Set user info
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Set default branch
git config --global init.defaultBranch main

# Set editor
git config --global core.editor nvim

# Set merge tool
git config --global merge.tool vimdiff

# Aliases
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
```

---

## Yazi

### Basic Usage

```bash
# Open Yazi
y

# Open specific directory
y ~/projects

# Open with search
y -s "pattern"

# Open with hidden files
y -h
```

### Navigation

```bash
# Movement
h j k l         # Left, down, up, right
gg              # Top of directory
G               # Bottom of directory
Ctrl+U          # Half page up
Ctrl+D          # Half page down

# Quick navigation
~               # Home directory
-               # Previous directory
Tab             # Next tab
```

### File Operations

```bash
# Selection
Space           # Select file
v               # Visual mode
Ctrl+A          # Select all

# Actions
Enter           # Open file
o               # Open with default app
e               # Edit with $EDITOR
c               # Copy
x               # Cut
p               # Paste
d               # Delete
r               # Rename
n               # New file/directory
```

### Search & Filter

```bash
# Search
/               # Search files
n               # Next match
N               # Previous match

# Filter
f               # Filter by pattern
Ctrl+F          # Clear filter
```

### Custom Functions

```bash
# Directory change (when exiting)
y               # Changes directory on exit

# Project navigation
yzp             # Open project root
yzg             # Open git root

# File operations
yzedit          # Edit selected file
yzpick cat      # Open file picker for command
```

---

## Superfile

### Basic Usage

```bash
# Open Superfile
sf

# Open specific directory
sfd ~/projects

# Open with search
sfs "pattern"

# Open with filter
sff .go
```

### Interface

```bash
# Navigation
h j k l         # Left, down, up, right
Ctrl+U          # Half page up
Ctrl+D          # Half page down

# File operations
Enter           # Open file
e               # Edit file
c               # Copy
x               # Cut
p               # Paste
d               # Delete
r               # Rename
n               # New file
```

### Views

```bash
# Switch views
1               # List view
2               # Grid view
3               # Tree view

# Toggle options
.               # Show hidden files
m               # Mouse support
```

### Configuration

```bash
# Edit configuration
superfile-config edit

# Create default config
superfile-config init

# Backup configuration
superfile-config backup
```

---

## Ripgrep

### Basic Search

```bash
# Search for pattern
rg "pattern"

# Search in specific directory
rg "pattern" ~/projects

# Search in specific files
rg "pattern" *.go
rg "pattern" -g "*.js"

# Case insensitive
rg -i "pattern"

# Word boundary
rg -w "word"

# Invert match
rg -v "pattern"
```

### Advanced Usage

```bash
# Show line numbers
rg -n "pattern"

# Show context
rg -C 3 "pattern"    # 3 lines before and after
rg -B 2 -A 5 "pattern"  # 2 before, 5 after

# Replace
rg "old" -r "new"

# Count matches
rg -c "pattern"

# List files with matches
rg -l "pattern"

# Show only filenames
rg --files-with-matches "pattern"
```

### File Type Search

```bash
# Search in specific file types
rg "pattern" -t rust
rg "pattern" -t python
rg "pattern" -t javascript

# Available types
rg --type-list
```

### Custom Functions

```bash
# Search and edit
rgv "pattern" "*.go"

# Search and replace
rgsed "old" "new" "*.js"

# Search with context
rgcontext "pattern" 2 3

# Search statistics
rgstats "pattern"

# Code search
rgcode "function"
```

---

## Development Tools

### Go Development

```bash
# Initialize module
go mod init project

# Add dependencies
go get package
go mod tidy

# Build
go build
go build -o binary .

# Run
go run .
go run main.go

# Test
go test
go test -v
go test -race
go test -cover

# Format
go fmt
gofmt -w .

# Lint
go vet
```

### Rust Development

```bash
# Create new project
cargo new project
cargo new --lib library

# Build
cargo build
cargo build --release

# Run
cargo run
cargo run --release

# Test
cargo test
cargo test --release

# Format
cargo fmt

# Lint
cargo clippy

# Documentation
cargo doc --open

# Update dependencies
cargo update
```

### Node.js Development

```bash
# Initialize project
npm init -y
yarn init -y
pnpm init -y

# Install dependencies
npm install package
yarn add package
pnpm add package

# Install dev dependencies
npm install -D package
yarn add -D package
pnpm add -D package

# Run scripts
npm run dev
yarn dev
pnpm dev

# Build
npm run build
yarn build
pnpm build

# Test
npm test
yarn test
pnpm test
```

### Python Development

```bash
# Create virtual environment
python -m venv venv
source venv/bin/activate

# Install packages
pip install package
pip install -r requirements.txt

# Install development tools
pip install black flake8 mypy pytest

# Format code
black .

# Lint code
flake8 .
mypy .

# Run tests
pytest
pytest -v
pytest --cov
```

---

## Ansible

### Basic Usage

```bash
# Run playbook
ansible-playbook playbook.yml

# Run with inventory
ansible-playbook -i inventory.yml playbook.yml

# Dry run
ansible-playbook playbook.yml --check

# Verbose output
ansible-playbook playbook.yml -v

# Ask for sudo password
ansible-playbook playbook.yml --ask-become-pass
```

### Setup Script

```bash
# Run the automated setup
cd ~/.local/share/chezmoi/dot_bootstrap/ansible
chmod +x setup.sh
./setup.sh
```

### Manual Setup

```bash
# Install Ansible
pip install ansible

# Install collections
ansible-galaxy collection install community.general

# Run specific roles
ansible-playbook playbook.yml --tags common
ansible-playbook playbook.yml --tags development_tools
```

---

## Troubleshooting

### Common Issues

#### Chezmoi Issues
```bash
# Check Chezmoi status
chezmoi doctor

# Reset Chezmoi state
chezmoi state reset

# Debug templates
chezmoi execute-template '{{ .chezmoi.os }}'
```

#### Neovim Issues
```bash
# Check health
:checkhealth

# Update plugins
:Lazy sync

# Clear cache
rm -rf ~/.cache/nvim
rm -rf ~/.local/share/nvim
```

#### 1Password Issues
```bash
# Check session
op whoami

# Sign in again
eval $(op signin --account my)

# Check vault access
op vault list
```

#### Git Issues
```bash
# Check configuration
git config --list

# Fix permissions
chmod 600 ~/.ssh/id_rsa

# Update remote
git remote set-url origin new-url
```

### Getting Help

```bash
# Chezmoi help
chezmoi help
chezmoi help command

# Neovim help
:help
:help topic

# 1Password help
op --help
op command --help

# Git help
git help
git help command
```

---

## Customization

### Adding New Tools

1. **Create configuration file**
   ```bash
   # Add to dot_zshrc.d/50-tools/
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

## Quick Reference

### Most Used Commands

```bash
# Navigation
..              # Up directory
lg              # LazyGit
y               # Yazi
sf              # Superfile

# Files
<leader>e       # File explorer (Neovim)
<leader>ff      # Find files (Neovim)
rg              # Search text

# Git
gs              # Git status
ga              # Git add
gc              # Git commit
gp              # Git push

# Development
<leader>gg      # LazyGit (Neovim)
<leader>tt      # Terminal (Neovim)
gd              # Go to definition (Neovim)
```

### Emergency Commands

```bash
# Reset everything
chezmoi purge

# Force quit Neovim
pkill -9 nvim

# Clear all caches
rm -rf ~/.cache/*
rm -rf ~/.local/share/*cache*

# Reset terminal
reset
```

---

**Happy Coding!** 🎉

This guide covers the essential usage of all tools in your dotfiles setup. Refer back to it whenever you need to remember specific commands or workflows.