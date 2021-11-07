class Icestorm < Formula
  desc "Bitstream Tools for Lattice iCE40 FPGAs"
  homepage "http://www.clifford.at/icestorm/"
  url "https://github.com/YosysHQ/icestorm/archive/83b8ef947f77723f602b706eac16281e37de278c.tar.gz"
  version "20210906"
  sha256 "cfec4396ca06e33a91e27e194acf58eaa23eeb801ce23020d9e405de0806f0b6"
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

