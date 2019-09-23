class Prjtrellis < Formula
  desc "Device database and tools for bitstream creation for ECP5 FPGAs"
  homepage "https://github.com/SymbiFlow/prjtrellis"
  version "20190911"
  url "https://github.com/SymbiFlow/prjtrellis/archive/f6922699dcb44799fe72a861e19e93cbe235c400.tar.gz"
  sha256 "353fc1a7015dc257e17337a0eb22e2b8938e5f6b7a9b03cae0da1400020a4c81"
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
    url "https://github.com/SymbiFlow/prjtrellis-db/archive/b4d626b6402c131e9a035470ffe4cf33ccbe7986.tar.gz"
    sha256 "28a0d6037a970fc9054003699d807bed5e20faf912fcc697ab6ea24b07508f04"
  end

  def install
    (buildpath/"database").install resource("database") unless build.head?

    args = []
    args << "-DBUILD_PYTHON=OFF" if build.without? "python"
    args << "-DBUILD_SHARED=OFF" if build.without? "shared"
    args << "-DSTATIC_BUILD=ON" if build.with? "static"

    args << "-DBoost_NO_BOOST_CMAKE=ON"

    args << "-DCURRENT_GIT_VERSION=f692269" unless build.head?
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
