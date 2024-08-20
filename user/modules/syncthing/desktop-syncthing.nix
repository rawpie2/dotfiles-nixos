{ lib, config, pkgs}:
{
 syncthing = {
   enable = true;
   user = "rawpie";
   dataDir = "/home/rawpie";
   configDir = "/home/rawpie/.config/syncthing";
   systemService = true;
   settings = {
     gui = {
       user = "rawpie";
     };
   };
 };
}
