{ config, pkgs, lib, ... }: {
  # TODO two files
  home.file.yabai = {
    executable = true;
    target = ".config/yabai/yabairc";
    text = ''
            #!/usr/bin/env sh

            # load scripting addition
            sudo yabai --load-sa
            yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"

            # bar configuration
            yabai -m config external_bar all:35:0
            # yabai -m signal --add event=window_focused action="sketchybar --trigger window_focus"

      #      # borders
      #      yabai -m config window_border on
      #      yabai -m config window_border_width 2
      #      yabai -m config window_border_radius 0
      #      yabai -m config window_border_blur off
      #      yabai -m config active_window_border_color 0xFFF2D5CF
      #      yabai -m config normal_window_border_color 0x00FFFFFF
             yabai -m config insert_feedback_color 0xffd75f5f

            yabai -m config window_shadow off

            # layout
            yabai -m config layout bsp
            yabai -m config auto_balance off
      #      yabai -m config window_topmost on

            # gaps
            yabai -m config top_padding    2
            yabai -m config bottom_padding 2
            yabai -m config left_padding   2
            yabai -m config right_padding  2
            yabai -m config window_gap     2

            # refresh my Übersicht bar when the space changes
            yabai -m signal --add event=space_changed \
                action="osascript -e 'tell application \"Übersicht\" to refresh widget id \"simple-bar-index-jsx\"'"
            
            # rules
            yabai -m rule --add app="^System.*Settings$" manage=off

            # workspace management
            yabai -m space 1 --label term
            yabai -m space 2 --label notes 
            yabai -m space 3 --label www
            yabai -m space 4 --label www2
            yabai -m space 5 --label mail
            yabai -m space 6 --label music
            yabai -m space 7 --label chat
            yabai -m space 8 --label chat2
            yabai -m space 9 --label tools 
            yabai -m space 10 --label voice
            yabai -m space 11 --label office 
            yabai -m space 12 --label finder 
            yabai -m space 13 --label db 
            yabai -m space 13 --label settings

            # assign apps to spaces
            yabai -m rule --add app="WezTerm" space=term
            yabai -m rule --add app="Logseq" space=notes
            yabai -m rule --add app="Firefox" space=www
            yabai -m rule --add app="qutebrowser" space=www2
            yabai -m rule --add app="Rocket.Chat" space=chat
            yabai -m rule --add app="Element" space=chat
            yabai -m rule --add app="Signal" space=chat2
            yabai -m rule --add app="Spotify" space=music
            yabai -m rule --add app="Thunderbird" space=mail
            yabai -m rule --add app="Bitwarden" space=tools
            yabai -m rule --add app="Beekeeper Studio" space=db
            yabai -m rule --add app="Webex" space=voice
            yabai -m rule --add app="LibreOffice" space=office
            yabai -m rule --add app="Microsoft Word" space=office
            yabai -m rule --add app="Microsoft PowerPoint" space=office
            yabai -m rule --add app="Microsoft Excel" space=office
            yabai -m rule --add app="Finder" space=finder
            yabai -m rule --add app="Activity Monitor" space=tools
            yabai -m rule --add app="System Settings" space=tools
            yabai -m rule --add app="Cisco Secure Client" space=tools

            echo "yabai configuration loaded.."
    '';
  };

  home.file.skhd = {
    target = ".config/skhd/skhdrc";
    text = let yabai = if pkgs.stdenv.hostPlatform.isAarch64 then "/opt/homebrew/bin/yabai" else "/usr/local/bin/yabai"; in
      ''
        # alt + a / u / o / s are blocked due to umlaute

        # workspaces
        ctrl + alt - j : ${yabai} -m space --focus prev
        ctrl + alt - k : ${yabai} -m space --focus next
        cmd + alt - j : ${yabai} -m space --focus prev
        cmd + alt - k : ${yabai} -m space --focus next

        # send window to space and follow focus
        ctrl + alt - l : ${yabai} -m window --space prev; ${yabai} -m space --focus prev
        ctrl + alt - h : ${yabai} -m window --space next; ${yabai} -m space --focus next
        cmd + alt - l : ${yabai} -m window --space prev; ${yabai} -m space --focus prev
        cmd + alt - h : ${yabai} -m window --space next; ${yabai} -m space --focus next

        # focus window
        alt - h : ${yabai} -m window --focus west
        alt - l : ${yabai} -m window --focus east

        # swap managed window
        shift + alt - h : ${yabai} -m window --swap west
        shift + alt - j : ${yabai} -m window --swap south
        shift + alt - k : ${yabai} -m window --swap north
        shift + alt - l : ${yabai} -m window --swap east

        # increase window size
        # shift + alt - a : ${yabai} -m window --resize left:-20:0
        # shift + alt - s : ${yabai} -m window --resize right:-20:0

        # skhdad
        shift + alt - r : skhd --restart-service; yabai --restart-service; yabai -m rule --apply
      '';
  };
}
