from llama_cpp import Llama
from .context_manager import suppress_stdout_stderr
import os

MODEL_PATH = os.getenv("LLM_MODEL_PATH")
if MODEL_PATH is None:
    MODEL_PATH = os.path.expanduser("~/.commandgenie/models/japanese-ggml-model.gguf")

with suppress_stdout_stderr():
    llm = Llama(model_path=MODEL_PATH, n_ctx=2048, n_threads=4, verbose=False)

def apply_chat_template(messages: list) -> str:
    result = ""
    for m in messages:
        if m["role"] == "system":
            result += f"<|start_header_id|>system<|end_header_id|>\n\n{m['content']}<|eot_id|>"
        elif m["role"] == "user":
            result += f"<|start_header_id|>user<|end_header_id|>\n\n{m['content']}<|eot_id|>"
        elif m["role"] == "assistant":
            result += f"<|start_header_id|>assistant<|end_header_id|>\n\n{m['content']}<|eot_id|>"
    result += "<|start_header_id|>assistant<|end_header_id|>\n\n"
    return result

def generate_command(natural_text: str) -> str:
    messages = [
        {
            "role": "system",
            "content": "あなたはUnixのCLIコマンドに詳しい専門家です。",
        },
        {
            "role": "user",
            "content": f"{natural_text}。\n対応するUnixコマンドを1行で教えてください。説明は不要です。"
        }
    ]
    
    prompt = apply_chat_template(messages)
    
    output = llm(prompt, max_tokens=128, stop=["<|user|>", "<|system|>"])
    
    return output["choices"][0]["text"].split("\n")[0]