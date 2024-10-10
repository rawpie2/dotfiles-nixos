{ lib, config, pkgs, ... }:

{
  services = {
    displayManager = {
      sddm = {
        enable = true;
	theme = "where_is_my_sddm_theme";
      };
    };
  };
}
