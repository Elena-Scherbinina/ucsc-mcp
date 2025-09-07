#!/usr/bin/env bash
# Runs the Tiny Agents *host (client)* using ./my-agent/config.json.
# Activates the project .venv and ensures you're logged in to Hugging Face.
# No local MCP server is started here.

set -euo pipefail

# load env vars if present
if [[ -f ".env" ]]; then
  set -a          # enable auto-export env variables
  source ".env"   # exports HF_TOKEN
  set +a          # disable auto-export
fi

echo "$HF_TOKEN"

# repo root (It is a parent of this script)
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
echo "Root :   $ROOT"

# 1) Activate venv
if [[ -d "$ROOT/.venv" ]]; then
  source "$ROOT/.venv/bin/activate"
else
  echo "No .venv found at $ROOT/.venv"
  echo "Create it with:"
  echo "  python3 -m venv .venv && source .venv/bin/activate && pip install 'huggingface_hub[mcp]'"
  exit 1
fi

# 2) Tooling checks
# Check if tiny-agents installed
command -v tiny-agents >/dev/null || {
  echo "tiny-agents not found in this venv."
  echo "Install with: pip install 'huggingface_hub[mcp]'" ; exit 1; }

# Check if the huggingface cli exists 
command -v huggingface-cli >/dev/null || {
  echo "huggingface-cli not found (comes with huggingface_hub)."
  echo "Install with: pip install 'huggingface_hub[mcp]'" ; exit 1; }

[[ -f "$ROOT/my-agent/config.json" ]] || {
  echo "Missing: $ROOT/my-agent/config.json" ; exit 1; }

# 3) Ensure you're authenticated (prompts interactively if needed; no token in repo)
if ! huggingface-cli whoami >/dev/null 2>&1; then
  echo "You're not logged in to Hugging Face. Starting login flow..."
  huggingface-cli login
fi

# 4) Run the host (client). It reads ./my-agent/config.json
exec tiny-agents run "./my-agent/config.json"

