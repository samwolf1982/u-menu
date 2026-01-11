
install_man('umenu.1')
install_data('preferences.ui', install_dir: pkgdatadir)
install_data('umenu.deps', install_dir: join_paths(datadir, 'vala', 'vapi'))

umenu_autostart_desktop = 'umenu-autostart.desktop'

i18n.merge_file(
    type: 'desktop',
    input: 'umenu-autostart.desktop.in',
    output: umenu_autostart_desktop,
    po_dir: podir,
    install: true,
    install_dir: join_paths(etcdir, 'xdg', 'autostart'))

test('validate-umenu-autostart-desktop', desktop_file_validate,
    args: [join_paths(meson.current_build_dir(), umenu_autostart_desktop)])

umenu_desktop = 'umenu.desktop'

i18n.merge_file(
    type: 'desktop',
    input: 'umenu.desktop.in',
    output: umenu_desktop,
    po_dir: podir,
    install: true,
    install_dir: join_paths(datadir, 'applications'))

test('validate-umenu-desktop', desktop_file_validate,
    args: [join_paths(meson.current_build_dir(), umenu_desktop)])

umenu_gschema = 'com.biryukwolf.umenu.gschema.xml'

install_data(umenu_gschema,
    install_dir: join_paths(datadir, 'glib-2.0', 'schemas'))

# Validate schema during build
test('validate-gschema', glib_compile_schemas,
    args: ['--strict', '--dry-run', '--schema-file',
           join_paths(meson.current_source_dir(), umenu_gschema)])

# Dev convenience: compile schemas into builddir/schemas so uninstalled runs work
_dev_schemas_dir = join_paths(meson.build_root(), 'schemas')
custom_target('dev-compile-gschemas',
    input: umenu_gschema,
    output: 'gschemas.compiled',
    command: ['sh', '-c', 'mkdir -p "$1" && glib-compile-schemas --strict --targetdir "$1" "$2"', 'sh', _dev_schemas_dir, meson.current_source_dir()],
    build_by_default: true)

subdir('icons')

meson.add_install_script('post-install.sh', datadir)
message('''You may need to recompile your gsettings schemas or regenerate
         your icon cache after installation.''')
