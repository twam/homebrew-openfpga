class Icestorm < Formula
  desc "Bitstream Tools for Lattice iCE40 FPGAs"
  homepage "http://www.clifford.at/icestorm/"
  url "https://github.com/cliffordwolf/icestorm/archive/7afc64b480212c9ac2ce7cb1622731a69a7d212c.tar.gz"
  version "20201204"
  sha256 "0ea6d616e4f7411809291b8cf229ca5c9bd000460715cb9e4d4496e04555a116"
  head "https://github.com/cliffordwolf/icestorm.git"

  depends_on "pkg-config" => :build
  depends_on "libftdi0"
  depends_on "python"

  # Patch sed issues, see https://github.com/YosysHQ/icestorm/issues/255
  patch :DATA

  def install
    system "make", "install", "PREFIX=#{prefix}", "PRETTY=0"
  end

  test do
    system "#{bin}/iceprog", "--help"
  end
end

__END__
diff --git a/icebox/Makefile b/icebox/Makefile
index 2897dfb..2f44209 100644
--- a/icebox/Makefile
+++ b/icebox/Makefile
@@ -56,27 +56,27 @@ install: all
 	cp icebox_maps.py    $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_maps$(PY_EXE)
 	cp icebox_vlog.py    $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_vlog$(PY_EXE)
 	cp icebox_stat.py    $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_stat$(PY_EXE)
