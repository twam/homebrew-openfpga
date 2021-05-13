class Usb2snifferQt < Formula
  desc "GUI for LambdaConcept USB2Sniffer"
  homepage "https://github.com/lambdaconcept/usb2sniffer-qt"
  url "https://github.com/lambdaconcept/usb2sniffer-qt/archive/7499339962d6d725f6a92fa7a695e6b6cf984bdc.tar.gz"
  version "20201002"
  sha256 "8e4d971a8c21042a841d9e6a566023d8f86bc05639849e108ab0dd13e746ec78"
  head "https://github.com/lambdaconcept/usb2sniffer-qt.git"

  depends_on "qt5" #if build.with? "gui"

  resource "qhexedit2" do
   url "https://github.com/Simsys/qhexedit2/archive/2374ceafcc88c4139d4e91d179a5e78f2278c3d2.tar.gz"
   sha256 "5de272523c3b9095819b9f2e934aa9e0ac46d9573f2db86cc69a5fcd1013761c"
  end

  def install
    (buildpath/"qhexedit2").install resource("qhexedit2") unless build.head?

    system "qmake","lcsniff.pro"
    system "make"

    prefix.install "lcsniff.app"
  end

  test do
    assert_predicate testpath/"#{bin}/lcsniff", :exist?, ""
  end
end
