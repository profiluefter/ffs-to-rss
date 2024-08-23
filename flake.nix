{
  description = "firefox sync tabs -> RSS Feed ";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in
    {
      packages.x86_64-linux.firefox-sync-client = pkgs.buildGoModule rec {
        pname = "firefox-sync-client";
        version = "1.8.0";

        src = pkgs.fetchFromGitHub {
          owner = "Mikescher";
          repo = "firefox-sync-client";
          rev = "v${version}";
          sha256 = "sha256-Ax+v4a8bVuym1bp9dliXX85PXJk2Qlik3ME+adGiL1s=";
        };

        vendorHash = "sha256-MYetPdnnvIBzrYrA+eM9z1P3+P5FumYKH+brvvlwkm4=";
      };

      packages.x86_64-linux.default = self.packages.x86_64-linux.serve;

      packages.x86_64-linux.serve = pkgs.writeShellApplication {
        name = "serve.sh";
        runtimeInputs = [
          pkgs.socat
          self.packages.x86_64-linux.generate-rss
        ];
        text = builtins.readFile ./serve.sh;
      };
      packages.x86_64-linux.generate-rss = pkgs.writeShellApplication {
        name = "generate-rss.sh";
        runtimeInputs = [
          pkgs.yq-go
          self.packages.x86_64-linux.firefox-sync-client
        ];
        text = builtins.readFile ./generate-rss.sh;
      };
      packages.x86_64-linux.login = pkgs.writeShellApplication {
        name = "login.sh";
        runtimeInputs = [
          self.packages.x86_64-linux.firefox-sync-client
        ];
        text = builtins.readFile ./login.sh;
      };

      checks = self.packages;

      devShells.x86_64-linux.default = pkgs.mkShell {
        buildInputs = [
          self.packages.x86_64-linux.firefox-sync-client
          self.packages.x86_64-linux.serve
          self.packages.x86_64-linux.generate-rss
          self.packages.x86_64-linux.login
          pkgs.yq-go
        ];
      };

      formatter.x86_64-linux = pkgs.nixpkgs-fmt;
    };
}
