{pkgs ? import <nixpkgs> {}}:

with pkgs;
let 
  my-python-packages = python-packages: with python-packages; [
    pandas
    numpy
    matplotlib
    #Add packages as necessary
  ];
  python-with-packages = python3.withPackages my-python-packages;
in
  pkgs.mkShell {
    name="python-nix-environment";
    buildInputs = [
      python-with-packages
    ];
    shellHook = ''
      echo "Python environment ready..."
      '';
  }
