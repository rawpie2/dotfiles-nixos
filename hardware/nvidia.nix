{ lib, config, pkgs, ... }:
{
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
  forceFullCompositionPipeline = true;
  nvidiaPersistenced = true;
  modesetting.enable = true;
  open = true;
};
}
