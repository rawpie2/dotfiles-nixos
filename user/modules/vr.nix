{ lib, config, pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      monado
    ];
#    variables = {
#      STEAMVR_LH_ENABLE = true;
#      XRT_COMPOSITOR_COMPUTE = 1;
#    };
  };

  services = {
    monado = {
      enable = true;
      defaultRuntime = false;
      highPriority = true;
    };
  };

#  boot= {
#    kernelPatches = [pkgs.kernelPatches.cap_sys_nice_begone];
#  };
#  kernelPatches.cap_sys_nice_begone = {
#    name = "cap_sys_nice_begone";
#    patch = ./cap_sys_nice_begone.patch;
#  };
}
