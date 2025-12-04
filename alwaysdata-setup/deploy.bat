@echo off
echo ===== Dolibarr Deployment Helper untuk Alwaysdata =====
echo.

REM Konfigurasi - Edit sesuai dengan akun Alwaysdata Anda
set FTP_HOST=ftp-textileapp.alwaysdata.net
set FTP_USER=textileapp
set FTP_REMOTE_DIR=/www

echo Preparing files for deployment...

REM Copy .htaccess ke htdocs
if exist "alwaysdata-setup\.htaccess" (
    copy "alwaysdata-setup\.htaccess" "htdocs\.htaccess"
    echo ✓ .htaccess copied to htdocs
)

REM Buat direktori temp untuk upload
if not exist "upload-package" mkdir "upload-package"

REM Copy htdocs ke package
echo Packaging htdocs...
robocopy "htdocs" "upload-package" /E /XD .git /XF *.log *.bak

echo.
echo ===== DEPLOYMENT INSTRUCTIONS =====
echo.
echo 1. Files are ready in 'upload-package' folder
echo 2. Upload contents of 'upload-package' to your Alwaysdata public_html
echo.
echo Using FTP/SFTP:
echo Host: %FTP_HOST%
echo User: %FTP_USER%
echo Remote Directory: %FTP_REMOTE_DIR%
echo.
echo 3. After upload, run setup check:
echo    https://[your-domain]/install/
echo.
echo 4. Don't forget to:
echo    - Create MySQL database in Alwaysdata panel
echo    - Note down database credentials
echo    - Run the installation wizard
echo.

REM Optional: Start WinSCP atau FileZilla jika tersedia
echo Would you like to start a FTP client?
echo.
echo Available options:
echo 1. Manual upload (recommended)
echo 2. Exit
echo.
set /p choice="Enter your choice (1-2): "

if "%choice%"=="1" (
    echo Please manually upload the 'upload-package' contents to your Alwaysdata account
    echo using your preferred FTP/SFTP client.
)

echo.
echo Deployment preparation completed!
echo Check DEPLOYMENT.md for detailed instructions.
pause