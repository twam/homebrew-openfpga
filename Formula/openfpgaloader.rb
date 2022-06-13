class Openfpgaloader < Formula
  desc "Universal utility for programming FPGA"
  homepage "https://github.com/trabucayre/openFPGALoader"
  url "https://github.com/trabucayre/openFPGALoader/archive/v0.8.0.zip"
  version "0.8.0"
  sha256 "04da7fac7f140602e2afab13250c33b00fb1262fb5a83d39470073c0debe1da3"
  head "https://github.com/trabucayre/openFPGALoader.git"

  depends_on "libftdi"
  depends_on "cmake" => :build
  depends_on "ninja" => :build

  def install
    system "cmake", ".", "-GNinja", *std_cmake_args
    system "ninja"
    system "ninja", "install"
  end

  test do
    system "#{bin}/openFPGALoader"
  end
end
