{ pkgs, ... }:
{

  fonts.fontconfig.enable = true;
  gtk = {
    enable = true;
    font = {
      name = "Hack Nerd Font";
      size = 10;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    package = pkgs.catppuccin-cursors.mochaDark;
    name = "catppuccin-mocha-dark-cursors";
    size = 24;
  };
}
