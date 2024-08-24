{ lib, config, pkgs, ... }:
let
  cfg = config.nvidia;
in
{
  options.nvidia = {
    enable = lib.mkEnableOption "nvidia";
  };
  config = lib.mkIf cfg.enable {
    services.xserver = { 
	videoDrivers = ["nvidia"];
#	config = ''
#		ForceCompositionPipeline=On
#		ForceFullCompositionPipeline=On
#		AllowGSYNCCompatible=On
#	'';
    };
    hardware.nvidia = {
      #powerManagement = {
          #enabled = true;

          #finegrained = true; #maybe comment this out idk what it does
      #};
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      nvidiaPersistenced = true;
      modesetting.enable = true;
    };
  };
}
