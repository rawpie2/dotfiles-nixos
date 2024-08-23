{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.rofi;
in
{
  options.rofi = {
    enable = mkEnableOption "rofi";
  };
  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      xdotool # Depended by rofi-emoji
    ];

    home-manager.users.rawpie.programs.rofi = {
      enable = true;
      plugins = [ pkgs.rofi-emoji ];
    };

    home-manager.users.rawpie.home.file = {
      ".config/rofi" = {
        source = ./config;
        recursive = true;
      };
    };
  };
}
