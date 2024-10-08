#!/bin/bash

# Название бинарного файла
BINARY_NAME="cpwd"

# Путь к домашней директории пользователя
BIN_DIR="$HOME/bin"

# Проверка, находится ли бинарный файл рядом со скриптом
SCRIPT_DIR="$(dirname "$0")"
BINARY_PATH="$SCRIPT_DIR/$BINARY_NAME"

if [ ! -f "$BINARY_PATH" ]; then
    echo "Ошибка: бинарник $BINARY_NAME не найден в папке $SCRIPT_DIR."
    exit 1
fi

# Создание директории ~/bin, если она не существует
if [ ! -d "$BIN_DIR" ]; then
    echo "Создаю директорию $BIN_DIR..."
    mkdir -p "$BIN_DIR"
fi

# Перемещение бинарного файла в ~/bin
if [ -f "$BIN_DIR/$BINARY_NAME" ]; then
    echo "Бинарник $BINARY_NAME уже существует в $BIN_DIR"
else
    echo "Перемещаю $BINARY_NAME в $BIN_DIR..."
    mv "$BINARY_PATH" "$BIN_DIR/"
fi

# Добавление ~/bin в PATH, если его там нет
if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    echo "Добавляю $BIN_DIR в PATH..."
    echo "export PATH=\"$BIN_DIR:\$PATH\"" >> "$HOME/.bashrc"
    export PATH="$BIN_DIR:$PATH"
    echo "Для применения изменений перезапустите терминал или выполните команду: source ~/.bashrc"
else
    echo "$BIN_DIR уже находится в PATH"
fi

echo "Установка завершена. Теперь вы можете использовать команду $BINARY_NAME."

