{ lib, config, pkgs, ... }:
{
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
      moonlight-qt
      (writers.writeBashBin "protonhax" (builtins.readFile ./protonhax))
      ];
    sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS =
      "/home/rawpie/.steam/root/compatibilitytools.d";
    };
  };
  programs.gamemode.enable = true;
  services.xserver.enable = true;
}
