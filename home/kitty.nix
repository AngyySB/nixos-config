{ ... }:
{
  programs.kitty = {
    enable = true;
    #themeFile = "ChallengerDeep";
    themeFile = "Catppuccin-Mocha";
    settings = {
      # kitty saves tiled windows as "maximized" under Hyprland, so new windows
      # would reopen maximized and cover the workspace instead of tiling
      remember_window_size = "no";
    };
  };
}
