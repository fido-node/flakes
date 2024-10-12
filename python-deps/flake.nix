{
  description = "A flake with minor python deps";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs =
    { self
    , nixpkgs
    , flake-utils
    ,
    }:
    let
      supportedSystems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-linux"
        "x86_64-darwin"
      ];
    in
    flake-utils.lib.eachSystem supportedSystems (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            python312Packages.invoke
            python312Packages.pyyaml
          ];
        };
        formatter = pkgs.nixpkgs-fmt;
      }
    );
}
