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

              opengl() {
                nix develop ~/nixos#opengl -c "$SHELL"
              }


            ntnu-vpn() {
              openconnect-sso --server vpn.ntnu.no
            }
            adbc() {
             adb connect 192.168.0.151:$1
            }

           adb-storacle() {
        export ANDROID_HOME=/home/jonas/Android/Sdk
        ./gradlew installDebug && adb shell am start -n no.ntnu.storacle/.MainActivity
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
            mkcd() {
              mkdir $1 && cd $1
            }
            gc() {
              git commit -m $1
            }
            gs() {
              git status
            }

            git-review() {
              local branch="$1"
              if [ -z "$branch" ]; then
                echo "Usage: git-review <branch-name>"
                return 1
              fi

              local git_dir
              git_dir=$(git rev-parse --git-dir 2>/dev/null) || { echo "Not a git repository"; return 1; }

              local state_file="$git_dir/GIT_REVIEW_STATE"
              if [ -f "$state_file" ]; then
                echo "A git-review is already in progress. Run git-revert first."
                return 1
              fi

              local prev_branch
              prev_branch=$(git symbolic-ref --short HEAD 2>/dev/null) || prev_branch=$(git rev-parse HEAD)

              local stashed="no"
              if ! git diff --quiet || ! git diff --cached --quiet || [ -n "$(git ls-files --others --exclude-standard)" ]; then
                git stash push -u -m "git-review autostash from $prev_branch"
                stashed="yes"
              fi

              {
                echo "prev_branch='$prev_branch'"
                echo "stashed='$stashed'"
              } > "$state_file"

              git fetch origin
              git checkout "$branch"

              local base_branch
              base_branch=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')
              if [ -z "$base_branch" ]; then
                base_branch="main"
              fi

              echo
              echo "Commits on '$branch' not on '$base_branch':"
              git log --oneline "$base_branch".."$branch"
              echo
              echo "Run 'git diff $base_branch...$branch' for the full diff."
              echo "Run 'git-revert' to go back to '$prev_branch' if this branch doesn't get merged."
            }

            git-revert() {
              local git_dir
              git_dir=$(git rev-parse --git-dir 2>/dev/null) || { echo "Not a git repository"; return 1; }

              local state_file="$git_dir/GIT_REVIEW_STATE"
              if [ ! -f "$state_file" ]; then
                echo "No git-review in progress."
                return 1
              fi

              local prev_branch stashed
              source "$state_file"

              git checkout "$prev_branch"

              if [ "$stashed" = "yes" ]; then
                git stash pop
              fi

              rm -f "$state_file"
              echo "Back on '$prev_branch'."
            }

            decomp() {
              for file in "$@"; do
               if [ -f "$file" ]; then
                 case "$file" in
                  *.tar.bz2)   tar -xf "$file"    ;;
                  *.tar.gz)    tar -xf "$file"    ;;
                  *.tar.xz)    tar -xf "$file"    ;;
                  *.tar)       tar -xf "$file"    ;;
                  *.tgz)       tar -xf "$file"    ;;
                  *.zip)       unzip "$file"      ;;
                  *)           echo "Unknown extension: '$file'" ;;
                esac
              else
                echo "'$file' is not a valid file"
              fi
            done
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
