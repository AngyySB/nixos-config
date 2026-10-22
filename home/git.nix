{ ... }:
{
  # --- SSH Key Routing ---
  # Per-host key mappings live in hosts/<host>/home.nix (key names differ per machine)
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false; # Silences the Home Manager warning cleanly
  };

  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user = {

        name = "AngyySB";
        email = "johe261@gmail.com";
      };
    };

    includes = [
      {
        condition = "hasconfig:remote.*.url:git@git.ntnu.no:*/**";
        contents.user = {
          name = "jonaherm";
          email = "jonaherm@stud.ntnu.no";
        };
      }
      {
        condition = "hasconfig:remote.*.url:https://git.ntnu.no/**";
        contents.user = {
          name = "jonaherm";
          email = "jonaherm@stud.ntnu.no";
        };
      }
      {
        condition = "hasconfig:remote.*.url:https://git.gvk.idi.ntnu.no/**";
        contents.user = {
          name = "jonaherm";
          email = "jonaherm@stud.ntnu.no";
        };

      }

      {
        condition = "hasconfig:remote.*.url:git@git.gvk.idi.ntnu.no:*/**";
        contents.user = {
          name = "jonaherm";
          email = "jonaherm@stud.ntnu.no";
        };
      }
    ];
  };
}
