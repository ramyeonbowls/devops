#!/usr/bin/env bash
set -euo pipefail

echo "=================================================="
echo " LogPulse Dev Container — Post Create Setup"
echo "=================================================="

# ── 1. Frontend dependencies ──────────────────────────
echo ""
echo "→ Installing Node.js dependencies..."
cd /workspace/logs
npm install

# ── 2. Go tools ───────────────────────────────────────
echo ""
echo "→ Installing Go tools..."
go install golang.org/x/tools/cmd/goimports@latest 2>/dev/null || true
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest 2>/dev/null || true

# ── 3. Go backend: verify module ──────────────────────
echo ""
echo "→ Verifying Go module..."
cd /workspace/logs/backend
go mod tidy 2>/dev/null || true
go build ./... 2>/dev/null || echo "  (Build check done)"

# ── 4. Create data dir for SQLite ─────────────────────
echo ""
echo "→ Creating data directory..."
mkdir -p /workspace/logs/data

# ── 5. Copy .env if not exists ────────────────────────
if [ ! -f /workspace/.env ]; then
  cp /workspace/.devcontainer/.env.devcontainer /workspace/.env 2>/dev/null || true
  echo "→ .env created from template"
fi

echo ""
echo "=================================================="
echo " Setup complete!"
echo " Run: npm run dev         → Frontend (port 3000)"
echo " Run: go run main.go      → Backend  (port 8080)"
echo "=================================================="
