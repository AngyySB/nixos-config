{ ... }:
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        layer = "overlay";
        font = "Hack Nerd Font";
        lines = 10;
        width = 40;
      };
    };
  };
}
