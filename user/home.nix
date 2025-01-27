{ config, pkgs, home-manager, ... }:

{
  home.stateVersion = "24.05";
  fonts.fontconfig.enable = true;

### Fix gtk bs
  # force creation of ~/.config/gtk-2.0/gtkrc otherwise home-manager will fail
  home.file.${config.gtk.gtk2.configLocation}.force = true;

  # force creation of ~/.config/gtk-3.0/settings.ini otherwise home-manager will fail
  xdg.configFile."gtk-3.0/settings.ini".force = true;

  # force creation of ~/.config/gtk-4.0/gtk.css otherwise home-manager will fail
  xdg.configFile."gtk-4.0/gtk.css".force = true;

  # force creation of ~/.config/gtk-4.0/settings.ini otherwise home-manager will fail
  xdg.configFile."gtk-4.0/settings.ini".force = true;
###

  programs.wezterm.enable = true;

  home.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  home.file = {
    ##
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };
}
