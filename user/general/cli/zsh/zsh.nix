{ lib, config, pkgs, home-manager, ... }:
let
  cfg = config.zsh;
in
{
  options.zsh = {
    enable = lib.mkEnableOption "zsh";
  };
  config = lib.mkIf cfg.enable {
    users.users.rawpie.shell = pkgs.zsh;
    programs = {
      zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestions.enable = true;
        syntaxHighlighting.enable = true;
        shellAliases = {
          ls = "eza -a";
        };
        ohMyZsh = {
          enable = true;
          theme = "fino-time";
            plugins = [
              "git"
              "rust"
           ];
        };
      };
    };
    environment.pathsToLink = [ "/share/zsh" ];

    home-manager.users.rawpie.home = {
      packages = with pkgs; [ eza ];
      file.".zshrc".source = ./.zshrc;
    };
  };
}
