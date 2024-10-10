{ lib, config, pkgs, home-manager, ... }:
let
  cfg = config.wezterm;
in
{
  options.wezterm = {
    enable = lib.mkEnableOption "wezterm";
  };
  config = lib.mkIf cfg.enable {
    security.sudo.extraConfig = "Defaults pwfeedback"; # show ***** on pw
    environment.systemPackages = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];
    home-manager.users.rawpie = {
      programs.wezterm = {
        enable = true;
        extraConfig = /*lua*/ ''
          local wezterm = require 'wezterm'
          return {
            font = wezterm.font 'FiraCode Nerd Font Mono',
                 front_end = "WebGpu",
                 use_fancy_tab_bar = false,
                 hide_tab_bar_if_only_one_tab = true,
                 window_decorations = "RESIZE",
                 window_padding = {
                   left    = 5,
                   right   = 5,
                   top     = 5,
                   bottom  = 5,
                 },
                 adjust_window_size_when_changing_font_size = false,
                 window_background_opacity = 0.8,
                 text_background_opacity = 1.0,
          }
        '';
      };
    };
  };
}
