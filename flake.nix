{
  description = "My Machines";


  # miraculix
  # nix --experimental-features "nix-command flakes" build ".#darwinConfigurations.miraculix.system"
  # ./result/sw/bin/darwin-rebuild switch --flake ~/.nixpkgs

  # obelix
  # nix --experimental-features "nix-command flakes" build ".#nixosConfigurations.obelix.config.system.build.toplevel"
  # ./result/bin/switch-to-configuration switch
  # or if you want to edit boot entry
  # sudo nixos-rebuild switch --flake ".#obelix"
  # or if you want to install from scratch
  # sudo nixos-install --flake github:reiferschris/dotfiles#obelix


  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, darwin, home-manager, disko, ... }@inputs:
    let
      nixpkgsConfig = {
        allowUnfree = true;
        allowUnsupportedSystem = false;
      };
      stateVersion = "22.05";
      user = "chris";
    in
    {

      # macbook air m1 work
      # nix-darwin with home-manager for macOS
      darwinConfigurations.miraculix = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        # makes all inputs availble in imported files
        specialArgs = { inherit inputs; };
        modules = [
          ./modules
          ./machines/miraculix.nix
          ./darwin/homebrew.nix
          ({ pkgs, lib, ... }: {
            nixpkgs.config = nixpkgsConfig;

            system.stateVersion = 4;

            users.users.${user} = {
              home = "/Users/${user}";
              shell = lib.mkDefault pkgs.zsh;
            };

            nix = {
              # enable flakes per default
              package = pkgs.nixVersions.stable;
              settings = {
                allowed-users = [ user ];
                experimental-features = [ "nix-command" "flakes" ];
              };
            };
          })
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              # makes all inputs available in imported files for hm
              extraSpecialArgs = { inherit inputs; };
              users.${user} = { ... }: {
                imports = [
                  ./home/mac.nix
                  ./darwin
                  ./shell
                  ./desktop/wezterm.nix
                ];
                home.stateVersion = stateVersion;
              };
            };
          }
        ];
      };

      # macbook 13 inch
      # nix-darwin with home-manager for macOS
      darwinConfigurations.idefix = darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        # makes all inputs availble in imported files
        specialArgs = { inherit inputs; };
        modules = [
          ./modules
          ./machines/idefix.nix
          ./darwin/homebrew.nix
          ({ pkgs, lib, ... }: {
            nixpkgs.config = nixpkgsConfig;

            system.stateVersion = 4;

            users.users.${user} = {
              home = "/Users/${user}";
              shell = lib.mkDefault pkgs.zsh;
            };

            nix = {
              # enable flakes per default
              package = pkgs.nixVersions.stable;
              settings = {
                allowed-users = [ user ];
                experimental-features = [ "nix-command" "flakes" ];
              };
            };
          })
          home-manager.darwinModule
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              # makes all inputs available in imported files for hm
              extraSpecialArgs = { inherit inputs; };
              users.${user} = { ... }: {
                imports = [
                  ./home/mac.nix
                  ./darwin
                  ./shell
                  ./desktop/wezterm.nix
                ];
                home.stateVersion = stateVersion;
              };
            };
          }
        ];
      };

      # nixos system
      nixosConfigurations.obelix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        # makes all inputs availble in imported files
        specialArgs = { inherit inputs; inherit user; };
        modules = [
          ./modules
          ./machines/obelix.nix
          ./system
          disko.nixosModules.disko
          ({ pkgs, ... }: {
            nixpkgs.config = nixpkgsConfig;

            system.stateVersion = stateVersion;

            users.users.${user} = {
              home = "/home/${user}";
              shell = pkgs.zsh;
              isNormalUser = true;
            };

            nix = {
              # enable flakes per default
              package = pkgs.nixVersions.stable;
              settings = {
                allowed-users = [ user ];
                experimental-features = [ "nix-command" "flakes" ];
              };
            };
          })
          home-manager.nixosModule
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              # makes all inputs available in imported files for hm
              extraSpecialArgs = { inherit inputs; };
              users.${user} = { ... }: {
                imports = [
                  ./home/linux.nix
                  ./shell
                  ./desktop
                ];
                home.stateVersion = stateVersion;
              };
            };
          }
        ];
      };

    };
}
