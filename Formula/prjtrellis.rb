class Prjtrellis < Formula
  desc "Device database and tools for bitstream creation for ECP5 FPGAs"
  homepage "https://github.com/SymbiFlow/prjtrellis"
  version "20190809"
  url "https://github.com/SymbiFlow/prjtrellis/archive/a67379179985bb12a611c75d975548cdf6e7d12e.tar.gz"
  sha256 "618562a4701585c1bd8ae0a6722483741e7f54882013f5549ee91e3b2cbb60da"
  head "https://github.com/SymbiFlow/prjtrellis.git"

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
