#!/bin/bash
set -e

# --- НАЛАШТУВАННЯ ШЛЯХІВ ---
DEPLOY_DIR="$(pwd)/deploy"
LINUXDEPLOY="$DEPLOY_DIR/linuxdeploy-x86_64.AppImage"
PLUGIN_GTK_SCRIPT="$DEPLOY_DIR/linuxdeploy-plugin-gtk.sh"
PLUGIN_GTK_LINK="$DEPLOY_DIR/linuxdeploy-plugin-gtk"

BUILD_DIR="builddir"
APP_DIR="AppDir"
RELEASE_DIR="release"

# --- НАЛАШТУВАННЯ ІМЕН (ВАЖЛИВО!) ---
# Як програма буде називатися у меню
APP_NAME="Umenu"
# Ім'я існуючого файлу іконки (тепер umenu.svg)
ICON_SOURCE_NAME="umenu"
# Ім'я бінарного файлу, який створив Meson (тепер це umenu)
BINARY_NAME="umenu"

# --- 1. ПІДГОТОВКА ІНСТРУМЕНТІВ ---
echo "--> Підготовка інструментів..."
chmod +x "$LINUXDEPLOY"
chmod +x "$PLUGIN_GTK_SCRIPT"

if [ ! -f "$PLUGIN_GTK_LINK" ]; then
    ln -s "$PLUGIN_GTK_SCRIPT" "$PLUGIN_GTK_LINK"
fi

export PATH="$DEPLOY_DIR:$PATH"

# --- 2. ЧИСТКА ТА ЗБІРКА ---
echo "--> Очищення та збірка..."
rm -rf "$BUILD_DIR" "$APP_DIR"
mkdir -p "$RELEASE_DIR"
rm -f "$RELEASE_DIR"/Umenu*.AppImage

meson setup "$BUILD_DIR" --prefix=/usr -Ddisable-indicator-plugin=false
DESTDIR="$(pwd)/$APP_DIR" ninja -C "$BUILD_DIR" install

# --- 3. ПІДГОТОВКА ДАНИХ ДЛЯ APPIMAGE (без пост-правок) ---
echo "--> Підготовка даних для AppImage..."

# Знаходимо встановлений desktop файл (очікуємо umenu.desktop)
DESKTOP_FILE=$(find "$APP_DIR" -name "umenu.desktop" | head -n 1)
if [ -z "$DESKTOP_FILE" ]; then
    echo "ПОМИЛКА: Не знайдено umenu.desktop у AppDir!"
    exit 1
fi

NEW_DESKTOP_FILE="$DESKTOP_FILE"

# Переконуємось, що є іконка umenu.svg (має бути встановлена Meson'ом)
ICON_SRC="$APP_DIR/usr/share/icons/hicolor/scalable/apps/umenu.svg"
if [ ! -f "$ICON_SRC" ]; then
    echo "УВАГА: Іконку $ICON_SRC не знайдено! Перевірте встановлення іконок."
fi

# --- 4. СТВОРЕННЯ APPIMAGE ---
echo "--> Генерація AppImage..."

export LINUXDEPLOY_PLUGIN_GTK_STYLE=2

# Вказуємо шлях до бібліотек, щоб linuxdeploy знайшов libumenu.so
export LD_LIBRARY_PATH="$APP_DIR/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH"

"$LINUXDEPLOY" \
    --appdir "$APP_DIR" \
    --plugin gtk \
    --desktop-file "$NEW_DESKTOP_FILE" \
    --output appimage

# --- 5. ФІНАЛ ---
mv Umenu*.AppImage "$RELEASE_DIR/"
echo "Успіх! Файл у папці $RELEASE_DIR"
ls -lh "$RELEASE_DIR/"*.AppImage
