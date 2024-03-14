{ config, pkgs, lib, ... }: {
  programs.zellij = {
    enable = true;
  };

  home.file.zellij = {
    target = ".config/zellij/config.kdl";
    text = ''
      simplified_ui false
      session_serialization true
      pane_viewport_serialization true
      scrollback_lines_to_serialize 20000
      keybinds clear-defaults=true {
        normal {
          bind "Ctrl o" { SwitchToMode "tmux"; }
        }
        tmux {
          bind "Ctrl o" { SwitchToMode "Normal"; }
          bind "Esc" { SwitchToMode "Normal"; }

          bind "Ctrl e" { WriteChars "vi ."; Write 13; SwitchToMode "Normal"; }

          bind "Ctrl u" { CloseFocus; SwitchToMode "Normal"; }
          bind "z" { ToggleFocusFullscreen; SwitchToMode "Normal"; }
          bind "d" { Detach; }
          bind "s" { ToggleActiveSyncTab; SwitchToMode "Normal"; }

          bind "h" { MoveFocus "Left"; SwitchToMode "Normal"; }
          bind "l" { MoveFocus "Right"; SwitchToMode "Normal"; }
          bind "j" { MoveFocus "Down"; SwitchToMode "Normal"; }
          bind "k" { MoveFocus "Up"; SwitchToMode "Normal"; }

          bind "y" { NewPane "Down"; SwitchToMode "Normal"; }
          bind "n" { NewPane "Right"; SwitchToMode "Normal"; }

          bind "c" { NewTab; SwitchToMode "Normal"; }
          bind "Ctrl l" { GoToNextTab; SwitchToMode "Normal"; }
          bind "Ctrl h" { GoToPreviousTab; SwitchToMode "Normal"; }
          bind "w" {
             LaunchOrFocusPlugin "zellij:session-manager" {
                 floating true
                 move_to_focused_tab true
             };
             SwitchToMode "Normal"
             }      
          }
      }
      theme "catppuccin-frappe"
    '';
  };
}
