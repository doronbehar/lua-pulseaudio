with import <nixpkgs> {};
pkgs.mkShell {
  buildInputs = [
    lua53Packages.luarocks
    lua53Packages.lua
    libpulseaudio

    pkg-config
  ];
}
