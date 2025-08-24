# Lazygit Configuration
# Lazygit is a simple terminal UI for git commands
# This file sets up aliases and functions for Lazygit

# Lazygit aliases
alias lg='lazygit'
alias lga='lazygit --all'         # Show all branches
alias lgs='lazygit --single-branch' # Show single branch
alias lgw='lazygit --work-tree'    # Specify working tree
alias lgg='lazygit --git-dir'      # Specify git directory

# Lazygit functions

# Open lazygit in current directory
lg() {
    lazygit
}

# Open lazygit with specific directory
lgd() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: lgd <directory>"
        return 1
    fi
    (cd "$1" && lazygit)
}

# Open lazygit in project root
lgp() {
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
        lazygit
    else
        echo "Opening lazygit at project root: $project_root"
        (cd "$project_root" && lazygit)
    fi
}

# Open lazygit in git root
lgg() {
    # Find git root
    local git_root
    if git_root=$(git rev-parse --show-toplevel 2>/dev/null); then
        (cd "$git_root" && lazygit)
    else
        echo "Not in a git repository"
        return 1
    fi
}

# Lazygit with specific branch
lgb() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: lgb <branch-name>"
        return 1
    fi
    local branch="$1"
    git checkout "$branch" && lazygit
}

# Lazygit status (quick status view)
lgs() {
    lazygit --filter 'status'
}

# Lazygit log (commit history)
lgl() {
    lazygit --filter 'log'
}

# Lazygit branches
lgbr() {
    lazygit --filter 'branches'
}

# Lazygit remotes
lgr() {
    lazygit --filter 'remotes'
}

# Lazygit stashes
lgst() {
    lazygit --filter 'stash'
}

