#!/bin/bash
# =============================================================================
# SCRIPT SETUP STRUKTUR DOLIBARR YANG BENAR UNTUK ALWAYSDATA
# =============================================================================
# Struktur yang benar:
# ~/www/
# ├── htdocs/              <- Web application (domain pointing ke sini)
# ├── scripts/             <- Maintenance tools (di level www)
# └── alwaysdata-setup/    <- Hosting configs (di level www)
# =============================================================================

set -e

echo "🚀 SETUP STRUKTUR DOLIBARR YANG BENAR"
echo "===================================="

# Pastikan di direktori www
cd ~/www

# Bersihkan struktur lama jika ada
echo "🧹 Membersihkan struktur lama..."
rm -rf htdocs scripts alwaysdata-setup README.md dolibarr temp-dolibarr

# Clone repository
echo "📥 Clone repository dari GitHub..."
git clone https://github.com/mrizkymxx/dolibarr.git temp-dolibarr

# Setup struktur yang benar
echo "📁 Setup struktur folder..."

# Buat folder htdocs
mkdir -p htdocs

# Pindahkan isi htdocs dari repo ke ~/www/htdocs
echo "   - Memindahkan aplikasi web ke htdocs..."
mv temp-dolibarr/htdocs/* htdocs/
mv temp-dolibarr/htdocs/.htaccess htdocs/ 2>/dev/null || true

# Pindahkan scripts ke level www (bukan ke htdocs)
echo "   - Memindahkan scripts ke ~/www..."
mv temp-dolibarr/scripts ./

# Pindahkan alwaysdata-setup ke level www
echo "   - Memindahkan alwaysdata-setup ke ~/www..."
mv temp-dolibarr/alwaysdata-setup ./

# Pindahkan dokumentasi
mv temp-dolibarr/README.md ./
mv temp-dolibarr/DEPLOYMENT-GUIDE.md ./ 2>/dev/null || true

# Hapus folder temporary
rm -rf temp-dolibarr

# Setup konfigurasi
echo "⚙️  Setup konfigurasi..."

# Copy .htaccess optimasi Alwaysdata
cp alwaysdata-setup/htdocs/.htaccess htdocs/

# Buat direktori yang diperlukan
mkdir -p htdocs/documents
mkdir -p htdocs/conf

# Set permissions
chmod 755 htdocs/documents
chmod 755 htdocs/conf
chmod 755 scripts
chmod 644 htdocs/.htaccess

echo "✅ SETUP SELESAI!"
echo ""
echo "📁 STRUKTUR YANG DIBUAT:"
echo "~/www/"
echo "├── htdocs/              <- Web application (domain point ke sini)"
echo "│   ├── index.php"
echo "│   ├── install/"
echo "│   ├── documents/"
echo "│   ├── conf/"
echo "│   └── .htaccess"
echo "├── scripts/             <- Maintenance tools"
echo "├── alwaysdata-setup/    <- Hosting configs"
echo "└── README.md"
echo ""
echo "🌐 PANEL ALWAYSDATA SETTING:"
echo "   Root directory: /www/htdocs"
echo ""
echo "🚀 AKSES:"
echo "   Website: https://your-domain.com/"
echo "   Installer: https://your-domain.com/install/"
echo ""

# Verifikasi
echo "🔍 VERIFIKASI STRUKTUR:"
ls -la ~/www/
echo ""
echo "📂 ISI HTDOCS:"
ls -la ~/www/htdocs/ | head -10