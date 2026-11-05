FROM node:22-alpine

ARG TAILSCALE_MCP_VERSION=1.3.4

ENV NODE_ENV=production \
    TAILSCALE_TAILNET=- \
    TAILSCALE_ALLOWED_TOOL_RISK=read \
    MCP_TRANSPORT=stdio

RUN npm install --global --omit=dev --fetch-retries=1 --fetch-timeout=30000 \
    "@hexsleeves/tailscale-mcp-server@${TAILSCALE_MCP_VERSION}" \
    && npm cache clean --force

USER node
WORKDIR /home/node

ENTRYPOINT ["tailscale-mcp-server"]
