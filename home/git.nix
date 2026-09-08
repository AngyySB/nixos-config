{ ... }:
{
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
        condition = "gitdir:~/NTNU/";
        contents.user.email = "jonaher@stud.ntnu.no";
      }
    ];
  };
}
