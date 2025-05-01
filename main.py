import typer
from rich import print

app = typer.Typer(help="コマンド生成くん - 入力文からUnixコマンドを生成するCLI")

@app.command()
def generate(query: str):
    """自然文からUnixコマンドを生成"""
    print(f"[bold cyan]あなたの入力:[/bold cyan] {query}")
    
    # 仮のレスポンス
    print("[bold green]おすすめコマンド:[/bold green] ls -la")
    print("説明: ディレクトリ内のファイルを詳細表示します")

if __name__ == "__main__":
    app()
