{
  description = "A minimal scopes project";
  inputs = {
    scopes.url = "github:Fundament-software/scopes";
    scopes.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, scopes, nixpkgs, flake-utils }:
    (flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        devshell-ldpath =
          pkgs.lib.concatMapStringsSep ":" (lib: "${pkgs.lib.getLib lib}/lib")
          [ ];

      in {
        devShell = builtins.trace (builtins.attrNames self) (pkgs.mkShell {
          buildInputs = [ scopes.packages.${system}.scopes ];
          shellHook = ''
            export LD_LIBRARY_PATH=${devshell-ldpath}:$LD_LIBRARY_PATH
          '';

        });
      })) // {

      };

}
