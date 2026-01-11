#!/bin/bash

# ==============================================================================
# UMENU INSTALLER (AUTO-CONFIGURED)
# ==============================================================================
# Автор: biryukwolf@yahoo.com
# Опис: Автоматично завантажує UMenu, інтегрує в меню та налаштовує Hotkey.
#       Не потребує аргументів.
# ==============================================================================

set -e

# --- 1. КОНФІГУРАЦІЯ (Hardcoded) ---
APP_NAME="UMenu"
APP_URL="https://github.com/samwolf1982/u-menu/releases/download/test/UMenu-x86_64.AppImage"
ICON_URL="" # Залиш порожнім, якщо іконки немає, або встав URL на .png

# --- 2. Шляхи (XDG Standard) ---
INSTALL_DIR="$HOME/.local/bin"
DESKTOP_DIR="$HOME/.local/share/applications"
ICON_DIR="$HOME/.local/share/icons"

# --- 3. Підготовка ---
APP_SLUG=$(echo "$APP_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
FILENAME="${APP_SLUG}.AppImage"
TARGET_PATH="$INSTALL_DIR/$FILENAME"

mkdir -p "$INSTALL_DIR" "$DESKTOP_DIR" "$ICON_DIR"

# --- 4. Завантаження ---
if [ -f "$TARGET_PATH" ]; then
    echo "⚠️  Знайдено стару версію. Оновлюємо..."
    rm "$TARGET_PATH"
fi

echo "⬇️  Завантаження $APP_NAME..."
curl -L -o "$TARGET_PATH" "$APP_URL" --progress-bar

echo "🔧 Налаштування прав..."
chmod +x "$TARGET_PATH"

# --- 5. Іконка ---
ICON_PATH=""
if [[ -n "$ICON_URL" ]]; then
    ICON_EXT="${ICON_URL##*.}"
    [[ "$ICON_EXT" != "png" && "$ICON_EXT" != "svg" && "$ICON_EXT" != "jpg" ]] && ICON_EXT="png"
    ICON_PATH="$ICON_DIR/${APP_SLUG}.${ICON_EXT}"
    curl -L -o "$ICON_PATH" "$ICON_URL" --silent
else
    ICON_PATH="utilities-terminal"
fi

# --- 6. Створення .desktop файлу ---
DESKTOP_FILE="$DESKTOP_DIR/${APP_SLUG}.desktop"

cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Type=Application
Name=$APP_NAME
Exec=$TARGET_PATH
Icon=$ICON_PATH
Categories=Utility;
Terminal=false
StartupNotify=true
EOF

update-desktop-database "$DESKTOP_DIR" 2>/dev/null || true

# --- 7. Налаштування HOTKEY (Тільки GNOME) ---

setup_gnome_hotkey() {
    echo "⌨️  Спроба налаштування гарячих клавіш (GNOME)..."

    if ! command -v gsettings &> /dev/null; then
        echo "   -> gsettings не знайдено. Пропускаємо."
        return
    fi

    SCHEMA="org.gnome.settings-daemon.plugins.media-keys"
    KEY_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-umenu/"

    CURRENT_LIST=$(gsettings get $SCHEMA custom-keybindings)

    # Логіка додавання до списку ключів
    if [[ "$CURRENT_LIST" == "@as []" || -z "$CURRENT_LIST" ]]; then
        NEW_LIST="['$KEY_PATH']"
    elif [[ "$CURRENT_LIST" != *"$KEY_PATH"* ]]; then
        NEW_LIST="${CURRENT_LIST%]*}, '$KEY_PATH']"
    else
        # Вже існує - форсуємо правильний біндинг і виходимо
        gsettings set "$SCHEMA.custom-keybinding:$KEY_PATH" binding "<Control><Alt>q"
        echo "   -> Hotkey оновлено на Ctrl+Alt+Q."
        return
    fi

    if [[ -n "$NEW_LIST" ]]; then
        gsettings set $SCHEMA custom-keybindings "$NEW_LIST"
    fi

    # Налаштування параметрів ключа
    gsettings set "$SCHEMA.custom-keybinding:$KEY_PATH" name "$APP_NAME"
    gsettings set "$SCHEMA.custom-keybinding:$KEY_PATH" command "$TARGET_PATH"
    gsettings set "$SCHEMA.custom-keybinding:$KEY_PATH" binding "<Control><Alt>q"

    echo "✅ Hotkey встановлено: Ctrl + Alt + Q"
}

# Перевірка середовища
if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* || "$XDG_CURRENT_DESKTOP" == *"Ubuntu"* ]]; then
    setup_gnome_hotkey
else
    echo "ℹ️  Ваше середовище ($XDG_CURRENT_DESKTOP) вимагає ручного налаштування клавіш."
    echo "   Додайте шорткат Ctrl+Alt+Q на команду: $TARGET_PATH"
fi

echo "✅ Успішно встановлено: $TARGET_PATH"
