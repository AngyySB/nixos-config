{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  home-manager.users.jonas.imports = [ ./home.nix ];

  networking.hostName = "nix-desktop";

  hardware.logitech.wireless.enable = true;
  services.udev.packages = [ pkgs.solaar ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  system.stateVersion = "26.05"; # Did you read the comment?
}
