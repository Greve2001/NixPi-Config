# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_rpi4;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.firewall.enable = true;
  
  users.users.tv = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; 
    packages = with pkgs; [
      firefox
    ];
  };

  environment.systemPackages = with pkgs; [
    # Needed
    libraspberrypi
    raspberrypi-eeprom

    neovim 
    wget
    git
    tree
  ];

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh.enable = true;

  system.copySystemConfiguration = true;
  system.stateVersion = "23.11"; # Did you read the comment?

}

