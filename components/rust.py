import shutil

from .base import Component


class RustComponent(Component):
    def is_installed(self) -> bool:
        return shutil.which("rustup") is not None

    def sync(self):
        if not self.is_installed():
            self._run_cmd(
                "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y",
                "Installing Rust...",
            )
            self._run_cmd(
                "rustup component add rust-analyzer",
                "Installing rust-analyzer...",
            )
        else:
            self._run_cmd(
                "rustup update",
                "Updating Rust toolchains..."
            )

    def check_health(self) -> bool:
        rust_is_installed = self._run_cmd(
            "rustc --version",
            "Checking Rust's installation...",
        )
        rust_analyzer_is_installed = self._run_cmd(
            "rustup component add rust-analyzer",
            "Checking rust-analyzer's installation...",
        )
        if rust_is_installed and rust_analyzer_is_installed:
            return True
        return False