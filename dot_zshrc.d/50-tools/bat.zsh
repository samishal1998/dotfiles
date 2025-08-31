# Bat Configuration
# Bat is a cat clone with syntax highlighting and Git integration
# This file sets up aliases and functions for Bat

# Bat aliases
alias cat='bat'                        # Replace cat with bat

# Extra bat aliases (enabled with EXTRA_ALIASES=true)
if [[ "$EXTRA_ALIASES" == "true" ]]; then
    alias c='bat'                          # Short bat alias
    alias bc='bat --color=always'          # Force color output
    alias bn='bat --number'                # Show line numbers
    alias bl='bat --line-range'            # Show specific line range
    alias bp='bat --plain'                 # Plain output (no syntax highlighting)
    alias bs='bat --show-all'              # Show all characters including non-printing
    alias bg='bat --decorations=never'     # No decorations (for piping)
    alias bdiff='bat --diff'               # Diff mode
fi

# Bat functions

# Enhanced file viewing
bat() {
    command bat "$@"
}

# Extra bat functions (enabled with EXTRA_ALIASES=true)
if [[ "$EXTRA_ALIASES" == "true" ]]; then
    # View file with line numbers
    batn() {
        if [[ $# -eq 0 ]]; then
            echo "Usage: batn <file> [line-range]"
            return 1
        fi
        local file="$1"
        local range="${2:-}"
        if [[ -n "$range" ]]; then
            bat --number --line-range "$range" "$file"
        else
            bat --number "$file"
        fi
    }

    # View file with syntax highlighting disabled
    batp() {
        if [[ $# -eq 0 ]]; then
            echo "Usage: batp <file>"
            return 1
        fi
        bat --plain "$@" | cat
    }

    # View multiple files
    batm() {
        if [[ $# -lt 2 ]]; then
            echo "Usage: batm <file1> <file2> [file3...]"
            return 1
        fi
        for file in "$@"; do
            echo "=== $file ==="
            bat "$file"
            echo ""
        done
    }

    # View file with git blame
    batg() {
        if [[ $# -eq 0 ]]; then
            echo "Usage: batg <file>"
            return 1
        fi
        local file="$1"
        if command -v git >/dev/null 2>&1 && git ls-files "$file" >/dev/null 2>&1; then
            git blame "$file" | bat --language=git-blame
        else
            echo "File not in git repository or git not available"
            bat "$file"
        fi
    }

    # View file with grep context
    batgrep() {
        if [[ $# -lt 2 ]]; then
            echo "Usage: batgrep <pattern> <file>"
            return 1
        fi
        local pattern="$1"
        local file="$2"
        shift 2
        grep -n "$pattern" "$file" | while IFS=: read -r line_number content; do
            echo "Line $line_number:"
            bat --line-range "$((line_number-2)):$((line_number+2))" "$file"
            echo "---"
        done
    }

    # View JSON files with formatting
    batjson() {
        if [[ $# -eq 0 ]]; then
            echo "Usage: batjson <json-file>"
            return 1
        fi
        local file="$1"
        if command -v jq >/dev/null 2>&1; then
            jq . "$file" | bat --language=json
        else
            bat --language=json "$file"
        fi
    }

    # View YAML files with formatting
    batyaml() {
        if [[ $# -eq 0 ]]; then
            echo "Usage: batyaml <yaml-file>"
            return 1
        fi
        local file="$1"
        if command -v yq >/dev/null 2>&1; then
            yq . "$file" | bat --language=yaml
        else
            bat --language=yaml "$file"
        fi
    }

    # View log files with highlighting
    batlog() {
        if [[ $# -eq 0 ]]; then
            echo "Usage: batlog <log-file>"
            return 1
        fi
        local file="$1"
        bat --language=log --theme=gruvbox-dark "$file"
    }

    # View CSV files with formatting
    batcsv() {
        if [[ $# -eq 0 ]]; then
            echo "Usage: batcsv <csv-file>"
            return 1
        fi
        local file="$1"
        if command -v column >/dev/null 2>&1; then
            column -t -s, "$file" | bat --language=csv
        else
            bat --language=csv "$file"
        fi
    }

    # View files with different themes
    battheme() {
        if [[ $# -lt 2 ]]; then
            echo "Usage: battheme <theme> <file>"
            echo "Available themes: gruvbox-dark, gruvbox-light, onehalf-dark, onehalf-light, solarized-dark, solarized-light"
            return 1
        fi
        local theme="$1"
        local file="$2"
        shift 2
        bat --theme="$theme" "$file" "$@"
    }

    # View file with custom language
    batlang() {
        if [[ $# -lt 2 ]]; then
            echo "Usage: batlang <language> <file>"
            return 1
        fi
        local language="$1"
        local file="$2"
        shift 2
        bat --language="$language" "$file" "$@"
    }

    # View file with custom pager
    batless() {
        if [[ $# -eq 0 ]]; then
            echo "Usage: batless <file>"
            return 1
        fi
        bat "$@" | less -R
    }

    # View file with line numbers and highlighting
    bathighlight() {
        if [[ $# -lt 2 ]]; then
            echo "Usage: bathighlight <pattern> <file>"
            return 1
        fi
        local pattern="$1"
        local file="$2"
        shift 2
        bat --highlight-line "$pattern" "$file" "$@"
    }

    # View file with git diff
    batdiff() {
        if [[ $# -eq 0 ]]; then
            echo "Usage: batdiff <file>"
            return 1
        fi
        local file="$1"
        if command -v git >/dev/null 2>&1 && git ls-files "$file" >/dev/null 2>&1; then
            git diff "$file" | bat --language=diff
        else
            echo "File not in git repository or git not available"
        fi
    }

    # View file with word wrapping
    batwrap() {
        if [[ $# -eq 0 ]]; then
            echo "Usage: batwrap <file>"
            return 1
        fi
        bat --wrap=character "$@" | cat
    }

    # View file with tabs expanded
    battab() {
        if [[ $# -eq 0 ]]; then
            echo "Usage: battab <file>"
            return 1
        fi
        bat --tabs=4 "$@" | cat
    }

    # View file with invisible characters
    batinv() {
        if [[ $# -eq 0 ]]; then
            echo "Usage: batinv <file>"
            return 1
        fi
        bat --show-all "$@" | cat
    }

    # View file with line ranges
    batrange() {
        if [[ $# -lt 2 ]]; then
            echo "Usage: batrange <start:end> <file>"
            return 1
        fi
        local range="$1"
        local file="$2"
        shift 2
        bat --line-range="$range" "$file" "$@"
    }

    # View file with context around pattern
    batcontext() {
        if [[ $# -lt 2 ]]; then
            echo "Usage: batcontext <pattern> <file> [context-lines]"
            return 1
        fi
        local pattern="$1"
        local file="$2"
        local context="${3:-3}"
        shift 3

        # Find line numbers containing the pattern
        local lines=($(grep -n "$pattern" "$file" | cut -d: -f1))

        for line in "${lines[@]}"; do
            local start=$((line - context))
            local end=$((line + context))
            [[ $start -lt 1 ]] && start=1
            echo "=== Lines $start-$end (match at line $line) ==="
            bat --line-range="$start:$end" "$file"
            echo ""
        done
    }
fi

# Bat configuration
export BAT_CONFIG_PATH="$HOME/.config/bat/config"
export BAT_THEME="gruvbox-dark"
export BAT_STYLE="numbers,changes,header"
export BAT_PAGER="less -R"

# Create bat config directory and file
[[ ! -d "$HOME/.config/bat" ]] && mkdir -p "$HOME/.config/bat"

# Bat config file
if [[ ! -f "$HOME/.config/bat/config" ]]; then
    cat > "$HOME/.config/bat/config" << 'EOF'
# Bat Configuration File

# Set the theme
--theme=gruvbox-dark

# Show line numbers
--number

# Show changes (git)
--changes

# Show header with filename
--header

# Use italic text
--italic-text=always

# Tab width
--tabs=4

# Wrap long lines
--wrap=never

# Show non-printable characters
--show-all

# Use pager
--pager=less -R

# Color output
--color=auto

# Language mappings
--map-syntax=*.conf:ini
--map-syntax=*.config:ini
--map-syntax=Dockerfile*:dockerfile
--map-syntax=*.dockerfile:dockerfile
EOF
fi

# Bat cache and data directories
export BAT_CACHE_PATH="$HOME/.cache/bat"
export BAT_DATA_PATH="$HOME/.local/share/bat"

# Create necessary directories
[[ ! -d "$BAT_CACHE_PATH" ]] && mkdir -p "$BAT_CACHE_PATH"
[[ ! -d "$BAT_DATA_PATH" ]] && mkdir -p "$BAT_DATA_PATH"