#!/bin/bash

# Define arrays for pacman (official) and paru (AUR) packages
# Note: Package names are standardized for Arch/AUR.

# Official packages (pacman)
pacman_packages=(
    # Core utilities
    "stow"
    "zoxide"
    "go" # For Go runtime and development tools
    
    # System and Container tools
    "podman"
    "podman-compose" # Replaces podman-docker-compose
    
    # Desktop applications/Tools
    "nautilus" # GNOME file manager
    "neovim"
)

# AUR packages (paru)
paru_packages=(
    # Terminal-based tools
    "yazi" # File manager
    "ghostty" # Terminal emulator
    "lazygit"
    "lazydocker"

    # Go and Docker tools
    "go-task" # Task runner (often go-task-bin or similar in AUR)
    "goose-cli" # Database migration tool (often goose-cli-bin or similar in AUR)
    
    # Desktop applications
    "bruno" # API client
    "discord"
    "discord-canary"
    "tableplus" # Database GUI client
)

# Go-specific installation for airverse
AIRVERSE_INSTALL="go install github.com/air-verse/air@latest"

BUN_INSTALL="curl -fsSL https://bun.com/install | bash"

echo "Updating system before installing new packages..."
sudo pacman -Syu --noconfirm

---

echo "Installing official packages with pacman..."
for pkg in "${pacman_packages[@]}"; do
    echo "Installing $pkg..."
    # --needed prevents re-installing packages that are already installed
    sudo pacman -S --noconfirm --needed "$pkg"
done


---

## ⚡ Installing Bun Runtime
echo "Installing the Bun Javascript runtime..."
# Installation command from the official Bun documentation:
if command -v curl &> /dev/null; then
    curl -fsSL https://bun.com/install | bash
    # Note: Bun installs to ~/.bun/bin and updates your shell's config ($PATH).
else
    echo "**Warning:** 'curl' command not found. Skipping 'Bun' installation."
fi

---

echo "Installing **airverse** using 'go install'..."
# Ensure Go environment is set up and working for 'go install'
if command -v go &> /dev/null; then
    echo "Executing: $AIRVERSE_INSTALL"
    $AIRVERSE_INSTALL
    # Note: Ensure $HOME/go/bin is in your \$PATH to run airverse.
else
    echo "**Warning:** 'go' command not found. Skipping 'airverse' installation."
fi



---

echo "Installing AUR packages with paru..."
# Ensure paru is available before trying to use it.
if ! command -v paru &> /dev/null; then
    echo "**Error:** 'paru' not found. Please ensure 'paru' is installed or manually install the AUR packages."
    exit 1
fi

for pkg in "${paru_packages[@]}"; do
    echo "Installing $pkg..."
    paru -S --noconfirm --needed "$pkg"
done

---
echo "Batch installation complete. 🎉"
