#!/usr/bin/env bash
set -euo pipefail

# Requires: export HF_TOKEN=hf_... (or `huggingface-cli login`)
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
: "${HF_TOKEN:?Set HF_TOKEN first: export HF_TOKEN=hf_...}"
exec npx @huggingface/tiny-agents run "$ROOT/my-agent-js"

