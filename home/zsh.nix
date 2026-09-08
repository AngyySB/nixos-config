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
        export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="bg=244"

        reswitch() {
          git -C ~/nixos add -A
          sudo nixos-rebuild switch --flake ~/nixos#nix-desktop
        }


      ntnu-vpn() {
        openconnect-sso --server vpn.ntnu.no
      }

      home() {
        nmcli connection up home
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
