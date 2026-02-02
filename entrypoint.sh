#!/bin/sh
set -e

echo "Starting drizzle-gateway on internal port ${INTERNAL_PORT}..."
PORT=${INTERNAL_PORT} bun run index.js &
BUN_PID=$!

# Wait a moment for bun to start
sleep 2

echo "Starting socat IPv6 listener on port ${PORT} -> 127.0.0.1:${INTERNAL_PORT}..."
socat TCP6-LISTEN:${PORT},fork,reuseaddr TCP4:127.0.0.1:${INTERNAL_PORT} &
SOCAT_PID=$!

echo "PIDs: bun=$BUN_PID, socat=$SOCAT_PID"

# Wait for either to exit
wait -n $BUN_PID $SOCAT_PID
echo "Process exited, shutting down..."
kill $BUN_PID $SOCAT_PID 2>/dev/null || true
wait
