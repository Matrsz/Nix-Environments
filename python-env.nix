#My Python Nix Environment for VScode. To be used with the Nix-Env extension.

{pkgs ? import <nixpkgs> {}}:

with pkgs;
let 
  my-python-packages = python-packages: with python-packages; [
    numpy
    matplotlib
    #Add packages as necessary
  ];
  python-with-packages = python3.withPackages my-python-packages;
  nixPackages = [
    python38Packages.ipykernel
  ]
in
  pkgs.mkShell {
    name="python-nix-environment";
    buildInputs = [
      python-with-packages
      nixPackages
    ];
    shellHook = ''
      echo "Python environment ready..."
      '';
  }
