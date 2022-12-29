{ nixpkgs ? import <nixpkgs> {} }:

let
  rustOverlay = builtins.fetchTarball "https://github.com/oxalica/rust-overlay/archive/master.tar.gz";
  llvmstdenv = pkgs.llvmPackages_11.stdenv;

  # NixOS 22.05
  pinnedPkgs = fetchTarball "https://github.com/NixOS/nixpkgs/archive/0938d73bb143f4ae037143572f11f4338c7b2d1c.tar.gz"; 
  

  pkgs = import pinnedPkgs {
    overlays = [ (import rustOverlay) ];
  };

  rustbin = pkgs.rust-bin.stable.latest.default.override {
    extensions = [ "rust-src" ];
    targets = [ "wasm32-unknown-unknown" ];
  };
in
pkgs.mkShell.override { stdenv = llvmstdenv;} {
  
  nativeBuildInputs = with pkgs; [
    git
    pkg-config
    nodejs
    nodePackages.npm
    binaryen
    jq
  ];

  buildInputs = with pkgs; [
    openssl
    rustbin
    wasm-pack
  ];

}