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
            bind "Ctrl t" { SwitchToMode "tmux"; }
          }
          tmux {
            bind "[" { SwitchToMode "Scroll"; }
            bind "Ctrl t" { SwitchToMode "Normal"; }
            bind "Esc" { SwitchToMode "Normal"; }

            bind "Ctrl e" { WriteChars "nvim ."; Write 13; SwitchToMode "Normal"; }

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
            resize {
                bind "Ctrl n" { SwitchToMode "Normal"; }
                bind "h" "Left" { Resize "Increase Left"; }
                bind "j" "Down" { Resize "Increase Down"; }
                bind "k" "Up" { Resize "Increase Up"; }
                bind "l" "Right" { Resize "Increase Right"; }
                bind "H" { Resize "Decrease Left"; }
                bind "J" { Resize "Decrease Down"; }
                bind "K" { Resize "Decrease Up"; }
                bind "L" { Resize "Decrease Right"; }
                bind "=" "+" { Resize "Increase"; }
                bind "-" { Resize "Decrease"; }
            }
            shared_except "resize" {
                bind "Ctrl n" { SwitchToMode "Resize"; }
            }
            scroll {
                bind "Ctrl s" { SwitchToMode "Normal"; }
                bind "e" { EditScrollback; SwitchToMode "Normal"; }
                bind "s" { SwitchToMode "EnterSearch"; SearchInput 0; }
                bind "Ctrl c" { ScrollToBottom; SwitchToMode "Normal"; }
                bind "j" "Down" { ScrollDown; }
                bind "k" "Up" { ScrollUp; }
                bind "Ctrl f" "PageDown" "Right" "l" { PageScrollDown; }
                bind "Ctrl b" "PageUp" "Left" "h" { PageScrollUp; }
                bind "d" { HalfPageScrollDown; }
                bind "u" { HalfPageScrollUp; }
                // uncomment this and adjust key if using copy_on_select=false
                // bind "Alt c" { Copy; }
            }
          search {
                bind "Ctrl s" { SwitchToMode "Normal"; }
                bind "Ctrl c" { ScrollToBottom; SwitchToMode "Normal"; }
                bind "j" "Down" { ScrollDown; }
                bind "k" "Up" { ScrollUp; }
                bind "Ctrl f" "PageDown" "Right" "l" { PageScrollDown; }
                bind "Ctrl b" "PageUp" "Left" "h" { PageScrollUp; }
                bind "d" { HalfPageScrollDown; }
                bind "u" { HalfPageScrollUp; }
                bind "n" { Search "down"; }
                bind "p" { Search "up"; }
                bind "c" { SearchToggleOption "CaseSensitivity"; }
                bind "w" { SearchToggleOption "Wrap"; }
                bind "o" { SearchToggleOption "WholeWord"; }
            }
          entersearch {
                bind "Ctrl c" "Esc" { SwitchToMode "Scroll"; }
                bind "Enter" { SwitchToMode "Search"; }
            }
      ren
        }
        theme "catppuccin-frappe"
    '';
  };
}
