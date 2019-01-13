class Prjtrellis < Formula
  desc "Device database and tools for bitstream creation for ECP5 FPGAs"
  homepage "https://github.com/SymbiFlow/prjtrellis"
  url "https://github.com/SymbiFlow/prjtrellis/archive/3df0e3df4f69ec6fe0ca157b0a67c9fea94eab48.tar.gz"
  version "20190113"
  sha256 "063d96d060d22f353a8f6451f74486413a48ebe466da698589d111a0a1e07dc0"
  head "https://github.com/SymbiFlow/prjtrellis.git"

  depends_on "cmake" => :build
  depends_on "boost"
  depends_on "boost-python3"
  depends_on "python@3"

  needs :cxx14

  resource "database" do
    url "https://github.com/SymbiFlow/prjtrellis-db/archive/670d04f0b8412193d5e974eea67f2bb7355aa1ec.zip"
    sha256 "78cd0c85085f59799fd055e04522da5a5d67b7a434c51ff10e6bbe337e12fbaf"
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
