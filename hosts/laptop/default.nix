{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  home-manager.users.jonas.imports = [ ./home.nix ];

  networking.hostName = "nix-laptop";

  networking.networkmanager.settings = {
    device."wifi.scan-rand-mac-address" = "no";
  };
  #  networking.wireless.iwd.enable = true;
  #networking.networkmanager.wifi.backend = "iwd";

  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    lxqt.lxqt-policykit
    brightnessctl
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  system.stateVersion = "26.05"; # Did you read the comment?
}
