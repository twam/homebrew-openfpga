class Prjtrellis < Formula
  desc "Device database and tools for bitstream creation for Lattice ECP5 FPGAs"
  homepage "https://github.com/YosysHQ/prjtrellis"
  version "20240129"
  url "https://github.com/YosysHQ/prjtrellis/archive/2dab0095e1a5691855b0955b329cb4946b6a13b8.tar.gz"
  sha256 "4300ef434c16d05ee73e8ca912f4c8e002db1633f15e36c362b3e01be45c9bfc"
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
    url "https://github.com/YosysHQ/prjtrellis-db/archive/4dda149b9e4f1753ebc8b011ece2fe794be1281a.tar.gz"
    sha256 "d404603134a0b9181b4cdfeca5e90bcd5b38c614f9c4d4ccb29a14d9ddf2d351"
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
