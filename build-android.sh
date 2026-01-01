#!/bin/bash

# Build EarnTimeToPlay for Google Play Store
# Usage: ./build-android.sh

set -e  # Exit on any error

echo "🤖 Building EarnTimeToPlay for Android"
echo "==========================================="

# Check if key.properties exists
if [ ! -f "android/key.properties" ]; then
    echo ""
    echo "⚠️  android/key.properties not found!"
    echo ""
    echo "Please create it first:"
    echo "1. Generate keystore (if you haven't):"
    echo "   keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload"
    echo ""
    echo "2. Copy template and fill in values:"
    echo "   cp android/key.properties.template android/key.properties"
    echo ""
    exit 1
fi

# Step 1: Clean
echo ""
echo "🧹 Cleaning previous build..."
flutter clean

# Step 2: Get dependencies
echo ""
echo "📦 Getting dependencies..."
flutter pub get

# Step 3: Build App Bundle
echo ""
echo "🔨 Building Android App Bundle (AAB)..."
flutter build appbundle --release

echo ""
echo "✅ Android build complete!"
echo ""
echo "📦 Output: build/app/outputs/bundle/release/app-release.aab"
echo ""
echo "Next steps:"
echo "1. Go to Google Play Console: https://play.google.com/console"
echo "2. Select your app (or create new)"
echo "3. Production → Create new release"
echo "4. Upload the AAB file"
echo "5. Complete store listing and submit for review"
