import subprocess
from pathlib import Path

from logger import logger
from components import ALL_COMPONENTS


class Dotman:
    def __init__(self):
        self.logger = logger
        self.home_dir = Path.home()
        self.bin_dir = self.home_dir / "tools"
        self.configs_dir = Path("configs")
        
        self.components = [
            component(self.bin_dir, self.home_dir, self.configs_dir, self.logger) 
            for component in ALL_COMPONENTS
        ]

    def sync(self):
        if not self._prime_sudo():
            return

        self.logger.info("Starting environment sync...")
        results = []
        for comp in self.components:
            self.logger.info(f"Syncing component {comp}...")
            with self.logger.indent():
                comp.sync()
                results.append(comp.check_health())
        
        if all(r is True for r in results):
            self.logger.info("Synchronization completed successfully.")
        else:
            self.logger.error("Synchronization completed with errors.")

    def _prime_sudo(self):
        """
        Primes the sudo timestamp so subsequent sudo calls don't require a
        password.
        """
        self.logger.info("Authenticating for system tasks...")
        try:
            subprocess.run(["sudo", "-v"], check=True, capture_output=True)
            self.logger.info("Authentication successful.")
            return True
        except subprocess.CalledProcessError:
            self.logger.error("Authentication failed.")
            return False

    def health_check(self):
        self.logger.info("Checking components health...")
        for comp in self.components:
            self.logger.info(f"Checking {comp}...")
            with self.logger.indent():
                comp.check_health()