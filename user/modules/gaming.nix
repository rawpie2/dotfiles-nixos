{ lib, config, pkgs, ... }:
let
  cfg = config.gaming;
in
{
  options.gaming = {
    enable = lib.mkEnableOption "gaming";
  };
  config = lib.mkIf cfg.enable {
    nixpkgs.config.allowBroken = true;
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
#      extraCompatPackages = with pkgs; [
#        proton-ge-bin
#      ];
    };
    environment = {
      systemPackages = with pkgs; [
        protontricks
        prismlauncher
        heroic
        lutris
        itch
        wineWowPackages.stable
        winetricks
        protonup
        (writers.writeBashBin "protonhax" (builtins.readFile ./protonhax))
        ];
      sessionVariables = {
        STEAM_EXTRA_COMPAT_TOOLS_PATHS =
	"/home/rawpie/.steam/root/compatibilitytools.d";
      };
    };
    programs.gamemode.enable = true;
  };
}
