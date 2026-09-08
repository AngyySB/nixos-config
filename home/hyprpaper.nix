{ ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = true;
      splash = false;
      preload = [
        "/home/jonas/nixos/home/wallpapers/1.png"
        "/home/jonas/nixos/home/wallpapers/2.jpg"
        "/home/jonas/nixos/home/wallpapers/3.jpg"
        "/home/jonas/nixos/home/wallpapers/4.png"
      ];
      wallpaper = [
        {
          monitor = "";
          path = "/home/jonas/nixos/home/wallpapers/2.jpg";
        }
      ];
    };
  };
}
