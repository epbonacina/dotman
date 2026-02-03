Dotman is a simple utility tool used to download, update and check the health of my most used programming tools, including Neovim, Pyenv, Rust and its toolchain, LLVM, NodeJS and all related LSP's.

# Installation
The easiest way to install **dotman** is to run the automated installation script. This will clone the repository to `~/.dotman`, set up the necessary permissions and
add a `dotman` alias to your shell configuration (`.bashrc` or `.zshrc`).

## Quick installation

Open your terminal and run
```bash
curl -sSL https://raw.githubusercontent.com/epbonacina/dotman/main/install.sh | bash
```

## Manual installation

If your prefer to install it manually, so that you can customize some things,
follow these steps:  

1. **Clone the repository:**
```bash
git clone https://github.com/epbonacina/dotman.git ~/.dotman
```

2. **Make it executable:**
```bash
chmod +x ~/.dotman/main.py
```

3. **Add an alias:**
```bash
alias dotman='~/.dotman/main.py'
```

4. **Reload your shell:**
```bash
source ~/.bashrc  # or source ~/.zshrc
```

## Verifying the installation
Once installed, you can verify that everything is working by checking the help menu:
```bash
dotman --help
```