{ ... }:
{
  programs.firefox = {
    enable = true;
    configPath = ".mozilla/firefox";
    profiles.default.settings = {
      "font.name-list.monospace.x-western" = "Hack Nerd Font Mono, monospace";
    };
  };
}
