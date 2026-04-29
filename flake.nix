{
  description = "Dotfiles";

  inputs = {
    nixpkgs = {
      url = "nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    homelab-secrets.url = "git+ssh://git@github.com/WardenDigital/homelab-secrets.git";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      disko,
      nvf,
      sops-nix,
      homelab-secrets,
      ...
    }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        ankylo = lib.nixosSystem {
          inherit system;

          specialArgs = { inherit homelab-secrets; };

          modules = [
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
            ./hosts/ankylo/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = {
                inherit system inputs homelab-secrets;
              };
              home-manager.backupFileExtension = "hm-backup";
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.ankylo = {
                imports = [
                  nvf.homeManagerModules.default
                  ./hosts/ankylo/home.nix
                ];
              };
            }
          ];
        };
      };
    };
}
