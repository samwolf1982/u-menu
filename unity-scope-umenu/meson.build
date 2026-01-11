# -*- Mode: Meson; indent-tabs-mode: nil; tab-width: 4 -*-

unity_scope = executable('unity-scope-umenu', [
        'unity-scope-umenu.vala',
    ],
    vala_args: common_vflags,
    c_args: common_cflags,
    dependencies: [
        gtk_dep,
        unity_dep,
    ],
    link_with: [libumenu],
    include_directories: [libumenu_inc],
    install: true,
    install_dir: pkglibdir)

conf_data = configuration_data()
conf_data.set('DATADIR', datadir)
conf_data.set('PKGLIBDIR', pkglibdir)

configure_file(input : 'clipboard.scope.in.in',
               output : 'clipboard.scope.in',
               configuration : conf_data)

i18n.merge_file(
    type: 'desktop',
    input: join_paths(meson.current_build_dir(), 'clipboard.scope.in'),
    output: 'clipboard.scope',
    po_dir: podir,
    install: true,
    install_dir: join_paths(datadir, 'unity', 'scopes')
)

configure_file(input : 'unity-scope-umenu.service.in',
    output : 'unity-scope-umenu.service',
    configuration : conf_data,
    install_dir: join_paths(datadir, 'dbus-1', 'services')
)

install_data('unity-scope-umenu.gschema.override',
    install_dir: join_paths(datadir, 'glib-2.0', 'schemas'))
