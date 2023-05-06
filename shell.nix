{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/aa2f845096f72dde4ad0c168eeec387cbd2eae04.tar.gz") {}}:
with pkgs;

let findspark =
  python39.pkgs.buildPythonPackage rec {
    pname = "findspark";
    version = "2.0.1";
    src = python39.pkgs.fetchPypi {
      inherit pname version;
      sha256 = "sha256-qhCpbLYWyrMpGB1y6O8T0txFO0ur0CtUgkcaCILBGV4=";
    };
    doCheck = false;
  }; in

let myPythonPackages =
  python39.withPackages (p: with p; [
    findspark
  ]); in

pkgs.mkShell {
  buildInputs = with pkgs; [
    myPythonPackages
  ];

  shellHook = ''
    export PS1='\[\e[0;38;5;129m\]\W \[\e[0m\]& \[\e[0m\]'

    # echo ""
    # echo "To repeat the experiments execute experiments.py."
    # echo "The results can be found in ./results."
  '';
}