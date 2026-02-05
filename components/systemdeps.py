import shutil
import subprocess

from .base import Component


class SystemDepsComponent(Component):
    name = "System Dependencies"
    _dependencies = {
    # This dictionary contains package names and their executables.
    "build-essential": None,     # Libraries don't have unified executables.
    "clangd": "clangd",
    "cmake": "cmake",
    "curl": "curl",
    "git": "git",
    "libssl-dev": None,
    "meld": "meld",
    "ripgrep": "rg",
    "tree-sitter-cli": "tree-sitter",
    "unzip": "unzip",
    "xclip": "xclip",
    }
    
    def sync(self):
        self.logger.info("Syncing system libraries and build tools...")
        if not self.is_installed():
            self._run_cmd(
                "sudo apt update",
                "Updating system packages (without upgrading them)...",
            )

            self._run_cmd(
                f"sudo apt install -y {" ".join(self._dependencies.keys())}",
                "Installing programming dependencies...",
            )

    def is_installed(self) -> bool:
        return self.check_health()

    def check_health(self) -> bool:
        self.logger.info(f"Checking system dependencies...")
        results = []
        for package, binary in self._dependencies.items():
            results.append(self._check_dependency(package, binary))
        return all(r is True for r in results)

    def _check_dependency(self, package: str, binary: str | None) -> bool:
        """Helper to check either binary or package status."""
        if binary:
            return shutil.which(binary) is not None
        
        # If 'binary' is None, the package is a library and needs to
        # be checked with 'dpkg-query'.
        cmd = f"dpkg-query -W -f='${{Status}}' {package}"
        result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
        return "ok installed" in result.stdout
