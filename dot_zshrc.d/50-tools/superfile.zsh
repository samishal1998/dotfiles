# Superfile Configuration
# Superfile is a modern terminal-based file manager
# This file sets up aliases and functions for Superfile

# Superfile aliases
alias sf='superfile'
alias sfa='superfile --all'        # Show all files including hidden
alias sft='superfile --tree'       # Tree view
alias sfd='superfile --dir'        # Directory mode
alias sfs='superfile --search'     # Search mode

# Superfile functions

# Open superfile in current directory
sf() {
    superfile
}

# Open superfile with specific directory
sfd() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: sfd <directory>"
        return 1
    fi
    superfile "$1"
}

# Open superfile in project root
sfp() {
    # Find project root (look for common project files)
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
        echo "No project root found, using current directory"
        superfile
    else
        echo "Opening superfile at project root: $project_root"
        superfile "$project_root"
    fi
}

# Open superfile in git root
sfg() {
    # Find git root
    local git_root
    if git_root=$(git rev-parse --show-toplevel 2>/dev/null); then
        superfile "$git_root"
    else
        echo "Not in a git repository"
        return 1
    fi
}

# Superfile with search functionality
sfs() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: sfs <search-pattern>"
        return 1
    fi
    local pattern="$1"
    superfile --search "$pattern"
}

# Superfile with specific file type filter
sff() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: sff <extension>"
        echo "Example: sff .go, sff .js"
        return 1
    fi
    local ext="$1"
    superfile --filter "*$ext"
}

