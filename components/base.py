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
        if user_message:
            self.logger.info(user_message)
        
        try:
            self.logger.debug(f"Executing: {command}")
            
            result = subprocess.run(
                command, 
                shell=True, 
                check=True, 
                capture_output=True, 
                text=True
            )
            
            if result.stdout:
                self.logger.debug(f"Output: {result.stdout.strip()}")
            return True

        except subprocess.CalledProcessError as e:
            self.logger.error(f"Command failed: {command}")
            if e.stderr:
                self.logger.error(f"Error details: {e.stderr.strip()}")
            return False

    def __str__(self):
        return self.__class__.__name__