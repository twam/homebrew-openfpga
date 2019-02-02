class Prjtrellis < Formula
  desc "Device database and tools for bitstream creation for ECP5 FPGAs"
  homepage "https://github.com/SymbiFlow/prjtrellis"
  url "https://github.com/SymbiFlow/prjtrellis/archive/ce4a961a65519ee2f9140de0bab07911f6f26af7.tar.gz"
  version "20190127"
  sha256 "be6c8ec1238f1d0f6822bc72c720d9749988827cbcc2b9c0deb408ca71d89db2"
  head "https://github.com/SymbiFlow/prjtrellis.git"

  depends_on "cmake" => :build
  depends_on "boost"
  depends_on "boost-python3"
  depends_on "python@3"

  resource "database" do
    url "https://github.com/SymbiFlow/prjtrellis-db/archive/d9603500f4a4df5b643c790d0e44bf7c67b755d0.zip"
    sha256 "910e6edd7bf68b00d19731de8e45fa81e0745f03f84e58a815b70fdd88028bf8"
  end

  def install
    (buildpath/"database").install resource("database") if not build.head?

    cd "libtrellis" do
      system "cmake", *std_cmake_args
      system "make"
      system "make install"
    end
  end
end
