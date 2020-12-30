class Ecpprog < Formula
  desc "A basic driver for FTDI based JTAG probes, to program ECP5 FPGAs."
  homepage "https://github.com/gregdavill/ecpprog"
  url "https://github.com/gregdavill/ecpprog/archive/d654a4d0ad9ad794c24af2079000b813e204eecf.tar.gz"
  version "20200920"
  sha256 "4ff36b6896ea9d9b5e940e34069160d228f13b7a912ce63fb3bb5a5fe436abb1"
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
