# MCP Client to Hugging Face Remote Server (Tiny Agents)

This repo shows two Tiny Agents configs that connect to the **Hugging Face Remote MCP server** and gives you ready-to-use tools (whoami, model_search, dataset_search, etc.) plus sample image tools via Spaces.
It demonstrates:
- Shared remote MCP (`mcp-remote`) used by both CLIs.
- Provider-routed inference (e.g., Nebius) controlled by `config.json` / `agent.json`.
- Real MCP tools (HF search/docs + image generator).
- Safe secrets: `.env.example` (commit) and `.env` (ignore).


## Repo layout
```
ucsc-mcp/
├─ my-agent/                 # Python tiny-agents config
│  └─ config.json
├─ my-agent-js/              # Node tiny-agents config
│  └─ agent.json
├─ scripts/
│  ├─ hf-mcp-remote.sh       # starts remote HF MCP (uses HF_TOKEN)
│  ├─ run-py.sh              # Python CLI
│  └─ run-js.sh              # Node CLI
├─ screenshots/              # PNGs referenced in README
├─ .env.example              # template for secrets (commit this)
├─ .gitignore                # ignore .env, .venv, etc.
└─ README.md
```




## Prereqs
- macOS/Linux, `bash`
- Hugging Face account + access token
- Python 3.10+ and Node 18+
- `HF_TOKEN` set, or be logged in with `huggingface-cli login`
- Optional: `jq`, `curl`

## Quickstart

```bash
# Clone and enter
git clone https://github.com/<you>/ucsc-mcp.git
cd ucsc-mcp


# (Optional) Python venv
python3 -m venv .venv
source .venv/bin/activate
pip install 'huggingface_hub[mcp]'


## Setup
1. Copy the env template and set your token:
cp .env.example .env
# edit .env and set HF_TOKEN=hf_xxx...

2. Make scripts executable:
chmod +x scripts/hf-mcp-remote.sh scripts/run-py.sh scripts/run-js.sh


# Run the Node CLI
scripts/run-js.sh

You’ll see the agent start and a > prompt.
Try:
Call the function "hf_whoami" now

Try:
Tell me a two-line poem about the ocean

Docs search:
Search the HF docs for “space hardware requirements” and summarize in 3 bullets.


Image generation (numbers as numbers):
Call the function "gr1_flux1_schnell_infer" with args {"prompt":"a hummingbird and a red rose"} now

# Run the Python CLI
scripts/run-py.sh

At the » prompt, same calls work; e.g.:
hf_whoami

Image:
Call tool gr1_flux1_schnell_infer with {"prompt":"mysterious castle near the river with beautiful flowers"}


## Screenshots

The `screenshots/` folder contains example runs for both CLIs and tool calls.

| Preview | Description |
|---|---|
| ![Python CLI start](screenshots/python-cli-start.png) | Python client starting via `scripts/run-py.sh` |
| ![Node.js CLI start](screenshots/node-cli-start.png) | Node.js client starting via `scripts/run-js.sh` |
| ![HF whoami](screenshots/hf-whoami.png) | Calling `hf_whoami` |
| ![Poem demo (Node.js)](screenshots/poem-ocean.png) | Two-line ocean poem (Node.js CLI) |
| ![Image tool (Node.js)](screenshots/hummingbird.png) | `gr1_flux1_schnell_infer` image generation result (Node.js CLI) |
| ![Image tool (Python)](screenshots/castle_river_py.png) | `gr1_flux1_schnell_infer` image generation result (Python CLI) |


> Tip: GitHub renders images via relative paths like `screenshots/your-file.png`.




