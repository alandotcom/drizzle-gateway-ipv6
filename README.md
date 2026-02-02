# Drizzle Gateway IPv6 Wrapper

A wrapper Docker image for [drizzle-gateway](https://github.com/drizzle-team/drizzle-gateway) that adds IPv6 support.

## Problem

The official `ghcr.io/drizzle-team/gateway` image hardcodes its hostname to `0.0.0.0` (IPv4 only). This causes connection failures on platforms like Railway that use IPv6 for internal networking.

## Solution

This wrapper uses `socat` to bridge IPv6 connections to the IPv4-only drizzle-gateway process:

```
[IPv6 clients] → socat (dual-stack :4983) → drizzle-gateway (127.0.0.1:4984)
```

## Usage

### Docker Hub / GHCR

```bash
docker pull ghcr.io/alancohen/drizzle-gateway-ipv6:latest
docker run -p 4983:4983 ghcr.io/alancohen/drizzle-gateway-ipv6:latest
```

### Build locally

```bash
docker build -t drizzle-gateway-ipv6 .
docker run -p 4983:4983 drizzle-gateway-ipv6
```

### Railway

Point your Railway service to this GitHub repo. Railway will build and deploy automatically.

## Environment Variables

- `PORT` - External port (default: `4983`)
- `INTERNAL_PORT` - Internal port for drizzle-gateway (default: `4984`)

Pass through any drizzle-gateway environment variables as normal.

## License

MIT
