{ lib, config, pkgs, ... }:

{
  environment.etc."keyboard_switch.sh" = {
    text = builtins.readFile ./user/scripts/keyboard_switch.sh;
    mode = "0755";
  };
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", ATTRS{product}=="USB Keyboard",

}