-	sed -i 's+import iceboxdb+import $(subst -,_,$(PROGRAM_PREFIX))iceboxdb as iceboxdb+g' $(DESTDIR)$(PREFIX)/bin/$(subst -,_,$(PROGRAM_PREFIX))icebox.py
-	sed -i 's+import icebox+import $(subst -,_,$(PROGRAM_PREFIX))icebox as icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_chipdb$(PY_EXE)
-	sed -i 's+import icebox+import $(subst -,_,$(PROGRAM_PREFIX))icebox as icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_diff$(PY_EXE)
-	sed -i 's+from icebox+from $(subst -,_,$(PROGRAM_PREFIX))icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_diff$(PY_EXE)
-	sed -i 's+import icebox+import $(subst -,_,$(PROGRAM_PREFIX))icebox as icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_explain$(PY_EXE)
-	sed -i 's+from icebox+from $(subst -,_,$(PROGRAM_PREFIX))icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_explain$(PY_EXE)
-	sed -i 's+import icebox+import $(subst -,_,$(PROGRAM_PREFIX))icebox as icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_asc2hlc$(PY_EXE)
-	sed -i 's+from icebox+from $(subst -,_,$(PROGRAM_PREFIX))icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_asc2hlc$(PY_EXE)
-	sed -i 's+import icebox+import $(subst -,_,$(PROGRAM_PREFIX))icebox as icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_hlc2asc$(PY_EXE)
-	sed -i 's+from icebox+from $(subst -,_,$(PROGRAM_PREFIX))icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_hlc2asc$(PY_EXE)
-	sed -i 's+import icebox+import $(subst -,_,$(PROGRAM_PREFIX))icebox as icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_colbuf$(PY_EXE)
-	sed -i 's+from icebox+from $(subst -,_,$(PROGRAM_PREFIX))icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_colbuf$(PY_EXE)
-	sed -i 's+import icebox+import $(subst -,_,$(PROGRAM_PREFIX))icebox as icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_html$(PY_EXE)
-	sed -i 's+from icebox+from $(subst -,_,$(PROGRAM_PREFIX))icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_html$(PY_EXE)
-	sed -i 's+import icebox+import $(subst -,_,$(PROGRAM_PREFIX))icebox as icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_maps$(PY_EXE)
-	sed -i 's+from icebox+from $(subst -,_,$(PROGRAM_PREFIX))icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_maps$(PY_EXE)
-	sed -i 's+import icebox+import $(subst -,_,$(PROGRAM_PREFIX))icebox as icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_vlog$(PY_EXE)
-	sed -i 's+from icebox+from $(subst -,_,$(PROGRAM_PREFIX))icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_vlog$(PY_EXE)
-	sed -i 's+/usr/local/share/icebox+$(PREFIX)/share/$(PROGRAM_PREFIX)icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_vlog$(PY_EXE)
-	sed -i 's+import icebox+import $(subst -,_,$(PROGRAM_PREFIX))icebox as icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_stat$(PY_EXE)
-	sed -i 's+from icebox+from $(subst -,_,$(PROGRAM_PREFIX))icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_stat$(PY_EXE)
+	sed -i'' -e 's+import iceboxdb+import $(subst -,_,$(PROGRAM_PREFIX))iceboxdb as iceboxdb+g' $(DESTDIR)$(PREFIX)/bin/$(subst -,_,$(PROGRAM_PREFIX))icebox.py
+	sed -i'' -e 's+import icebox+import $(subst -,_,$(PROGRAM_PREFIX))icebox as icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_chipdb$(PY_EXE)
+	sed -i'' -e 's+import icebox+import $(subst -,_,$(PROGRAM_PREFIX))icebox as icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_diff$(PY_EXE)
+	sed -i'' -e 's+from icebox+from $(subst -,_,$(PROGRAM_PREFIX))icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_diff$(PY_EXE)
+	sed -i'' -e 's+import icebox+import $(subst -,_,$(PROGRAM_PREFIX))icebox as icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_explain$(PY_EXE)
+	sed -i'' -e 's+from icebox+from $(subst -,_,$(PROGRAM_PREFIX))icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_explain$(PY_EXE)
+	sed -i'' -e 's+import icebox+import $(subst -,_,$(PROGRAM_PREFIX))icebox as icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_asc2hlc$(PY_EXE)
+	sed -i'' -e 's+from icebox+from $(subst -,_,$(PROGRAM_PREFIX))icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_asc2hlc$(PY_EXE)
+	sed -i'' -e 's+import icebox+import $(subst -,_,$(PROGRAM_PREFIX))icebox as icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_hlc2asc$(PY_EXE)
+	sed -i'' -e 's+from icebox+from $(subst -,_,$(PROGRAM_PREFIX))icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_hlc2asc$(PY_EXE)
+	sed -i'' -e 's+import icebox+import $(subst -,_,$(PROGRAM_PREFIX))icebox as icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_colbuf$(PY_EXE)
+	sed -i'' -e 's+from icebox+from $(subst -,_,$(PROGRAM_PREFIX))icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_colbuf$(PY_EXE)
+	sed -i'' -e 's+import icebox+import $(subst -,_,$(PROGRAM_PREFIX))icebox as icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_html$(PY_EXE)
+	sed -i'' -e 's+from icebox+from $(subst -,_,$(PROGRAM_PREFIX))icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_html$(PY_EXE)
+	sed -i'' -e 's+import icebox+import $(subst -,_,$(PROGRAM_PREFIX))icebox as icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_maps$(PY_EXE)
+	sed -i'' -e 's+from icebox+from $(subst -,_,$(PROGRAM_PREFIX))icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_maps$(PY_EXE)
+	sed -i'' -e 's+import icebox+import $(subst -,_,$(PROGRAM_PREFIX))icebox as icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_vlog$(PY_EXE)
+	sed -i'' -e 's+from icebox+from $(subst -,_,$(PROGRAM_PREFIX))icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_vlog$(PY_EXE)
+	sed -i'' -e 's+/usr/local/share/icebox+$(PREFIX)/share/$(PROGRAM_PREFIX)icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_vlog$(PY_EXE)
+	sed -i'' -e 's+import icebox+import $(subst -,_,$(PROGRAM_PREFIX))icebox as icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_stat$(PY_EXE)
+	sed -i'' -e 's+from icebox+from $(subst -,_,$(PROGRAM_PREFIX))icebox+g' $(DESTDIR)$(PREFIX)/bin/$(PROGRAM_PREFIX)icebox_stat$(PY_EXE)
 
 uninstall:
 	rm -f $(DESTDIR)$(PREFIX)/bin/$(subst -,_,$(PROGRAM_PREFIX))cebox.py