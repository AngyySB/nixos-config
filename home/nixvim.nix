{ pkgs, config, ... }:
{
  programs.nixvim = {
    enable = true;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    globals.mapleader = " ";
    extraPlugins = [ pkgs.vimPlugins.harpoon-lualine ];

    opts = {
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      number = true;
      relativenumber = true;
      confirm = true;
      foldenable = false;
      clipboard = "unnamedplus";
      autoindent = true;

    };

    autoCmd = [
      {
        event = "FileType";
        pattern = "nix";
        command = "setlocal shiftwidth=2 tabstop=2 expandtab";
      }
    ];

    keymaps = [
      {
        #i hate pressing escape
        mode = "i";
        key = "jk";
        action = "<Esc>";
      }
      {
        #saving
        mode = "n";
        key = "<leader>aw";
        action = "<cmd>w<CR>";
      }
      {
        #quitting
        mode = "n";
        key = "<leader>qq";
        action = "<cmd>q<CR>";
      }

      {
        mode = "n";
        key = "<leader>aa";
        action.__raw = "function() require('harpoon'):list():add() end";
      }
      {
        mode = "n";
        key = "<leader>xx";
        action.__raw = "function() require('harpoon'):list():remove() end";
      }
      {
        mode = "n";
        key = "<C-e>";
        action.__raw = "function() local h = require('harpoon'); h.ui:toggle_quick_menu(h:list()) end";
      }
      {
        mode = "n";
        key = "<C-j>";
        action.__raw = "function() require('harpoon'):list():next() end";
      }
      {
        mode = "n";
        key = "<C-k>";
        action.__raw = "function() require('harpoon'):list():prev() end";
      }
    ]
    ++ (map
      (i: {
        mode = "n";
        key = "<C-${toString i}>";
        action.__raw = "function() require('harpoon'):list():select(${toString i}) end";
      })
      [
        1
        2
        3
        4
        5
      ]
    );

    plugins = {
      treesitter = {
        enable = true;
        highlight.enable = true;
        indent.enable = true;
        folding.enable = false;

        grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
          bash
          json
          lua
          make
          markdown
          nix
          regex
          toml
          yaml
          xml
          rust
          go
          haskell
          kotlin
          c
          cpp
          python
        ];
      };

      lsp-format.enable = true;

      lsp = {
        enable = true;
        servers = {
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
          nil_ls.enable = true;
          lua_ls.enable = true;
          hls = {
            enable = true;
            installGhc = true;
          };
          kotlin_language_server.enable = true;
          gopls.enable = true;
          pyright.enable = true;
          clangd.enable = true;

        };
      };
      nvim-autopairs = {
        enable = true;
        settings.mapCr = true;
      };
      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings.mapping = {
          "<C-e>" = "cmp.mapping.abort()";
          "<C-Space>" = "cmp.mapping.complete()";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<Tab>" = "cmp.mapping.select_next_item()";
          "<S-Tab>" = "cmp.mapping.select_prev_item()";

        };
        settings.sources = [
          { name = "nvim_lsp"; }
          { name = "buffer"; }

        ];
      };
      lualine = {
        enable = true;
        settings = {
          sections.lualine_c = [
            "filename"
            "harpoon2"
          ];
        };
      };
      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
          "<leader>fh" = "harpoon marks";
        };
      };
      harpoon = {
        enable = true;
        enableTelescope = true;
      };
      mini-animate = {
        enable = true;
      };

    };

  };
}
