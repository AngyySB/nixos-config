{ ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        output = [ "HDMI-A-1" ];
        margin-top = 0;
        modules-left = [
          "network"
          "bluetooth"
          "battery"
          "pulseaudio"
          "cpu"
          "temperature"

        ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [
          "custom/notification"
          "clock"
          "clock#date"
        ];

        network = {
          format-wifi = "{icon} {essid}";
          format-ethernet = "  ";
          format-disconnected = "󰤭";
          format-icons = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤢"
            "󰤨"
          ];
          tooltip-format-wifi = "{essid} ({signalStrength}%)";
          tooltip-format-ethernet = "{ifname}";
          tooltip-format-disconnected = "Disconnected";
          on-click = "pgrep nm-connection-editor && pkill nm-connection-editor || nm-connection-editor";
        };

        bluetooth = {
          format = " 󰂯 ";
          format-disabled = " 󰂲 ";
          format-connected = " 󰂱 {num_connections}";
          on-click = "pgrep blueman-manager && pkill blueman-manager || blueman-manager";
        };

        battery = {
          format = "{icon} {capacity}%";
          format-charging = "{icon} {capacity}% ";
          format-plugged = "{icon} {capacity}% ";
          format-full = "{icon} {capacity}% ";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        pulseaudio = {
          format = "{volume}% {icon}";
          format-bluetooth = "{volume}% {icon}";
          format-muted = "󰝟";
          on-click = "pgrep pavucontrol && pkill pavucontrol || pavucontrol";
          format-icons = [
            ""
            ""
            ""
          ];
        };

        cpu = {
          interval = 5;
          format = "{}% ";
          max-length = 10;
        };

        temperature = {
          interval = 3;
          hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
          critical-threshold = 80;
          format = "{temperatureC}°C";
        };

        "hyprland/workspaces" = {
          disable-scroll = true;
          format = "{name}";
          persistent-workspaces = {
            "*" = 10;
          };
        };

        "custom/notification" = {
          tooltip = false;
          format = "{icon}";
          format-icons = {
            notification = "<span foreground='red'><sup> 󱅫 </sup></span>";
            none = " 󰂜 ";
            dnd-notification = "<span foreground='red'><sup> 󰂠 </sup></span>";
            dnd-none = " 󰪓 ";
            inhibited-notification = "<span foreground='red'><sup> 󱨩 </sup></span>";
            inhibited-none = " 󱨪 ";
            dnd-inhibited-notification = "<span foreground='red'><sup> 󱏫 </sup></span>";
            dnd-inhibited-none = " 󱏬 ";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };

        clock = {
          format = "{:%H:%M}";
        };
        "clock#date" = {
          format = "{:%d.%m}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "month";
            weeks-pos = "left";
            on-click-right = "mode";
            format = {
              months = "<span color='#948ae3'><b>{}</b></span>";
              days = "<span color='#A6A6A6'>{}</span>";
              weeks = "<span color='#3B3A52'>W{}  </span>";
              weekdays = "<span color='#3B3A52'><b>{}</b></span>";
              today = "<span color='#948ae3'><b><u>{}</u></b></span>";
            };
          };
        };
      };
    };

    style = ''
      * {
        font-family: "Hack Nerd Font";
        font-size: 13px;
        border: none;
        border-radius: 0;
      }

      window#waybar {
        background: transparent;
      }

      #workspaces,
      #battery,
      #pulseaudio,
      #cpu,
      #temperature,
      #network,
      #bluetooth,
      #custom-notification,
      #clock,
      #clock.date {
        background-color: #1E1C31;
        color: #A6A6A6;
        padding: 0 10px;
        border-bottom: 2px solid #3B3A52;
      }
      #custom-notification {
        color: #A6A6A6;
        border-radius: 0px 0px 0px 2px;
        border-left: 2px solid #3B3A52;
        border-right: 2px solid #3B3A52;
      }
      #temperature {
      border-radius: 0px 0px 2px 0px;
      }

      /* left group: network, bluetooth, battery, pulseaudio, cpu, temperature */
      #network,
      #bluetooth,
      #battery,
      #pulseaudio,
      #temperature,
      #cpu {
        border-right: 1px solid #3B3A52;
      }

      /* center group: workspaces */
      #workspaces {
        border-radius: 0px 0px 2px 2px;
        padding: 0 0px;
        border-right: 2px solid #3B3A52;
        border-left: 2px solid #3B3A52;
      }
      #workspaces button {
        padding: 0 8px;
        color: #A6A6A6;
        background: transparent;
      }
      #workspaces button.active {
        color: #948ae3;
        background-color: #34314f;
      }
      #workspaces button.urgent {
        color: #948ae3;
        background-color: rgba(148, 138, 227, 0.2);
      }

    '';
  };
}
