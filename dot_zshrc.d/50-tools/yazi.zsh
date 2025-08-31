# Yazi Configuration
# Yazi is a terminal file manager written in Rust
# This file sets up aliases and functions for Yazi

# Yazi aliases
# Note: The 'y' function below will override this alias

# Extra yazi aliases (enabled with EXTRA_ALIASES=true)
if [[ "$EXTRA_ALIASES" == "true" ]]; then
    alias ya='yazi'                    # Alternative alias
    alias yazi-cd='yazi --cwd-file /tmp/yazi-cwd'  # For directory changing
fi

# Yazi functions

# Change directory after exiting Yazi
y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# Extra yazi functions (enabled with EXTRA_ALIASES=true)
if [[ "$EXTRA_ALIASES" == "true" ]]; then
    # Open Yazi in current directory
    yz() {
        yazi
    }

    # Open Yazi with specific directory
    yzd() {
        if [[ $# -eq 0 ]]; then
            echo "Usage: yzd <directory>"
            return 1
        fi
        yazi "$1"
    }

    # Open Yazi and show hidden files
    yzh() {
        YAZI_CONFIG_HOME="$HOME/.config/yazi" yazi --show-hidden
    }

    # Yazi with custom configuration
    yzc() {
        if [[ $# -eq 0 ]]; then
            echo "Usage: yzc <config-file>"
            return 1
        fi
        YAZI_CONFIG_HOME="$1" yazi
    }

    # Quick navigation with Yazi
    yzp() {
        # Open Yazi in project root (look for common project files)
        local project_root="$PWD"
        while [[ "$project_root" != "/" ]]; do
            if [[ -f "$project_root/package.json" ]] || \
               [[ -f "$project_root/Cargo.toml" ]] || \
               [[ -f "$project_root/go.mod" ]] || \
               [[ -f "$project_root/pyproject.toml" ]] || \
               [[ -f "$project_root/.git" ]]; then
                break
            fi
            project_root="$(dirname "$project_root")"
        done

        if [[ "$project_root" == "/" ]]; then
            echo "No project root found"
            yazi
        else
            echo "Opening project at: $project_root"
            yazi "$project_root"
        fi
    }

    # Yazi with git integration
    yzg() {
        # Open Yazi in git root
        local git_root
        if git_root=$(git rev-parse --show-toplevel 2>/dev/null); then
            yazi "$git_root"
        else
            echo "Not in a git repository"
            yazi
        fi
    }
fi

# Yazi help and information
yazi-info() {
    echo "=== Yazi Information ==="
    if command -v yazi >/dev/null 2>&1; then
        echo "Yazi Version: $(yazi --version)"
        echo "Config Directory: $HOME/.config/yazi"
        echo "Data Directory: $HOME/.local/share/yazi"
        echo "Cache Directory: $HOME/.cache/yazi"
    else
        echo "Yazi is not installed"
    fi
}

# Yazi configuration management
yazi-config() {
    local config_dir="$HOME/.config/yazi"

    if [[ ! -d "$config_dir" ]]; then
        mkdir -p "$config_dir"
        echo "Created Yazi config directory: $config_dir"
    fi

    if [[ $# -eq 0 ]]; then
        echo "Usage: yazi-config <command>"
        echo "Commands:"
        echo "  edit    - Edit yazi.toml"
        echo "  init    - Create default configuration"
        echo "  backup  - Backup current configuration"
        echo "  restore - Restore configuration from backup"
        return 1
    fi

    case "$1" in
        "edit")
            ${EDITOR:-vim} "$config_dir/yazi.toml"
            ;;
        "init")
            if [[ ! -f "$config_dir/yazi.toml" ]]; then
                cat > "$config_dir/yazi.toml" << 'EOF'
[manager]
ratio = [1, 4, 3]
sort_by = "alphabetical"
sort_sensitive = false
sort_reverse = false
sort_dir_first = true
show_hidden = false
show_symlink = true

[preview]
tab_size = 2
max_width = 600
max_height = 900
cache_dir = ""

[opener]
edit = [
    { run = '${EDITOR:-vim} "$@"', block = true },
]
open = [
    { run = 'xdg-open "$@"', desc = "Open" },
]

[input]
cursor_blink = false

[log]
enabled = false
EOF
                echo "Created default Yazi configuration"
            else
                echo "Configuration file already exists"
            fi
            ;;
        "backup")
            local backup_file="$config_dir/yazi-backup-$(date +%Y%m%d-%H%M%S).tar.gz"
            tar -czf "$backup_file" -C "$config_dir" .
            echo "Configuration backed up to: $backup_file"
            ;;
        "restore")
            if [[ $# -lt 2 ]]; then
                echo "Usage: yazi-config restore <backup-file>"
                return 1
            fi
            local backup_file="$2"
            if [[ -f "$backup_file" ]]; then
                tar -xzf "$backup_file" -C "$config_dir"
                echo "Configuration restored from: $backup_file"
            else
                echo "Backup file not found: $backup_file"
            fi
            ;;
        *)
            echo "Unknown command: $1"
            return 1
            ;;
    esac
}

# Yazi plugin management (if using plugins)
yazi-plugins() {
    local plugin_dir="$HOME/.config/yazi/plugins"

    if [[ ! -d "$plugin_dir" ]]; then
        mkdir -p "$plugin_dir"
        echo "Created Yazi plugins directory: $plugin_dir"
    fi

    if [[ $# -eq 0 ]]; then
        echo "Usage: yazi-plugins <command>"
        echo "Commands:"
        echo "  list    - List installed plugins"
        echo "  install - Install a plugin"
        echo "  update  - Update all plugins"
        return 1
    fi

    case "$1" in
        "list")
            echo "=== Installed Yazi Plugins ==="
            if [[ -d "$plugin_dir" ]]; then
                ls -la "$plugin_dir"
            else
                echo "No plugins directory found"
            fi
            ;;
        "install")
            if [[ $# -lt 2 ]]; then
                echo "Usage: yazi-plugins install <plugin-url>"
                return 1
            fi
            local plugin_url="$2"
            local plugin_name=$(basename "$plugin_url" .git)
            git clone "$plugin_url" "$plugin_dir/$plugin_name"
            echo "Plugin installed: $plugin_name"
            ;;
        "update")
            echo "Updating Yazi plugins..."
            if [[ -d "$plugin_dir" ]]; then
                for plugin in "$plugin_dir"/*; do
                    if [[ -d "$plugin" ]]; then
                        echo "Updating $(basename "$plugin")..."
                        (cd "$plugin" && git pull)
                    fi
                done
            fi
            ;;
        *)
            echo "Unknown command: $1"
            return 1
            ;;
    esac
}

# Extra yazi integration functions (enabled with EXTRA_ALIASES=true)
if [[ "$EXTRA_ALIASES" == "true" ]]; then
    # Open file with Yazi and edit with Neovim
    yzedit() {
        local file
        file=$(yazi --chooser-file /tmp/yazi-chooser 2>/dev/null && cat /tmp/yazi-chooser)
        rm -f /tmp/yazi-chooser

        if [[ -n "$file" ]]; then
            ${EDITOR:-vim} "$file"
        fi
    }

    # Yazi as a file picker for other commands
    yzpick() {
        if [[ $# -eq 0 ]]; then
            echo "Usage: yzpick <command>"
            echo "Example: yzpick 'cat'"
            return 1
        fi

        local cmd="$1"
        local files
        files=$(yazi --chooser-file /tmp/yazi-picker 2>/dev/null && cat /tmp/yazi-picker)
        rm -f /tmp/yazi-picker

        if [[ -n "$files" ]]; then
            echo "$files" | xargs -I {} $cmd {}
        fi
    }

    # Yazi with specific file operations
    yzfind() {
        if [[ $# -eq 0 ]]; then
            echo "Usage: yzfind <pattern>"
            return 1
        fi
        local pattern="$1"
        local files=$(find . -name "*$pattern*" -type f | head -20)
        if [[ -n "$files" ]]; then
            echo "$files" | yazi
        else
            echo "No files found matching: $pattern"
        fi
    }

    # Yazi with ripgrep integration
    yzgrep() {
        if [[ $# -eq 0 ]]; then
            echo "Usage: yzgrep <pattern>"
            return 1
        fi
        local pattern="$1"
        local files=$(rg -l "$pattern" . 2>/dev/null | head -20)
        if [[ -n "$files" ]]; then
            echo "$files" | yazi
        else
            echo "No files found containing: $pattern"
        fi
    }
fi

# Quick access to common directories with Yazi
yzhome='yazi ~'
yzconfig='yazi ~/.config'
yzdotfiles='yazi ~/.local/share/chezmoi'

# Extra yazi directory shortcuts (enabled with EXTRA_ALIASES=true)
if [[ "$EXTRA_ALIASES" == "true" ]]; then
    yzdownloads='yazi ~/Downloads'
    yzdocuments='yazi ~/Documents'
    yzdesktop='yazi ~/Desktop'
fi

# Yazi environment variables
export YAZI_CONFIG_HOME="$HOME/.config/yazi"
export YAZI_DATA_HOME="$HOME/.local/share/yazi"
export YAZI_CACHE_HOME="$HOME/.cache/yazi"

# Create necessary directories
[[ ! -d "$YAZI_CONFIG_HOME" ]] && mkdir -p "$YAZI_CONFIG_HOME"
[[ ! -d "$YAZI_DATA_HOME" ]] && mkdir -p "$YAZI_DATA_HOME"
[[ ! -d "$YAZI_CACHE_HOME" ]] && mkdir -p "$YAZI_CACHE_HOME"