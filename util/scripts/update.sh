sudo pacman -Syu --needed --noconfirm firefox swww curl git hyprland exa kitty obsidian brightnessctl zsh btop qalculate-qt playerctl bemenu-wayland spotify-launcher man-db grim slurp tesseract-data-pol tesseract-data-eng tesseract wl-clipboard translate-shell jq ripgrep npm iwd base-devel ttf-fira-code unzip noto-fonts-emoji libnotify pandoc tree-sitter tree-sitter-cli imagemagick gdb php feh vlc python-adblock lf bat python-pdftotext unrar chafa rnote

yay -Syu --needed --noconfirm coppwr hyprnotify proton-ge-custom

go install github.com/go-delve/delve/cmd/dlv@latest

fc-cache -fv # for updating fontconfig cache in case of changing it
