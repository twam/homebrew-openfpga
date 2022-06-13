class Ecpprog < Formula
  desc "A basic driver for FTDI based JTAG probes, to program ECP5 FPGAs."
  homepage "https://github.com/gregdavill/ecpprog"
  url "https://github.com/gregdavill/ecpprog/archive/7212b56a9d2fc6de534e06636a1c6d8b0c6f80ab.tar.gz"
  version "20211204"
  sha256 "06b08cad1b039aa3ef119c6057b613712476fe6c8ef96fa494c4d4a7dec34c65"
  head "https://github.com/gregdavill/ecpprog.git"

  depends_on "libftdi0"
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
