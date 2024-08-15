{ lib, config, pkgs, ... }:
let
  cfg = config.cliutils;
in
{
  options.cliutils = {
    enable = lib.mkEnableOption "cliutils";
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      hyfetch
      pciutils 
    ];
  };
}
