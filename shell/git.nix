{ config, pkgs, lib, ... }: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "reiferschristoph@gmail.com";
        name = "Christoph Reifers";
      };
      aliases = { };
      extraConfig = {
        init = { defaultBranch = "main"; };
        fetch = {
          prune = true;
        };
        pull = {
          ff = false;
          commit = false;
          rebase = true;
        };
        push.autoSetupRemote = true;
        delta = {
          line-numbers = true;
        };
      };
    };
    includes = [
      {
        condition = "gitdir:~/work/git-nrw/";
        contents.user.email = "creifers@uni-koeln.de";
        path = "~/.config/git/git.opencast.config";
      }
      {
        condition = "gitdir:~/work/github/";
        contents.user.email = "creifers@uni-koeln.de";
      }
    ];
    ignores = [
      ".idea"
      ".vs"
      ".vsc"
      ".vscode" # ide
      ".DS_Store" # mac
    ];
  };
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      side-by-side = true;
    };
  };

}
