{ pkgs, home-manager, ...}:
{
  environment = {
    systemPackages = with pkgs; [
      neovim
      lazygit
      gh
      ripgrep
      nodejs
      tree-sitter
      nvimpager
    ];

    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      PAGER = "nvimpager";
    };
  };

  home-manager.users.rawpie.home.file.".config/nvim" = {
    source = ./.;
    recursive = true;
  };
}
