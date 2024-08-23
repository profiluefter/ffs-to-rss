{
  description = "firefox sync tabs -> RSS Feed ";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: let
  	pkgs = import nixpkgs { system = "x86_64-linux"; };
  in
   {
    packages.x86_64-linux.default = pkgs.hello;
  };
}
