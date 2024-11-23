{
  description = "Nix flake for x86-simd-sort library";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/24.05";
  };

  outputs = { self, nixpkgs }:
    rec {
      packages.x86_64-linux.x86SimdSort = import ./default.nix {
        inherit nixpkgs;
        buildTests = true;
        buildBenchmarks = true;
        libType = "shared";
      };

      packages.x86_64-linux.default = packages.x86_64-linux.x86SimdSort;
    };
}
