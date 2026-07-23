{
  pkgs,
  lib,
  isLinux ? false,
  isDarwin ? false,
  ...
}:

{
  imports = [
    ./packages.nix
    ./git.nix
    ./shell.nix
  ]
  ++ lib.optionals isLinux [
    ./linux.nix
  ]
  ++ lib.optionals isDarwin [
    ./darwin.nix
  ];
}
