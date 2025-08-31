# FZF Configuration
# FZF is a general-purpose command-line fuzzy finder
# This file sets up aliases and functions for FZF

# FZF aliases
alias f='fzf'                         # Basic fzf

# Extra fzf aliases (enabled with EXTRA_ALIASES=true)
if [[ "$EXTRA_ALIASES" == "true" ]]; then
    alias fh='fzf --height=50%'           # Half screen height
    alias ff='fzf --preview="bat --color=always {}"'  # With preview
    alias ft='fzf --preview="tree -C {}"' # Tree preview
    alias fg='fzf --preview="head -100 {}"' # Head preview
    alias fzf='fzf --border --height=40% --reverse --preview="bat --color=always --line-range=:50 {}"'
fi

# FZF functions

# Enhanced file finder
f() {
    fzf --preview="bat --color=always --line-range=:50 {}" "$@"
}

# Extra fzf functions (enabled with EXTRA_ALIASES=true)
if [[ "$EXTRA_ALIASES" == "true" ]]; then
    # Find and edit file
    fe() {
        local file
        file=$(fzf --preview="bat --color=always --line-range=:50 {}")
        if [[ -n "$file" ]]; then
            ${EDITOR:-vim} "$file"
        fi
    }

    # Find and view file
    fv() {
        local file
        file=$(fzf --preview="bat --color=always --line-range=:50 {}")
        if [[ -n "$file" ]]; then
            bat "$file"
        fi
    }

    # Find and cd to directory
    fcd() {
        local dir
        dir=$(find . -type d | fzf --preview="tree -C {} | head -20")
        if [[ -n "$dir" ]]; then
            cd "$dir"
        fi
    }

    # Find and cd to directory (including hidden)
    fcda() {
        local dir
        dir=$(find . -type d | fzf --preview="tree -C {} | head -20" --hidden)
        if [[ -n "$dir" ]]; then
            cd "$dir"
        fi
    }

    # Find file and copy path
    fcp() {
        local file
        file=$(fzf --preview="bat --color=always --line-range=:50 {}")
        if [[ -n "$file" ]]; then
            echo -n "$file" | pbcopy
            echo "Copied: $file"
        fi
    }

    # Find file and show info
    finfo() {
        local file
        file=$(fzf --preview="bat --color=always --line-range=:50 {}")
        if [[ -n "$file" ]]; then
            echo "=== File Information ==="
            echo "Path: $file"
            echo "Size: $(du -h "$file" | cut -f1)"
            echo "Permissions: $(ls -la "$file" | awk '{print $1}')"
            echo "Modified: $(stat -c '%y' "$file" 2>/dev/null || stat -f '%Sm' "$file" 2>/dev/null)"
            echo "Type: $(file "$file")"
            if command -v md5sum >/dev/null 2>&1; then
                echo "MD5: $(md5sum "$file" | cut -d' ' -f1)"
            fi
        fi
    }

    # Find and execute command on file
    fexec() {
        if [[ $# -eq 0 ]]; then
            echo "Usage: fexec <command>"
            return 1
        fi
        local cmd="$1"
        local file
        file=$(fzf --preview="bat --color=always --line-range=:50 {}")
        if [[ -n "$file" ]]; then
            "$cmd" "$file"
        fi
    }

    # Find and move file
    fmv() {
        local file
        file=$(fzf --preview="bat --color=always --line-range=:50 {}")
        if [[ -n "$file" ]]; then
            local dest
            read "dest?Move to: "
            if [[ -n "$dest" ]]; then
                mv "$file" "$dest"
                echo "Moved: $file -> $dest"
            fi
        fi
    }

    # Find and copy file
    fcpfile() {
        local file
        file=$(fzf --preview="bat --color=always --line-range=:50 {}")
        if [[ -n "$file" ]]; then
            local dest
            read "dest?Copy to: "
            if [[ -n "$dest" ]]; then
                cp "$file" "$dest"
                echo "Copied: $file -> $dest"
            fi
        fi
    }

    # Find and delete file
    frm() {
        local file
        file=$(fzf --preview="bat --color=always --line-range=:50 {}")
        if [[ -n "$file" ]]; then
            echo "Delete: $file"
            read -q "REPLY?Are you sure? (y/N) "
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                rm "$file"
                echo "Deleted: $file"
            fi
        fi
    }

    # Find in files (ripgrep + fzf)
    frg() {
        if [[ $# -eq 0 ]]; then
            echo "Usage: frg <pattern>"
            return 1
        fi
        local pattern="$1"
        local file
        file=$(rg -l "$pattern" . | fzf --preview="rg -n \"$pattern\" {} | head -20")
        if [[ -n "$file" ]]; then
            ${EDITOR:-vim} "$file"
        fi
    }

    # Find git files
    fgit() {
        local file
        file=$(git ls-files | fzf --preview="bat --color=always --line-range=:50 {}")
        if [[ -n "$file" ]]; then
            ${EDITOR:-vim} "$file"
        fi
    }

    # Find recent files
    frecent() {
        local file
        file=$(find . -type f -mtime -7 | fzf --preview="bat --color=always --line-range=:50 {}")
        if [[ -n "$file" ]]; then
            ${EDITOR:-vim} "$file"
        fi
    }

    # Find large files
    flarge() {
        local file
        file=$(find . -type f -size +10M | fzf --preview="du -h {} && echo && file {}")
        if [[ -n "$file" ]]; then
            echo "Large file: $file"
            du -h "$file"
        fi
    }

    # Find by extension
    fext() {
        if [[ $# -eq 0 ]]; then
            echo "Usage: fext <extension>"
            return 1
        fi
        local ext="$1"
        local file
        file=$(find . -name "*.$ext" -type f | fzf --preview="bat --color=always --line-range=:50 {}")
        if [[ -n "$file" ]]; then
            ${EDITOR:-vim} "$file"
        fi
    }

    # Find in directory
    fdir() {
        if [[ $# -eq 0 ]]; then
            echo "Usage: fdir <directory>"
            return 1
        fi
        local dir="$1"
        local file
        file=$(find "$dir" -type f | fzf --preview="bat --color=always --line-range=:50 {}")
        if [[ -n "$file" ]]; then
            ${EDITOR:-vim} "$file"
        fi
    }

    # Find and grep
    fgrep() {
        if [[ $# -eq 0 ]]; then
            echo "Usage: fgrep <pattern>"
            return 1
        fi
        local pattern="$1"
        local file
        file=$(grep -r -l "$pattern" . | fzf --preview="grep -n \"$pattern\" {} | head -20")
        if [[ -n "$file" ]]; then
            ${EDITOR:-vim} "$file"
        fi
    }

    # Find process
    fproc() {
        local pid
        pid=$(ps aux | fzf --header="Select process" | awk '{print $2}')
        if [[ -n "$pid" ]]; then
            echo "Process ID: $pid"
            ps -p "$pid" -o pid,ppid,user,pcpu,pmem,comm
        fi
    }

    # Find and kill process
    fkill() {
        local pid
        pid=$(ps aux | fzf --header="Select process to kill" | awk '{print $2}')
        if [[ -n "$pid" ]]; then
            echo "Killing process $pid"
            kill "$pid"
        fi
    }

    # Find environment variable
    fenv() {
        local var
        var=$(env | fzf --header="Select environment variable" | cut -d= -f1)
        if [[ -n "$var" ]]; then
            echo "$var=${(P)var}"
        fi
    }

    # Find alias
    falias() {
        local alias_name
        alias_name=$(alias | fzf --header="Select alias" | cut -d= -f1)
        if [[ -n "$alias_name" ]]; then
            alias "$alias_name"
        fi
    }

    # Find function
    ffunc() {
        local func_name
        func_name=$(functions | fzf --header="Select function" | cut -d' ' -f1)
        if [[ -n "$func_name" ]]; then
            which "$func_name"
        fi
    }

    # Find command history
    fhist() {
        local cmd
        cmd=$(history | fzf --header="Select command from history" | sed 's/^[ ]*[0-9]*[ ]*//')
        if [[ -n "$cmd" ]]; then
            echo "Selected command: $cmd"
            print -z "$cmd"
        fi
    }

    # Find and execute
    fexec() {
        local cmd
        cmd=$(compgen -c | fzf --header="Select command to execute")
        if [[ -n "$cmd" ]]; then
            echo "Executing: $cmd"
            "$cmd"
        fi
    }

    # FZF with git integration
    fglog() {
        local commit
        commit=$(git log --oneline | fzf --preview="git show --stat {1}" | awk '{print $1}')
        if [[ -n "$commit" ]]; then
            git show "$commit"
        fi
    }

    fgbranch() {
        local branch
        branch=$(git branch -a | fzf --preview="git log --oneline {1} | head -10" | sed 's/.* //')
        if [[ -n "$branch" ]]; then
            git checkout "$branch"
        fi
    }

    # FZF with docker integration
    fdocker() {
        local container
        container=$(docker ps -a --format "table {{.Names}}\t{{.Image}}\t{{.Status}}" | fzf --header="Select container" | awk '{print $1}')
        if [[ -n "$container" ]]; then
            echo "Selected container: $container"
            docker logs "$container" | tail -50
        fi
    }

    # FZF with tmux integration
    ftmux() {
        local session
        session=$(tmux list-sessions | fzf --header="Select tmux session" | cut -d: -f1)
        if [[ -n "$session" ]]; then
            tmux switch-client -t "$session"
        fi
    }
fi

# FZF configuration
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border --preview="bat --color=always --line-range=:50 {}" --preview-window=right:50%:hidden --bind=ctrl-p:toggle-preview'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_COMPLETION_TRIGGER='**'

# FZF colors (match your theme)
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=fg:#cdd6f4,bg:#1e1e2e,hl:#f38ba8
--color=fg+:#cdd6f4,bg+:#313244,hl+:#f38ba8
--color=info:#a6e3a1,prompt:#89b4fa,pointer:#f5e0dc
--color=marker:#f5e0dc,spinner:#f5e0dc,header:#f38ba8'

# FZF key bindings
# Ctrl+T: Paste the selected file path into the command line
# Alt+C: cd into the selected directory
# Ctrl+R: Search through command history

# FZF completion
if [[ -f /usr/share/fzf/completion.zsh ]]; then
    source /usr/share/fzf/completion.zsh
fi

if [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
    source /usr/share/fzf/key-bindings.zsh
fi

# FZF auto-completion
# Complete command with fzf
_fzf_complete() {
    local cmd="${1}"
    local cur="${2}"
    local list

    case "$cmd" in
        cd)
            list=$(find . -type d | fzf --height=20)
            ;;
        vim|nvim|code)
            list=$(find . -type f | fzf --height=20)
            ;;
        *)
            list=$(compgen -c | fzf --height=20)
            ;;
    esac

    if [[ -n "$list" ]]; then
        COMPREPLY=("$list")
    fi
}

# Enable fzf completion for common commands
complete -F _fzf_complete -o default -o bashdefault vim nvim code cat bat

# FZF cache directory
export FZF_CACHE_DIR="$HOME/.cache/fzf"

# Create necessary directories
[[ ! -d "$FZF_CACHE_DIR" ]] && mkdir -p "$FZF_CACHE_DIR"