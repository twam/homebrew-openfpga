class Icestorm < Formula
  desc "Bitstream Tools for Lattice iCE40 FPGAs"
  homepage "http://www.clifford.at/icestorm/"
  url "https://github.com/YosysHQ/icestorm/archive/c495861c19bd0976c88d4964f912abe76f3901c3.tar.gz"
  version "20210309"
  sha256 "ff20faff0e3db2b5f1fb714486c8a5a5e480042de74267fcf59c772ec0805f66"
  head "https://github.com/YosysHQ/icestorm.git"

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