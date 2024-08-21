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
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
    environment.systemPackages = with pkgs; [
      protontricks
      prismlauncher
      heroic
      lutris
      itch
      wineWowPackages.stable
      winetricks
      (writers.writeBashBin "protonhax" (builtins.readFile ./protonhax))
    ];
  };
}
