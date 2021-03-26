class Prjoxide < Formula
  desc "Device database and tools for bitstream creation for Lattice Nexus FPGAs"
  homepage "https://github.com/gatecat/prjoxide"
  version "20210325"
  url "https://github.com/gatecat/prjoxide/archive/7dd6fecac3b19294e2b82b07980c279bca74c46b.tar.gz"
  sha256 "a62dbd3e69d1c9e9af89390a0240872eb50e85469105ed6648ee1aa2839ae0f1"
  head "https://github.com/gatecat/prjoxide.git"

  depends_on "rust" => :build

  resource "database" do
   url "https://github.com/gatecat/prjoxide-db/archive/5427616ec04f25f50a200060116c4b41fcfe7fbe.tar.gz"
   sha256 "fba943d3e3b4531976f06e1671d1cc84608a1d5e4725ffda4cd5cf10ccb60981"
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
