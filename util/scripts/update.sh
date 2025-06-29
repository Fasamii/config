sudo pacman -Syu --noconfirm firefox swww curl git hyprland exa kitty obsidian brightnessctl zsh btop qalculate-qt playerctl bemenu-wayland spotify-launcher man-db grim slurp tesseract-data-pol tesseract-data-eng tesseract wl-clipboard translate-shell jq ripgrep npm iwd base-devel ttf-fira-code unzip noto-fonts-emoji libnotify pandoc tree-sitter tree-sitter-cli imagemagick gdb php
yay -Syu --noconfirm coppwr hyprnotify

go install github.com/go-delve/delve/cmd/dlv@latest

fc-cache -fv # for updating fontconfig cache in case of changing it
