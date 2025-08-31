# Zoxide Configuration
# Zoxide is a smarter cd command that learns your habits
# This file sets up aliases and functions for Zoxide

# Zoxide aliases
alias cd='z'                          # Replace cd with z

# Extra zoxide aliases (enabled with EXTRA_ALIASES=true)
if [[ "$EXTRA_ALIASES" == "true" ]]; then
    alias zz='z -'                        # Go to previous directory
    alias zc='z -c'                       # Restrict matches to subdirectories of current directory
    alias zi='z -i'                       # Interactive selection
    alias zl='z -l'                       # List all directories in database
    alias zr='z -r'                       # Match by rank
    alias zs='z -s'                       # Match by frecency score
    alias zt='z -t'                       # Match by most recently accessed
fi

# Zoxide functions

# Enhanced directory navigation
z() {
    __zoxide_z "$@"
}

# Quick directory bookmarks
zdot='z ~/.local/share/chezmoi' # Dotfiles

# Extra zoxide functions (enabled with EXTRA_ALIASES=true)
if [[ "$EXTRA_ALIASES" == "true" ]]; then
    # Quick directory bookmarks
    alias zh='z ~'                        # Home directory
    alias zd='z ~/Downloads'              # Downloads
    alias zc='z ~/Documents'              # Documents
    alias zp='z ~/projects'               # Projects
    alias zco='z ~/code'                  # Code directory

    # Zoxide with fzf integration
    zf() {
        local dir
        dir=$(zoxide query --list | fzf --height 40% --reverse --preview 'ls -la {}' --preview-window right:50%)
        if [[ -n "$dir" ]]; then
            cd "$dir"
        fi
    }

    # Zoxide with ripgrep integration
    zrg() {
        if [[ $# -eq 0 ]]; then
            echo "Usage: zrg <pattern>"
            return 1
        fi
        local pattern="$1"
        local dir
        dir=$(zoxide query --list | xargs -I {} sh -c "echo {} && rg -l \"$pattern\" \"{}\" 2>/dev/null | head -1" | grep -B1 . | grep -v '\-\-' | head -1)
        if [[ -n "$dir" ]]; then
            cd "$dir"
            echo "Found '$pattern' in: $dir"
        else
            echo "Pattern '$pattern' not found in any directory"
        fi
    }

    # Zoxide statistics
    zstats() {
        echo "=== Zoxide Statistics ==="
        echo "Total directories: $(zoxide query --list | wc -l)"
        echo ""
        echo "=== Most visited directories ==="
        zoxide query --list | head -10 | nl
        echo ""
        echo "=== Recent directories ==="
        zoxide query --list | tail -10 | nl
    }

    # Zoxide maintenance
    zclean() {
        echo "Cleaning Zoxide database..."
        zoxide remove $(zoxide query --list | grep -E "(node_modules|\.git|cache|tmp)" | head -20)
        echo "Database cleaned!"
    }

    zreset() {
        echo "Resetting Zoxide database..."
        zoxide remove --all
        echo "Database reset! Start building your habits again."
    }

    # Zoxide with git integration
    zg() {
        # Go to git root directory
        local git_root
        if git_root=$(git rev-parse --show-toplevel 2>/dev/null); then
            z "$git_root"
        else
            echo "Not in a git repository"
            return 1
        fi
    }

    # Zoxide with project detection
    zp() {
        # Find project root (look for common project files)
        local project_root="$PWD"
        while [[ "$project_root" != "/" ]]; do
            if [[ -f "$project_root/package.json" ]] || \
               [[ -f "$project_root/Cargo.toml" ]] || \
               [[ -f "$project_root/go.mod" ]] || \
               [[ -f "$project_root/pyproject.toml" ]] || \
               [[ -f "$project_root/.git" ]]; then
                z "$project_root"
                return 0
            fi
            project_root="$(dirname "$project_root")"
        done

        echo "No project root found"
        return 1
    }

    # Zoxide with directory creation
    zmk() {
        if [[ $# -eq 0 ]]; then
            echo "Usage: zmk <directory>"
            return 1
        fi
        local dir="$1"
        mkdir -p "$dir"
        z "$dir"
    }

    # Zoxide with file search
    zfind() {
        if [[ $# -eq 0 ]]; then
            echo "Usage: zfind <filename>"
            return 1
        fi
        local filename="$1"
        local dir
        dir=$(zoxide query --list | xargs -I {} sh -c "find \"{}\" -name \"$filename\" -type f 2>/dev/null | head -1" | head -1 | xargs dirname 2>/dev/null)
        if [[ -n "$dir" ]]; then
            z "$dir"
            echo "Found '$filename' in: $dir"
        else
            echo "File '$filename' not found in any directory"
        fi
    }
fi

# Zoxide environment variables
export _ZO_DATA_DIR="$HOME/.local/share/zoxide"
export _ZO_ECHO="1"                    # Echo the matched directory before cd
export _ZO_EXCLUDE_DIRS="/tmp"         # Exclude directories from database
export _ZO_FZF_OPTS="--height 40% --reverse --preview 'ls -la {}' --preview-window right:50%"

# Create necessary directories
[[ ! -d "$_ZO_DATA_DIR" ]] && mkdir -p "$_ZO_DATA_DIR"

# Zoxide initialization (should be done in main zshrc)
# eval "$(zoxide init zsh)"