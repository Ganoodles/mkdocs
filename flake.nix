{
  description = "custom flake to deploy mkdocs website";

  outputs = { self, nixpkgs }: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
   in {
    packages.${system}.default = pkgs.stdenv.mkDerivation {
      name = "mkdocs deploy";
      version = "0.1";
      src = ./.;
      nativeBuildInputs = [pkgs.mkdocs];
      buildPhase = ''
      ${pkgs.mkdocs}/bin/mkdocs build
      mkdir -p $out
      mv site/* $out
      '';
    };
  };
}