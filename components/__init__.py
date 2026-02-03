from .dotman import DotmanComponent
from .neovim import NeovimComponent
from .nodejs import NodejsComponent
from .python import PythonComponent
from .rust import RustComponent
from .systemdeps import SystemDepsComponent


__all__ = [
    "NeovimComponent",
    "NodejsComponent",
    "PythonComponent",
    "RustComponent", 
    "SystemDepsComponent",
]

ALL_COMPONENTS = [
    # 'SystemDepsComponent' should always be the first one, because system
    # dependecies need to be installed first.
    SystemDepsComponent,
    RustComponent,
    NodejsComponent,
    PythonComponent,
    NeovimComponent,
    DotmanComponent,
]