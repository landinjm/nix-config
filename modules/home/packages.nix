{
  pkgs,
  lib,
  isLinux ? false,
  isDarwin ? false,
  ...
}:

{
  home.packages =
    with pkgs;
    [
      bat
      bottom
      curl
      delta
      direnv
      eza
      fd
      fzf
      gh
      git
      jq
      neovim
      ripgrep
      starship
      tmux
      unzip
      wget
      yazi
      zoxide
    ]
    ++ lib.optionals isLinux [
      wl-clipboard
      xclip
    ]
    ++ lib.optionals isDarwin [
      reattach-to-user-namespace
    ];
}
