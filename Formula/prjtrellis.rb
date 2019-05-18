class Prjtrellis < Formula
  desc "Device database and tools for bitstream creation for ECP5 FPGAs"
  homepage "https://github.com/SymbiFlow/prjtrellis"
  version "20190422"
  url "https://github.com/SymbiFlow/prjtrellis/archive/5eb0ad870f30422b95d090ac9a476343809c62b9.tar.gz"
  sha256 "846a28d8d08dc7953f826a8893615fb335ab126b3099202afa33d37896327ce2"
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
