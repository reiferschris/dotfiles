{ config, pkgs, lib, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      window = {
        opacity = 1;
        dynamic_title = true;
        dynamic_padding = true;
        decorations = "full";
        dimensions = { lines = 0; columns = 0; };
        padding = { x = 5; y = 5; };
      };

      scrolling = {
        history = 10000;
        multiplier = 3;
      };

      mouse = { hide_when_typing = true; };

      key_bindings = [
        {
          # clear terminal
          key = "L";
          mods = "Control";
          chars = "\\x0c";
        }
      ];

      font = let fontname = "FiraCode Nerd Font Mono"; in
        {
          normal = { family = fontname; style = "Bold"; };
          bold = { family = fontname; style = "Bold"; };
          italic = { family = fontname; style = "Light"; };
          size = 14;
        };
      cursor.style = "Block";

      colors = {
        primary = {
          background = "0x303446";
          foreground = "0xC6D0F5";
        };
        normal = {
          black = "0x51576D";
          red = "0xE78284";
          green = "0xA6D189";
          yellow = "0xE5C890";
          blue = "0x8CAAEE";
          magenta = "0xF4B8E4";
          cyan = "0x81C8BE";
          white = "0xB5BFE2";
        };
        bright = {
          black = "0x626880";
          red = "0xE78284";
          green = "0xA6D189";
          yellow = "0xE5C890";
          blue = "0x8CAAEE";
          magenta = "0xF4B8E4";
          cyan = "0x81C8BE";
          white = "0xA5ADCE";
        };
        indexed_colors = [
          { index = 16; color = "0xEF9F76"; }
          { index = 17; color = "0xF2D5CF"; }
        ];
      };
    };
  };
}
