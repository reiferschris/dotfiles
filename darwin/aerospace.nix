{ config, pkgs, lib, ... }: {
  services.aerospace = {
    enable = true;
    settings = {
      gaps = {
        outer.left = 8;
        outer.bottom = 8;
        outer.top = 8;
        outer.right = 8;
      };
      mode.main.binding = {
        alt-h = "focus left";
        alt-j = "focus down";
        alt-k = "focus up";
        alt-l = "focus right";
        alt-shift-j = "move down";
        alt-shift-k = "move up";
        alt-shift-l = "move right";
        alt-shift-h = "move left";

        alt-f = "fullscreen";
        alt-d = "layout h_accordion tiles";
        alt-shift-space = "layout floating tiling";

        alt-1 = "workspace 1";
        alt-2 = "workspace 2";
        alt-3 = "workspace 3";
        alt-4 = "workspace 4";
        alt-5 = "workspace 5";
        alt-6 = "workspace 6";
        alt-7 = "workspace 7";
        alt-8 = "workspace 8";
        alt-9 = "workspace 9";
        alt-0 = "workspace 10";

        alt-shift-1 = "move-node-to-workspace 1";
        alt-shift-2 = "move-node-to-workspace 2";
        alt-shift-3 = "move-node-to-workspace 3";
        alt-shift-4 = "move-node-to-workspace 4";
        alt-shift-5 = "move-node-to-workspace 5";
        alt-shift-6 = "move-node-to-workspace 6";
        # overlaps with alt-u for 'ue' on eurkey. come with an alternative
        alt-shift-7 = "move-node-to-workspace 7";
        alt-shift-8 = "move-node-to-workspace 8";
        alt-shift-9 = "move-node-to-workspace 9";
        alt-shift-0 = "move-node-to-workspace 10";

        alt-shift-c = "reload-config";
      };
      workspace-to-monitor-force-assignment = {
        "1" = [ "main" ];
        "2" = [ "main" ];
        "3" = [ "main" ];
        "4" = [ "main" ];
        "5" = [ "main" ];
        "6" = [ "main" ];
        "7" = [ "main" ];
        "8" = [ "main" ];
        "9" = [ "main" ];
        "10" = [
          "secondary"
          "main"
        ];
      };
      on-window-detected = [
        {
          "if".app-name-regex-substring = "Ghostty";
          run = [ "move-node-to-workspace 1" ];
        }
        {
          "if".app-name-regex-substring = "Firefox";
          run = [ "move-node-to-workspace 2" ];
        }
        {
          "if".app-name-regex-substring = "mail";
          run = [ "move-node-to-workspace 3" ];
        }
        {
          "if".app-name-regex-substring = "calendar";
          run = [ "move-node-to-workspace 4" ];
        }
        {
          "if".app-name-regex-substring = "Logseq";
          run = [ "move-node-to-workspace 4" ];
        }
        {
          "if".app-name-regex-substring = "Beekeeper Studio";
          run = [ "move-node-to-workspace 5" ];
        }
        {
          "if".app-name-regex-substring = "Spotify";
          run = [ "move-node-to-workspace 5" ];
        }
        {
          "if".app-name-regex-substring = "Webex";
          run = [ "move-node-to-workspace 6" ];
        }
        {
          "if".app-name-regex-substring = "Bitwarden";
          run = [ "move-node-to-workspace 7" ];
        }
        {
          "if".app-name-regex-substring = "Cisco Secure Client";
          run = [ "move-node-to-workspace 7" ];
        }
        {
          "if".app-name-regex-substring = "Signal";
          run = [ "move-node-to-workspace 8" ];
        }
        {
          "if".app-name-regex-substring = "Element";
          run = [ "move-node-to-workspace 8" ];
        }
        {
          "if".app-name-regex-substring = "settings";
          run = [
            "layout floating"
            "move-node-to-workspace 1"
          ];
        }
      ];
    };
  };
}
