class Prjtrellis < Formula
  desc "Device database and tools for bitstream creation for Lattice ECP5 FPGAs"
  homepage "https://github.com/YosysHQ/prjtrellis"
  version "20210509"
  url "https://github.com/YosysHQ/prjtrellis/archive/fe1c39c8b66b103d82ddb23ceb62e4a528058057.tar.gz"
  sha256 "9e34f6719eef73ea14e4c9705688f6475b408464f8b1c4aaa188d5eac478cce5"
  head "https://github.com/YosysHQ/prjtrellis.git"

  option "without-python", "No python"
  option "without-shared", "No shared Trellis lib"
  option "with-static", "Use static lib build"

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "boost"
  depends_on "boost-python3"
  depends_on "python"

  resource "database" do
    url "https://github.com/YosysHQ/prjtrellis-db/archive/f7f8375101dfa7f7d5ccb654ff8fcae73356ce48.tar.gz"
    sha256 "ea7b4064dce41d13d5480bde67b6fc8c874254bb7bb7fb3c4cd075f71e28ee6d"
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
