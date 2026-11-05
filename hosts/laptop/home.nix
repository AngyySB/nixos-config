{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    obsidian
    geteduroam
    bat-extras.batgrep
  ];

  wayland.windowManager.hyprland = {
    settings = {
      monitor = [
        { output = "eDP-1"; mode = "1920x1080@60"; position = "0x0"; scale = 1; }
      ];

      config.input = {
        accel_profile = "adaptive";
        sensitivity = 0.1;
        touchpad.natural_scroll = true;
      };
    };

    extraConfig = ''
      hl.on("hyprland.start", function()
        hl.exec_cmd("lxqt-policykit-agent")
      end)

      -- Laptop brightness keys
      hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"), { locked = true, repeating = true })
      hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })
    '';
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
