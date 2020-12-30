class Prjoxide < Formula
  desc "Device database and tools for bitstream creation for Lattice Nexus FPGAs"
  homepage "https://github.com/daveshah1/prjoxide"
  version "20201207"
  url "https://github.com/daveshah1/prjoxide/archive/09d9d16e25e920f550c3c3bfaeaaaeca4e7f24c4.tar.gz"
  sha256 "7807cd58170a0110cae6efc76afd73f1de2081ad5ede5fd882ec2cf661beeea4"
  head "https://github.com/daveshah1/prjoxide.git"

  depends_on "rust" => :build

  resource "database" do
   url "https://github.com/daveshah1/prjoxide-db/archive/9726bc867ec77319e11086552072400d13fe296d.tar.gz"
   sha256 "da0f0049d8258f7fcb37af5d55f5092bf0c4a85ac164dad6e95c10ed16a5c2cb"
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
