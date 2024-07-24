# my dotfiles

heavily inspired by https://github.com/breuerfelix/dotfiles.git thanks!

## installation

the installation instructions are *not* updated for my flake version.

### macos

```bash
# install nix
sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume --daemon
sudo reboot

nix-channel --add https://github.com/LnL7/nix-darwin/archive/master.tar.gz darwin
nix-channel --update
nix-shell '<darwin>' -A installer
darwin-rebuild switch

# install these dotfiles
git clone https://github.com/reiferschris/dotfiles.git ~/.nixpkgs
darwin-rebuild switch
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
- window manager: yabai
- bar: übersicht
- terminal: wezterm + tmux/zellij
- shell: zsh + pretzo
- editor: neovim

