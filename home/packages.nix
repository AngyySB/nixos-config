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
    fzf
    zoxide
    swayimg
    imv
    ttyper

    #Languages
    kotlin
    jdk
    gcc
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
    prismlauncher
    spotify
    libreoffice
    libresprite
  ];
}
