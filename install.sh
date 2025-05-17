#!/bin/bash

set -e

REPO_URL="https://github.com/yourusername/commandgenie.git"
INSTALL_DIR="$HOME/.commandgenie"
VENV_DIR="$INSTALL_DIR/venv"

echo "🛠️ commandgenie をインストール中..."

rm -rf "$INSTALL_DIR"
git clone "$REPO_URL" "$INSTALL_DIR"

python -m venv "$VENV_DIR"
source "$VENV_DIR/bin/activate"

cd "$INSTALL_DIR"
pip install --upgrade pip
pip install .

# shellの種類を判別
SHELL_NAME=$(basename "$SHELL")

if [ "$SHELL_NAME" = "zsh" ]; then
  PROFILE_FILE="$HOME/.zshrc"
elif [ "$SHELL_NAME" = "bash" ]; then
  if [ -f "$HOME/.bashrc" ]; then
    PROFILE_FILE="$HOME/.bashrc"
  else
    PROFILE_FILE="$HOME/.bash_profile"
  fi
else
  PROFILE_FILE="$HOME/.profile"
fi

if ! grep -q "$VENV_DIR/bin" "$PROFILE_FILE"; then
  echo "export PATH=\"$VENV_DIR/bin:\$PATH\"" >> "$PROFILE_FILE"
  echo "✅ PATH を $PROFILE_FILE に追加しました（新しいターミナルで有効になります）"
fi

echo "✅ インストール完了！以下のように使えます："
echo ""
echo "    commandgenie generate \"ファイルの検索方法\""
