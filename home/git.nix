{ ... }:
{
  # --- SSH Key Routing ---

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false; # Silences the Home Manager warning cleanly

    settings = {
      "github.com" = {
        HostName = "github.com";
        User = "git";
        IdentityFile = "~/.ssh/id_ed25519";
      };
      "git.ntnu.no" = {
        HostName = "git.ntnu.no";
        User = "git";
        IdentityFile = "~/.ssh/id_ed25519_githubNTNU";
      };
    };
  };

  programs.git = {
    enable = true;
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
    ];
  };
}
