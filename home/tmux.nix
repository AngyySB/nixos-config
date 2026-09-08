{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    baseIndex = 1; # Starts window numbering at 1 instead of 0
    mouse = true; # Disable all mouse controls

    terminal = "tmux-256color";

    extraConfig = ''
        #Disable split-screen binds entirely
        unbind '"'
        unbind %

        #Fast Creation & Destruction
        bind-key -n M-c new-window        # Alt + c creates a new workspace
        bind-key -n M-x kill-window       # Alt + x closes the current workspace

        bind-key -n M-h previous-window   # Alt + h goes left
        bind-key -n M-l next-window       # Alt + l goes right
        bind-key -n M-1 select-window -t 1
        bind-key -n M-2 select-window -t 2
        bind-key -n M-3 select-window -t 3
        bind-key -n M-4 select-window -t 4
        bind-key -n M-5 select-window -t 5

      #Pull the status bar tight against Neovim (removes the padding/gap)
      set -g status-position bottom

      #Match your Neovim theme colors (Dark charcoal background, grey text)
      set -g status-style bg=#1e1e2e,fg=#cdd6f4

      #Active workspace style (Highlights the current window in blue/bold)
      set -g window-status-current-style bg=#89b4fa,fg=#11111b,bold

      #Clean up the text layout (Removes the messy clock and hostname on the right)
      set -g status-left ""
      set -g status-right ""
      set -g window-status-format " #I:#W "
      set -g window-status-current-format " #I:#W "



      unbind -n MouseDragEnd1Pane
      unbind -T copy-mode MouseDragEnd1Pane
      unbind -T copy-mode-vi MouseDragEnd1Pane


    '';
  };
}
