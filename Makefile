# Installer for HiPERCalc on Linux.
# By Daniel Collins, released to public domain.

ICONS := \
	HiPERCalc-16x16.png \
	HiPERCalc-32x32.png \
	HiPERCalc-48x48.png \
	HiPERCalc-64x64.png \
	HiPERCalc-128x128.png

.PHONY: all
all: HiPERCalc HiPERCalc/com/sun/java/swing/plaf/windows/WindowsLookAndFeel.class

# Ensure downloaded HiPERCalc.exe is deleted if checksum does not match.
.DELETE_ON_ERROR:

.PHONY: install
install: all icons
	cp -a HiPERCalc $(DESTDIR)/opt/
	
	sed -e 's/^hipercalc_path=.*$$/hipercalc_path=\/opt\/HiPERCalc/' hipercalc > $(DESTDIR)/usr/bin/hipercalc
	chmod 0755 $(DESTDIR)/usr/bin/hipercalc
	
	for icon in $(ICONS); \
	do \
		size=$$(echo $$icon | cut -d- -f2 | cut -d. -f1); \
		mkdir -p $(DESTDIR)/usr/share/icons/hicolor/$${size}/apps; \
		install -m 0644 $$icon $(DESTDIR)/usr/share/icons/hicolor/$${size}/apps/HiPERCalc.png; \
	done
	
	mkdir -p $(DESTDIR)/usr/share/applications
	install -m 0644 HiPERCalc.desktop $(DESTDIR)/usr/share/applications/HiPERCalc.desktop

.PHONY: uninstall
uninstall:
	rm -f $(DESTDIR)/usr/share/applications/HiPERCalc.desktop
	
	rm -f $(DESTDIR)/usr/bin/hipercalc
	
	for icon in $(ICONS); \
	do \
		size=$$(echo $$icon | cut -d- -f2 | cut -d. -f1); \
		rm -f $(DESTDIR)/usr/share/icons/hicolor/$${size}/apps/HiPERCalc.png; \
	done
	
	rm -rf $(DESTDIR)/opt/HiPERCalc/

.PHONY: clean
clean:
	rm -rf HiPERCalc
	rm -f HiPERCalc.ico $(ICONS)

HiPERCalc: HiPERCalc.exe
	mkdir -p HiPERCalc
	7z x HiPERCalc.exe -oHiPERCalc

HiPERCalc/com/sun/java/swing/plaf/windows/WindowsLookAndFeel.class: WindowsLookAndFeel.java
	mkdir -p $(dir $@)
	javac --add-exports java.desktop/com.sun.java.swing.plaf.gtk=ALL-UNNAMED -d HiPERCalc $<

HiPERCalc.exe:
	wget -O "$@" "http://bit.ly/HiPERCalcDownload"
	sha256sum -c HiPERCalc.exe.sha256sum

.PHONY: icons
icons: $(ICONS)

HiPERCalc.ico: HiPERCalc.exe
	wrestool -x HiPERCalc.exe -t 14 -n 1 > HiPERCalc.ico

HiPERCalc-16x16.png: HiPERCalc.ico
	convert $<[0] $@

HiPERCalc-32x32.png: HiPERCalc.ico
	convert $<[1] $@

HiPERCalc-48x48.png: HiPERCalc.ico
	convert $<[2] $@

HiPERCalc-64x64.png: HiPERCalc.ico
	convert $<[3] $@

HiPERCalc-128x128.png: HiPERCalc.ico
	convert $<[4] $@
