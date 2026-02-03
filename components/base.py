import subprocess
from abc import ABC, abstractmethod
from pathlib import Path

from logger import Logger


class Component(ABC):
    def __init__(self, bin_dir: Path, home_dir: Path, configs_dir: Path, logger: Logger):
        self.bin_dir = bin_dir
        self.home_dir = home_dir
        self.configs_dir = configs_dir
        self.logger = logger

    @abstractmethod
    def sync(self): pass

    @abstractmethod
    def check_health(self) -> bool: pass

    def _run_cmd(self, command: str, user_message: str | None = None) -> bool:
        """
        Runs a command directly. If 'sudo' is in the string, 
        the OS will handle the password prompt.
        """
        if user_message:
            self.logger.info(user_message)
        
        try:
            self.logger.debug(f"Executing: {command}")
            # We don't capture output for interactive sudo prompts to work correctly
            subprocess.run(command, shell=True, check=True)
            return True
        except subprocess.CalledProcessError as e:
            self.logger.error(f"Command failed: {command}")
            return False

    def __str__(self):
        return self.__class__.__name__