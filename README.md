# Tailscale MCP connector

This repository packages the maintained [`@hexsleeves/tailscale-mcp-server`](https://github.com/HexSleeves/tailscale-mcp) in a small, non-root Docker image.

## Safety defaults

- Tailscale policy operations are **read-only** by default.
- `TAILSCALE_ALLOWED_TOOL_RISK=write` is required before ACL, policy, DNS, route, tag, or webhook writes are exposed.
- The API key is supplied only at runtime; no secret is stored in this repository or image.
- The container has a read-only filesystem, drops Linux capabilities, and disallows privilege escalation.

## Build

```sh
docker build --build-arg TAILSCALE_MCP_VERSION=1.3.4 \
  -t locke1979/tailscale-mcp-server:1.3.4 .
```

## Run as an MCP stdio server

```sh
docker run --rm -i \
  -e TAILSCALE_API_KEY \
  -e TAILSCALE_TAILNET=- \
  -e TAILSCALE_ALLOWED_TOOL_RISK=read \
  locke1979/tailscale-mcp-server:1.3.4
```

For Compose, use the Docker secret-file flow below:

```sh
export TAILSCALE_API_KEY='tskey-api-...'
docker compose run --rm tailscale-mcp
```

## Run with a Docker secret file

Create the ignored secret file outside source control with restrictive permissions:

```sh
umask 077
mkdir -p secrets
$EDITOR secrets/tailscale_api_key
```

The container reads this file as `/run/secrets/tailscale_api_key` during startup. Do not commit it.
Then start the connector:

```sh
docker compose run --rm tailscale-mcp
```

Do not place a real API key in `.env.example`, source control, image layers, or command history.
