#!/bin/bash
set -e

# --------------------------
# Files (edit these as needed)
# --------------------------
PKGFILE_PACKMAN="./installed_packages_pacman.txt"
PKGFILE_AUR="./installed_packages_aur.txt"

# --------------------------
# Function: read a package file into an array
# --------------------------
read_pkg_file() {
    local file="$1"

    if [ ! -f "$file" ]; then
        echo "ERROR: Package file not found: $file"
        exit 1
    fi

    # Read file line-by-line, ignore blank lines + comments
    mapfile -t arr < <(grep -v '^\s*$' "$file" | grep -v '^\s*#')
    echo "${arr[@]}"
}

# --------------------------
# Load both package lists
# --------------------------
echo "==> Reading package lists..."

PACMAN_PKGS=($(read_pkg_file "$PKGFILE_PACKMAN"))
AUR_PKGS=($(read_pkg_file "$PKGFILE_AUR"))

echo "Main packages: ${#PACMAN_PKGS[@]}"
echo "Extra packages: ${#AUR_PKGS[@]}"

# --------------------------
# Update system
# --------------------------
echo "==> Updating system..."
sudo pacman -Syu --noconfirm

# --------------------------
# Install main list
# --------------------------
echo "==> Installing main packages..."
sudo pacman -S --needed --noconfirm "${PACMAN_PKGS[@]}"

# --------------------------
# Install yay (AUR helper)
# --------------------------
if ! command -v yay >/dev/null 2>&1; then
    echo "==> Installing yay..."
    sudo pacman -S --needed --noconfirm git base-devel

    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ../
    rm -rf yay
else
    echo "==> yay already installed."
fi

# --------------------------
# Install extra list
# --------------------------
echo "==> Installing extra packages..."
yay -S --needed --noconfirm "${AUR_PKGS[@]}"


echo "==> Done!"
