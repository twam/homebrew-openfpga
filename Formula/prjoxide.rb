class Prjoxide < Formula
  desc "Device database and tools for bitstream creation for Lattice Nexus FPGAs"
  homepage "https://github.com/gatecat/prjoxide"
  version "20230517"
  url "https://github.com/gatecat/prjoxide/archive/a64ccc79c0af45811a052ef737d7ed9b8fec4a9c.tar.gz"
  sha256 "445845b2e104367d3d1093223b8316a40c5483e8ddc0a945676550489cf1c960"
  head "https://github.com/gatecat/prjoxide.git"

  depends_on "rust" => :build

  resource "database" do
   url "https://github.com/gatecat/prjoxide-db/archive/56009be1ca77a7123ffdb50a813216302a42ac27.tar.gz"
   sha256 "164f7c3b93f778465b5a72ece445a1f9fc7af3a6fd303b7090b9540fb803f9c6"
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
