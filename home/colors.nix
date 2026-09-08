# home/colors.nix
# Challenger Deep colorscheme, as a plain attribute set.
# Import this wherever you need consistent colors across apps.
{
  # Base terminal colors — raw ANSI slots, unambiguous, matches
  # what most terminal-focused options (e.g. kitty) expect directly.
  bg = "#1e1c31";
  fg = "#cbe3e7";
  cursor = "#fbfcfc";

  # black
  color0 = "#565575";
  color8 = "#100e23";

  # red
  color1 = "#ff8080";
  color9 = "#ff5458";

  # green
  color2 = "#95ffa4";
  color10 = "#62d196";

  # yellow
  color3 = "#ffe9aa";
  color11 = "#ffb378";

  # blue
  color4 = "#91ddff";
  color12 = "#65b2ff";

  # magenta
  color5 = "#c991e1";
  color13 = "#906cff";

  # cyan
  color6 = "#aaffe4";
  color14 = "#63f2f1";

  # white
  color7 = "#cbe3e7";
  color15 = "#a6b3cc";

  # Semantic aliases — my own assignment, not from upstream.
  # These are the ones you'll actually reach for in waybar/fuzzel/etc,
  # since "accent" reads better there than "color4".
  # Change these mappings if you disagree with the choices.
  background = "#1e1c31";
  foreground = "#cbe3e7";
  accent = "#91ddff"; # blue
  warning = "#ffe9aa"; # yellow
  error = "#ff5458"; # bright red
  success = "#62d196"; # bright green
}
