""" Entry point for the doc-docs package. """
from . import Config

def main():
    """ Main function for the doc-docs package. """
    config = Config()
    config.parse()
    print("Parsed some configs.")


if __name__ == "__main__":
    main()
