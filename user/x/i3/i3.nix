{ lib, config, pkgs, ... }:
let
  cfg = config.i3;
in
{
  options.i3 = {
    enable = lib.mkEnableOption "i3";
  };
  config = lib.mkIf cfg.enable {
    services.xserver = {
      windowManager.i3 = {
        enable = true;
        package = pkgs.i3;
        extraPackages = with pkgs; [
          nitrogen
          flameshot
          libnotify
          brightnessctl
        ];
      };
    };
#    home-manager.users.rawpie.home.file = {
#      ".config/i3/config".source = ./i3/config;
#    };
  };
}
