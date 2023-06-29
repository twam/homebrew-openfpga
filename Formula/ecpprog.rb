class Ecpprog < Formula
  desc "A basic driver for FTDI based JTAG probes, to program ECP5 FPGAs."
  homepage "https://github.com/gregdavill/ecpprog"
  url "https://github.com/gregdavill/ecpprog/archive/8af8863855599f4b8ef8f46a336408b1aba60e9d.tar.gz"
  version "20220913"
  sha256 "b88d49ec086e425e83b27e23dd1f48e4a82ad3bc2618c0c91b0e658d5063498e"
  head "https://github.com/gregdavill/ecpprog.git"

  depends_on "libftdi"
  depends_on "libusb-compat"

  def install
    cd "ecpprog" do
      system "make"
      bin.install "ecpprog"
    end
  end

  test do
    system "#{bin}/ecpprog"
  end
end
