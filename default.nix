{ nixpkgs
, buildTests ? true
, buildBenchmarks ? true
, libType ? "shared"
}:
let
  pkgs = import nixpkgs { system = "x86_64-linux"; };
  buildBenchmarksStr = if buildBenchmarks then "-Dbuild_benchmarks=true" else "";
  buildTestsStr = if buildTests then "-Dbuild_tests=true" else "";
in

with pkgs;

pkgs.stdenv.mkDerivation rec {
  pname = "x86-simd-sort";
  version = "6.0";

  src = ./.;

  mesonBuildType = "release";

  nativeBuildInputs = [
    pkg-config
    meson
    ninja
  ];

  buildInputs = [
    gcc
    gtest
    gbenchmark
  ];

  mesonFlags = [
    "-Dlib_type=${libType}"
    buildBenchmarksStr
    buildTestsStr
  ];

  meta = with pkgs.lib; {
    description = "High-performance SIMD-based sorting routines";
    homepage = "https://github.com/intel/x86-simd-sort";
    license = licenses.bsd3;
    platforms = platforms.linux;
    maintainers = [ "juliuskoskela" ];
  };
}
