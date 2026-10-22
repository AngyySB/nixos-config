{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    obsidian
    geteduroam
    bat-extras.batgrep
  ];

  wayland.windowManager.hyprland = {
    extraConfig = ''
      # Laptop brightness keys
      bindel = , XF86MonBrightnessUp, exec, brightnessctl set 5%+
      bindel = , XF86MonBrightnessDown, exec, brightnessctl set 5%-
    '';

    settings = {
      monitor = [ "eDP-1, 1920x1080@60, 0x0, 1" ];

      input = {
        accel_profile = "adaptive";
        sensitivity = 0.1;
        touchpad.natural_scroll = true;
      };

      exec-once = [
        "lxqt-policykit-agent"
      ];
    };
  };

  programs.waybar.settings.mainBar.output = [ "eDP-1" ];

  programs.ssh.settings = {
    # Default / Personal GitHub
    "github.com" = {
      HostName = "github.com";
      User = "git";
      IdentityFile = "~/.ssh/id_ed25519_personal";
    };
    # School GitHub (Use 'github-school' in clone URLs)
    "github-school" = {
      HostName = "github.com";
      User = "git";
      IdentityFile = "~/.ssh/id_ed25519_school";
    };
    # NTNU GitLab
    "git.ntnu.no" = {
      HostName = "git.ntnu.no";
      User = "git";
      IdentityFile = "~/.ssh/id_ed25519_school";
    };
  };

  programs.zsh.initContent = lib.mkAfter ''
    cmk() {
      cd ~/Documents/ntnu/graphics/Group_16
      cmake -S . -B build
      cmake --build build
    }
  '';
}
