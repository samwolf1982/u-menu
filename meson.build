# -*- Mode: Meson; indent-tabs-mode: nil; tab-width: 4 -*-

project('umenu', ['vala', 'c'],
    version: '1.0.1',
    license: 'GPLv2+',
    default_options: [
        'warning_level=1',
        'buildtype=debugoptimized',
    ],
    meson_version: '>= 0.45')

gnome = import('gnome')
i18n = import('i18n')
pkg = import('pkgconfig')

# Source paths
podir = join_paths(meson.current_source_dir(), 'po')
vapidir = join_paths(meson.current_source_dir(), 'vapi')
testdatadir = join_paths(meson.current_source_dir(), 'tests', 'data')

# Install paths
prefix = get_option('prefix')
bindir = join_paths(prefix, get_option('bindir'))
datadir = join_paths(prefix, get_option('datadir'))
etcdir = get_option('sysconfdir')
libdir = join_paths(prefix, get_option('libdir'))
pkgincludedir = join_paths(prefix, get_option('includedir'), 'umenu')
localedir = join_paths(prefix, get_option('localedir'))
pkgdatadir = join_paths(datadir, meson.project_name())
pkglibdir = join_paths(libdir, meson.project_name())
pkgpluginslibdir = join_paths(pkglibdir, 'plugins')
pkgpluginsdatadir = join_paths(pkgdatadir, 'plugins')

# Dependencies
if not get_option('disable-indicator-plugin')
	appindicator_dep = dependency('ayatana-appindicator3-0.1', version: '>=0.5.3')
endif
if get_option('enable-unity-scope')
	unity_dep = dependency('unity', version: '>=7.1.0')
endif
gdk_dep = dependency('gdk-3.0', version: '>=3.0.8')
gdk_x11_dep = dependency('gdk-x11-3.0', version: '>=3.0.8')
gio_dep = dependency('gio-2.0', version: '>= 2.46')
gio_unix_dep = dependency('gio-unix-2.0', version: '>=2.46')
glib_dep = dependency('glib-2.0', version: '>=2.46.0')
gtk_dep = dependency('gtk+-3.0', version: '>= 3.22')
libpeas_dep = dependency('libpeas-1.0', version: '>=1.1.0')
libpeas_gtk_dep = dependency('libpeas-gtk-1.0', version: '>=1.1.0')
xtst_dep = dependency('xtst', version: '>=1.2.0')
x11_dep = dependency('x11', version: '>=1.6.3')
#SOB

# Programs

glib_compile_schemas = find_program('glib-compile-schemas')
desktop_file_validate = find_program('desktop-file-validate')
g_ir_compiler = find_program('g-ir-compiler')
xvfb_run = find_program('xvfb-run')

common_vflags = [
    '--pkg=config',
    '--pkg=posix',
    '--disable-assert',
    '--target-glib=2.46',
    '--vapidir', vapidir,
]

common_cflags = [
    '-w',
    '-DPACKAGE="@0@"'.format(meson.project_name()),
    '-DGETTEXT_PACKAGE="@0@"'.format(meson.project_name()),
    '-DVERSION="@0@"'.format(meson.project_version()),
    '-DLOCALE_DIR="@0@"'.format(localedir),
    '-DPKG_DATA_DIR="@0@"'.format(pkgdatadir),
    '-DPKG_PLUGINS_LIB_DIR="@0@"'.format(pkgpluginslibdir),
    '-DPKG_PLUGINS_DATA_DIR="@0@"'.format(pkgpluginsdatadir),
    '-DTEST_DATA_DIR="@0@"'.format(testdatadir),
    '-DDEV_GSETTINGS_DIR="@0@"'.format(join_paths(meson.build_root(), 'schemas')),
]

if x11_dep.found() and xtst_dep.found()
    common_vflags += ['--define=HAVE_X11']
endif

subdir('data')
subdir('libumenu')
subdir('umenu')
subdir('po')
subdir('plugins')
# subdir('tests')
if get_option('enable-unity-scope')
	subdir('unity-scope-umenu')
endif
