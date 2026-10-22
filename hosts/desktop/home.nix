{ pkgs, ... }:
{
  home.packages = with pkgs; [
    prismlauncher
    solaar
  ];

  wayland.windowManager.hyprland.settings = {
    monitor = [
      "HDMI-A-2,1920x1080@144,0x0,1"
      "HDMI-A-1,1920x1080@180,1920x0,1"
    ];

    input = {
      accel_profile = "flat";
      sensitivity = -0.10;
    };

    workspace = [
      "1, monitor:HDMI-A-1, default:true"
      "2, monitor:HDMI-A-1"
      "3, monitor:HDMI-A-2, default:true"
      "4, monitor:HDMI-A-2"
      "10, monitor:HDMI-A-1"
    ];

    bind = [
      "SUPER CTRL, H, movecurrentworkspacetomonitor, HDMI-A-2"
      "SUPER CTRL, L, movecurrentworkspacetomonitor, HDMI-A-1"
    ];
  };

  programs.waybar.settings.mainBar.output = [ "HDMI-A-1" ];

  programs.ssh.settings = {
    "github.com" = {
      HostName = "github.com";
      User = "git";
      IdentityFile = "~/.ssh/id_ed25519";
    };
    "git.ntnu.no" = {
      HostName = "git.ntnu.no";
      User = "git";
      IdentityFile = "~/.ssh/id_ed25519_githubNTNU";
    };
    "git.gvk.idi.ntnu.no" = {
      HostName = "git.gvk.idi.ntnu.no";
      User = "git";
      IdentityFile = "~/.ssh/id_ed25519_gitlab";
    };
  };
}
