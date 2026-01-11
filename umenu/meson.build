
umenu = executable('umenu',
    ['main.vala'],
    vala_args: common_vflags,
    c_args: common_cflags,
    dependencies: [
        gio_unix_dep,
        gtk_dep,
    ],
    link_with: [libumenu],
    include_directories: [libumenu_inc],
    install: true)
