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
            component(self.bin_dir, self.home_dir, self.logger, self.configs_dir) 
            for component in ALL_COMPONENTS
        ]

    def sync(self):
        self.logger.info("Starting environment sync...")
        for comp in self.components:
            self.logger.info(f"Syncing component {comp}...")
            with self.logger.indent():
                comp.sync()
                comp.check_health()
        self.logger.info("Sync complete!")

    def health_check(self):
        self.logger.info("Checking components health...")
        for comp in self.components:
            self.logger.info(f"Checking {comp}...")
            with self.logger.indent():
                comp.check_health()