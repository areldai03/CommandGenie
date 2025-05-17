# 🧞 CommandGenie - 自然文からUnixコマンドを生成するCLIツール

CommandGenie は、自然言語での入力から対応する Unix 系コマンドを提案してくれる CLI アシスタントです。  
日本語に対応しています。

## ✨ 特長

- 🧠 **日本語入力に対応**：「ログファイルを検索したい」→ `grep "..." /var/log/...`
- 🦙 **軽量なローカルLLM**：llama-cpp + ggufモデルで高速動作
- 🗂 **manページを検索するRAG機能**（開発中）
  

## 📦 インストール方法

### ✅ 方法①（推奨）: 

```bash
curl -SfL https://raw.githubusercontent.com/yourusername/commandgenie/main/install.sh -o install.sh
chmod +x install.sh
./install.sh
```

### ✅ 方法②: pip 経由でインストール

```bash
pip install git+https://github.com/areldai03/Commandgenie.git
```
## 🦙 モデルの選択
任意のモデルを使う場合
```bash
export LLM_MODEL_PATH="/path/to/your/model.gguf"
```
## 📕 使用例
```bash
$ commandgenie "すべての.txtファイルを検索"
あなたの入力: すべての.txtファイルを検索
⠴ コマンドを生成中...
おすすめコマンド: find . -name "*.txt"
```

## 🖊️ 感想
- 初めてCLIのエントリポイント作ってみたが、pythonやっぱ便利やなぁと、、
- 1.5Bモデルだと3秒近くで返答が返ってくるため、実用性はありそう。RAG組んだ後どれくらい遅くなるのか気になる。
- 小さいモデルでもそこそこ正しい返答を返してくる、正確性に関してもRAGでどう変わるのか気になる。
