{ pkgs ? import <nixpkgs> {} }:

with pkgs;
let
  my-haskell-packages = haskell-packages: with haskell-packages; [
    base
  ];
  ghc-with-packages = haskellPackages.ghcWithPackages my-haskell-packages;
  nixPackages = [
    gdb
    stack
  ];
in
  pkgs.mkShell {
    name = "haskell-nix-environment";
    buildInputs = [
        ghc-with-packages
        nixPackages
    ];
    shellHook = ''
      echo "Haskell environment ready..."
      '';
  }