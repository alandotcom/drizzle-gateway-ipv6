# Stage 1: Get drizzle-gateway files
FROM ghcr.io/drizzle-team/gateway:latest AS source

# Stage 2: Alpine with socat
FROM oven/bun:1.3.4-alpine

RUN apk add --no-cache socat

# Copy drizzle-gateway application
COPY --from=source /entry /entry

WORKDIR /entry

# External port (IPv6) → Internal port (IPv4)
ENV PORT=4983
ENV INTERNAL_PORT=4984

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 4983

CMD ["/entrypoint.sh"]
