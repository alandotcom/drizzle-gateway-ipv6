#!/bin/sh
set -e

# socat listens on dual-stack (IPv4+IPv6) on $PORT
# forwards to localhost:$INTERNAL_PORT where drizzle-gateway runs
socat TCP6-LISTEN:${PORT},fork,reuseaddr,ipv6only=0 TCP4:127.0.0.1:${INTERNAL_PORT} &

# Run drizzle-gateway on internal IPv4 port
PORT=${INTERNAL_PORT} exec bun run index.js
