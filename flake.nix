{
  description = "My Machines";

  # solid
  # nix --experimental-features "nix-command flakes" build ".#homeConfigurations.solid.activationPackage"
  # ./result/activate

  # miraculix
  # nix --experimental-features "nix-command flakes" build ".#darwinConfigurations.miraculix.system"
  # ./result/sw/bin/darwin-rebuild switch --flake ~/.nixpkgs

  # rocky
  # nix --experimental-features "nix-command flakes" build ".#nixosConfigurations.rocky.config.system.build.toplevel"
  # ./result/bin/switch-to-configuration switch
  # or if you want to edit boot entry
  # sudo nixos-rebuild switch --flake ".#rocky"
  # or if you want to install from scratch
  # sudo nixos-install --flake github:breuerfelix/dotfiles#rocky


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

    forgit = {
      url = "github:wfxr/forgit";
      flake = false;
    };

    # custom cursor
    breeze = {
      url = "github:KDE/breeze";
      flake = false;
    };

  };

  outputs = { self, nixpkgs, darwin, home-manager, ... }@inputs:
    let
      nixpkgsConfig = {
        allowUnfree = true;
        allowUnsupportedSystem = false;
        };

      overlays = with inputs; [
        # feovim.overlay
        # krewfile.overlay
      ];
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
          ({ pkgs, ... }: {
            nixpkgs.config = nixpkgsConfig;
            nixpkgs.overlays = overlays;

            system.stateVersion = 4;

            users.users.${user} = {
              home = "/Users/${user}";
              shell = pkgs.zsh;
            };

            nix = {
              # enable flakes per default
              package = pkgs.nixFlakes;
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

      # macbook 13 inch
      # nix-darwin with home-manager for macOS
      darwinConfigurations.idefix= darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        # makes all inputs availble in imported files
        specialArgs = { inherit inputs; };
        modules = [
          ./modules
          ./machines/idefix.nix
          ./darwin/homebrew.nix
          ({ pkgs, ... }: {
            nixpkgs.config = nixpkgsConfig;
            nixpkgs.overlays = overlays;

            system.stateVersion = 4;

            users.users.${user} = {
              home = "/Users/${user}";
              shell = pkgs.zsh;
            };

            nix = {
              # enable flakes per default
              package = pkgs.nixFlakes;
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
                  ./desktop/alacritty.nix
                ];
                home.stateVersion = stateVersion;
              };
            };
          }
        ];
      };


      # standalone home-manager installation
      homeConfigurations.solid =
        let
          system = "x86_64-linux";
          # modifies pkgs to allow unfree packages
          pkgs = import nixpkgs {
            inherit system;
            config = nixpkgsConfig;
            overlays = overlays;
          };
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          # makes all inputs available in imported files
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./modules
            ./home/linux.nix
            ./shell
            ({ ... }: {
              home.stateVersion = stateVersion;
              # home-manager manages itself
              programs.home-manager.enable = true;

              home = {
                username = user;
                homeDirectory = "/home/${user}";
              };
            })
          ];
        };

      # nixos system
      nixosConfigurations.rocky = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        # makes all inputs availble in imported files
        specialArgs = { inherit inputs; inherit user; };
        modules = [
          ./modules
          ./machines/rocky.nix
          ./system
          ({ pkgs, ... }: {
            nixpkgs.config = nixpkgsConfig;
            nixpkgs.overlays = overlays;

            system.stateVersion = stateVersion;

            users.users.${user} = {
              home = "/home/${user}";
              shell = pkgs.zsh;
              isNormalUser = true;
            };

            nix = {
              # enable flakes per default
              package = pkgs.nixFlakes;
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
                  ./modules/base16.nix
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
