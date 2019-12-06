class Prjtrellis < Formula
  desc "Device database and tools for bitstream creation for ECP5 FPGAs"
  homepage "https://github.com/SymbiFlow/prjtrellis"
  version "20191204"
  url "https://github.com/SymbiFlow/prjtrellis/archive/ca601cd272c93c0be8d51f2a9ce052066c8d0de1.tar.gz"
  sha256 "0ec71c9887169294d1d4a2afc97d452d0f17371cd151fdcb02a7b349915b3aff"
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
    url "https://github.com/SymbiFlow/prjtrellis-db/archive/e3a1751355910c7ac0b3535e20264a6022381a87.tar.gz"
    sha256 "d75ec86d779666340212bd248c136deb144e0b5fa1f126969227e414f6e9c95d"
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
