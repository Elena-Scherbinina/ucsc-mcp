#!/usr/bin/env bash
set -euo pipefail

# use HF_TOKEN if set; otherwise read the login token saved by huggingface-cli
if [[ -z "${HF_TOKEN:-}" ]]; then
  if [[ -f "$HOME/.cache/huggingface/token" ]]; then
    HF_TOKEN="$(cat "$HOME/.cache/huggingface/token")"
  elif [[ -f "$HOME/.huggingface/token" ]]; then
    HF_TOKEN="$(cat "$HOME/.huggingface/token")"
  else
    echo "No HF token found. Either export HF_TOKEN=hf_xxx or run: huggingface-cli login"
    exit 1
  fi
fi

npx mcp-remote@0.1.29 https://huggingface.co/mcp --header "Authorization: Bearer ${HF_TOKEN}"


