#!/bin/bash

# Deploy EarnTimeToPlay to Cloudflare Pages
# Usage: ./deploy-web.sh

set -e  # Exit on any error

PROJECT_NAME="earn-time-to-play"
BUILD_DIR="build/web"

echo "🚀 Deploying EarnTimeToPlay to Cloudflare Pages"
echo "=================================================="

# Step 1: Clean previous build
echo ""
echo "🧹 Cleaning previous build..."
flutter clean

# Step 2: Get dependencies
echo ""
echo "📦 Getting dependencies..."
flutter pub get

# Step 3: Build for web
echo ""
echo "🔨 Building Flutter web app (release mode)..."
flutter build web --release --no-wasm-dry-run

# Step 4: Deploy to Cloudflare Pages
echo ""
echo "☁️  Deploying to Cloudflare Pages..."
wrangler pages deploy "$BUILD_DIR" --project-name="$PROJECT_NAME" --branch=main

echo ""
echo "✅ Deployment complete!"
echo "🌐 Your app is live at: https://$PROJECT_NAME.pages.dev"
echo "📜 Privacy policy at: https://$PROJECT_NAME.pages.dev/privacy-policy.html"
