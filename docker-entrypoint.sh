#!/bin/sh
set -eu

secret_file=/run/secrets/tailscale_api_key
if [ -r "$secret_file" ]; then
  TAILSCALE_API_KEY=$(cat "$secret_file")
  export TAILSCALE_API_KEY
fi

exec tailscale-mcp-server "$@"
