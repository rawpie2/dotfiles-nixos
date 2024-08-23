{ lib, config, nixos-hardware, ... }:
let
  cfg = config.laptop;
in
{
  options.laptop = {
    enable = lib.mkEnableOption "laptop";
  };
  config = lib.mkIf cfg.enable {
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;
  };
}
