class Nextpnr < Formula
  desc "Place and Route Tool for ECP5 FPGAs"
  homepage "https://github.com/YosysHQ/nextpnr"
  url "https://github.com/YosysHQ/nextpnr/archive/3f26cf50767143e48d29ae691b2a0052c359eb15.tar.gz"
  version "20190810"
  sha256 "f7d992376e95c95d1fe105d5c90e038b7119355ff0eed1f7036aff13cb8bbf34"
  head "https://github.com/YosysHQ/nextpnr.git"

  option "without-gui", "No GUI"
  option "without-python", "No python scripting support"
  option "with-static", "Build with static libraries"
  option "with-arch-generic", "Enable generic arch support"
  option "without-arch-ice40", "Disable support for Lattice iCE40 FPGAs"
  option "without-arch-ecp5", "Disable support for Lattice ECP5 FPGAs"

  depends_on "cmake" => :build
  depends_on "ninja" => :build

  depends_on "boost"
  depends_on "boost-python3"
  depends_on "eigen"
  depends_on "icestorm" if build.with? "arch-ice40"
  depends_on "prjtrellis" if build.with? "arch-ecp5"
  depends_on "qt" if build.with? "gui"
  depends_on "python" => :optional

  def install
    args = []
    args << "-DBUILD_GUI=OFF" if build.without? "gui"
    args << "-DBUILD_PYTHON=OFF" if build.without? "python"
    args << "-DSTATIC_BUILD=ON" if build.with? "static"

    archs = []
    archs << "ice40" if build.with? "arch-ice40"
    archs << "ecp5" if build.with? "arch-ecp5"
    archs << "generic" if build.with? "arch-generic"
    args << ("-DARCH=" << archs.join(";"))

    system "cmake", *args, ".", "-GNinja", *std_cmake_args
    system "ninja"
    system "ninja", "install"
  end

  test do
    system "#{bin}/nextpnr-ecp5", "--help" if build.with? "arch-ecp5"
    system "#{bin}/nextpnr-ice40", "--help" if build.with? "arch-ice40"
  end
end
