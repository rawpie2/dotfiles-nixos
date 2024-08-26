{ lib, config, pkgs, ... }:

{
  services.syncthing = {
    enable = true;
    user = "rawpie";
    dataDir = "/home/rawpie";
    systemService = true;
  };
}
