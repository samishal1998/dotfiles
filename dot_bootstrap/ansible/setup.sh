#!/bin/bash
# Ansible setup script for development environment

set -e

echo "🚀 Setting up development environment with Ansible..."

# # Check if Ansible is installed
# if ! command -v ansible-playbook >/dev/null 2>&1; then
#     echo "Installing Ansible..."
#     if command -v pip3 >/dev/null 2>&1; then
#         pip3 install ansible
#     elif command -v pip >/dev/null 2>&1; then
#         pip install ansible
#     else
#         echo "Error: pip not found. Please install Python and pip first."
#         exit 1
#     fi
# fi
#
echo "Checking if Ansible is installed..."
if ! command -v ansible-playbook >/dev/null 2>&1; then
  echo "Installing Ansible..."
  if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Installing Ansible on using homebrew..."
    brew update
    brew install ansible
  elif [[ "$OSTYPE" == "linux"* ]]; then

    # Check for package manager and install Ansible accordingly
    echo "Determining package manager..."
    if command -v apt > /dev/null 2>&1; then 
      echo "Installing Ansible on Linux using apt..."
      apt-get update && apt-get install -y ansible
    elif command -v yum > /dev/null 2>&1; then
      echo "Installing Ansible on Linux using yum..."
      yum install -y ansible
    elif command -v dnf > /dev/null 2>&1; then
      echo "Installing Ansible on Linux using dnf..."
      dnf install -y ansible
    else
      echo "Error: Package manager not found. Please install Ansible manually."
      exit 1
    fi

  fi

fi

# Check if we're running on macOS and need to install additional collections
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "Installing Ansible collections for macOS..."
  ansible-galaxy collection install community.general
fi

# Run the playbook
echo "Running Ansible playbook..."
ansible-playbook -i inventory.yml playbook.yml --ask-become-pass

echo "✅ Development environment setup complete!"
echo ""
echo "Next steps:"
echo "1. Configure 1Password: op account add --address YOUR_SUBDOMAIN.1password.com"
echo "2. Set up SSH keys: ssh-keygen -t ed25519 -C 'your.email@example.com'"
echo "3. Configure Git: git config --global user.name 'Your Name'"
echo "4. Install language-specific tools as needed"
