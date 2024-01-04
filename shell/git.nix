{ config, pkgs, lib, ... }: {
  programs.git = {
    enable = true;
    delta.enable = true;
    delta.options = {
      side-by-side = true;
    };
    userEmail = "reiferschristoph@gmail.com";
    userName = "Christoph Reifers";
    includes = [
      {
        condition = "gitdir:~/work/gitlab-uzk/";
        contents.user.email = "creifers@uni-koeln.de";
      }
      {
        condition = "gitdir:~/work/github/";
        contents.user.email = "creifers@uni-koeln.de";
      }
    ];
    aliases = {
    };
    ignores = [
      ".idea" ".vs" ".vsc" ".vscode" # ide
      ".DS_Store" # mac
    ];
    extraConfig = {
      init = { defaultBranch = "main"; };
      pull = {
        ff = false;
        commit = false;
        rebase = true;
      };
      push.autoSetupRemote = true;
      #url = {
        #"ssh://git@github.com" = { insteadOf = "https://github.com"; };
      #};
      delta = {
        line-numbers = true;
      };
    };
  };
}
