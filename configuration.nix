# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Configure grub EFI boot loader.
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;
  
  #Set nixos-unstable as the upgrade channel
  system.autoUpgrade.channel = "https://nixos.org/channels/nixos-unstable/";

  # networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
 i18n.defaultLocale = "en_US.UTF-8";
 console = {
   font = "Lat2-Terminus16";
   keyMap = "us";
 };
  #Set the timezone
  time.timeZone = "America/Argentina/Mendoza";

  #Declare installed system packages
  environment.systemPackages = with pkgs; [
    wget 
    nano
    gnumake
    gcc-unwrapped
    neofetch
    htop
    gparted
    ark
    okular
    xfce.mousepad
    firefox 
    vscode
    arc-theme
    arc-kde-theme
    git
    discord
    vscode
    python3
    ansible
  ];

  programs.steam.enable = true;
  
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;

  
  # Enable the KDE Desktop Environment.
   services.xserver.displayManager.gdm.enable = true;
   services.xserver.desktopManager.plasma5.enable = true;

  # Enable the X11 windowing system
  services.xserver.enable = true;
  services.xserver.layout = "us";

  users.users.inox = {
    isNormalUser = true;
    home = "/home/inox";
    extraGroups = [ "wheel" "network" ]; # Enable ‘sudo’ for the user.
  };
  users.users.lucy = {
    isNormalUser = true;
    home = "/home/lucy";
    extraGroups = [ "wheel" "network" ]; # Enable ‘sudo’ for the user.
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

  #Allow installation of unfree packages
  nixpkgs.config.allowUnfree = true;
  
  #Enable automatic garbage collection
  nix.gc = {
	automatic = true;
        dates = "daily";
        options = "-- delete-older-than 7d";
  };
}
