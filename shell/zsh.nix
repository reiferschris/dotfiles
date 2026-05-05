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
      palette = "catppuccin_latte"

      [character]
      # Note the use of Catppuccin color 'maroon'
      success_symbol = "[[♥](green) ❯](maroon)"
      error_symbol = "[❯](red)"
      vimcmd_symbol = "[❮](green)"

      [palettes.catppuccin_macchiato]
      rosewater = "#f4dbd6"
      flamingo = "#f0c6c6"
      pink = "#f5bde6"
      mauve = "#c6a0f6"
      red = "#ed8796"
      maroon = "#ee99a0"
      peach = "#f5a97f"
      yellow = "#eed49f"
      green = "#a6da95"
      teal = "#8bd5ca"
      sky = "#91d7e3"
      sapphire = "#7dc4e4"
      blue = "#8aadf4"
      lavender = "#b7bdf8"
      text = "#cad3f5"
      subtext1 = "#b8c0e0"
      subtext0 = "#a5adcb"
      overlay2 = "#939ab7"
      overlay1 = "#8087a2"
      overlay0 = "#6e738d"
      surface2 = "#5b6078"
      surface1 = "#494d64"
      surface0 = "#363a4f"
      base = "#24273a"
      mantle = "#1e2030"
      crust = "#181926"

      [palettes.catppuccin_latte]
      rosewater = "#dc8a78"
      flamingo = "#dd7878"
      pink = "#ea76cb"
      mauve = "#8839ef"
      red = "#d20f39"
      maroon = "#e64553"
      peach = "#fe640b"
      yellow = "#df8e1d"
      green = "#40a02b"
      teal = "#179299"
      sky = "#04a5e5"
      sapphire = "#209fb5"
      blue = "#1e66f5"
      lavender = "#7287fd"
      text = "#4c4f69"
      subtext1 = "#5c5f77"
      subtext0 = "#6c6f85"
      overlay2 = "#7c7f93"
      overlay1 = "#8c8fa1"
      overlay0 = "#9ca0b0"
      surface2 = "#acb0be"
      surface1 = "#bcc0cc"
      surface0 = "#ccd0da"
      base = "#eff1f5"
      mantle = "#e6e9ef"
      crust = "#dce0e8"
    '';
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    autocd = true;
    dotDir = config.xdg.configHome + "/zsh";
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

    initContent = ''
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


      # export FZF_DEFAULT_OPTS=" \
      # --color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
      # --color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
      # --color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284"
      export FZF_DEFAULT_OPTS=" \
      --color=bg+:#CCD0DA,bg:#EFF1F5,spinner:#DC8A78,hl:#D20F39 \
      --color=fg:#4C4F69,header:#D20F39,info:#8839EF,pointer:#DC8A78 \
      --color=marker:#7287FD,fg+:#4C4F69,prompt:#8839EF,hl+:#D20F39 \
      --color=selected-bg:#BCC0CC \
      --color=border:#9CA0B0,label:#4C4F69"

      export BAT_THEME="Catppuccin-latte"

      export PATH="/opt/homebrew/opt/ansible@9/bin:$PATH"

      ssh-add --apple-load-keychain
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
      ssh = "TERM=xterm ssh";
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
