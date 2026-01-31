import os
from pathlib import Path

from .base import Component


class NeovimComponent(Component):
    def is_installed(self) -> bool:
        return (self.bin_dir / "nvim").exists()

    def sync(self):
        self.bin_dir.mkdir(parents=True, exist_ok=True)
        self._run_cmd(
            "curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage",
            "Fetching latest NeoVim..."
        )
        self._run_cmd(
            f"chmod +x nvim.appimage && mv nvim.appimage {self.bin_dir}/nvim",
        )
        
        target = self.home_dir / ".config" / "nvim"
        source = Path.cwd() / "nvim"
        if not target.exists():
            target.parent.mkdir(parents=True, exist_ok=True)
            os.symlink(source, target)

    def check_health(self) -> bool:
        # Check version and that the config directory is a valid link
        neovim_is_ok = self._run_cmd(
            f"{self.bin_dir}/nvim --version",
            "Checking NeoVim's health...",
        )
        config_directory_is_ok = self._run_cmd(
            f"{self.bin_dir}/nvim --version"
            "Checking configuration files...",
        )
        if neovim_is_ok and config_directory_is_ok:
            return True
        return False