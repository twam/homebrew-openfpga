class Ujprog < Formula
  desc "ULX2S / ULX3S FPGA JTAG programmer"
  homepage "https://github.com/f32c/tools"
  url "https://github.com/f32c/tools/archive/73c0c267d7d7cc211fa3506d9d3faa71c86a45cb.tar.gz"
  version "3.0.92"
  sha256 "5350008798612eec887eacc152090ad4048449094af9888a891ea950ef64b114"
  head "https://github.com/f32c/tools.git"

  depends_on "pkg-config" => :build
  depends_on "libftdi0"
  depends_on "libusb-compat"

  def install
    cd "ujprog" do
      system "make", "-f", "Makefile.osx"
      bin.install "ujprog"
    end
  end

  test do
    system "#{bin}/ujprog"
  end
end
