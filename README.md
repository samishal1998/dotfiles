# Dotfiles Setup with Chezmoi

This repository contains a comprehensive dotfiles setup using [Chezmoi](https://chezmoi.io) for managing configuration files across multiple machines (macOS and Linux).

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

2. **Initialize Chezmoi**
   ```bash
   chezmoi init
   ```

3. **Apply the configuration**
   ```bash
   chezmoi apply
   ```

## 📁 Structure

```
~/.local/share/chezmoi/
├── .chezmoi.toml.tmpl              # Main configuration template
├── .chezmoiignore                  # Files to ignore
├── dot_zshrc.tmpl                  # Main ZSH configuration
├── dot_zshrc.d/                    # Modular ZSH configs
│   ├── 00-common.zsh               # Common settings
│   ├── 10-aliases.zsh.tmpl         # Aliases (OS-aware)
│   ├── 20-exports.zsh.tmpl         # Environment variables
│   ├── 30-path.zsh.tmpl            # PATH modifications
│   ├── 40-languages/               # Language-specific configs
│   │   ├── golang.zsh.tmpl
│   │   ├── rust.zsh.tmpl
│   │   └── nodejs.zsh.tmpl
│   ├── 50-tools/                   # Tool-specific configs
│   │   └── 1password.zsh.tmpl
│   ├── 60-macos.zsh.tmpl           # macOS-specific
│   └── 60-linux.zsh.tmpl           # Linux-specific
├── dot_config/                     # Application configs
│   ├── nvim/                       # Neovim config
│   ├── tmux/                       # Tmux config
│   └── yazi/                       # Yazi config
└── .chezmoiscripts/                # Setup scripts
```

## 🔧 Features

### Modular ZSH Configuration

The ZSH configuration is split into modular files for better organization:

- **00-common.zsh**: Basic shell settings that work everywhere
- **10-aliases.zsh.tmpl**: Cross-platform aliases with OS-specific variants
- **20-exports.zsh.tmpl**: Environment variables and PATH setup
- **40-languages/**: Language-specific configurations (Go, Rust, Node.js, Python)
- **50-tools/**: Tool-specific configurations (1Password, etc.)
- **60-*.zsh.tmpl**: OS-specific configurations (macOS/Linux)

### Cross-Platform Support

- **macOS**: Homebrew integration, system-specific aliases
- **Linux**: APT/Pacman support, systemd integration
- **Conditional Logic**: Templates automatically adapt based on OS and machine type

### 1Password Integration

Secure secrets management through 1Password CLI:

```bash
# Load secrets into environment
op-env "Development"

# Get specific secret
op-secret "Database" "password" "DB_PASSWORD"

# Generate secure password
op-genpass 32 complex
```

### Development Tools

Pre-configured support for:

- **Languages**: Go, Rust, Node.js, Python
- **Tools**: Git, Docker, Kubernetes, Terraform
- **Editors**: Neovim, VS Code
- **Package Managers**: Homebrew, APT, Yarn, pnpm, Poetry

## 🎯 Usage

### Daily Operations

```bash
# Check what files will be changed
chezmoi diff

# Apply changes
chezmoi apply

# Edit a file
chezmoi edit ~/.zshrc

# Add a new file
chezmoi add ~/.config/starship.toml

# Update from repository
chezmoi update
```

### Managing Secrets

```bash
# Store a secret in 1Password
op item create --category password --title "API Key" --vault "Development"

# Use secret in template
{{ onepasswordRead "op://Development/API Key/password" }}
```

### Machine-Specific Configuration

The setup automatically detects:

- **OS**: macOS vs Linux
- **Machine Type**: Work vs Personal
- **Architecture**: amd64 vs arm64

Use these in templates:

```bash
{{ if .is_work }}
# Work-specific configuration
{{ end }}

{{ if eq .chezmoi.os "darwin" }}
# macOS-specific configuration
{{ end }}
```

## 🛠️ Customization

### Adding New Tools

1. **Create configuration file**
   ```bash
   # For a new tool, create ~/.zshrc.d/50-tools/tool.zsh.tmpl
   chezmoi add ~/.zshrc.d/50-tools/newtool.zsh
   ```

2. **Add OS-specific logic**
   ```bash
   {{ if lookPath "newtool" }}
   # Tool-specific configuration
   {{ end }}
   ```

### Modifying Aliases

Edit `dot_zshrc.d/10-aliases.zsh.tmpl`:

```bash
# Add new alias
alias myalias='command --with-options'

# OS-specific alias
{{ if eq .chezmoi.os "darwin" }}
alias macalias='mac-specific-command'
{{ end }}
```

### Environment Variables

Edit `dot_zshrc.d/20-exports.zsh.tmpl`:

```bash
# Add new environment variable
export MY_VAR="value"

# Conditional export
{{ if .is_work }}
export WORK_VAR="work-value"
{{ end }}
```

## 🔒 Security

### 1Password Integration

- Secrets are never stored in plain text
- Templates retrieve values dynamically from 1Password
- Supports multiple vaults and accounts
- Automatic session management

### File Permissions

- Private files are automatically detected and secured
- SSH keys and other sensitive files get 600 permissions
- Configuration files are properly secured

## 🚀 Advanced Features

### Setup Scripts

Automated installation and configuration:

```bash
# Install development tools
install-macos-tools    # macOS
install-linux-tools    # Linux

# Install language tools
install_node_tools
install_python_tools
install_rust_tools
```

### Project Templates

Quick project setup:

```bash
# Create new projects
nodecreate my-app express
pythoncreate my-api fastapi
rustcreate my-tool bin
```

### System Maintenance

Built-in cleanup and maintenance:

```bash
# System cleanup
mac-cleanup      # macOS
linux-cleanup    # Linux

# Development cleanup
nodeclean
pythonclean
rustclean
```

## 📊 Monitoring and Debugging

### Status Commands

```bash
# Show system information
sysinfo

# Show environment info
nodeinfo
pythoninfo
rustinfo

# Show 1Password status
op-info
```

### Debugging Templates

```bash
# Test template rendering
chezmoi execute-template '{{ .chezmoi.os }}'

# Show available variables
chezmoi data

# Debug 1Password connection
op account list
```

## 🤝 Contributing

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/new-tool
   ```
3. **Make changes**
4. **Test on multiple platforms**
5. **Submit a pull request**

## 📝 License

This dotfiles setup is provided as-is for educational and personal use. Feel free to adapt it to your needs.

## 🆘 Troubleshooting

### Common Issues

1. **Template errors**: Check syntax with `chezmoi execute-template`
2. **1Password issues**: Verify CLI installation and authentication
3. **Permission problems**: Run `chezmoi doctor` to diagnose
4. **Missing tools**: Use setup scripts to install dependencies

### Getting Help

```bash
# Chezmoi help
chezmoi help
chezmoi doctor

# 1Password help
op --help

# Check system status
chezmoi status
```

## 🔄 Updates

To update your dotfiles:

```bash
# Pull latest changes
chezmoi update

# Or if you have local changes
chezmoi merge
```

---

**Happy Hacking!** 🎉

This setup is designed to be maintainable, secure, and adaptable to your workflow. Customize it as needed and enjoy a consistent development environment across all your machines.