#!/bin/bash

set -e

REPO_URL="https://github.com/areldai03/CommandGenie.git"
INSTALL_DIR="$HOME/.commandgenie"
VENV_DIR="$INSTALL_DIR/venv"

echo "🛠️ commandgenie をインストール中..."

# rm -rf "$INSTALL_DIR"
# git clone "$REPO_URL" "$INSTALL_DIR"

MODEL_DIR="$INSTALL_DIR/models"
MODEL_FILE="$MODEL_DIR/japanese-ggml-model.gguf"
MODEL_URL="https://huggingface.co/SakanaAI/TinySwallow-1.5B-Instruct-GGUF/resolve/main/tinyswallow-1.5b-instruct-q8_0.gguf"

if [ -f "$MODEL_FILE" ]; then
  echo "モデルファイルが既に存在します。"
else
  if [ -n "$ZSH_VERSION" ]; then
    read "ANSWER?モデルファイルをダウンロードしますか？ (y/n): "
  elif [ -n "$BASH_VERSION" ]; then
    read -p "モデルファイルをダウンロードしますか？ (y/n): " ANSWER
  else
    echo -n "モデルファイルをダウンロードしますか？ (y/n): "
    read ANSWER
  fi

  case "$ANSWER" in
    [Yy]* )
      echo "モデルをダウンロードしています..."
      mkdir -p "$MODEL_DIR"
      curl -L "$MODEL_URL" -o "$MODEL_FILE"
      echo "モデルのダウンロードが完了しました。"
      ;;
    * )
      echo "モデルのダウンロードをスキップしました。"
      ;;
  esac
fi

if command -v python3 &>/dev/null; then
  PYTHON=python3
  PIP=pip3
elif command -v python &>/dev/null; then
  PYTHON=python
  PIP=pip
else
  echo "❌ Pythonが見つかりません。Pythonをインストールしてください。"
  exit 1
fi

$PYTHON -m venv "$VENV_DIR"
source "$VENV_DIR/bin/activate"

cd "$INSTALL_DIR"
$PIP install --upgrade pip
$PIP install .

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
