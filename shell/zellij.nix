{ config, pkgs, lib, ... }: {
  programs.zellij = {
    enable = true;
  };

  home.file.zellij = {
    target = ".config/zellij/config.kdl";
    text = ''
      simplified_ui true
      default_layout "default"
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
        }
      }
      theme "catppuccin-frappe"
    '';
  };
}
