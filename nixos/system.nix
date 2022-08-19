{ inputs, lib, config, pkgs, ... }: {
  environment = {

    systemPackages = with pkgs; [
      # editors
      neovim

      # standard toolset
      coreutils-full
      curl
      wget
      git
      jq

      # helpful shell stuff
      bat
      fzf
      ripgrep

      # languages
      python3
      ruby
    ];
    etc = {
      home-manager.source = "${inputs.home-manager}";
      nixpkgs.source = "${pkgs.path}";
      stable.source = "${inputs.stable}";
    };
    # list of acceptable shells in /etc/shells
    shells = with pkgs; [ bash zsh fish ];
  };

}