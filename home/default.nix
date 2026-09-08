{ inputs, ... }:
{
  home.stateVersion = "24.11";
  imports = [
    ./git.nix
    ./packages.nix
    inputs.nixvim.homeModules.nixvim
    ./nixvim.nix
    ./theme.nix
    ./hyprland.nix
    ./zsh.nix
    ./starship.nix
    ./fuzzel.nix
    ./hyprpaper.nix
    ./kitty.nix
    ./firefox.nix
    ./waybar.nix
    ./swaync.nix
    ./direnv.nix
    ./fzf.nix
  ];
}
