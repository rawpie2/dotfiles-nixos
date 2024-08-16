{ lib, config, nixos-hardware, ... }:
let
  cfg = config.desktop;
in
{
  options.desktop = {
    enable = lib.mkEnableOption "desktop";
  };
  config = lib.mkIf cfg.enable {
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;

    fileSystems."/mnt/nvme2n1p2" = {
      device = "/dev/nvme2n1p2";
      fsType = "ntfs";
      options = [ "defaults" "user" "rw" "utf8" "umask=000" ];
     };
  };
}
