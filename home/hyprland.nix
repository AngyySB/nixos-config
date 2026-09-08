{ pkgs, ... }:
{

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "hyprlang";
    extraConfig = ''
      # Laptop brightness keys
      bindel = , XF86MonBrightnessUp, exec, brightnessctl set 5%+
      bindel = , XF86MonBrightnessDown, exec, brightnessctl set 5%-
    '';
    settings = {
      "$mod" = "SUPER";
      monitor = [ "eDP-1, 1920x1080@60, 0x0, 1" ];

      input = {
        kb_layout = "no";
        follow_mouse = 2;
        accel_profile = "adaptive";
        sensitivity = 0.1;
        touchpad.natural_scroll = true;
        numlock_by_default = true;
      };

      general = {
        gaps_in = 2;
        gaps_out = 3;
        border_size = 2;

      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      ecosystem = {
        no_update_news = true;
        no_donation_nag = true;
      };

      decoration = {
        rounding = 2;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        fullscreen_opacity = 1.0;
        blur = {
          enabled = true;
          size = 15;
          passes = 3;
          noise = 0.03;
        };
        shadow.enabled = false;
      };

      exec-once = [
        "swaync"
        "waybar"
        "${pkgs.writeShellScript "delayed-nm-applet" ''
          sleep 2
          nm-applet --indicator
        ''}"
        "lxqt-policykit-agent"
        "blueman-applet"
        "[workspace 2 silent] firefox"
        "discord"
        "steam"
      ];
      windowrule = [
        "workspace 3 silent, match:class ^(discord)$"
        "workspace 4 silent, match:class ^(steam)$"
        "opacity 0.85, match:class kitty"
        "workspace 10, match:initial_class ^(steam_app_.*)$"
        "float 1, match:title ^(Friends List)$"
        "size 400 600, match:title ^(Friends List)$"
        "move 1400 700, match:title ^(Friends List)$"
      ];

      workspace = [
        "1, monitor:HDMI-A-1, default:true"
        "2, monitor:HDMI-A-1"
        "3, monitor:HDMI-A-2, default:true"
        "4, monitor:HDMI-A-2"
        "10, monitor:HDMI-A-1"
      ];

      animation = [
        "workspaces, 0"
        "layers, 0"
        "fadeLayers, 0"
        "windowsIn, 1, 2, default, popin 90%"
        "windowsOut, 1, 2, default, popin 90%"
      ];

      bind = [
        "SUPER, T, exec, kitty"
        "SUPER, F, exec, firefox"

        "SUPER CTRL, H, movecurrentworkspacetomonitor, HDMI-A-2"
        "SUPER CTRL, L, movecurrentworkspacetomonitor, HDMI-A-1"

        #toggle fuzzel
        "SUPER, SPACE, exec, ${pkgs.writeShellScript "toggle-fuzzel" ''
          pgrep fuzzel && pkill fuzzel || fuzzel
        ''}"

        "SUPER SHIFT, W, exec, ${pkgs.writeShellScript "reload-waybar" ''
          pkill waybar; waybar &
        ''}"

        "SUPER, C, killactive"
        "SUPER SHIFT, S, exec, grim -g \"$(slurp)\" - | wl-copy"
        "SUPER, V, togglefloating"

        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"
        "SUPER, 0, workspace, 10"

        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"
        "SUPER SHIFT, 6, movetoworkspace, 6"
        "SUPER SHIFT, 7, movetoworkspace, 7"
        "SUPER SHIFT, 8, movetoworkspace, 8"
        "SUPER SHIFT, 9, movetoworkspace, 9"
        "SUPER SHIFT, 0,movetoworkspace,  10"

        "SUPER, H, movefocus, l"
        "SUPER, J, movefocus, d"
        "SUPER, K, movefocus, u"
        "SUPER, L, movefocus, r"
        "SUPER, left, movefocus, l"
        "SUPER, down, movefocus, d"
        "SUPER, up, movefocus, u"
        "SUPER, right, movefocus, r"

        "SUPER SHIFT, H, movewindow, l"
        "SUPER SHIFT, J, movewindow, d"
        "SUPER SHIFT, K, movewindow, u"
        "SUPER SHIFT, L, movewindow, r"
        "SUPER SHIFT, left, movewindow, l"
        "SUPER SHIFT, down, movewindow, d"
        "SUPER SHIFT, up,   movewindow, u"
        "SUPER SHIFT, right,movewindow,  r"

      ];
      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];
    };
  };
}