# Superfile configuration management
superfile-config() {
    local config_dir="$HOME/.config/superfile"
    local config_file="$config_dir/config.toml"

    if [[ ! -d "$config_dir" ]]; then
        mkdir -p "$config_dir"
        echo "Created Superfile config directory: $config_dir"
    fi

    if [[ $# -eq 0 ]]; then
        echo "Usage: superfile-config <command>"
        echo "Commands:"
        echo "  edit    - Edit config.toml"
        echo "  init    - Create default configuration"
        echo "  backup  - Backup current configuration"
        echo "  restore - Restore configuration from backup"
        return 1
    fi

    case "$1" in
        "edit")
            ${EDITOR:-vim} "$config_file"
            ;;
        "init")
            if [[ ! -f "$config_file" ]]; then
                cat > "$config_file" << 'EOF'
# Superfile Configuration
# This is a sample configuration file for superfile

[general]
# Default editor
editor = "nvim"

# Default shell
shell = "zsh"

# Show hidden files by default
show_hidden = false

# Default view mode (list, grid, tree)
default_view = "list"

# Enable mouse support
mouse_support = true

# Enable syntax highlighting
syntax_highlight = true

# Color theme (dark, light, auto)
theme = "auto"

# File size display format (bytes, kb, mb, gb)
size_format = "auto"

# Date format
date_format = "%Y-%m-%d %H:%M:%S"

# Sort settings
[sort]
# Sort by (name, size, date, type)
by = "name"
# Sort order (asc, desc)
order = "asc"
# Sort directories first
dirs_first = true

# File operations
[operations]
# Confirm before deleting files
confirm_delete = true
# Confirm before overwriting files
confirm_overwrite = true
# Use trash instead of permanent delete
use_trash = true

# Key bindings
[keybindings]
# Navigation
up = ["k", "up"]
down = ["j", "down"]
left = ["h", "left"]
right = ["l", "right"]

# Actions
select = ["space"]
open = ["enter"]
back = ["backspace"]
quit = ["q", "ctrl+c"]

# File operations
copy = ["c"]
move = ["m"]
delete = ["d"]
rename = ["r"]
mkdir = ["n"]

# View modes
list_view = ["1"]
grid_view = ["2"]
tree_view = ["3"]

# Search
search = ["/"]
filter = ["f"]

# Sort
sort_name = ["sn"]
sort_size = ["ss"]
sort_date = ["sd"]
sort_type = ["st"]

# Toggle options
toggle_hidden = ["."]
toggle_mouse = ["M"]

# File type associations
[filetypes]
# Text files
text = ["txt", "md", "rst", "org"]
# Code files
code = ["go", "rs", "py", "js", "ts", "java", "c", "cpp", "h", "hpp"]
# Config files
config = ["json", "yaml", "yml", "toml", "ini", "conf"]
# Archive files
archive = ["zip", "tar", "gz", "bz2", "xz", "7z", "rar"]
# Image files
image = ["jpg", "jpeg", "png", "gif", "bmp", "tiff", "svg", "webp"]
# Video files
video = ["mp4", "avi", "mkv", "mov", "wmv", "flv", "webm"]
# Audio files
audio = ["mp3", "wav", "flac", "ogg", "aac", "wma"]
# Document files
document = ["pdf", "doc", "docx", "xls", "xlsx", "ppt", "pptx"]

# Custom commands
[commands]
# Open with default application
open_default = "xdg-open"
# Open with editor
open_editor = "nvim"
# Open with browser
open_browser = "xdg-open"
# Show file info
file_info = "file"
# Show directory size
dir_size = "du -sh"
# Create archive
create_archive = "tar -czf"
# Extract archive
extract_archive = "tar -xzf"

# Plugin settings
[plugins]
# Enable plugins
enabled = true
# Plugin directory
directory = "~/.config/superfile/plugins"

# Theme settings
[theme.dark]
background = "#1e1e2e"
foreground = "#cdd6f4"
border = "#89b4fa"
selected = "#89b4fa"
text = "#cdd6f4"
comment = "#7f849c"
keyword = "#f38ba8"
string = "#a6e3a1"
number = "#fab387"
function = "#89b4fa"
type = "#f9e2af"

[theme.light]
background = "#ffffff"
foreground = "#1e1e2e"
border = "#89b4fa"
selected = "#89b4fa"
text = "#1e1e2e"
comment = "#7f849c"
keyword = "#f38ba8"
string = "#a6e3a1"
number = "#fab387"
function = "#89b4fa"
type = "#f9e2af"
EOF
                echo "Created default Superfile configuration"
            else
                echo "Configuration file already exists"
            fi
            ;;
        "backup")
            local backup_file="$config_dir/superfile-backup-$(date +%Y%m%d-%H%M%S).tar.gz"
            tar -czf "$backup_file" -C "$config_dir" .
            echo "Configuration backed up to: $backup_file"
            ;;
        "restore")
            if [[ $# -lt 2 ]]; then
                echo "Usage: superfile-config restore <backup-file>"
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

# Superfile information and debugging
superfile-info() {
    echo "=== Superfile Information ==="
    if command -v superfile >/dev/null 2>&1; then
        echo "Superfile Version: $(superfile --version)"
        echo "Config Directory: $HOME/.config/superfile"
        echo "Config File: $HOME/.config/superfile/config.toml"
        echo "Data Directory: $HOME/.local/share/superfile"
        echo "Cache Directory: $HOME/.cache/superfile"
    else
        echo "Superfile is not installed"
    fi
}

# Extra superfile functions (enabled with EXTRA_ALIASES=true)
if [[ "$EXTRA_ALIASES" == "true" ]]; then
    # Superfile with custom config
    sfc() {
        if [[ $# -eq 0 ]]; then
            echo "Usage: sfc <config-file>"
            return 1
        fi
        local config_file="$1"
        if [[ -f "$config_file" ]]; then
            SUPERFILE_CONFIG_FILE="$config_file" superfile
        else
            echo "Config file not found: $config_file"
        fi
    }

    # Superfile with debug mode
    sfd() {
        SUPERFILE_DEBUG=true superfile
    }

    # Open superfile after file operations
    sf-edit() {
        if [[ $# -eq 0 ]]; then
            echo "Usage: sf-edit <file>"
            return 1
        fi
        local file="$1"
        superfile --select "$file" --editor
    }

    # Superfile with fzf integration
    sffzf() {
        local file
        file=$(find . -type f | fzf)
        if [[ -n "$file" ]]; then
            superfile --select "$file"
        fi
    }

    # Superfile with ripgrep integration
    sfrg() {
        if [[ $# -eq 0 ]]; then
            echo "Usage: sfrg <pattern>"
            return 1
        fi
        local pattern="$1"
        local files=$(rg -l "$pattern" . 2>/dev/null)
        if [[ -n "$files" ]]; then
            echo "$files" | head -1 | xargs superfile --select
        else
            echo "No files found containing: $pattern"
        fi
    }

    # Superfile with specific file operations
    sffind() {
        if [[ $# -eq 0 ]]; then
            echo "Usage: sffind <pattern>"
            return 1
        fi
        local pattern="$1"
        local files=$(find . -name "*$pattern*" -type f | head -20)
        if [[ -n "$files" ]]; then
            echo "$files" | head -1 | xargs superfile --select
        else
            echo "No files found matching: $pattern"
        fi
    }

    # Superfile with git integration
    sfgit() {
        # Open superfile in git root with git files only
        local git_root
        if git_root=$(git rev-parse --show-toplevel 2>/dev/null); then
            (cd "$git_root" && superfile --filter "*.git*")
        else
            echo "Not in a git repository"
            return 1
        fi
    }

    # Extra superfile directory shortcuts
    sfdownloads='superfile ~/Downloads'
    sfdocuments='superfile ~/Documents'
    sfdesktop='superfile ~/Desktop'
fi

# Quick access to common directories with Superfile
sfhome='superfile ~'
sfconfig='superfile ~/.config'
sfdotfiles='superfile ~/.local/share/chezmoi'

# Superfile environment variables
export SUPERFILE_CONFIG_FILE="$HOME/.config/superfile/config.toml"
export SUPERFILE_DATA_DIR="$HOME/.local/share/superfile"
export SUPERFILE_CACHE_DIR="$HOME/.cache/superfile"

# Create necessary directories
[[ ! -d "$HOME/.config/superfile" ]] && mkdir -p "$HOME/.config/superfile"
[[ ! -d "$SUPERFILE_DATA_DIR" ]] && mkdir -p "$SUPERFILE_DATA_DIR"
[[ ! -d "$SUPERFILE_CACHE_DIR" ]] && mkdir -p "$SUPERFILE_CACHE_DIR"