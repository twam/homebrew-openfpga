class Nextpnr < Formula
  desc "Place and Route Tool for ECP5 FPGAs"
  homepage "https://github.com/YosysHQ/nextpnr"
  url "https://github.com/YosysHQ/nextpnr/archive/c1d15c749c2aa105ee7b38ebe1b60a27e3743e8c.tar.gz"
  version "20190108"
  sha256 "5f410f956e730bef44f70e89aa7e9f7ea57c4ad2fe6c59f78ed0798f99ba0a16"
  head "https://github.com/YosysHQ/nextpnr.git"

  option "without-gui", "No GUI"
  option "with-arch-generic", "Enable generic arch support"
  option "without-arch-ice40", "Disable support for Lattice iCE40 FPGAs"
  option "without-arch-ecp5", "Disable support for Lattice ECP5 FPGAs"

  depends_on "cmake" => :build

  depends_on "icestorm" if build.with? "arch-ice40"
  depends_on "prjtrellis" if build.with? "arch-ecp5"
  depends_on "qt5" if build.with? "gui"
  depends_on "boost"
  depends_on "boost-python3"
  depends_on "python@3"

  def install
    args = []
    args << "-DBUILD_GUI=OFF" if build.without? "gui"
    args << "-DTRELLIS_ROOT=/usr/local/share/trellis" if build.with? "arch-ecp5"

    archs = []
    archs << "ice40" if build.with? "arch-ice40"
    archs << "ecp5" if build.with? "arch-ecp5"
    archs << "generic" if build.with? "arch-generic"
    args << ("-DARCH=" << archs.join(";"))

    system "cmake", *args, ".", *std_cmake_args
    system "make"
    system "make install"
  end
end
