{ config, pkgs, lib, ... }: {
  home.file.starship = {
    target = ".config/starship.toml";
    text = ''
      add_newline = false
      command_timeout = 2000

      [character]
      success_symbol = "[➜](bold green) "
      error_symbol = "[✗](bold red) "


      [directory]
      truncation_length = 8
      truncation_symbol = '…/'
      '';
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
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
      # fixes starship swallowing newlines
      precmd() {
        precmd() {
          echo
        }
      }

      #export LD_LIBRARY_PATH=${lib.makeLibraryPath [pkgs.stdenv.cc.cc]}

      # TODO: handle secrets somehow
      #source /secrets/environment.bash

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

      function take() { builtin cd $(mktemp -d) }
      function vit() { nvim $(mktemp) }

      function lgc() { git commit --signoff -m "$*" }

      function clone() { git clone git@$1.git }

      function gclone() { clone github.com:$1 }

      function bclone() { gclone breuerfelix/$1 }

      function gsm() { git submodule foreach "$* || :" }

      function gitdel() {
        git tag -d $1
        git push --delete origin $1
      }

      function lg() {
        git add --all
        git commit --signoff -a -m "$*"
        git push
      }

      function dci() { docker inspect $(docker-compose ps -q $1) }

      function transfer() {
        wget --method PUT --body-file=$1 https://up.fbr.ai/$1 -O - -nv
      }

      function nf() {
        pushd ~/.nixpkgs
        nix --experimental-features "nix-command flakes" build ".#darwinConfigurations.miraculix.system"
        ./result/sw/bin/darwin-rebuild switch --flake ~/.nixpkgs
      }

      function nfh() {
        pushd ~/.config/nixpkgs
        nix --experimental-features "nix-command flakes" build ".#homeConfigurations.solid.activationPackage"
        ./result/activate
      }

      function nfs() {
        pushd ~/.config/nixpkgs
        sudo nixos-rebuild switch --flake ".#rocky"
      }
      
      export FZF_DEFAULT_OPTS=" \
      --color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
      --color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
      --color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284"

      export DOCKER_HOST='unix:///Users/chris/.local/share/containers/podman/machine/qemu/podman.sock'

      export BAT_THEME="Catppuccin-frappe"

      path+=('~/.rd/bin')
    '';

    dirHashes = {
      dl = "$HOME/Downloads";
      nix = "$HOME/.nixpkgs";
      code = "$HOME/code";
    };

    shellAliases = {
      # builtins
      size = "du -sh";
      cp = "cp -i";
      mkdir = "mkdir -p";
      df = "df -h";
      free = "free -h";
      du = "du -sh";
      susu = "sudo su";
      op = "xdg-open";
      del = "rm -rf";
      sdel = "sudo rm -rf";
      lst = "ls --tree -I .git";
      lsl = "ls -l";
      lsa = "ls -a";
      null = "/dev/null";
      tmux = "tmux -u";
      tu = "tmux -u";
      tua = "tmux a -t";

      # overrides
      cat = "bat";
      ssh = "TERM=screen ssh";
      python = "python3";
      pip = "python3 -m pip";
      venv = "python3 -m venv";
      j = "z";
      docker = "podman";

      # programs
      g = "git";
      dk = "docker";
      dc = "docker-compose";
      pd = "podman";
      pc = "podman-compose";
      li = "lima nerdctl";
      lc = "limactl";
      sc = "sudo systemctl";
      poe = "poetry";
      fb = "pcmanfm .";
      space = "ncdu";
      diff = "delta";
      py = "python";
      awake = "caffeinate";

      # terminal cheat sheet
      cht = "cht.sh";
      # lists node_modules folder and their size
      npkill = "npx npkill";

      # utilities
      psf = "ps -aux | grep";
      lsf = "ls | grep";
      search = "sudo fd . '/' | grep"; # TODO replace with ripgrep
      shut = "sudo shutdown -h now";
      tssh = "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null";
      socks = "ssh -D 1337 -q -C -N";

      # clean
      dklocal = "docker run --rm -it -v `PWD`:/usr/workdir --workdir=/usr/workdir";
      dkclean = "docker container rm $(docker container ls -aq)";

      caps = "xdotool key Caps_Lock";
      gclean = "git fetch -p && for branch in $(git branch -vv | grep ': gone]' | awk '{print $1}'); do git branch -D $branch; done";
      ew = "nvim -c ':cd ~/vimwiki' ~/vimwiki";
      weather = "curl -4 http://wttr.in/Koeln";

      # nix
      ne = "nvim -c ':cd ~/.nixpkgs' ~/.nixpkgs";
      clean = "nix-collect-garbage -d && nix-store --gc && nix-store --verify --check-contents --repair";
      nsh = "nix-shell";
      nse = "nix search nixpkgs";

      aupt = "sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y";

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
      ssh.identities = [
        "id_ed25519"
        "ChristophReifers"
      ];
      #prompt.showReturnVal = true;
      #tmux.autoStartLocal = true;
      pmodules = [
        "autosuggestions"
        "completion"
        "directory"
        "editor"
        "git"
        "terminal"
        "ssh"
      ];
    };
  };
}
