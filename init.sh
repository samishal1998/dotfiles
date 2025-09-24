#!/usr/bin/env bash

set -euo pipefail

echo "🚀 Initializing base environment (curl, wget, python3, pip, Ansible)..."

OS="$(uname -s)"
OSTYPE_LC="${OSTYPE:-}" 

has_cmd() { command -v "$1" >/dev/null 2>&1; }

install_macos() {
  if ! has_cmd brew; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
    # shellcheck disable=SC1091
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    brew update
  fi

  for pkg in curl wget python ansible; do
    if ! has_cmd "${pkg%% *}"; then
      echo "Installing $pkg via Homebrew..."
      brew install "$pkg" || true
    fi
  done

  if ! has_cmd chezmoi; then
    echo "Installing chezmoi via Homebrew..."
    brew install chezmoi || true
  fi
}

install_linux() {
  PM=""
  if has_cmd apt; then PM=apt; fi
  if has_cmd dnf; then PM=dnf; fi
  if has_cmd yum; then PM=yum; fi

  if [[ -z "$PM" ]]; then
    echo "❌ Supported package manager not found (apt/dnf/yum). Install prerequisites manually."
    exit 1
  fi

  echo "Using package manager: $PM"

  case "$PM" in
    apt)
      sudo apt update -y
      sudo apt install -y curl wget python3 python3-pip git software-properties-common || true
      # Prefer distro ansible if available
      if ! has_cmd ansible-playbook; then
        pip3 install --break-system-packages --user ansible
      fi
      ;;
    dnf)
      sudo dnf install -y curl wget python3 python3-pip git || true
      if ! has_cmd ansible-playbook; then
        pip3 install --break-system-packages  --user ansible
      fi
      ;;
    yum)
      sudo yum install -y curl wget python3 python3-pip git || true

      ;;
  esac

  if ! has_cmd ansible-playbook; then
  pip3 install --break-system-packages  --user ansible
  fi
  if ! has_cmd chezmoi; then
    echo "Installing chezmoi..."
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin" || true
    mkdir -p "$HOME/.local/bin"
    export PATH="$HOME/.local/bin:$PATH"
  fi
}

case "$OS" in
  Darwin)
    install_macos
    ;;
  Linux)
    install_linux
    ;;
  *)
    echo "❌ Unsupported OS: $OS"
    exit 1
    ;;
esac

echo "📦 Ensuring Ansible collection for Homebrew (macOS) and general modules..."
ansible-galaxy collection install community.general || true

echo "🏁 Running Ansible init playbook (bootstrap_init role)..."
cd "$(dirname "$0")/dot_bootstrap/ansible"
ansible-playbook -i inventory.yml init-playbook.yml --ask-become-pass || true

cat <<'EONEXT'

✅ Base initialization complete.

Next steps:
1) If 1Password CLI (op) was installed, sign in:
   op account add --address YOUR_SUBDOMAIN.1password.com
   eval $(op signin --account YOUR_SUBDOMAIN)

2) Apply dotfiles with chezmoi (after op sign-in so secrets resolve):
   chezmoi init --apply

3) Run full environment provisioning:
   cd ~/.local/share/chezmoi/dot_bootstrap/ansible
   ./setup.sh

If your PATH was updated by language managers, open a new shell before step 3.
EONEXT


