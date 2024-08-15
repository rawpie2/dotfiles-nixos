{ lib, config, pkgs, ... }:
let
  cfg = config.nvidia;
in
{
  options.nvidia = {
    enable = lib.mkEnableOption "nvidia";
  };
  config = lib.mkIf cfg.enable {
    #Nvidia settings for hybrid graphics(AMD video cores and Nvidia)

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
      #prime = {
        #offload.enable = true;
        #sync.enable = true;

        #amdgpuBusId = "PCI:5:0:0";
        #nvidiaBusId = "PCI:1:0:0";
      #};
    };
  };
}
