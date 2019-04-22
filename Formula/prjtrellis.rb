class Prjtrellis < Formula
  desc "Device database and tools for bitstream creation for ECP5 FPGAs"
  homepage "https://github.com/SymbiFlow/prjtrellis"
  url "https://github.com/SymbiFlow/prjtrellis/archive/1.0.tar.gz"
  sha256 "6cfa12b7bf1ad5aed2b711fdfdd5ade6a2047f4733a704cb0b04634d350a4e26"
  head "https://github.com/SymbiFlow/prjtrellis.git"

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "boost"
  depends_on "boost-python3"
  depends_on "python"

  resource "database" do
    url "https://github.com/SymbiFlow/prjtrellis-db/archive/d0b219af41ae3da6150645fbc5cc5613b530603f.tar.gz"
    sha256 "dd85dfb7a8606fa490cfcc4472f6d274b1b00d76a4e18e7669ecc59dc6997082"
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
