class Prjoxide < Formula
  desc "Device database and tools for bitstream creation for Lattice Nexus FPGAs"
  homepage "https://github.com/gatecat/prjoxide"
  version "20210924"
  url "https://github.com/gatecat/prjoxide/archive/318331f8b30c2e2a31cc41d51f104b671e180a8a.tar.gz"
  sha256 "9edb836cf8cfbe1f3c3c8575f2fed146c08f5017f96870d9273fd19ca911d6ed"
  head "https://github.com/gatecat/prjoxide.git"

  depends_on "rust" => :build

  resource "database" do
   url "https://github.com/gatecat/prjoxide-db/archive/48cb5537977c41d38c40ddff45ba1bbcec384ba8.tar.gz"
   sha256 "a123b35ddf58871f39fc7fa2e59862147e7257843f5abebe70384d6c6680f77c"
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
