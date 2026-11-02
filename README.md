# CPA Manager Plus + CLIProxyAPI — subscription-to-API proxy with a management and observability panel (MIT). Deploy on Railway with one click.

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/deploy/IKLUsa)

[CLIProxyAPI](https://github.com/router-for-me/CLIProxyAPI) turns your AI subscriptions (Claude, Codex/ChatGPT, Gemini, Kimi, xAI, …) and API keys into one OpenAI/Claude/Gemini-compatible API. [CPA Manager Plus](https://github.com/seakee/CPA-Manager-Plus) (CPAMP) is the full-mode management panel for it: providers, OAuth accounts, requests, failures, cost, quota and account health. This template runs both, already wired together.

## Services
| Service | Image | Port | Volume |
|---|---|---|---|
| CLIProxyAPI | `ghcr.io/onepush-dev/cpa-cliproxyapi:8.0.51` (FROM `eceasy/cli-proxy-api:v8.0.51`, digest-pinned) | Railway `PORT` (public HTTPS API), health `/healthz` | `/app/data` (config.yaml, OAuth credentials, logs) |
| CPA Manager Plus | `ghcr.io/onepush-dev/cpa-manager-plus:1.14.10` (FROM `seakee/cpa-manager-plus:1.14.10`, digest-pinned) | Railway `PORT` (public HTTPS), UI `/management.html`, health `/health` | `/data` (usage SQLite, settings, `data.key`) |

## Sign in
Zero inputs at deploy time. Three keys are generated per deploy:
- `CPA_MANAGER_ADMIN_KEY` (CPA Manager Plus service) — log in to `https://<cpa-manager-plus domain>/management.html`.
- `MANAGEMENT_PASSWORD` (CLIProxyAPI service) — the CPA management key; CPA Manager Plus receives it by reference (`CPA_MANAGEMENT_KEY`) together with `CPA_UPSTREAM_URL` (CLIProxyAPI's private address), so the panel is connected on first start.
- `CPA_API_KEY` (CLIProxyAPI service) — the client key for the proxy API (`Authorization: Bearer <key>` against `https://<cliproxyapi domain>/v1/...`). It seeds `config.yaml` on first boot; manage further keys in the panel.

Then add accounts (OAuth sign-ins) or provider API keys from the panel.

## What the wrappers add
- CLIProxyAPI: writes a minimal `config.yaml` on the volume on first boot (remote management on, usage statistics on for CPAMP, OAuth credentials under `/app/data/auths`, client key from `CPA_API_KEY`) and keeps `server.port` in sync with Railway's `PORT` on every boot.
- CPA Manager Plus: binds Railway's `PORT`; image defaults `USAGE_DB_PATH=/data/usage.sqlite`, `CPA_MANAGER_DATA_KEY_PATH=/data/data.key`, `USAGE_COLLECTOR_MODE=auto`.

## Notes
- OAuth flows that redirect to `localhost` callbacks need the copy-the-callback-URL step in the panel (or the device-code flow where offered).
- Back up `/data` (SQLite + `data.key`) together, and `/app/data` for credentials.
- Use only with subscriptions and credentials you are allowed to operate.

## License
CLIProxyAPI (router-for-me) and CPA Manager Plus (seakee) are MIT-licensed. This repo only holds Railway packaging.
