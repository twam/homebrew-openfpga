class Icestorm < Formula
  desc "Bitstream Tools for Lattice iCE40 FPGAs"
  homepage "http://www.clifford.at/icestorm/"
  url "https://github.com/YosysHQ/icestorm/archive/2bc541743ada3542c6da36a50e66303b9cbd2059.tar.gz"
  version "20220603"
  sha256 "3e47b12a7d6e58671b1a6ab4fcd4a56a81b9c4f2a7cfccbc1af46297f46543a7"
  head "https://github.com/YosysHQ/icestorm.git"

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

