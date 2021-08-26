class Prjoxide < Formula
  desc "Device database and tools for bitstream creation for Lattice Nexus FPGAs"
  homepage "https://github.com/gatecat/prjoxide"
  version "20210728"
  url "https://github.com/gatecat/prjoxide/archive/711770c7c7cfc48425827ddba20d13e6dc64b0fe.tar.gz"
  sha256 "60b63a94ecb8edcfbc0a86691b6958e0c6957b0d5c84ce1b3615a4f8a4832249"
  head "https://github.com/gatecat/prjoxide.git"

  depends_on "rust" => :build

  resource "database" do
   url "https://github.com/gatecat/prjoxide-db/archive/e31a1b8f214a691d153bbcaa8c3df158d8a22e0b.tar.gz"
   sha256 "fef3fec3e71618cb973b94b65c991fc38797e41fdd64d11ba735c2f428f41a3b"
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
