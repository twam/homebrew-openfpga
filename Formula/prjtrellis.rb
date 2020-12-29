class Prjtrellis < Formula
  desc "Device database and tools for bitstream creation for Lattice ECP5 FPGAs"
  homepage "https://github.com/SymbiFlow/prjtrellis"
  version "20200629"
  url "https://github.com/SymbiFlow/prjtrellis/archive/f93243b000c52b755c70829768d2ae6bcf7bb91a.tar.gz"
  sha256 "c2c36a7a9269010ea2b28546c6b6a2e90c055b0b7cb2e94634c35d0354b972ce"
  head "https://github.com/SymbiFlow/prjtrellis.git"

  option "without-python", "No python"
  option "without-shared", "No shared Trellis lib"
  option "with-static", "Use static lib build"

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "boost"
  depends_on "boost-python3"
  depends_on "python"

  resource "database" do
    url "https://github.com/SymbiFlow/prjtrellis-db/archive/c137076fdd8bfca3d2bf9cdacda9983dbbec599a.tar.gz"
    sha256 "9eb4fa063c1e2ab807ae2a1c1d9f2b3058b222358bc44d1b67debca55ad9afc3"
  end

  def install
    (buildpath/"database").install resource("database") unless build.head?

    args = []
    args << "-DBUILD_PYTHON=OFF" if build.without? "python"
    args << "-DBUILD_SHARED=OFF" if build.without? "shared"
    args << "-DSTATIC_BUILD=ON" if build.with? "static"

    args << "-DBoost_NO_BOOST_CMAKE=ON"

    stable_version_commit = @stable.url[/([a-f0-9]{8})[a-f0-9]{32}\.tar\.gz/,1]
    stable_version = @stable.version.to_s+" ("+stable_version_commit+")"
    args << "-DCURRENT_GIT_VERSION="+stable_version unless build.head?
    args << "-DCURRENT_GIT_VERSION="+head.version.commit if build.head?

    cd "libtrellis" do
      system "cmake", *args, ".", "-GNinja", *std_cmake_args
      system "ninja"
      system "ninja", "install"
    end
  end

  test do
    system "#{bin}/ecppack", "--help"
  end
end
