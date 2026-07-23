{ username, ... }:

{
  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.stateVersion = "25.05";

  programs.bash.enable = true;
  programs.zsh.enable = true;
}
