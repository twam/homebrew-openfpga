class Prjtrellis < Formula
  desc "Device database and tools for bitstream creation for Lattice ECP5 FPGAs"
  homepage "https://github.com/YosysHQ/prjtrellis"
  version "20210308"
  url "https://github.com/YosysHQ/prjtrellis/archive/7454564f7976cf0e70108fbb02f80a4c2f14bccb.tar.gz"
  sha256 "48e95749d7aaaeba59ed267119f2cf6b6e4c074f698fc9365ae8e8f2bb4c9314"
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
