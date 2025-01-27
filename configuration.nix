{ config, pkgs, ... }:

{
  imports =
    [
#      ./user/x/i3/i3.nix
      ./user/modules/messaging.nix
      ./user/general/cli/cli-utils.nix
      ./user/general/cli/btop.nix
      ./user/general/cli/zsh/zsh.nix
      ./user/general/gui/wezterm/wezterm.nix
      ./user/general/x/rofi/rofi.nix
    ];
  stylix = {
    enable = true;
      base16Scheme = {
        base00 = "#261920";
        base01 = "#4d1b35";
        base02 = "#671b43";
        base03 = "#8f1f5a";
        base04 = "#b94682";
        base05 = "#d575a8";
        base06 = "#e9a1c6";
        base07 = "#ffffff";
        base08 = "#ff0000";
        base09 = "#00beff";
        base0A = "#00a209";
        base0B = "#d97b00";
        base0C = "#7d0090";
        base0D = "#ea11ae";
        base0E = "#0051ff";
        base0F = "#fff2fb";
      };
   image = ./user/theme/wallpaper;
   polarity = "dark";
   targets.gtk.enable = false;
  };

  programs = {
    dconf.enable = true;
    ssh = {
      startAgent = true;
     # agentTimeout = "30m";
    };
  };

### Flakes!!
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

### OpenGL
#  hardware.opengl = {
#    enable = true;
#    driSupport = true;
#    driSupport32Bit = true;
#};

##### Modules #####

#  i3.enable = true;
  messaging.enable = true;
  cliutils.enable = true;
  btop.enable = true;
  zsh.enable = true;
  wezterm.enable = true;
  rofi.enable = true;

###################

#bell off
xdg.sounds.enable = false;

  swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 60*1024;
  } ];

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  #media-session.enable = true;

  # Bootloader.
  #boot.loader.systemd-boot.enable = true;
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = true;
    };
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

### Services

  # Desktop
  services = {
#    automatic-timezoned = {
#      enable = true;
#    };

    xserver = {
      enable = true;
      xkb = { #keymap
        layout = "us";
        variant = "";
      };
      windowManager.i3 = {
        enable = true;
        package = pkgs.i3;
        extraPackages = with pkgs; [
          nitrogen
          flameshot
          libnotify
          brightnessctl
	  i3status
        ];
      };
    };

    desktopManager = {
      plasma6 = {
        enable = true;
      };
    };

    printing = {
      enable = false;
    };

    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
	KbdInteractiveAuthentication = false;
	ClientAliveInterval = 300;
	ClientAliveCountMax = 2;
      };
    };

    syncthing = {
      enable = true;
      systemService = true;
      user = "rawpie";
      dataDir = "/home/rawpie";
    };

    udev.packages = with pkgs; [
      vial
    ];
  };
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rawpie = {
    isNormalUser = true;
    description = "rawpie";
    extraGroups = [
     "networkmanager"
     "wheel"
    ];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHdC/Mo03k78Y7tynI9pIod1poCVvxTXyaQeCBUtScjn" ];
    initialPassword = "12345";
  };

  environment = {
    systemPackages = with pkgs; [ 

      (where-is-my-sddm-theme.override {
        themeConfig.General = {
          backgroundFill = "${config.stylix.base16Scheme.base00}";
          passwordCursorColor = "${config.stylix.base16Scheme.base01}";
          passwordTextColor = "${config.stylix.base16Scheme.base0D}";
        };
      })

      firefox
      floorp
      rustup
      keepassxc
      qsyncthingtray
      spotify
      gimp
      obsidian
      gparted
      mpv
      syncplay
      #feishin
      xclip
      obs-studio
      nextcloud-client
      qflipper
      vial
      supersonic
      openvpn
    ];
  };

  nixpkgs.config.allowUnfree = true;
 
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
