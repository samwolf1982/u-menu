# Board-Menu

This clipboard menu works on any modern Linux distribution.

Debian-based: Ubuntu, Linux Mint, Pop!_OS, Kali.

RHEL-based: Fedora, CentOS, RHEL, AlmaLinux.

Arch-based: Arch Linux, Manjaro, EndeavourOS.

Etc: openSUSE, Solus, Void, NixOS.



## Building

U-menu uses the [Meson](https://mesonbuild.com/) build system.

    git clone https://github.com/samwolf1982/u-menu.git && cd u-menu
    meson builddir && cd builddir
    ninja
    ninja test
    sudo ninja install
    # only needed after the first ninja install
    sudo ldconfig

The unity scope needs to be explicitly enabled if you want to build it

    meson configure -Denable-unity-scope=true

On distributions which do not provide packages for application-indicator
building of the indicator can be disabled by adjusting builddir creation command:

    meson builddir -Ddisable-indicator-plugin=true && cd builddir

For uninstalling type this:

    sudo ninja uninstall
## If you want make AppImage
    mkdir deploy && cd deploy
    wget https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage
    chmod +x linuxdeploy-x86_64.AppImage

    wget https://raw.githubusercontent.com/linuxdeploy/linuxdeploy-plugin-gtk/master/linuxdeploy-plugin-gtk.sh
    chmod +x linuxdeploy-plugin-gtk.sh
