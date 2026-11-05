{ pkgs, ... }:
{
  home.packages = with pkgs; [
    prismlauncher
    solaar
  ];

  wayland.windowManager.hyprland = {
    settings = {
      monitor = [
        { output = "HDMI-A-2"; mode = "1920x1080@144"; position = "0x0"; scale = 1; }
        { output = "HDMI-A-1"; mode = "1920x1080@180"; position = "1920x0"; scale = 1; }
      ];

      config.input = {
        accel_profile = "flat";
        sensitivity = -0.10;
      };

      workspace_rule = [
        { workspace = "1"; monitor = "HDMI-A-1"; default = true; }
        { workspace = "2"; monitor = "HDMI-A-1"; }
        { workspace = "3"; monitor = "HDMI-A-2"; default = true; }
        { workspace = "4"; monitor = "HDMI-A-2"; }
        { workspace = "10"; monitor = "HDMI-A-1"; }
      ];
    };

    extraConfig = ''
      hl.bind("SUPER + CTRL + H", hl.dsp.workspace.move({ monitor = "HDMI-A-2" }))
      hl.bind("SUPER + CTRL + L", hl.dsp.workspace.move({ monitor = "HDMI-A-1" }))
    '';
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
