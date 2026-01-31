import shutil

from .base import Component


class SystemDepsComponent(Component):
    name = "System Dependencies"
    
    def is_installed(self) -> bool:
        # Check for a critical build tool
        return shutil.which("gcc") is not None

    def sync(self):
        self.logger.info("Syncing system libraries and build tools...")
        pkgs = "git curl build-essential libssl-dev unzip clangd ripgrep cmake"
        self._run_cmd(f"sudo apt update && sudo apt install -y {pkgs}", "Updating APT packages...")

    def check_health(self) -> bool:
        self.logger.info(f"Checking system dependencies...")
        if shutil.which("git") and shutil.which("clangd"):
            return True
        return False