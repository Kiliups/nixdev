{
  description = "Home Manager template for Darwin developer hosts";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      stylix,
      ...
    }:
    let
      configPath = "${toString ./.}/config/local.nix";
      templateConfig =
        if builtins.pathExists configPath then import configPath else import ./config/example.nix;

      mkHome =
        {
          username,
          name,
          email,
          justTmuxSetup ? false,
        }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "aarch64-darwin";
            config.allowUnfree = true;
          };

          extraSpecialArgs = {
            inherit name email justTmuxSetup;
          };

          modules = [
            stylix.homeModules.stylix
            ./users/template.nix
            {
              home = {
                inherit username;
                stateVersion = "26.05";
                homeDirectory = "/Users/${username}";
              };
            }
          ];
        };
    in
    {
      lib.mkHome = mkHome;

      homeConfigurations = builtins.listToAttrs (
        map (home: {
          name = home.username;
          value = mkHome home;
        }) templateConfig.homes
      );
    };
}
