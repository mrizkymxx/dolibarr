# =============================================================================
# PANDUAN CUSTOMIZATION DOLIBARR LOGO DAN VERSI
# =============================================================================

## 1. GANTI LOGO UTAMA DOLIBARR

### File Logo yang Perlu Diganti:
```
~/www/htdocs/theme/dolibarr_logo.png          <- Logo utama (150x50px)
~/www/htdocs/theme/dolibarr_logo.svg          <- Logo SVG (vector)
~/www/htdocs/theme/dolibarr_256x256_color.png <- Logo icon (256x256px)
~/www/htdocs/theme/dolibarr_512x512_white.png <- Logo putih (512x512px)
```

### Command untuk Replace Logo:
```bash
# Backup logo original
cd ~/www/htdocs/theme
cp dolibarr_logo.png dolibarr_logo_original.png
cp dolibarr_logo.svg dolibarr_logo_original.svg

# Upload logo baru Anda (via panel file manager atau scp)
# Atau gunakan wget jika logo ada online:
# wget "URL_LOGO_ANDA.png" -O dolibarr_logo.png
# wget "URL_LOGO_ANDA.svg" -O dolibarr_logo.svg
```

## 2. GANTI LOGO LOGIN PAGE

### File untuk Login Page:
```
~/www/htdocs/theme/common/login_logo.png      <- Logo login page
~/www/htdocs/theme/eldy/img/logo_setup.svg    <- Logo setup/installer
```

### Command untuk Replace:
```bash
cd ~/www/htdocs/theme/common
cp login_logo.png login_logo_original.png

# Upload logo login baru
# wget "URL_LOGIN_LOGO.png" -O login_logo.png
```

## 3. HAPUS/GANTI VERSI "23.0.0-beta"

### Option 1: Edit File Version
```bash
# Edit file versi utama
cd ~/www/htdocs
nano version.inc.php

# Cari line yang berisi DOL_VERSION dan ubah
# Dari: define('DOL_VERSION', '23.0.0-beta');
# Ke:   define('DOL_VERSION', 'Enterprise');
```

### Option 2: Hide Version dari Login
```bash
# Edit template login untuk hide versi
cd ~/www/htdocs/core/login
nano tpl/login.tpl.php

# Cari dan comment/hapus line yang menampilkan versi
```

### Option 3: Custom CSS untuk Hide Version
```bash
# Tambahkan CSS custom untuk hide version text
cd ~/www/htdocs/theme/
nano custom.css.php

# Tambahkan:
echo "
.loginpagedomainlogo {
    display: none !important;
}
.version {
    display: none !important;
}
" >> custom.css.php
```

## 4. SCRIPT OTOMATIS CUSTOMIZATION

### Download dan Run Script:
```bash
cd ~/www
wget https://raw.githubusercontent.com/mrizkymxx/dolibarr/master/customize-dolibarr.sh
chmod +x customize-dolibarr.sh
./customize-dolibarr.sh
```

## 5. UPLOAD LOGO VIA PANEL ALWAYSDATA

### Method Upload via File Manager:
1. Login panel Alwaysdata
2. Go to "Files" section  
3. Navigate to /www/htdocs/theme/
4. Upload logo files:
   - dolibarr_logo.png (150x50px recommended)
   - dolibarr_logo.svg (vector format)
   - login_logo.png (for login page)

### Format Logo yang Disarankan:
- **Main Logo:** PNG/SVG, 150x50px atau 200x60px
- **Login Logo:** PNG, 150x150px atau 200x200px  
- **Icon:** PNG, 64x64px, 128x128px, 256x256px
- **Background:** Transparent/white

## 6. VERIFIKASI PERUBAHAN

### Clear Cache:
```bash
# Clear Dolibarr cache
rm -rf ~/www/htdocs/documents/admin/temp/*
```

### Test Changes:
1. Refresh browser (Ctrl+F5)
2. Check login page
3. Check main dashboard
4. Verify logo appears correctly

## 7. ADVANCED: CUSTOM THEME

### Membuat Theme Custom:
```bash
cd ~/www/htdocs/theme
cp -r eldy mytheme
cd mytheme
# Edit style.css.php untuk custom styling
# Edit theme_vars.inc.php untuk custom variables
```