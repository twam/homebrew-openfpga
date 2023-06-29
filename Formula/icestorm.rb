class Icestorm < Formula
  desc "Bitstream Tools for Lattice iCE40 FPGAs"
  homepage "http://www.clifford.at/icestorm/"
  url "https://github.com/YosysHQ/icestorm/archive/d20a5e9001f46262bf0cef220f1a6943946e421d.tar.gz"
  version "20230218"
  sha256 "19784ecd38faa5284552ade4ca29531a2be1d9227df8956ef35b275c349fdbce"
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

