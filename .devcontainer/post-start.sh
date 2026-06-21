#!/bin/bash
# Post-start script for Codespace
# Runs every time the Codespace is started

set -e

echo "🔄 Post-Start Setup..."
echo "⏰ Time: $(date)"
echo ""

# Activate virtual environment
if [ -d /workspaces/venv ]; then
    echo "🐍 Activating virtual environment..."
    source /workspaces/venv/bin/activate
fi

# Update packages
echo "📦 Updating packages..."
pip install --upgrade pip setuptools wheel -q 2>/dev/null || true

# Check and install missing requirements
if [ -f /workspaces/requirements.txt ]; then
    echo "📥 Installing/updating requirements..."
    pip install -q -r /workspaces/requirements.txt 2>/dev/null || true
fi

# Create logs directory if it doesn't exist
mkdir -p /workspaces/logs
mkdir -p /workspaces/data

# Print environment info
echo ""
echo "✅ Environment Status:"
echo "  Python: $(python3 --version 2>&1)"
echo "  pip: $(pip --version 2>&1 | cut -d' ' -f1-2)"
echo "  Node.js: $(node --version 2>&1)"
echo "  npm: $(npm --version 2>&1)"
echo ""

# Show available commands
echo "📝 Available Commands:"
echo "  make help       - Show all available commands"
echo "  make install    - Install dependencies"
echo "  make dev        - Run development server"
echo "  make test       - Run tests"
echo "  make lint       - Run linters"
echo "  make format     - Format code"
echo ""

echo "✅ Codespace ready!"
