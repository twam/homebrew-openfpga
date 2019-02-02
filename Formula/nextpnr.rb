class Nextpnr < Formula
  desc "Place and Route Tool for ECP5 FPGAs"
  homepage "https://github.com/YosysHQ/nextpnr"
  url "https://github.com/YosysHQ/nextpnr/archive/6d664046d3774c8fa2a9dccb64dd8ab06cc0cd0a.tar.gz"
  version "20190129"
  sha256 "631995b809c65ef73976de707da81ae7b0450daf0eaf4af763f83c1d6117a44d"
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
