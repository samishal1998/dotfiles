# asdf - version manager
if command -v asdf > /dev/null; then
    # Load asdf
    . $(brew --prefix asdf)/libexec/asdf.sh
    
    # Useful aliases only
    alias ai="asdf install"
    alias al="asdf list"
    
    # Completion
    if [[ -n "$ZSH_VERSION" ]]; then
        # Generate completion if it doesn't exist
        if [[ ! -f "$HOME/.zsh/completions/_asdf" ]]; then
            mkdir -p "$HOME/.zsh/completions"
            asdf completions zsh > "$HOME/.zsh/completions/_asdf"
        fi
        fpath=("$HOME/.zsh/completions" $fpath)
    fi
    
    # Default plugins
    export ASDF_DEFAULT_PLUGINS=(
        "nodejs"
        "python"
        "ruby"
        "golang"
        "rust"
    )
    
    # Helper function to install default plugins
    asdf-setup-defaults() {
        for plugin in $ASDF_DEFAULT_PLUGINS; do
            if ! asdf plugin list | grep -q "^$plugin$"; then
                echo "Adding asdf plugin: $plugin"
                asdf plugin add $plugin
            fi
        done
    }
    
    # Update all plugins
    asdf-update-all() {
        for plugin in $(asdf plugin list); do
            echo "Updating $plugin..."
            asdf plugin update $plugin
        done
    }
fi