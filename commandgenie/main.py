import typer
from rich import print
from rich.spinner import Spinner
from rich.live import Live
from .model import generate_command

app = typer.Typer(help="コマンド生成くん - 入力文からUnixコマンドを生成するCLI")

@app.command()
def generate(query: str):
    """自然文からUnixコマンドを生成"""
    print(f"[bold cyan]あなたの入力:[/bold cyan] {query}")
    
    spinner = Spinner("dots", text="コマンドを生成中...")

    with Live(spinner, refresh_per_second=10):
        command = generate_command(query)
    
    print(f"[bold green]おすすめコマンド:[/bold green] {command}")

def cli():
    app()
