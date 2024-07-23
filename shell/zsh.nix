{ config, pkgs, lib, ... }: {
  home.file.starship = {
    target = ".config/starship.toml";
    text = ''
      add_newline = false
      command_timeout = 2000

      [directory]
      truncation_length = 8
      truncation_symbol = '…/'
      # Catppuccin 'rosewater'
      style = "bold rosewater"

      [docker_context]
      disabled = true 

      # Sets user-defined palette
      palette = "catppuccin_frappe"

      [character]
      # Note the use of Catppuccin color 'maroon'
      success_symbol = "[[♥](green) ❯](maroon)"
      error_symbol = "[❯](red)"
      vimcmd_symbol = "[❮](green)"

      [palettes.catppuccin_frappe]
      rosewater = "#f2d5cf"
      flamingo = "#eebebe"
      pink = "#f4b8e4"
      mauve = "#ca9ee6"
      red = "#e78284"
      maroon = "#ea999c"
      peach = "#ef9f76"
      yellow = "#e5c890"
      green = "#a6d189"
      teal = "#81c8be"
      sky = "#99d1db"
      sapphire = "#85c1dc"
      blue = "#8caaee"
      lavender = "#babbf1"
      text = "#c6d0f5"
      subtext1 = "#b5bfe2"
      subtext0 = "#a5adce"
      overlay2 = "#949cbb"
      overlay1 = "#838ba7"
      overlay0 = "#737994"
      surface2 = "#626880"
      surface1 = "#51576d"
      surface0 = "#414559"
      base = "#303446"
      mantle = "#292c3c"
      crust = "#232634"
    '';
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    autocd = true;
    dotDir = ".config/zsh";
    #defaultKeymap = "viins"; #vicmd or viins

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      NIXPKGS_ALLOW_UNFREE = "1";
    };

    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true; # ignore commands starting with a space
      save = 20000;
      size = 20000;
      share = true;
    };

    initExtra = ''
      zmodload zsh/zprof
      zprof

      # fixes starship swallowing newlines
      precmd() {
        precmd() {
          echo
        }
      }

      bindkey '^e' edit-command-line
      # this is backspace
      bindkey '^H' autosuggest-accept
      bindkey '^ ' autosuggest-accept

      bindkey '^k' up-line-or-search
      bindkey '^j' down-line-or-search

      bindkey '^r' fzf-history-widget
      bindkey '^f' fzf-file-widget

      function cd() {
        builtin cd $*
        lsd
      }

      function mkd() {
        mkdir $1
        builtin cd $1
      }


      export FZF_DEFAULT_OPTS=" \
      --color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
      --color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
      --color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284"

      export BAT_THEME="Catppuccin-frappe"

      # ssh-add --apple-load-keychain
    '';

    dirHashes = {
      dl = "$HOME/Downloads";
      nix = "$HOME/.nixpkgs";
      code = "$HOME/work/gitlab-uzk";
      work = "$HOME/work";
    };

    shellAliases = {
      # builtins
      size = "du -sh";
      cp = "cp -i";
      mkdir = "mkdir -p";
      df = "df -h";
      du = "du -sh";

      # overrides
      cat = "bat";
      #ssh = "TERM=screen ssh";
      j = "z";
      # docker = "lima nerdctl";

      # programs
      g = "git";
      diff = "delta";
      awake = "caffeinate";

      # terminal cheat sheet
      cht = "cht.sh";

      # utilities
      shut = "sudo shutdown -h now";

      # nix
      ne = "nvim -c ':cd ~/.nixpkgs' ~/.nixpkgs";
      clean = "nix-collect-garbage -d && nix-store --gc && nix-store --verify --check-contents --repair";
      nsh = "nix-shell";
      nse = "nix search nixpkgs";

    };

    plugins = [
      {
        name = "fast-syntax-highlighting";
        file = "fast-syntax-highlighting.plugin.zsh";
        src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
      }
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = "${pkgs.zsh-nix-shell}/share/zsh-nix-shell";
      }
      {
        name = "forgit";
        file = "forgit.plugin.zsh";
        src = "${pkgs.forgit}/share/forgit";
      }
    ];
    prezto = {
      enable = true;
      caseSensitive = false;
      utility.safeOps = true;
      editor = {
        dotExpansion = true;
        keymap = "vi";
      };
      pmodules = [
        "autosuggestions"
        "completion"
        "directory"
        "editor"
        "git"
        "terminal"
        #"ssh"
      ];
    };
  };
}
