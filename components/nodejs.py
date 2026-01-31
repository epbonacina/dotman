from .base import Component


class NodejsComponent(Component):
    def is_installed(self) -> bool:
        return (self.home_dir / ".nvm").exists()

    def sync(self):
        if not self.is_installed():
            self._run_cmd(
                "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash",
                "Installing NVM..."
            )
        # nvm is a shell function, so we invoke it via bash -c
        self._run_cmd(
            "bash -c 'source $HOME/.nvm/nvm.sh && nvm install --lts'",
            "Ensuring Node LTS is active...",
        )

    def check_health(self) -> bool:
        self.logger.info(f"Checking NodeJS's health...")
        cmd = "bash -c 'source $HOME/.nvm/nvm.sh && node --version'"
        if self._run_cmd(cmd):
            return True
        return False