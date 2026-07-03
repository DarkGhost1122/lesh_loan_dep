#!/bin/bash
# ────────────────────────────────────────────
# MACS MF – Start Script
# Starts MongoDB and the Flask API server
# Usage: ./start.sh
# ────────────────────────────────────────────

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKEND_DIR="$SCRIPT_DIR/backend"

echo "════════════════════════════════════════"
echo "  MACS MF – Startup"
echo "════════════════════════════════════════"

# ── 1. Start MongoDB ───────────────────────
echo ""
echo "▶ Starting MongoDB..."
brew services start mongodb-community 2>/dev/null || echo "  (MongoDB may already be running)"

# Wait for MongoDB to be ready
sleep 2

# ── 2. Seed the database (safe to run multiple times) ──
echo ""
echo "▶ Seeding database..."
cd "$BACKEND_DIR"
python3 seed.py

# ── 3. Start Flask API ─────────────────────
echo ""
echo "▶ Starting Flask API on http://localhost:5001"
echo "  Press Ctrl+C to stop."
echo ""
python3 app.py
