class Prjoxide < Formula
  desc "Device database and tools for bitstream creation for Lattice Nexus FPGAs"
  homepage "https://github.com/gatecat/prjoxide"
  version "20220527"
  url "https://github.com/gatecat/prjoxide/archive/d1fc5cd045531a0cc48ebffd5802f4ef84067aea.tar.gz"
  sha256 "2b7871bbd15262aa41a2ff24dc7ca38aa1b2c50e0300ac1b80141da8fa99e140"
  head "https://github.com/gatecat/prjoxide.git"

  depends_on "rust" => :build

  resource "database" do
   url "https://github.com/gatecat/prjoxide-db/archive/1566e0d8af245c4d52f4c5ec04667e5a4f0f01e2.tar.gz"
   sha256 "2d840947247a91daeb8c058448cb3cd3fe2c0b949ecc8eb5df21b48cc38f37f5"
  end

  def install
    (buildpath/"database").install resource("database") unless build.head?

    cd "libprjoxide/prjoxide" do
      system "cargo", "install", *std_cargo_args
    end
  end

  test do
    system "#{bin}/prjoxide", "--help"
  end
end
