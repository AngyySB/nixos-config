{ ... }:
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      format = "[$battery$directory\\[ $git_branch$git_status\\]~$character](bg:#3a3659) ";
      add_newline = false;
      git_branch.format = "[$symbol$branch](purple bg:#3a3659)";
      directory.style = "cyan bg:#3a3659";
      git_status.style = "bold red bg:#3a3659";
      battery = [
        {
          threshold = 20;
          charging_symbol = "⚡ ";
          discharging_symbol = "🪫 ";
        }
      ];
      character = {
        success_symbol = "i~[>](bold green bg:#3a3659)";
        error_symbol = "i~[X](bold red bg:#3a3659)";
        vicmd_symbol = "n~[<](bold blue bg:#3a3659)";
      };

      golang.symbol = " go ";
      rust.symbol = " rust ";
      haskell.symbol = " λ ";
      c.symbol = " c ";
      kotlin.symbol = " kot ";
      nodejs.symbol = " web ";
    };
  };
}
