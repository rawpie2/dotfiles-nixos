{ lib, config, nixos-hardware, ... }:
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
