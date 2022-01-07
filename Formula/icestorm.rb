class Icestorm < Formula
  desc "Bitstream Tools for Lattice iCE40 FPGAs"
  homepage "http://www.clifford.at/icestorm/"
  url "https://github.com/YosysHQ/icestorm/archive/3b7b1991318860997ef589112b3debb24eb4912d.tar.gz"
  version "20220102"
  sha256 "ed34e5c79bb4ccc36673f39abd68eea6d2d0feb49222a61e0636555fc201c5ea"
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

