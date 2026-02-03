from pathlib import Path

from .base import Component


class DotmanComponent(Component):
    def sync(self):
        """
        Updates dotman by pulling the latest changes from its Git repository.
        """
        dotman_dir = Path(__file__).parent.absolute()
        self.logger.info("Syncing dotman...")
        
        # -C tells git to run as if it were in that directory
        command = f"git -C {dotman_dir} pull"
        
        success = self._run_cmd(
            command,
            "Fetching latest updates for dotman...",
        )
        if success:
            self.logger.info("dotman is up to date.")
        else:
            self.logger.error("Failed to sync dotman.")

    def check_health(self) -> bool:
        """
        Verifies that dotman's environment is healthy.
        """
        dotman_dir = Path(__file__).parent.parent.absolute()
        
        # Check if we are actually in a git repository
        is_git_repo = (dotman_dir / ".git").exists()
        
        if not is_git_repo:
            self.logger.error(f"dotman directory ({dotman_dir}) is not in a git repository.")
            return False
            
        self.logger.debug("dotman health check passed.")
        return True