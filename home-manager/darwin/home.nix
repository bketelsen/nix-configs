# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, lib, config, pkgs, ... }: {
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors), use something like:
    # inputs.nix-colors.homeManagerModule
    ../common.nix
    # Feel free to split up your configuration and import pieces of it here.
  ];

  # Comment out if you wish to disable unfree packages for your system
  nixpkgs.config.allowUnfree = true;

  home = {
    username = "bjk";
    homeDirectory = "/Users/bjk";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];
    home.packages = with pkgs; [
        age
        cachix
        comma
        curl
        fd
        ffmpeg
        gawk
        git
        gnugrep
        gnupg
        gnused
        google-cloud-sdk
        helmfile
        htop
        httpie
        jq
        kubectl
        kubernetes-helm
        luajit
        mmv
        neovim
        nix
        nixfmt
        nixpkgs-fmt
        nodejs_latest
        openssh
        pandoc
        parallel
        pkgs.coreutils-full
        pre-commit
        neofetch
        nix-prefetch
        rclone
        ripgrep
        rsync
        shellcheck
        stylua
        sysdo
        tealdeer
        terraform
        treefmt
        yarn
        yq-go
      ];
  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.05";
}
