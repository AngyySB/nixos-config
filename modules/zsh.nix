{ pkgs, ... }:
{
  programs.zsh.enable = true;

  users.users.jonas.shell = pkgs.zsh;
}
