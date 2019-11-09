with import <nixpkgs> {};
pkgs.mkShell {
  buildInputs = [
    luajitPackages.luarocks
    luajitPackages.lua
    libpulseaudio

    pkg-config
  ];
}
