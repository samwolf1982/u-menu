# -*- Mode: Meson; indent-tabs-mode: nil; tab-width: 4 -*-

plugin_indicator = shared_library('indicator',
    [
     'indicator-plugin.vala',
    ],
    vala_args: common_vflags,
    c_args: common_cflags,
    link_with: [libumenu],
    dependencies: [
        gtk_dep,
        libpeas_dep,
        appindicator_dep
    ],
    include_directories: [libumenu_inc],
    install: true,
    install_dir: join_paths(pkgpluginslibdir, 'indicator'),
)

i18n.merge_file(
    type: 'desktop',
    input: 'indicator.plugin.in',
    output: 'indicator.plugin',
    po_dir: podir,
    install: true,
    install_dir: join_paths(pkgpluginslibdir, 'indicator')
)
