import logging
import sys
from contextlib import contextmanager


class Logger:
    def __init__(self):
        self.indentation_level = 1
        self.logger = logging.getLogger()
        self.logger.setLevel(logging.DEBUG)

        formatter = self.get_formatter()
        
        if not self.logger.handlers:
            handlers = [
                self.get_file_handler(formatter),
                self.get_console_handler(formatter),
            ]

            for handler in handlers:
                self.logger.addHandler(handler)

    def get_formatter(self) -> logging.Formatter:
        return logging.Formatter(
            fmt='[%(asctime)s - %(levelname)8s] %(message)s',
            datefmt='%Y-%m-%d %H:%M:%S'
        )

    def get_file_handler(self, formatter: logging.Formatter) -> logging.Handler:
        file_handler = logging.FileHandler('output.log', mode='w')
        file_handler.setLevel(logging.DEBUG)
        file_handler.setFormatter(formatter)
        return file_handler

    def get_console_handler(self, formatter: logging.Formatter) -> logging.Handler:
        console_handler = logging.StreamHandler(sys.stdout)
        console_handler.setLevel(logging.INFO)
        console_handler.setFormatter(formatter)
        return console_handler

    @contextmanager
    def indent(self):
        self.indentation_level += 1
        try:
            yield
        finally:
            self.indentation_level -= 1

    def info(self, m): self.logger.info(self._indent(m))
    def error(self, m): self.logger.error(self._indent(m))
    def debug(self, m): self.logger.debug(self._indent(m))

    def _indent(self, message: str) -> str:
        message = f"{'  ' * self.indentation_level}{message}"
        return message

logger = Logger()