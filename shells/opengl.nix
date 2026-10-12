{ pkgs }:
let
  pythonEnv = pkgs.python3.withPackages (ps: with ps; [ jinja2 ]);
  runtimeLibs = with pkgs; [
    libGL
    wayland
    libxkbcommon
    libx11
    libxrandr
    libxinerama
    libxcursor
    libxi
  ];
in
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    cmake
    pkg-config
    wayland-scanner
    pythonEnv
  ];
  buildInputs =
    runtimeLibs
    ++ (with pkgs; [
      wayland-protocols
      libffi
    ]);

  shellHook = ''
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath runtimeLibs}:$LD_LIBRARY_PATH"
    export DEVSHELL_NAME="opengl"
  '';
}
