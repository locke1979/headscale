#!/bin/sh
set -eu

secret_file=/run/secrets/tailscale_api_key
if [ -r "$secret_file" ]; then
  TAILSCALE_API_KEY=$(tr -d '\r\n' < "$secret_file")
  if [ -z "$TAILSCALE_API_KEY" ]; then
    echo "tailscale API secret file is empty" >&2
    exit 1
  fi
  export TAILSCALE_API_KEY
fi

exec tailscale-mcp-server "$@"
