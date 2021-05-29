class Prjoxide < Formula
  desc "Device database and tools for bitstream creation for Lattice Nexus FPGAs"
  homepage "https://github.com/gatecat/prjoxide"
  version "20210526"
  url "https://github.com/gatecat/prjoxide/archive/7b3e4f85562d3b86a367e8d97d4314ebdee7647a.tar.gz"
  sha256 "411602c72ff21fe703f80a8191660941bbdecd17ff06c07638f8f29122aa5b54"
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
