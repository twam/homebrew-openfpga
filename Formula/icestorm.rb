class Icestorm < Formula
  desc "Bitstream Tools for Lattice iCE40 FPGAs"
  homepage "http://www.clifford.at/icestorm/"
  url "https://github.com/cliffordwolf/icestorm/archive/c0cbae88ab47a3879aacf80d53b6a85710682a6b.tar.gz"
  version "20181231"
  sha256 "bdf0c9a9f5b98cc2e648cdf53b008625ebd530e6e86d543a2d53e74f8a72de5c"
  head "https://github.com/cliffordwolf/icestorm.git"

  depends_on "pkg-config" => :build
  depends_on "libftdi0"
  depends_on "python"

  def install
    system "make", "install", "PREFIX=#{prefix}", "PRETTY=0"
  end

  test do
    system "#{bin}/iceprog", "--help"
  end
end
