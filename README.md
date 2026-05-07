# my dotfiles

heavily inspired by https://github.com/breuerfelix/dotfiles.git thanks!

## installation

the installation instructions are *not* updated for my flake version.

### macos

```bash
# install nix via determinate systems installer
# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
git clone https://github.com:reiferschris/dotfiles.git ~/.nixpkgs
# make sure your hostname is set to the correct machine
sudo reboot

# -- for nix-darwin only --
# build the system
cd ~/.nixpkgs
nix --experimental-features "nix-command flakes" build ".#darwinConfigurations.brummi.system"
# switch to new system
sudo ./result/sw/bin/darwin-rebuild switch --flake ~/.nixpkgs

# all in one command
nix run nix-darwin -- switch --flake ~/.nixpkgs
```

### remote ssh server with home-manager

```bash
# install nix
curl -L https://nixos.org/nix/install | sh
sudo reboot

. ~/.nix-profile/etc/profile.d/nix.sh
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
home-manager switch

# install these dotfiles
rm -rf ~/.config/nixpkgs
git clone https://github.com/reiferschris/dotfiles.git ~/.config/nixpkgs
home-manager switch

# change default shell to zsh
echo $(which zsh) | sudo tee -a /etc/shells
sudo chsh -s $(which zsh) $USER
```

## update

```bash
# all inputs
nix flake update

# single input
nix flake lock --update-input <input>
```

## architecture

* `home.nix` is the home-manager entrypoint for ssh servers 
* `mac.nix` is the home-manager entrypoint for macos
* `darwin-configuration.nix` is the entrypoint for macos system

## content

- distro: macOS / Nixos 
- window manager: aerospace
- terminal: ghostty + zellij
- shell: zsh + pretzo
- editor: neovim

