{ pkgs, ... }:
let
  delayedNmApplet = pkgs.writeShellScript "delayed-nm-applet" ''
    sleep 2
    nm-applet --indicator
  '';
  delayedDiscord = pkgs.writeShellScript "delayed-discord" ''
    sleep 2
    discord
  '';
  toggleFuzzel = pkgs.writeShellScript "toggle-fuzzel" ''
    pgrep fuzzel && pkill fuzzel || fuzzel
  '';
  reloadWaybar = pkgs.writeShellScript "reload-waybar" ''
    pkill waybar; waybar &
  '';
in
{
  # Hyprland 0.57+ only reads Lua configs (hyprland.lua); hyprlang is gone.
  # `settings.<name>` renders as hl.<name>(...) calls; lists give one call per element.
  # Hosts can add to `settings.config` (merged) and append Lua via `extraConfig`.
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";

    settings = {
      config = {
        input = {
          kb_layout = "no";
          follow_mouse = 2;
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
      };

      window_rule = [
        { match.class = "^(discord)$"; workspace = "3 silent"; }
        { match.class = "^(steam)$"; workspace = "4 silent"; }
        { match.class = "kitty"; opacity = "0.85"; }
        { match.initial_class = "^(steam_app_.*)$"; workspace = "10"; }
        {
          match.title = "^(Friends List)$";
          float = true;
          size = "400 600";
          move = "1400 700";
        }
      ];

      animation = [
        { leaf = "workspaces"; enabled = false; }
        { leaf = "layers"; enabled = false; }
        { leaf = "fadeLayers"; enabled = false; }
        { leaf = "windowsIn"; enabled = true; speed = 2; bezier = "default"; style = "popin 90%"; }
        { leaf = "windowsOut"; enabled = true; speed = 2; bezier = "default"; style = "popin 90%"; }
      ];
    };

    extraConfig = ''
      ---- AUTOSTART ----
      hl.on("hyprland.start", function()
        hl.exec_cmd("swaync")
        hl.exec_cmd("waybar")
        hl.exec_cmd("${delayedNmApplet}")
        hl.exec_cmd("blueman-applet")
        hl.exec_cmd("firefox", { workspace = "2 silent" })
        hl.exec_cmd("${delayedDiscord}")
        hl.exec_cmd("steam")
      end)

      ---- BINDS ----
      hl.bind("SUPER + T", hl.dsp.exec_cmd("kitty"))
      hl.bind("SUPER + F", hl.dsp.exec_cmd("firefox"))
      hl.bind("CTRL + T", hl.dsp.exec_cmd("kitty"))
      hl.bind("SUPER + SPACE", hl.dsp.exec_cmd("${toggleFuzzel}"))
      hl.bind("SUPER + SHIFT + W", hl.dsp.exec_cmd("${reloadWaybar}"))
      hl.bind("SUPER + C", hl.dsp.window.close())
      hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd([[grim -g "$(slurp)" - | wl-copy]]))
      hl.bind("SUPER + V", hl.dsp.window.float({ action = "toggle" }))

      -- workspaces 1-10 (key 0 = workspace 10)
      for i = 1, 10 do
        local key = i % 10
        hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
        hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
      end

      -- focus / move windows with hjkl and arrows
      local dirs = {
        H = "left", J = "down", K = "up", L = "right",
        left = "left", down = "down", up = "up", right = "right",
      }
      for key, dir in pairs(dirs) do
        hl.bind("SUPER + " .. key, hl.dsp.focus({ direction = dir }))
        hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ direction = dir }))
      end

      -- mouse move / resize
      hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
      hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })
    '';
  };
}
