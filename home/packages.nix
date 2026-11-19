{ pkgs, ... }:
{
  home.packages = with pkgs; [
    #Utils
    alsa-utils
    kdePackages.dolphin
    fastfetch
    grim
    slurp
    wl-clipboard
    networkmanagerapplet
    libnotify
    ripgrep
    bat
    zip
    unzip
    zoxide
    swayimg
    imv
    ttyper
    claude-code
    bruno
    sendme
    git-lfs
    android-tools
    scrcpy
    #Languages
    kotlin
    nodejs_22
    gcc
    cmake
    gnumake
    rustc
    cargo
    stack
    python3
    go
    haskellPackages.yabi
    # GUI apps
    discord
    android-studio
    godot
    spotify
    libreoffice
    libresprite
    piper
    mpv
    anki
  ];
  programs.java = {
    enable = true;
    package = pkgs.temurin-bin-17;
  };
}
