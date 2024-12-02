# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "/dev/nvme0n1";

  networking.hostName = "phoenix"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
 time.timeZone = "Asia/Kathmandu";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

nix.settings.experimental-features = [ "nix-command" "flakes" ];
nixpkgs.config = {allowUnfree = true;};

fonts.packages = with pkgs;[
	noto-fonts
	nerdfonts

];

  # Enable the windowing system.
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
  services.xserver.enable = true;
# services.displayManager.sddm.enable = true;
# services.displayManager.sddm.wayland.enable = true;


services.greetd = {
    enable = true;
    package = pkgs.greetd.tuigreet;
    settings = {
      default_session = {
        command = (wm: "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd ${wm}") "hyprland";
      };
    };
  };
 

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # enable bluetooth
  hardware.bluetooth.enable = true;
  hardware.brillo.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
   services.pipewire = {
     enable = true;
     pulse.enable = true;
   };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
 users.users.ceaser = {
   home = "/home/ceaser";
   isNormalUser = true;
   shell = pkgs.zsh;
   extraGroups = [ "wheel" "video" "storage" ]; # Enable ‘sudo’ for the user.
   packages = with pkgs; [
     neovim
     vim
     tree
     zsh
     dunst
     rofi-wayland
     telegram-desktop
     signal-desktop
     dolphin
     pavucontrol
     librewolf
     firefox
     chromium
     rustup
     cargo
     kitty
     alacritty
     ranger
     htop
     fastfetch
     nodejs_22
     zoxide
     python3
     eza
     killall
     unzip
     ripgrep
     kdePackages.kdeconnect-kde
     greetd.tuigreet
     presenterm
     discord
     kdePackages.kdeconnect-kde
     wl-clipboard-rs
     zathura
     grim
     slurp
     obsidian
     hugo
     go
     lazygit
     tmux
     fzf
   ];
 };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
 environment.systemPackages = with pkgs; [
   ntfs3g
   udisks
   wget
   git
   libnotify
   waybar
   gcc
   hyprland
 ];

 environment.sessionVariables = {
	 WLR_NO_HARDWARE_CURSORS = "1";
	 NIXOS_OZONE_WL = "1";
 };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  # programs.light.enable = true;
 programs.hyprland = {
	 enable = true;
	 xwayland.enable = true;
 };
 programs.kdeconnect = {
	 enable = true;
	 package = pkgs.kdePackages.kdeconnect-kde;
 };
 
 programs.zsh.enable = true;


  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}


