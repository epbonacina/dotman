#!/bin/bash

echo "Installing dotman..."

INSTALL_DIR="$HOME/.dotman"
REPO_URL="https://github.com/epbonacina/dotman.git"

# 1. Clone or Update the repository
if [ -d "$INSTALL_DIR" ]; then
    echo "Directory $INSTALL_DIR already exists. Updating..."
    cd "$INSTALL_DIR" && git pull
else
    echo "Cloning dotman into $INSTALL_DIR..."
    git clone "$REPO_URL" "$INSTALL_DIR"
fi

# 2. Make the main script executable
chmod +x "$INSTALL_DIR/main.py"

# 3. Determine shell config
if [[ "$SHELL" == *"zsh"* ]]; then
    SHELL_CONFIG="$HOME/.zshrc"
elif [[ "$SHELL" == *"bash"* ]]; then
    SHELL_CONFIG="$HOME/.bashrc"
else
    echo "Unknown shell. Add this alias manually: alias dotman='$INSTALL_DIR/main.py'"
    exit 1
fi

# 4. Add the alias if it doesn't exist
ALIAS_CMD="alias dotman='$INSTALL_DIR/main.py'"

if grep -q "alias dotman=" "$SHELL_CONFIG"; then
    echo "Alias already exists in $SHELL_CONFIG."
else
    echo "" >> "$SHELL_CONFIG"
    echo "# dotman: development environment manager" >> "$SHELL_CONFIG"
    echo "$ALIAS_CMD" >> "$SHELL_CONFIG"
    echo "Alias added to $SHELL_CONFIG."
fi

echo "------------------------------------------------"
echo "Done! Restart your terminal or run: source $SHELL_CONFIG"
echo "You can now use 'dotman' from anywhere."