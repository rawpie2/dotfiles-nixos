{
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    jovian.url = "github:Jovian-Experiments/Jovian-NixOS";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nvim = {
      url = "github:rawpie2/dotfiles-nvim";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

###

  };

  outputs = { self, nixpkgs, home-manager, jovian, ... }@inputs:
    {
      nixosConfigurations =
        let       
          lib = nixpkgs.lib;
        in
        {
          desktop-nixos = lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {
              inherit home-manager;
              inherit inputs;
            };
            modules = [
              ./configuration.nix
              ./user/modules/zen.nix
              inputs.stylix.nixosModules.stylix
	      inputs.nvim.nixosModules.nvim
              home-manager.nixosModules.default
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.rawpie = import ./user/home.nix;
              }
              ./hardware-configuration/desktop.nix
              ./hardware/desktop.nix
              ./user/general/x/dm.nix
              ./hardware/nvidia.nix
              ./user/modules/vr.nix
              ./user/modules/gaming.nix
            ];
          };

	  thinkpad-nixos = lib.nixosSystem {
	    system = "x86_64-linux";
	    specialArgs = {
              inherit home-manager;
	      inherit inputs;
	    };
	    modules = [
              ./configuration.nix
              ./user/modules/zen.nix
              inputs.stylix.nixosModules.stylix
	      inputs.nvim.nixosModules.nvim
              home-manager.nixosModules.default
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.rawpie = import ./user/home.nix;
              }
              ./hardware-configuration/laptop.nix
              ./hardware/laptop.nix
              ./user/general/x/dm.nix
              ./user/modules/gaming.nix
            ];
	  };

          steamdeck-nixos = lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {
              inherit home-manager;
              inherit inputs;
            };
            modules = [
              ./configuration.nix
              ./user/modules/deck.nix
              inputs.stylix.nixosModules.stylix
              inputs.nvim.nixosModules.nvim
              home-manager.nixosModules.default
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.rawpie = import ./user/home.nix;
               # home-manager.backupFileExtension = "asdf59031";
              }
              jovian.nixosModules.default
              {
                jovian.devices.steamdeck.enable = true;
                jovian.devices.steamdeck.enableGyroDsuService = true;
                jovian.steam = {
                  enable = true;
                  autoStart = true;
                  desktopSession = "plasmax11";
                  user = "rawpie";
                };
                jovian.decky-loader.enable = true;
              }
              ./hardware-configuration/steamdeck.nix
            ];
          }; 
        };
    };
}
