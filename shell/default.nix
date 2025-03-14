{ config, pkgs, lib, inputs, system, ... }: {
  imports = [
    ./zsh.nix
    ./adblock.nix
    ./nvim.nix
    ./tmux.nix
    ./zellij.nix
    ./git.nix
  ];

  home = {
    packages = with pkgs; [
      neovim

      # net tools
      #bind # marked as broken
      nmap
      inetutils

      # core
      openssl
      wget
      curl
      fd
      ripgrep # fast search

      # htop alternatives
      bottom
      btop
      #gotop # TODO fix

      comma # nix-shell wrapper
      grc # colored log output
      gitAndTools.delta # pretty diff tool
      sshfs # mount folders via ssh
      gh # github cli tool
      tealdeer # community driven man pages
      dive # analyse docker images
      ffmpeg # video editing and cutting
      rclone # sync files
      duf # disk usage
      httpie # awesome alternative to curl
      bitwarden-cli
      unixtools.watch # watches commands
      crane # container registry tool
      pass
      pandoc

      # gnu binaries
      coreutils-full # installs some gnu versions of linux bins
      gnutar
      gnused
      gnugrep
      gnumake
      gzip
      findutils
      gawk
      gnupg

      #programming
      python3
      nodejs
      nodePackages.npm
      nodePackages.yarn
      cargo
      php81Packages.composer
      blade-formatter
      unixODBCDrivers.mariadb

      starship # terminal prompt
      slides # terminal presentation tool
      glab # gitlab commandline tool

      # custom nixFlakes command for home-manager standalone
      (pkgs.writeShellScriptBin "nx" ''
        exec ${pkgs.nixVersions.stable}/bin/nix --experimental-features "nix-command flakes" "$@"
      '')
    ];

    sessionPath = [
      "$HOME/go/bin"
      "$HOME/.local/bin"
      "$HOME/.cargo/bin"
    ];
    sessionVariables = {
      GO111MODULE = "on";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  programs = {
    # let home-manager manage itself
    home-manager.enable = true;

    #setup direnv
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    # shell integrations are enabled by default
    zoxide.enable = true; # autojump
    jq.enable = true; # json parser
    bat.enable = true; # pretty cat
    lazygit.enable = true; # git tui
    nnn.enable = true; # file browser

    # pretty ls
    lsd = {
      enable = true;
      enableAliases = true;
    };

    htop = {
      enable = true;
      settings = {
        tree_view = true;
        show_cpu_frequency = true;
        show_cpu_usage = true;
        show_program_path = false;
      };
    };

    fzf = {
      enable = true;
      defaultCommand = "fd --type f --hidden --follow --exclude .git --exclude .vim --exclude .cache --exclude vendor";
      defaultOptions = [
        "--border sharp"
        "--inline-info"
        "--bind ctrl-h:preview-down,ctrl-l:preview-up"
      ];
    };
  };
}
