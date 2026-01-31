import argparse

from dotman import Dotman

def main():
    parser = argparse.ArgumentParser(description="Dotman: An automatic programming environment configuration tool.")
    parser.add_argument("--doctor", action="store_true", help="Run a health check on the system.")
    parser.add_argument("--sync", action="store_true", help="Install/Update all components.")
    args = parser.parse_args()

    dm = Dotman()
    
    if args.doctor:
        dm.health_check()
    elif args.sync:
        dm.sync()
    else:
        parser.print_help()
    

if __name__ == "__main__":
    main()