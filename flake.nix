{
  description = "You new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # TODO: Add any other flake you might need

    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    # nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      forAllSystems = nixpkgs.lib.genAttrs systems;
      systems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
    in
    rec {
      # Your custom packages and modifications
      overlays = { default = import ./overlay { inherit inputs; }; };

      # Reusable nixos modules you might want to export
      # These are usually stuff you would upstream into nixpkgs
      nixosModules = import ./modules/nixos;
      # Reusable home-manager modules you might want to export
      # These are usually stuff you would upstream into home-manager
      homeManagerModules = import ./modules/home-manager;

      # Devshell for bootstrapping
      # Acessible through 'nix develop' or 'nix-shell' (legacy)
      devShells = forAllSystems (system: {
        default = legacyPackages.${system}.callPackage ./shell.nix { };
      });

      # Reexport nixpkgs with our overlays applied
      # Acessible on our configurations, and through nix build, shell, run, etc.
      legacyPackages = forAllSystems (system:
        import inputs.nixpkgs {
          inherit system;
          overlays = builtins.attrValues overlays;
        });


      nixosConfigurations =
        let
          mkHost = system: hostname: nixpkgs.lib.nixosSystem {
            pkgs = legacyPackages.${system};
            modules = [
              ./nixos/${hostname}/configuration.nix
            ] ++ (builtins.attrValues nixosModules);
            specialArgs = { inherit inputs; };
          };
        in
        {
          beast = mkHost "x86_64-linux" "beast";
          thopter = mkHost "x86-64-linux" "thopter";
        };
      homeConfigurations = {
        "bjk@chapterhouse" =
          home-manager.lib.homeManagerConfiguration {
            pkgs = legacyPackages.aarch64-darwin;
            extraSpecialArgs = { inherit inputs; }; # Pass flake inputs to our config
            modules = (builtins.attrValues homeManagerModules) ++ [
              # > Our main home-manager configuration file <
              ./home-manager/darwin/home.nix
            ];
          };
        "bjk@beast" =
          home-manager.lib.homeManagerConfiguration {
            pkgs = legacyPackages.x86_64-linux;
            extraSpecialArgs = { inherit inputs; }; # Pass flake inputs to our config
            modules = (builtins.attrValues homeManagerModules) ++ [
              # > Our main home-manager configuration file <
              ./home-manager/linux/home.nix
            ];
          };
      };
    };
}
