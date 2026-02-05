import os
from pathlib import Path

from .base import Component


class NeovimComponent(Component):
    def is_installed(self) -> bool:
        return (self.bin_dir / "nvim").exists()

    def sync(self):
        self.bin_dir.mkdir(parents=True, exist_ok=True)
        self._run_cmd(
            'curl -L https://github.com/neovim/neovim/releases/download/v0.11.6/nvim-linux-x86_64.appimage -o /tmp/nvim.new',
            "Fetching latest NeoVim...",
        )
        self._run_cmd(
            "chmod +x /tmp/nvim.new",
        )

        self._run_cmd(
            f"mv /tmp/nvim.new {self.bin_dir}/nvim",
        )
        
        target = self.home_dir / ".config" / "nvim"
        source = self.configs_dir / "nvim"
        if not target.exists():
            target.parent.mkdir(parents=True, exist_ok=True)
            os.symlink(source.absolute(), target)

    def check_health(self) -> bool:
        return self._run_cmd(
            f"{self.bin_dir}/nvim --version",
            "Checking NeoVim's health...",
        )
