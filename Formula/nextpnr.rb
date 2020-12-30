class Nextpnr < Formula
  desc "Place and Route Tool for FPGAs"
  homepage "https://github.com/YosysHQ/nextpnr"
  url "https://github.com/YosysHQ/nextpnr/archive/5e53a182921dad0e128186a1fe8766062c7cae61.tar.gz"
  version "20201227"
  sha256 "12a798cfecaadf551704bd6bf99fbcd83d1428244be21ddadadc3e7e5da15eb0"
  head "https://github.com/YosysHQ/nextpnr.git"

  option "without-gui", "No GUI"
  option "without-python", "No python scripting support"
  option "with-static", "Build with static libraries"
  option "with-arch-generic", "Enable generic arch support"
  option "without-arch-ice40", "Disable support for Lattice iCE40 FPGAs"
  option "without-arch-ecp5", "Disable support for Lattice ECP5 FPGAs"
  option "without-arch-nexus", "Disable support for Lattice Nexus FPGAs"

  depends_on "cmake" => :build
  depends_on "ninja" => :build

  depends_on "boost"
  depends_on "boost-python3"
  depends_on "eigen"
  depends_on "icestorm" if build.with? "arch-ice40"
  depends_on "prjtrellis" if build.with? "arch-ecp5"
  depends_on "prjoxide" if build.with? "arch-nexus"
  depends_on "qt" if build.with? "gui"
  depends_on "python" if build.with? "python"

  def install
    # Generic options
    args = []
    args << "-DBUILD_GUI=OFF" if build.without? "gui"
    args << "-DBUILD_PYTHON=OFF" if build.without? "python"
    args << "-DSTATIC_BUILD=ON" if build.with? "static"

    # Architectures
    archs = []

    # ICE40
    archs << "ice40" if build.with? "arch-ice40"
    args << "-DICESTORM_INSTALL_PREFIX=#{Formula["icestorm"].opt_prefix}" if build.with? "arch-ice40"

    # ECP5
    archs << "ecp5" if build.with? "arch-ecp5"
    args << "-DTRELLIS_INSTALL_PREFIX=#{Formula["prjtrellis"].opt_prefix}" if build.with? "arch-ecp5"

    # Nexus
    archs << "nexus" if build.with? "arch-nexus"
    args << "-DOXIDE_INSTALL_PREFIX=#{Formula["prjoxide"].opt_prefix}" if build.with? "arch-nexus"

    # Generic
    archs << "generic" if build.with? "arch-generic"

    args << ("-DARCH=" << archs.join(";"))

    # Version information
    stable_version_commit = @stable.url[/([a-f0-9]{8})[a-f0-9]{32}\.tar\.gz/,1]
    stable_version = @stable.version.to_s+" ("+stable_version_commit+")"
    args << "-DCURRENT_GIT_VERSION="+stable_version unless build.head?
    args << "-DCURRENT_GIT_VERSION="+head.version.commit if build.head?

    system "cmake", *args, ".", "-GNinja", *std_cmake_args
    system "ninja"
    system "ninja", "install"
  end

  test do
    system "#{bin}/nextpnr-ice40", "--help" if build.with? "arch-ice40"
    system "#{bin}/nextpnr-ecp5", "--help" if build.with? "arch-ecp5"
    system "#{bin}/nextpnr-nexus", "--help" if build.with? "arch-nexus"
  end
end
