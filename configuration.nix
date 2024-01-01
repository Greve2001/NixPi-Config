# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot = {
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };

    kernelPackages = pkgs.linuxPackages_rpi4;
  };

  environment.systemPackages = with pkgs; [
    # Needed
    libraspberrypi
    raspberrypi-eeprom

    neovim 
    wget
    git
    tree

    wayland
    xwayland
    greetd.tuigreet
  ];

  programs = {
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    hyprland.enable = true;
  };


  users.users.tv = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; 
    packages = with pkgs; [
      firefox
      spotify
      pavucontrol

      hyprpaper
      tofi
    ];
  };

  services = {
    openssh.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };


    greetd = {
      enable = true;
      settings = {
        default_session = { command = "tuigreet -r -c Hyprland"; };
      };
    };
  };
 
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.firewall.enable = true;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;

  system.copySystemConfiguration = true;
  system.stateVersion = "23.11"; # Did you read the comment?

}

