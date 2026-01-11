run:
	rm -rf builddir
	meson builddir
	cd builddir && ninja
	./build-appimage.sh
