{  pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
    buildInputs = [
        pkgs.gcc
        pkgs.libX11
    ];
}
