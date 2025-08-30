# direnv - environment switcher
if command -v direnv > /dev/null; then
    # Hook direnv into zsh
    eval "$(direnv hook zsh)"
    
    # Useful aliases only
    alias da="direnv allow"
    
    # Helper functions
    direnv-allow-all() {
        # Allow all .envrc files in current directory and subdirectories
        find . -name ".envrc" -exec direnv allow {} \;
    }
    
    # Integration with asdf
    if command -v asdf > /dev/null; then
        # Load asdf direnv integration
        if asdf where direnv > /dev/null 2>&1; then
            source "$(asdf where direnv)/bin/direnv" hook zsh
        fi
    fi
    
    # Custom .envrc template function
    direnv-template() {
        local env_type="${1:-python}"
        
        case "$env_type" in
            python)
                cat > .envrc << 'EOF'
# Python virtual environment
layout python

# Load project-specific environment variables
source_env_if_exists .env.local
source_env_if_exists .env.secrets
EOF
                ;;
            node)
                cat > .envrc << 'EOF'
# Node.js environment
layout node

# Load project-specific environment variables
source_env_if_exists .env.local
source_env_if_exists .env.secrets
EOF
                ;;
            go)
                cat > .envrc << 'EOF'
# Go environment
export GOPATH="$(pwd)/.go"
export PATH="$GOPATH/bin:$PATH"

# Load project-specific environment variables
source_env_if_exists .env.local
source_env_if_exists .env.secrets
EOF
                ;;
            rust)
                cat > .envrc << 'EOF'
# Rust environment
export PATH="$(pwd)/.cargo/bin:$PATH"

# Load project-specific environment variables
source_env_if_exists .env.local
source_env_if_exists .env.secrets
EOF
                ;;
            *)
                echo "Usage: direnv-template [python|node|go|rust]"
                return 1
                ;;
        esac
        
        direnv allow
        echo "Created .envrc for $env_type"
    }
fi