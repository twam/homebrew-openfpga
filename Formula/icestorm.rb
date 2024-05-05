class Icestorm < Formula
  desc "Bitstream Tools for Lattice iCE40 FPGAs"
  homepage "http://www.clifford.at/icestorm/"
  url "https://github.com/YosysHQ/icestorm/archive/1a40ae75d4eebee9cce73a2c4d634fd42ed0110f.tar.gz"
  version "20231212"
  sha256 "45bed97b0979ef567bfdb85ce31efc49ed9ba9efeb1501ad37d61a79f5e910fc"
  head "https://github.com/YosysHQ/icestorm.git"

  depends_on "pkg-config" => :build
  depends_on "libftdi"
  depends_on "python"

  def install
    system "make", "install", "PREFIX=#{prefix}", "PRETTY=0"
  end

  test do
    system "#{bin}/iceprog", "--help"
  end
end

