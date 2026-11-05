{ lib, ... }:
let
  audioTypes = [
    "audio/mpeg"
    "audio/mp4"
    "audio/aac"
    "audio/flac"
    "audio/x-flac"
    "audio/ogg"
    "audio/x-vorbis+ogg"
    "audio/opus"
    "audio/x-opus+ogg"
    "audio/wav"
    "audio/x-wav"
    "audio/webm"
    "audio/x-m4a"
    "audio/x-ms-wma"
    "audio/x-aiff"
    "audio/x-matroska"
  ];
in
{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = lib.genAttrs audioTypes (_: "mpv.desktop") // {
      "x-scheme-handler/claude-cli" = "claude-code-url-handler.desktop";
      "x-scheme-handler/bruno" = "bruno.desktop";
    };
  };
  # Replace the unmanaged mimeapps.list instead of failing activation
  xdg.configFile."mimeapps.list".force = true;
}
