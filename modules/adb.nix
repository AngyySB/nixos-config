{ ... }:
{
  programs.adb.enable = true;
  users.user.jonas.extraGroups = [ "adbusers" ];
}
