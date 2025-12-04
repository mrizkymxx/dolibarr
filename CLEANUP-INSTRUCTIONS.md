# =============================================================================
# DOLIBARR ALWAYSDATA CLEANUP & REDEPLOY SCRIPT
# =============================================================================
# 
# CARA PENGGUNAAN:
# 1. Copy script cleanup-and-redeploy.sh ke server Alwaysdata
# 2. Jalankan script untuk membersihkan dan deploy ulang dengan benar
#
# =============================================================================

## METODE 1: Copy-Paste Script (Paling Mudah)

# Login ke SSH Alwaysdata Anda:
ssh textileapp@ssh-textileapp.alwaysdata.net

# Buat file script baru:
nano ~/cleanup-dolibarr.sh

# Copy-paste isi dari file cleanup-and-redeploy.sh ke nano editor
# Simpan dengan Ctrl+X, Y, Enter

# Beri permission execute:
chmod +x ~/cleanup-dolibarr.sh

# Jalankan script:
./cleanup-dolibarr.sh

## METODE 2: Download Script Langsung

# Login SSH dan download:
ssh textileapp@ssh-textileapp.alwaysdata.net
cd ~
wget https://raw.githubusercontent.com/mrizkymxx/dolibarr/master/cleanup-and-redeploy.sh -O cleanup-dolibarr.sh
chmod +x cleanup-dolibarr.sh
./cleanup-dolibarr.sh

## METODE 3: Manual Command (Jika Script Tidak Bisa Digunakan)

# 1. Login SSH
ssh textileapp@ssh-textileapp.alwaysdata.net

# 2. Backup konfigurasi existing (jika ada)
cd ~/www
if [ -f "conf/conf.php" ]; then cp conf/conf.php ~/conf_backup.php; fi

# 3. Bersihkan semua file Dolibarr di www
cd ~/www
rm -rf htdocs scripts alwaysdata-setup adherents admin ai api asset asterisk barcode blockedlog bom bookcal bookmarks categories collab comm commande compta contact contrat core cron datapolicy dav debugbar delivery don ecm emailcollector eventorganization expedition expensereport exports fichinter fourn ftp holiday hrm imports intracommreport knowledgemanagement langs loan mailmanspip margin modulebuilder mrp multicurrency opensurvey partnership paybox paypal printing product projet public reception recruitment resource salaries societe stripe subtotals supplier_proposal takepos theme ticket user variants webhook webportal webservices website workstation zapier conf .git

rm -f favicon.ico main.inc.php master.inc.php filefunc.inc.php robots.txt security.txt version.inc.php viewimage.php waf.inc.php index.php document.php README.md DEPLOYMENT-GUIDE.md SSH_DEPLOYMENT_READY.md

# 4. Clone ulang dengan struktur yang benar
cd ~/www
git clone https://github.com/mrizkymxx/dolibarr.git dolibarr

# 5. Setup konfigurasi
cd ~/www/dolibarr
cp alwaysdata-setup/htdocs/.htaccess htdocs/.htaccess
mkdir -p htdocs/documents htdocs/conf
chmod 755 htdocs/documents htdocs/conf

# 6. Restore backup (jika ada)
if [ -f "~/conf_backup.php" ]; then cp ~/conf_backup.php htdocs/conf/conf.php; fi

# 7. Verifikasi struktur
ls -la ~/www/dolibarr/

## HASIL YANG DIHARAPKAN:

# Struktur folder yang benar:
#   ~/www/
#   └── dolibarr/              <- Repository
#       ├── htdocs/            <- Web app (point domain ke sini)
#       │   ├── index.php
#       │   ├── install/
#       │   ├── documents/
#       │   ├── conf/
#       │   └── .htaccess
#       ├── scripts/           <- Tools
#       ├── alwaysdata-setup/  <- Configs
#       └── README.md

## SETUP DOMAIN DI ALWAYSDATA:

# 1. Login ke panel Alwaysdata
# 2. Pergi ke "Web > Sites"
# 3. Edit/Tambah site
# 4. Set root directory ke: /www/dolibarr/htdocs
# 5. Save dan tunggu propagasi

## DATABASE SETUP:

# 1. Buat database MySQL/MariaDB di panel Alwaysdata
# 2. Catat: hostname, database name, username, password
# 3. Akses https://your-domain.com/install/ untuk setup Dolibarr

## TROUBLESHOOTING:

# Jika ada error permission:
find ~/www/dolibarr -type d -exec chmod 755 {} \;
find ~/www/dolibarr -type f -exec chmod 644 {} \;
chmod 755 ~/www/dolibarr/htdocs/documents

# Jika installer tidak muncul:
# - Pastikan domain pointing ke /www/dolibarr/htdocs
# - Cek file htdocs/index.php ada
# - Cek .htaccess readable

# Jika ada error database:
# - Pastikan database sudah dibuat di panel Alwaysdata
# - Gunakan hostname yang benar (biasanya mysql-textileapp.alwaysdata.net)
# - Test koneksi database di installer