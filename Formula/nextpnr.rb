class Nextpnr < Formula
  desc "Place and Route Tool for FPGAs"
  homepage "https://github.com/YosysHQ/nextpnr"
  url "https://github.com/YosysHQ/nextpnr/archive/0e83db47a067b55f45567c89a08af470196a18e7.tar.gz"
  version "20210826"
  sha256 "0cc5eea106dff657c66d595df46909a1a7e7d736d8fb5b68115cd484ae5521ec"
  head "https://github.com/YosysHQ/nextpnr.git"

  option "with-gui", "Enable GUI"
  option "without-python", "No python scripting support"
  option "with-static", "Build with static libraries"
  option "with-arch-generic", "Enable generic arch support"
  option "without-arch-ice40", "Disable support for Lattice iCE40 FPGAs"
  option "without-arch-ecp5", "Disable support for Lattice ECP5 FPGAs"
  option "without-arch-nexus", "Disable support for Lattice Nexus FPGAs"
  option "with-saferam", "Build chip databases sequentially to save RAM during build"

  depends_on "cmake" => :build
  depends_on "ninja" => :build

  depends_on "boost"
  depends_on "boost-python3"
  depends_on "eigen"
  depends_on "icestorm" if build.with? "arch-ice40"
  depends_on "prjtrellis" if build.with? "arch-ecp5"
  depends_on "prjoxide" if build.with? "arch-nexus"
  depends_on "qt5" if build.with? "gui"
  depends_on "python" if build.with? "python"

  resource "fpga-interchange-schema" do
   url "https://github.com/SymbiFlow/fpga-interchange-schema/archive/6b2973788692be86c4a8b2cff1353e603e5857a3.tar.gz"
   sha256 "d533b3157bb336aebefdb6bd12651b2f28a995df7b3c16067626befe9a1e2790"
  end

  def install
    (buildpath/"3rdparty/fpga-interchange-schema").install resource("fpga-interchange-schema") unless build.head?

    # Generic options
    args = []
    args << "-DBUILD_GUI=ON" if build.with? "gui"
    args << "-DBUILD_PYTHON=OFF" if build.without? "python"
    args << "-DSTATIC_BUILD=ON" if build.with? "static"
    args << "-DSERIALIZE_CHIPDBS=FALSE" if build.without? "saferam"

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
