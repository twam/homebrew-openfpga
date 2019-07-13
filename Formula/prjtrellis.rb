class Prjtrellis < Formula
  desc "Device database and tools for bitstream creation for ECP5 FPGAs"
  homepage "https://github.com/SymbiFlow/prjtrellis"
  version "20190627"
  url "https://github.com/SymbiFlow/prjtrellis/archive/3311e6d814e0001c8785d6d77a4c93e327875b6d.tar.gz"
  sha256 "1aed84a02289726154cdcf6e9260ac2caad5b4d2a41cd2ab70135d05b3350135"
  head "https://github.com/SymbiFlow/prjtrellis.git"

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "boost"
  depends_on "boost-python3"
  depends_on "python"

  resource "database" do
    url "https://github.com/SymbiFlow/prjtrellis-db/archive/d0b219af41ae3da6150645fbc5cc5613b530603f.tar.gz"
    sha256 "1f1b71741e8b70af777561a1422be8a01992ea46b363da24b7b97e41fa0fa5c5"
  end

  def install
    (buildpath/"database").install resource("database") unless build.head?

    cd "libtrellis" do
      system "cmake", "-GNinja", *std_cmake_args
      system "ninja"
      system "ninja", "install"
    end
  end

  test do
    system "#{bin}/ecppack", "--help"
  end
end
