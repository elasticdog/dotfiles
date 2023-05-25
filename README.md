# dotfiles

A collection of home directory configuration files used across multiple
Unix-based systems; managed via [chezmoi][].

## Usage

See: <https://www.chezmoi.io/user-guide/command-overview/>

### Bootstrap macOS

1. Open the _Terminal.app_ terminal emulator application.

2. Install [Homebrew][] by running the command:
   ```
   $ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```
3. Install [chezmoi][] using Homebrew:
   ```
   $ brew install chezmoi
   ```
4. Initialize and apply all configuration files using chezmoi:
   ```
   $ chezmoi init --apply https://github.com/elasticdog/dotfiles.git
   ```
5. Install additional system software using the [Homebrew bundle][]
   configuration file:
   ```
   $ brew bundle install --file ~/.config/homebrew/Brewfile
   ```

[chezmoi]: https://www.chezmoi.io/
[Homebrew]: https://brew.sh/
[Homebrew bundle]: https://github.com/Homebrew/homebrew-bundle/

## Manual Configuration Steps

Some things are not currently automated for my setup...

### Firefox Extensions

- [Bitwarden](https://addons.mozilla.org/en-US/firefox/addon/bitwarden-password-manager/)
- [Old Reddit Redirect](https://addons.mozilla.org/en-US/firefox/addon/old-reddit-redirect/)
- [Tridactyl](https://addons.mozilla.org/en-US/firefox/addon/tridactyl-vim/)
- [uBlock Origin](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/)
