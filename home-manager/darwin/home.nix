# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, lib, config, pkgs, ... }: {
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors), use something like:
    # inputs.nix-colors.homeManagerModule
    ../common.nix
    ../cli
    ../dotfiles
    ../git.nix
    ../1password
    # Feel free to split up your configuration and import pieces of it here.
  ];



  home = {
    username = "bjk";
    homeDirectory = "/Users/bjk";
  };



}
