install_data(join_paths('elementary-xfce', 'status', '16', 'umenu-panel.svg'),
    install_dir: join_paths(datadir, 'icons', 'elementary-xfce', 'status', '16'))
install_data(join_paths('elementary-xfce', 'status', '22', 'umenu-panel.svg'),
    install_dir: join_paths(datadir, 'icons', 'elementary-xfce', 'status', '22'))
install_data(join_paths('elementary-xfce', 'status', '24', 'umenu-panel.svg'),
    install_dir: join_paths(datadir, 'icons', 'elementary-xfce', 'status', '24'))

install_data(join_paths('elementary-xfce-dark', 'panel', '16', 'umenu-panel.svg'),
    install_dir: join_paths(datadir, 'icons', 'elementary-xfce-dark', 'panel', '16'))
install_data(join_paths('elementary-xfce-dark', 'panel', '22', 'umenu-panel.svg'),
    install_dir: join_paths(datadir, 'icons', 'elementary-xfce-dark', 'panel', '22'))
install_data(join_paths('elementary-xfce-dark', 'panel', '24', 'umenu-panel.svg'),
    install_dir: join_paths(datadir, 'icons', 'elementary-xfce-dark', 'panel', '24'))

install_data(join_paths('elementary-xfce-darker', 'actions', '16', 'umenu-panel.svg'),
    install_dir: join_paths(datadir, 'icons', 'elementary-xfce-darker', 'actions', '16'))
install_data(join_paths('elementary-xfce-darker', 'actions', '22', 'umenu-panel.svg'),
    install_dir: join_paths(datadir, 'icons', 'elementary-xfce-darker', 'actions', '22'))
install_data(join_paths('elementary-xfce-darker', 'actions', '24', 'umenu-panel.svg'),
    install_dir: join_paths(datadir, 'icons', 'elementary-xfce-darker', 'actions', '24'))

install_data(join_paths('hicolor', '16x16', 'apps', 'umenu-panel.svg'),
    install_dir: join_paths(datadir, 'icons', 'hicolor', '16x16', 'apps'))
install_data(join_paths('hicolor', '16x16', 'apps', 'umenu.svg'),
    install_dir: join_paths(datadir, 'icons', 'hicolor', '16x16', 'apps'))
install_data(join_paths('hicolor', '22x22', 'apps', 'umenu-panel.svg'),
    install_dir: join_paths(datadir, 'icons', 'hicolor', '22x22', 'apps'))
install_data(join_paths('hicolor', '22x22', 'apps', 'umenu.svg'),
    install_dir: join_paths(datadir, 'icons', 'hicolor', '22x22', 'apps'))
install_data(join_paths('hicolor', '24x24', 'apps', 'umenu-panel.svg'),
    install_dir: join_paths(datadir, 'icons', 'hicolor', '24x24', 'apps'))
install_data(join_paths('hicolor', '24x24', 'apps', 'umenu.svg'),
    install_dir: join_paths(datadir, 'icons', 'hicolor', '24x24', 'apps'))
install_data(join_paths('hicolor', '32x32', 'apps', 'umenu.svg'),
    install_dir: join_paths(datadir, 'icons', 'hicolor', '32x32', 'apps'))
install_data(join_paths('hicolor', '48x48', 'apps', 'umenu.svg'),
    install_dir: join_paths(datadir, 'icons', 'hicolor', '48x48', 'apps'))
install_data(join_paths('hicolor', 'scalable', 'apps', 'umenu.svg'),
    install_dir: join_paths(datadir, 'icons', 'hicolor', 'scalable', 'apps'))

install_data(join_paths('ubuntu-mono-dark', 'status', '16', 'umenu-panel.svg'),
    install_dir: join_paths(datadir, 'icons', 'ubuntu-mono-dark', 'status', '16'))
install_data(join_paths('ubuntu-mono-dark', 'status', '22', 'umenu-panel.svg'),
    install_dir: join_paths(datadir, 'icons', 'ubuntu-mono-dark', 'status', '22'))
install_data(join_paths('ubuntu-mono-dark', 'status', '24', 'umenu-panel.svg'),
    install_dir: join_paths(datadir, 'icons', 'ubuntu-mono-dark', 'status', '24'))

# Provide umenu-panel.svg as a copy for Unity scope icon
umenu_panel_16 = configure_file(
    input: join_paths('ubuntu-mono-dark', 'status', '16', 'umenu-panel.svg'),
    output: 'umenu-panel.svg',
    copy: true)
install_data(umenu_panel_16,
    install_dir: join_paths(datadir, 'icons', 'ubuntu-mono-dark', 'status', '16'))

install_data(join_paths('ubuntu-mono-light', 'status', '16', 'umenu-panel.svg'),
    install_dir: join_paths(datadir, 'icons', 'ubuntu-mono-light', 'status', '16'))
install_data(join_paths('ubuntu-mono-light', 'status', '22', 'umenu-panel.svg'),
    install_dir: join_paths(datadir, 'icons', 'ubuntu-mono-light', 'status', '22'))
install_data(join_paths('ubuntu-mono-light', 'status', '24', 'umenu-panel.svg'),
    install_dir: join_paths(datadir, 'icons', 'ubuntu-mono-light', 'status', '24'))

install_data(join_paths('Yaru', 'scalable', 'status', 'umenu-panel.svg'),
    install_dir: join_paths(datadir, 'icons', 'Yaru', 'scalable', 'status'))
install_data(join_paths('Yaru', 'scalable', 'apps', 'umenu.svg'),
    install_dir: join_paths(datadir, 'icons', 'Yaru', 'scalable', 'apps'))

# Install additional umenu icons
umenu_icon_16 = configure_file(
    input: join_paths('hicolor', '16x16', 'apps', 'umenu.svg'),
    output: 'umenu.svg',
    copy: true)
install_data(umenu_icon_16,
    install_dir: join_paths(datadir, 'icons', 'hicolor', '16x16', 'apps'))

umenu_icon_22 = configure_file(
    input: join_paths('hicolor', '22x22', 'apps', 'umenu.svg'),
    output: 'umenu.svg',
    copy: true)
install_data(umenu_icon_22,
    install_dir: join_paths(datadir, 'icons', 'hicolor', '22x22', 'apps'))

umenu_icon_24 = configure_file(
    input: join_paths('hicolor', '24x24', 'apps', 'umenu.svg'),
    output: 'umenu.svg',
    copy: true)
install_data(umenu_icon_24,
    install_dir: join_paths(datadir, 'icons', 'hicolor', '24x24', 'apps'))

umenu_icon_32 = configure_file(
    input: join_paths('hicolor', '32x32', 'apps', 'umenu.svg'),
    output: 'umenu.svg',
    copy: true)
install_data(umenu_icon_32,
    install_dir: join_paths(datadir, 'icons', 'hicolor', '32x32', 'apps'))

umenu_icon_48 = configure_file(
    input: join_paths('hicolor', '48x48', 'apps', 'umenu.svg'),
    output: 'umenu.svg',
    copy: true)
install_data(umenu_icon_48,
    install_dir: join_paths(datadir, 'icons', 'hicolor', '48x48', 'apps'))

umenu_icon_scalable = configure_file(
    input: join_paths('hicolor', 'scalable', 'apps', 'umenu.svg'),
    output: 'umenu.svg',
    copy: true)
install_data(umenu_icon_scalable,
    install_dir: join_paths(datadir, 'icons', 'hicolor', 'scalable', 'apps'))
