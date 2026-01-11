# -*- Mode: Meson; indent-tabs-mode: nil; tab-width: 4 -*-

libumenu = shared_library('umenu',
    [
     'clipboard-configuration.vala',
     'clipboard-item.vala',
     'clipboard-manager.vala',
     'clipboard-menu-item.vala',
     'clipboard-menu.vala',
     'clipboard-type.vala',
     'controller.vala',
     'file-clipboard-item.vala',
     'image-clipboard-item.vala',
     'preferences-view.vala',
     'primary-clipboard-manager.vala',
     'text-clipboard-item.vala',
     'utility.vala',
     'simple-clipboard-storage.vala',
    ],
    soversion: 0,
    vala_args: common_vflags,
    vala_gir: 'Umenu-1.0.gir',
    c_args: common_cflags,
    dependencies: [
        gdk_dep,
        gdk_x11_dep,
        gtk_dep,
        libpeas_dep,
        libpeas_gtk_dep,
        x11_dep,
        xtst_dep
    ],
    install: true,
    install_dir: [true, pkgincludedir, true, true],
)

libumenu_inc = include_directories('.')

# TODO: replace string in requires with gtk_dep variable
# once meson build system requirement can be set higher than 0.45
pkg.generate(
	name: 'umenu',
	libraries: [libumenu],
	requires: ['gtk+-3.0'],
	version: meson.project_version(),
	description: 'Umenu GTK+ Clipboard Manager'
)

# TODO: Workaround till following issue is fixed:
# https://github.com/mesonbuild/meson/issues/2296
custom_target('libumenu typelib',
	command: [g_ir_compiler, '--shared-library=libumenu', '--output', '@OUTPUT@', join_paths(meson.current_build_dir(), 'Umenu-1.0.gir')],
	output: 'Umenu-1.0.typelib',
	depends: libumenu,
	install: true,
	install_dir: join_paths(get_option('libdir'), 'girepository-1.0')
)
