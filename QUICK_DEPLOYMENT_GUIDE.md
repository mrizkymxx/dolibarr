# 🎯 QUICK DEPLOYMENT GUIDE - CUSTOMIZED DOLIBARR
# ================================================

## 📥 PULL CHANGES KE SERVER ALWAYSDATA

```bash
# 1. Login SSH ke Alwaysdata
ssh textileapp@ssh-textileapp.alwaysdata.net

# 2. Masuk ke direktori htdocs
cd ~/www/htdocs

# 3. Pull latest changes dari GitHub
git pull origin master

# 4. Clear cache Dolibarr
rm -rf documents/admin/temp/*

# 5. Set permissions jika diperlukan
chmod 644 filefunc.inc.php version.inc.php theme/custom.css.php
```

## 🎨 UPLOAD LOGO CUSTOM (Setelah Git Pull)

### Via Panel Alwaysdata:
1. Login panel Alwaysdata
2. Go to "Files" section
3. Navigate: `/www/htdocs/theme/`
4. Upload & replace:
   - `dolibarr_logo.png` (main logo - 200x60px)
   - `common/login_logo.png` (login logo - 150x150px)
   - `dolibarr_256x256_color.png` (icon - 256x256px)

### Via SSH (jika logo sudah uploaded ke server):
```bash
cd ~/www/htdocs/theme

# Replace dengan logo Anda
cp /path/to/your/main-logo.png dolibarr_logo.png
cp /path/to/your/login-logo.png common/login_logo.png
cp /path/to/your/icon.png dolibarr_256x256_color.png

# Set permissions
chmod 644 dolibarr_logo.png common/login_logo.png dolibarr_256x256_color.png
```

## ✅ HASIL CUSTOMIZATION:

1. ❌ **"Dolibarr 23.0.0-beta" HILANG**
2. ✅ **App title: "Enterprise ERP"** 
3. ✅ **Version: "23.0.0" (tanpa beta)**
4. ✅ **Custom CSS: Rounded login, gradient header**
5. 🔄 **Logo: Siap diganti setelah upload**

## 🔄 AFTER LOGO UPLOAD:

1. **Refresh browser** (Ctrl+F5)
2. **Check login page** - logo baru muncul
3. **Check dashboard** - header dengan logo baru
4. **Verify version text** - tidak ada "beta"

## 🎯 QUICK ACCESS:

- **Website:** https://your-domain.com/
- **Login:** User yang dibuat saat install
- **Admin Panel:** Setup > Display untuk customization lebih lanjut

## 📞 TROUBLESHOOTING:

- Jika logo tidak muncul: Clear browser cache
- Jika version masih beta: Restart PHP atau clear Dolibarr cache
- Jika CSS tidak apply: Check file permissions (644)