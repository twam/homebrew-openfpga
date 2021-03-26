class Openfpgaloader < Formula
  desc "Universal utility for programming FPGA"
  homepage "https://github.com/trabucayre/openFPGALoader"
  url "https://github.com/trabucayre/openFPGALoader/archive/v0.2.5.zip"
  version "0.2.5"
  sha256 "dbc07ee1ecb164f6bee3aa129bc3da29d5427bae12c0312e46537cc0a13db4d7"
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
