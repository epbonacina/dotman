from .base import Component


class PythonComponent(Component):
    name = "Python (Pyenv)"
    binary_name = "pyenv"

    def is_installed(self) -> bool:
        return (self.home_dir / ".pyenv").exists()

    def sync(self):
        if not self.is_installed():
            self._run_cmd(
                "curl https://pyenv.run | bash",
                "Installing Pyenv...",
            )
            self._run_cmd(
                "bash -c 'export PATH=\"$HOME/.pyenv/bin:$PATH\" && eval \"$(pyenv init -)\" && pyenv install -s 3 && pyenv global 3'",
                "Installing latest Python 3 version...",
            )
        else:
            self._run_cmd(
                f"git -C {self.home_dir}/.pyenv pull",
                "Updating Pyenv...",
            )

    def check_health(self) -> bool:
        self.logger.info(f"Checking Python's health...")
        check_cmd = "bash -c 'export PATH=\"$HOME/.pyenv/bin:$PATH\" && eval \"$(pyenv init -)\" && python3 --version'"
        if self._run_cmd(check_cmd):
            return True
        return False
