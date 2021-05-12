class Prjoxide < Formula
  desc "Device database and tools for bitstream creation for Lattice Nexus FPGAs"
  homepage "https://github.com/gatecat/prjoxide"
  version "20210512"
  url "https://github.com/gatecat/prjoxide/archive/f61d18eb33fddb16ea7736b8c9e6282fc3f8e7e0.tar.gz"
  sha256 "50cca748dcdb5f41a16f68ee128b95d187764a10d21b9298b1954fffb3e9f7f1"
  head "https://github.com/gatecat/prjoxide.git"

  depends_on "rust" => :build

  resource "database" do
   url "https://github.com/gatecat/prjoxide-db/archive/30c1f1de1af5d2c4fcb9d13a59e756d3f9d66754.tar.gz"
   sha256 "50d44bd35ec9aa0bd3de708b9575745af770c2b6edf98f1c7b97404758738e5e"
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
