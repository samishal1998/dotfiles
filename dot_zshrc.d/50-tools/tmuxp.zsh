# tmuxp - tmux session manager
if command -v tmuxp > /dev/null; then
    # Aliases for tmuxp
    alias tp="tmuxp"
    alias tpl="tmuxp load"
    alias tps="tmuxp freeze"
    
    # Auto-completion
    if [[ -n "$ZSH_VERSION" ]]; then
        if [[ ! -f "$HOME/.zsh/completions/_tmuxp" ]]; then
            mkdir -p "$HOME/.zsh/completions"
            tmuxp completions zsh > "$HOME/.zsh/completions/_tmuxp"
        fi
        fpath=("$HOME/.zsh/completions" $fpath)
    fi
    
    # Load sessions from default directory
    export TMUXP_CONFIGDIR="$HOME/.config/tmuxp"
fi