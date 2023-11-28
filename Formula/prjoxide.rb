class Prjoxide < Formula
  desc "Device database and tools for bitstream creation for Lattice Nexus FPGAs"
  homepage "https://github.com/gatecat/prjoxide"
  version "20230831"
  url "https://github.com/gatecat/prjoxide/archive/36a27981b36cb30765796080a5a5fb1270a0ea65.tar.gz"
  sha256 "588216e3f913708ca1b10547d0b7f50fd10d16da4d9c52a94d5f745348da5aed"
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
