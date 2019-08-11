class Icestorm < Formula
  desc "Bitstream Tools for Lattice iCE40 FPGAs"
  homepage "http://www.clifford.at/icestorm/"
  url "https://github.com/cliffordwolf/icestorm/archive/2ccae0d3864fd7268118287a85963c0116745cff.tar.gz"
  version "20190808"
  sha256 "db12be079518f2422ac66284663a3cf33335c19c9ea60114034c9d8b47bdd1c1"
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
