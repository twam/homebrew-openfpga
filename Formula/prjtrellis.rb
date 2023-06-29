class Prjtrellis < Formula
  desc "Device database and tools for bitstream creation for Lattice ECP5 FPGAs"
  homepage "https://github.com/YosysHQ/prjtrellis"
  version "20230526"
  url "https://github.com/YosysHQ/prjtrellis/archive/89ffb4571ee53e34eca7ab7b2cc9a983efc4d7e1.tar.gz"
  sha256 "a40d584bd83b191eb3ea18e6127c51ec1262e1c783555242830cea2135f18b51"
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
    url "https://github.com/YosysHQ/prjtrellis-db/archive/ce8cdafe7a8c718f0ec43895894b668a479ba33f.tar.gz"
    sha256 "49c8c1a2dbe5dc4eff7449dd57653f71494f98fe6ee36f4554590afeb3e3f355"
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
