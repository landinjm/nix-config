{ config, ... }:
let
  username = "landinjm";
  email = "landinjm@umich.edu";
in
{
  programs.git = {
    enable = true;
    settings = {
      user.name = username;
      user.email = email;
    };
  };
}
