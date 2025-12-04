#!/bin/bash
# =============================================================================
# SCRIPT PEMBERSIHAN DAN DEPLOYMENT ULANG DOLIBARR DI ALWAYSDATA
# =============================================================================
# Script ini akan:
# 1. Membersihkan file-file yang tercampur di www
# 2. Clone ulang repository dengan struktur yang benar
# 3. Setup file konfigurasi untuk Alwaysdata
# =============================================================================

set -e  # Exit on any error

echo "🚀 MEMULAI PEMBERSIHAN DAN DEPLOYMENT ULANG DOLIBARR"
echo "=================================================="

# Fungsi untuk konfirmasi
confirm() {
    read -p "$1 (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "❌ Dibatalkan oleh user"
        exit 1
    fi
}

# 1. BACKUP FILE PENTING (jika ada)
echo "📦 STEP 1: Backup file konfigurasi yang ada..."
cd ~/www
if [ -f "conf/conf.php" ]; then
    echo "   - Backing up conf.php..."
    cp conf/conf.php ~/conf_backup.php
    echo "   ✅ conf.php di-backup ke ~/conf_backup.php"
fi

# 2. BERSIHKAN DIREKTORI WWW
echo ""
echo "🧹 STEP 2: Membersihkan direktori www..."
confirm "⚠️  Ini akan menghapus semua file Dolibarr di ~/www. Lanjutkan?"

# Daftar folder dan file Dolibarr yang akan dihapus
DOLIBARR_FOLDERS=(
    "htdocs" "scripts" "alwaysdata-setup" "adherents" "admin" "ai" "api" "asset" 
    "asterisk" "barcode" "blockedlog" "bom" "bookcal" "bookmarks" "categories" 
    "collab" "comm" "commande" "compta" "contact" "contrat" "core" "cron" 
    "datapolicy" "dav" "debugbar" "delivery" "don" "ecm" "emailcollector" 
    "eventorganization" "expedition" "expensereport" "exports" "fichinter" 
    "fourn" "ftp" "holiday" "hrm" "imports" "intracommreport" "knowledgemanagement" 
    "langs" "loan" "mailmanspip" "margin" "modulebuilder" "mrp" "multicurrency" 
    "opensurvey" "partnership" "paybox" "paypal" "printing" "product" "projet" 
    "public" "reception" "recruitment" "resource" "salaries" "societe" "stripe" 
    "subtotals" "supplier_proposal" "takepos" "theme" "ticket" "user" "variants" 
    "webhook" "webportal" "webservices" "website" "workstation" "zapier" "conf"
)

DOLIBARR_FILES=(
    "favicon.ico" "main.inc.php" "master.inc.php" "filefunc.inc.php" "robots.txt" 
    "security.txt" "version.inc.php" "viewimage.php" "waf.inc.php" "index.php" 
    "document.php" "README.md" "DEPLOYMENT-GUIDE.md" "SSH_DEPLOYMENT_READY.md"
)

# Hapus folder
for folder in "${DOLIBARR_FOLDERS[@]}"; do
    if [ -d "$folder" ]; then
        echo "   - Menghapus folder: $folder"
        rm -rf "$folder"
    fi
done

# Hapus file
for file in "${DOLIBARR_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "   - Menghapus file: $file"
        rm -f "$file"
    fi
done

# Hapus folder .git jika ada
if [ -d ".git" ]; then
    echo "   - Menghapus folder .git"
    rm -rf ".git"
fi

echo "   ✅ Pembersihan selesai!"

# 3. CLONE REPOSITORY DENGAN BENAR
echo ""
echo "📥 STEP 3: Clone repository Dolibarr..."
cd ~/www

# Clone ke folder dolibarr
echo "   - Cloning dari GitHub..."
git clone https://github.com/mrizkymxx/dolibarr.git dolibarr

if [ ! -d "dolibarr" ]; then
    echo "❌ ERROR: Gagal clone repository!"
    exit 1
fi

echo "   ✅ Repository berhasil di-clone ke ~/www/dolibarr/"

# 4. SETUP KONFIGURASI ALWAYSDATA
echo ""
echo "⚙️  STEP 4: Setup konfigurasi untuk Alwaysdata..."

cd ~/www/dolibarr

# Copy .htaccess untuk optimasi Alwaysdata
if [ -f "alwaysdata-setup/htdocs/.htaccess" ]; then
    echo "   - Menyalin .htaccess ke htdocs..."
    cp "alwaysdata-setup/htdocs/.htaccess" "htdocs/.htaccess"
    echo "   ✅ .htaccess ter-setup"
fi

# Setup direktori documents dan conf
echo "   - Membuat direktori yang diperlukan..."
mkdir -p htdocs/documents
mkdir -p htdocs/conf

# Set permissions
echo "   - Mengatur permissions..."
chmod 755 htdocs/documents
chmod 755 htdocs/conf
chmod 644 htdocs/.htaccess 2>/dev/null || true

echo "   ✅ Konfigurasi dasar selesai!"

# 5. RESTORE BACKUP KONFIGURASI
echo ""
echo "🔄 STEP 5: Restore konfigurasi yang di-backup..."
if [ -f "~/conf_backup.php" ]; then
    echo "   - Restoring conf.php..."
    cp ~/conf_backup.php htdocs/conf/conf.php
    chmod 644 htdocs/conf/conf.php
    echo "   ✅ conf.php ter-restore"
else
    echo "   ℹ️  Tidak ada backup konfigurasi, akan setup dari awal"
fi

# 6. INFORMASI FINAL
echo ""
echo "🎉 PEMBERSIHAN DAN DEPLOYMENT SELESAI!"
echo "====================================="
echo ""
echo "📁 STRUKTUR FOLDER YANG BENAR:"
echo "   ~/www/"
echo "   └── dolibarr/              <- Repository folder"
echo "       ├── htdocs/            <- Web application (point domain di sini)"
echo "       ├── scripts/           <- Maintenance tools"
echo "       ├── alwaysdata-setup/  <- Hosting configs"
echo "       └── README.md          <- Documentation"
echo ""
echo "🌐 LANGKAH SELANJUTNYA:"
echo "   1. Buka panel Alwaysdata"
echo "   2. Setup domain/subdomain pointing ke: /www/dolibarr/htdocs"
echo "   3. Buat database MySQL/MariaDB"
echo "   4. Akses https://your-domain.com/install/ untuk setup"
echo ""
echo "📋 INFO PENTING:"
echo "   - Web root: ~/www/dolibarr/htdocs"
echo "   - Documents: ~/www/dolibarr/htdocs/documents"
echo "   - Config: ~/www/dolibarr/htdocs/conf/conf.php"
echo ""
echo "✅ Siap untuk deployment!"