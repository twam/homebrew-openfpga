class Ujprog < Formula
  desc "ULX2S / ULX3S FPGA JTAG programmer"
  homepage "https://github.com/f32c/tools"
  url "https://github.com/f32c/tools/archive/0698352b0e912caa9b8371b8f692e19aac547a69.tar.gz"
  version "3.0.92-r1"
  sha256 "2b863a366b063c54ad164602b601bca6f8374d85b798090780dcc43cb423fed4"
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
