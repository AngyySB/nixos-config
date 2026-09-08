{ pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    plugins = [
      {
        name = "zsh-vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];
    initContent = lib.mkAfter ''
      eval "$(direnv hook zsh)"
        export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="bg=244"

        reswitch() {
          git -C ~/nixos add -A
          sudo nixos-rebuild switch --flake ~/nixos#nix-laptop
        }

        cmk() {
        cd ~/Documents/ntnu/graphics/Group_16
        cmake -S . -B build
        cmake --build build
        }


      ntnu-proxy() {
          echo "Setting up NTNU proxy tunnel..."
          echo "Remember to set Firefox to SOCKS5 proxy: 127.0.0.1:1080"
          ssh -D 1080 -N -C jonaherm@login.stud.ntnu.no
          echo "Tunnel closed. Remember to disable the proxy in Firefox!"
      }

      mypi() {
          ssh jonas@192.168.0.168 "$@"
      }

      mypi_remote() {
          ssh jonas@100.95.64.57 "$@"
      }
    '';
    envExtra = ''
      ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
      ZVM_CURSOR_STYLE_ENABLED=true
      ZVM_VI_INSERT_ESCAPE_BINDKEY=jk

      function zvm_after_init() {
        zvm_bindkey viins '^ ' autosuggest-accept
      }
    '';
  };
}
