#!/bin/bash
# =============================================================================
# SCRIPT CUSTOMIZATION DOLIBARR - LOGO & VERSION
# =============================================================================
# Script untuk mengganti logo dan menghilangkan versi beta Dolibarr
# =============================================================================

set -e

echo "🎨 DOLIBARR CUSTOMIZATION SCRIPT"
echo "================================"
echo "Script ini akan:"
echo "1. Backup logo original"
echo "2. Menghilangkan text versi '23.0.0-beta'"
echo "3. Setup untuk upload logo custom"
echo ""

# Pastikan di direktori yang benar
cd ~/www/htdocs

# 1. BACKUP LOGO ORIGINAL
echo "📦 Step 1: Backup logo original..."
cd theme
if [ ! -f "dolibarr_logo_original.png" ]; then
    cp dolibarr_logo.png dolibarr_logo_original.png
    echo "   ✅ dolibarr_logo.png backed up"
fi

if [ ! -f "dolibarr_logo_original.svg" ]; then
    cp dolibarr_logo.svg dolibarr_logo_original.svg
    echo "   ✅ dolibarr_logo.svg backed up"
fi

cd common
if [ ! -f "login_logo_original.png" ]; then
    cp login_logo.png login_logo_original.png
    echo "   ✅ login_logo.png backed up"
fi

# 2. HILANGKAN TEXT VERSI BETA
echo ""
echo "🔧 Step 2: Menghilangkan text versi beta..."
cd ~/www/htdocs

# Edit version.inc.php untuk hide version
if grep -q "23.0.0-beta" version.inc.php; then
    sed -i 's/23.0.0-beta/Enterprise Edition/g' version.inc.php
    echo "   ✅ Versi diubah dari '23.0.0-beta' ke 'Enterprise Edition'"
fi

# 3. CREATE CUSTOM CSS UNTUK HIDE VERSION DI LOGIN
echo ""
echo "🎨 Step 3: Hide version text di login page..."

# Buat atau update custom.css.php
cat >> theme/custom.css.php << 'EOF'

/* Custom CSS untuk hide version text */
.login-dolibarr-logo-version {
    display: none !important;
}

.version-text {
    display: none !important;
}

.dolibarr-version {
    display: none !important;
}

/* Style custom untuk logo */
.loginboxlogo img {
    max-width: 200px;
    height: auto;
}

EOF

echo "   ✅ Custom CSS untuk hide version telah ditambahkan"

# 4. SETUP DIREKTORI UNTUK LOGO CUSTOM
echo ""
echo "📁 Step 4: Setup direktori logo custom..."
mkdir -p ~/www/custom-logos
echo "   ✅ Direktori ~/www/custom-logos dibuat"

# 5. CLEAR CACHE
echo ""
echo "🧹 Step 5: Clear cache Dolibarr..."
rm -rf documents/admin/temp/* 2>/dev/null || true
echo "   ✅ Cache cleared"

# 6. INFO UPLOAD LOGO
echo ""
echo "🎯 LANGKAH SELANJUTNYA:"
echo "======================"
echo ""
echo "📤 UPLOAD LOGO BARU:"
echo "   1. Via Panel Alwaysdata File Manager:"
echo "      - Upload ke: /www/htdocs/theme/dolibarr_logo.png"
echo "      - Upload ke: /www/htdocs/theme/common/login_logo.png"
echo ""
echo "   2. Via SCP/SFTP:"
echo "      scp your-logo.png textileapp@ssh-textileapp.alwaysdata.net:www/htdocs/theme/dolibarr_logo.png"
echo "      scp your-login-logo.png textileapp@ssh-textileapp.alwaysdata.net:www/htdocs/theme/common/login_logo.png"
echo ""
echo "   3. Via wget (jika logo online):"
echo "      cd ~/www/htdocs/theme"
echo "      wget 'URL_LOGO_ANDA' -O dolibarr_logo.png"
echo "      cd common"
echo "      wget 'URL_LOGIN_LOGO_ANDA' -O login_logo.png"
echo ""
echo "💡 REKOMENDASI UKURAN LOGO:"
echo "   - Main Logo: 200x60px atau 150x50px (PNG/SVG)"
echo "   - Login Logo: 150x150px atau 200x200px (PNG)"
echo "   - Background: Transparent atau putih"
echo ""
echo "🔄 SETELAH UPLOAD:"
echo "   1. Refresh browser (Ctrl+F5)"
echo "   2. Clear browser cache"
echo "   3. Check login page dan dashboard"
echo ""
echo "✅ CUSTOMIZATION SCRIPT SELESAI!"
echo ""
echo "📁 BACKUP LOCATION:"
echo "   - Original logo: ~/www/htdocs/theme/dolibarr_logo_original.png"
echo "   - Original SVG: ~/www/htdocs/theme/dolibarr_logo_original.svg"
echo "   - Original login: ~/www/htdocs/theme/common/login_logo_original.png"