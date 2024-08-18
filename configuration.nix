{ config, pkgs, ... }:

{
  imports =
    [
    ./user/modules/messaging.nix
    ./user/modules/gaming.nix
    ./user/general/cli/cli-utils.nix
    ./hardware/nvidia.nix
    ./user/modules/vr.nix
    ./user/general/cli/btop.nix
    ./user/general/cli/zsh/zsh.nix
    ./user/general/gui/wezterm/wezterm.nix
    ./hardware/desktop.nix
    ./user/general/cli/neovim/nvim.nix
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
        base0D = "#ff00b0";
        base0E = "#0051ff";
        base0F = "#fff2fb";
      };
   image = ./user/theme/wallpaper;
   polarity = "dark";
   targets.gtk.enable = false;
  };

  programs.dconf.enable = true;

### Flakes!!
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot= {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  };

##### Modules #####

  messaging.enable = true;
  gaming.enable = true;
  cliutils.enable = true;
  btop.enable = true;
  zsh.enable = true;
  wezterm.enable = true;
  vr.enable = true;

  desktop.enable = true;
  nvidia.enable = true;

###################


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
   #jack.enable = true;
  };
  #media-session.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
    xserver = {
      enable = true;
      xkb = { #keymap
        layout = "us";
        variant = "workman";
      };
    };

    displayManager = {
      sddm = {
        enable = true;
      };
    };

    desktopManager = {
      plasma6 = {
        enable = true;
      };
    };
  };

  services = {
#    tlp = {             # make module when get laptop #
#      enable = true;
#      settings = {
#        CPU_SCALING_GOVERNOR_ON_AC = "performance";
#        CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";

#        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
#        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

#        CPU_MIN_PERF_ON_AC = 0;
#        CPU_MAX_PERF_ON_AC = 100;
#        CPU_MIN_PERF_ON_BAT = 0;
#        CPU_MAX_PERF_ON_BAT = 80;
#      };
#    };
    syncthing = {
      enable = true;
      user = "rawpie";
      dataDir = "/home/rawpie/Documents";
      configDir = "/home/rawpie/.config/syncthing";
      systemService = true;
      settings = {
        gui = {
          user = "rawpie";
        };
      };
    };

    printing = {
      enable = true;
    };
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
    initialPassword = "12345";
  };

  environment = {
    systemPackages = with pkgs; [ 
      firefox
      floorp
      rustup
      keepassxc
      syncthingtray-minimal
      spotify
      gimp
      obsidian
      gparted
      mpv
      syncplay
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