# Lazygit configuration management
lazygit-config() {
    local config_dir="$HOME/.config/lazygit"
    local config_file="$config_dir/config.yml"

    if [[ ! -d "$config_dir" ]]; then
        mkdir -p "$config_dir"
        echo "Created Lazygit config directory: $config_dir"
    fi

    if [[ $# -eq 0 ]]; then
        echo "Usage: lazygit-config <command>"
        echo "Commands:"
        echo "  edit    - Edit config.yml"
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
gui:
  theme:
    activeBorderColor:
      - '#ff0000'
      - bold
    inactiveBorderColor:
      - '#ffffff'
    selectedLineBgColor:
      - '#00ff00'
    selectedRangeBgColor:
      - '#00ff00'
  commitLength:
    show: true
  mouseEvents: true
  skipDiscardChangeWarning: false
  skipStashWarning: false

git:
  paging:
    colorArg: always
    pager: delta --dark --paging=never
  merging:
    manualCommit: false
  mainBranches:
    - master
    - main
    - develop

update:
  method: prompt
  days: 14

reporting: 'on'

splash: true

confirmOnQuit: false

quitOnTopLevelReturn: false

keybinding:
  universal:
    quit: 'q'
    quit-alt1: '<c-c>'
    return: '<esc>'
    quitWithoutConfirm: 'Q'
    togglePanel: '<tab>'
    prevItem: '<up>'
    nextItem: '<down>'
    prevItem-alt: 'k'
    nextItem-alt: 'j'
    prevPage: ','
    nextPage: '.'
    scrollLeft: 'h'
    scrollRight: 'l'
    scrollUpMain: '<c-u>'
    scrollDownMain: '<c-d>'
    scrollUpExtra: '<c-b>'
    scrollDownExtra: '<c-f>'
    startSearch: '/'
    gotoTop: '<home>'
    gotoBottom: '<end>'
    toggleRangeSelect: 'v'
    rangeSelectDown: '<s-down>'
    rangeSelectUp: '<s-up>'
    copyToClipboard: '<c-o>'
    openFile: '<c-o>'
    editFile: 'e'
    openInEditor: 'E'
    ignoreFile: 'i'
    refresh: 'R'
    createPatch: '<c-p>'
    createRebase: 'r'
    pickBothHunks: 'b'
    editHunk: 'a'
    undo: 'z'
    redo: 'Z'
    remove: 'd'
    new: 'n'
    push: 'P'
    pull: 'p'
    scrollUp: '<c-k>'
    scrollDown: '<c-j>'
    executeShellCommand: ':'
    createRebaseFromCurrentItem: 'r'
    createFixupCommit: 'f'
    squashAbove: 's'
    squashOntoAbove: 'S'
    moveUp: '<c-up>'
    moveDown: '<c-down>'
    amendTo: 'A'
    rename: 'c'
    reset: 'X'
    cherryPick: 'C'
    markAsBase: 'B'
    toggleStaged: '<space>'
    toggleStagedAll: 'a'
    stageHunk: 's'
    unstageHunk: 'u'
    editHunk: 'e'
    navigateToNextHunk: 'n'
    navigateToPrevHunk: 'N'
    inlineMergeConflicts: 'm'
    externalMergeConflicts: 'M'
    jumpToNextConflict: ']'
    jumpToPrevConflict: '['
    selectPrevConflict: '{'
    selectNextConflict: '}'
    commit: 'c'
    commitAll: 'C'
    commitMessage: '<c-m>'
    commitWithoutHook: 'w'
    amend: 'a'
    amendWithoutHook: 'A'
    commitEditor: 'e'
    findBaseCommitForFixup: 'f'
    revert: 'r'
    createTag: 't'
    pushTag: 'P'
    checkout: '<space>'
    forceCheckout: 'f'
    delete: 'd'
    merge: 'm'
    rebase: 'r'
    squashMerge: 's'
    fastForward: 'f'
    preview: '<space>'
    fetch: 'f'
    createBranch: 'n'
    copyPullRequestURL: '<c-o>'
    checkoutByName: 'c'
    forcePush: 'F'
    pull: 'p'
    push: 'P'
    stash: 's'
    stashAll: 'S'
    stashStaged: 'A'
    stashIncludeUntracked: 'u'
    stashApply: 'a'
    stashPop: 'o'
    stashDrop: 'd'
    showRefs: 'r'
    sortOrder: 's'
    showGitFlowOptions: 'g'
    undo: 'z'
    redo: 'Z'
    resetCherryPick: 'R'
    copy: 'c'
    paste: 'v'
    cut: 'x'
    selectAll: '<c-a>'
    remove: '<delete>'
    removeWithoutConfirm: 'D'
    edit: 'e'
    openFile: 'o'
    scrollUp: '<c-k>'
    scrollDown: '<c-j>'
    gotoTop: 'g'
    gotoBottom: 'G'
    toggleWrap: 'w'
    toggleLineNumbers: 'l'
    toggleWhitespace: '<c-w>'
EOF
                echo "Created default Lazygit configuration"
            else
                echo "Configuration file already exists"
            fi
            ;;
        "backup")
            local backup_file="$config_dir/lazygit-backup-$(date +%Y%m%d-%H%M%S).tar.gz"
            tar -czf "$backup_file" -C "$config_dir" .
            echo "Configuration backed up to: $backup_file"
            ;;
        "restore")
            if [[ $# -lt 2 ]]; then
                echo "Usage: lazygit-config restore <backup-file>"
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

# Lazygit information and debugging
lazygit-info() {
    echo "=== Lazygit Information ==="
    if command -v lazygit >/dev/null 2>&1; then
        echo "Lazygit Version: $(lazygit --version)"
        echo "Config Directory: $HOME/.config/lazygit"
        echo "Config File: $HOME/.config/lazygit/config.yml"
    else
        echo "Lazygit is not installed"
    fi
}

# Lazygit with custom config
lgc() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: lgc <config-file>"
        return 1
    fi
    local config_file="$1"
    if [[ -f "$config_file" ]]; then
        LAZYGIT_CONFIG_FILE="$config_file" lazygit
    else
        echo "Config file not found: $config_file"
    fi
}

# Lazygit with debug mode
lgd() {
    LAZYGIT_DEBUG=true lazygit
}

# Lazygit integration with other tools

# Open lazygit after git operations
git-lg() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: git-lg <git-command> [args...]"
        echo "Example: git-lg clone https://github.com/user/repo.git"
        return 1
    fi

    git "$@" && lazygit
}

# Lazygit with fzf integration for branch selection
lgf() {
    local branch
    branch=$(git branch -a | fzf | sed 's/.* //')
    if [[ -n "$branch" ]]; then
        git checkout "$branch" && lazygit
    fi
}

# Lazygit with ripgrep integration
lggrep() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: lggrep <pattern>"
        return 1
    fi
    local pattern="$1"
    local files=$(rg -l "$pattern" . 2>/dev/null)
    if [[ -n "$files" ]]; then
        echo "Files containing '$pattern':"
        echo "$files"
        echo ""
        echo "Opening lazygit..."
        lazygit
    else
        echo "No files found containing: $pattern"
    fi
}

# Quick git operations with lazygit
lg-commit() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: lg-commit <message>"
        return 1
    fi
    local message="$1"
    git add . && git commit -m "$message" && lazygit
}

lg-push() {
    local branch=$(git branch --show-current)
    git push origin "$branch" && lazygit
}

lg-pull() {
    git pull && lazygit
}

lg-fetch() {
    git fetch --all && lazygit
}

# Lazygit environment variables
export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml"

# Create necessary directories
[[ ! -d "$HOME/.config/lazygit" ]] && mkdir -p "$HOME/.config/lazygit"