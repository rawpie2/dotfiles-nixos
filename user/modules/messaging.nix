{ lib, config, pkgs, ... }:
let
  cfg = config.messaging;
in
{
  options.messaging = {
    enable = lib.mkEnableOption "messaging";
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (discord.override { withOpenASAR = true; withVencord = true; })

      # Used for running discord the first time or when vencord breaks
      (writers.writeBashBin "vanillaDiscord" ''
       pkill .Discord-wrapp 
       export NIXPKGS_ALLOW_UNFREE=1; nix run nixpkgs#discord --impure
      '')
      signal-desktop
      telegram-desktop
    ];
  };
}
