class Prjoxide < Formula
  desc "Device database and tools for bitstream creation for Lattice Nexus FPGAs"
  homepage "https://github.com/gatecat/prjoxide"
  version "20240105"
  url "https://github.com/gatecat/prjoxide/archive/30712ff988a3ea7700fa11b87ae2d77e55c7c468.tar.gz"
  sha256 "657c48fa0408ac5bc80d2da8e85a560dfef48eac3f0469654ca46a4c2a925736"
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
