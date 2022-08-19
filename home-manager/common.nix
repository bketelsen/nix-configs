# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, lib, config, pkgs, ... }: {
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors), use something like:
    # inputs.nix-colors.homeManagerModule

    # Feel free to split up your configuration and import pieces of it here.
  ];

  # Comment out if you wish to disable unfree packages for your system
  nixpkgs.config.allowUnfree = true;


  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;
  home =
    let
      NODE_GLOBAL = "${config.home.homeDirectory}/.node-packages";
      SD_GLOBAL = "${config.home.homeDirectory}/.sd";

    in
    {
     stateVersion = "22.05";
      sessionVariables = {
        GPG_TTY = "/dev/ttys000";
        EDITOR = "nvim";
        VISUAL = "nvim";
        CLICOLOR = 1;
        LSCOLORS = "ExFxBxDxCxegedabagacad";
        NODE_PATH = "${NODE_GLOBAL}/lib";
        # HOMEBREW_NO_AUTO_UPDATE = 1;
      };
      sessionPath = [
        "${config.home.homeDirectory}/bin"
        "${NODE_GLOBAL}/bin"
        "${config.home.homeDirectory}/.sd"
      ];
  packages = with pkgs; [
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
        terraform
        treefmt
        yarn
        yq-go
      ];
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
 

}
