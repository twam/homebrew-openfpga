class Prjtrellis < Formula
  desc "Device database and tools for bitstream creation for ECP5 FPGAs"
  homepage "https://github.com/SymbiFlow/prjtrellis"
  head "https://github.com/SymbiFlow/prjtrellis.git"

  depends_on "cmake" => :build
  depends_on "boost" => "with-python"
  depends_on "boost-python"
  depends_on "python"

  def install
    cd "libtrellis" do
      system "cmake", *std_cmake_args
      system "make"
      system "make install"
  end
  end
end