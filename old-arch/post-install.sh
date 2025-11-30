#!/usr/bin/env bash
set -e

# Colors
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
CYAN="\033[1;36m"
RESET="\033[0m"

# Pacman packages (official repos)
PACMAN_PKGS=(
    neovim wl-clipboard bibtex-tidy black skylua astyle ltex-ls-plus harper-ls
    zathura zathura-pdf-mupdf networkmanager nano zsh zsh-completions openssh
    terminus-font emacs python base-devel cmake gcc clang meson ninja gdb
    valgrind cppcheck boost doxygen git texlive m4 sddm plasma-meta firefox
    libreoffice-fresh pass passff-host dolphin ttf-dejavu ark p7zip unrar
    unzip tar texlab imagemagick feh ttf-font-awesome ttf-fira-sans ttf-fira-code
    ttf-firacode-nerd python-dbus hyprland waybar hyprpaper hyprlock hypridle
    hyprpicker wlogout qt5-wayland qt6-wayland brightnessctl nwg-dock-hyprland
    xdg-desktop-portal xdg-desktop-portal-hyprland
)

# AUR packages
AUR_PKGS=(
    tofi
    ttf-meslo-nerd-font-powerlevel10k wlogout
)

# Functions
section() {
    echo -e "\n${CYAN}=== $1 ===${RESET}"
}

# Install yay if missing
if ! command -v yay >/dev/null 2>&1; then
    section "Installing yay (AUR helper)"
    sudo pacman -S --needed --noconfirm git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    pushd /tmp/yay >/dev/null
    makepkg -si --noconfirm
    popd >/dev/null
    rm -rf /tmp/yay
fi

# Show package lists
section "Packages to be installed"
echo -e "${YELLOW}Pacman:${RESET}"
printf "%s\n" "${PACMAN_PKGS[@]}"
echo -e "\n${YELLOW}AUR:${RESET}"
printf "%s\n" "${AUR_PKGS[@]}"

# Confirmation
read -rp "Proceed with installation? [y/N]: " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}Installation aborted.${RESET}"
    exit 1
fi

# Install pacman packages
section "Installing official repository packages"
sudo pacman -Syu --needed --noconfirm "${PACMAN_PKGS[@]}"

# Install AUR packages
section "Installing AUR packages"
yay -S --needed --noconfirm "${AUR_PKGS[@]}"

# Enable services
section "Enabling essential services"
sudo systemctl enable --now NetworkManager
sudo systemctl enable --now sddm

# Install and configure Zsh + plugins + theme
section "Configuring Zsh and Oh My Zsh"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo -e "${YELLOW}Installing Oh My Zsh...${RESET}"
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo -e "${GREEN}Oh My Zsh already installed, skipping.${RESET}"
fi

# Zsh plugins
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# Powerlevel10k theme
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
fi

# Set Zsh as default shell
if [ "$SHELL" != "$(which zsh)" ]; then
    echo -e "${YELLOW}Changing default shell to Zsh...${RESET}"
    chsh -s "$(which zsh)"
fi

section "Setup complete"
echo -e "${GREEN}✔ All packages installed, services enabled, and Zsh configured!${RESET}"
echo -e "${CYAN}Reboot to enjoy your new environment 🚀${RESET}"


#!/usr/bin/env bash
set -e

# Colors
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
CYAN="\033[1;36m"
RESET="\033[0m"

# Pacman packages (official repos)
PACMAN_PKGS=(
    neovim wl-clipboard bibtex-tidy black skylua astyle ltex-ls-plus harper-ls
    zathura zathura-pdf-mupdf networkmanager nano zsh zsh-completions openssh
    terminus-font emacs python base-devel cmake gcc clang meson ninja gdb
    valgrind cppcheck boost doxygen git texlive m4 sddm plasma-meta firefox
    libreoffice-fresh pass passff-host dolphin ttf-dejavu ark p7zip unrar
    unzip tar texlab imagemagick feh ttf-font-awesome ttf-fira-sans ttf-fira-code
    ttf-firacode-nerd python-dbus hyprland waybar hyprpaper hyprlock hypridle
    hyprpicker wlogout qt5-wayland qt6-wayland brightnessctl nwg-dock-hyprland
    xdg-desktop-portal xdg-desktop-portal-hyprland
)

# AUR packages
AUR_PKGS=(
    tofi
    ttf-meslo-nerd-font-powerlevel10k
)

section() {
    echo -e "\n${CYAN}=== $1 ===${RESET}"
}

# Install yay if missing
if ! command -v yay >/dev/null 2>&1; then
    section "Installing yay (AUR helper)"
    sudo pacman -S --needed --noconfirm git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    pushd /tmp/yay >/dev/null
    makepkg -si --noconfirm
    popd >/dev/null
    rm -rf /tmp/yay
fi

# Show package lists
section "Packages to be installed"
echo -e "${YELLOW}Pacman:${RESET}"
printf "%s\n" "${PACMAN_PKGS[@]}"
echo -e "\n${YELLOW}AUR:${RESET}"
printf "%s\n" "${AUR_PKGS[@]}"

# Confirmation
read -rp "Proceed with installation? [y/N]: " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}Installation aborted.${RESET}"
    exit 1
fi

# Install pacman packages
section "Installing official repository packages"
sudo pacman -Syu --needed --noconfirm "${PACMAN_PKGS[@]}"

# Install AUR packages
section "Installing AUR packages"
yay -S --needed --noconfirm "${AUR_PKGS[@]}"

# Enable services
section "Enabling essential services"
sudo systemctl enable --now NetworkManager
sudo systemctl enable --now sddm

# Install and configure Zsh + plugins + theme
section "Configuring Zsh and Oh My Zsh"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo -e "${YELLOW}Installing Oh My Zsh...${RESET}"
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo -e "${GREEN}Oh My Zsh already installed, skipping.${RESET}"
fi

# Zsh plugins
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# Powerlevel10k theme
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
fi

# Set Zsh as default shell
if [ "$SHELL" != "$(which zsh)" ]; then
    echo -e "${YELLOW}Changing default shell to Zsh...${RESET}"
    chsh -s "$(which zsh)"
fi

# Install dpic
section "Installing dpic from source"
TMP_DIR=$(mktemp -d)
git clone https://github.com/rpuntaie/dpic.git "$TMP_DIR/dpic"
pushd "$TMP_DIR/dpic" >/dev/null
make
sudo cp dpic /usr/local/bin
popd >/dev/null
rm -rf "$TMP_DIR"

section "Setup complete"
echo -e "${GREEN}✔ All packages installed, services enabled, Zsh configured, and dpic installed!${RESET}"
echo -e "${CYAN}Reboot to enjoy your new environment 🚀${RESET}"
