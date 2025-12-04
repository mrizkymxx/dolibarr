<?php
/**
 * Script untuk setup Dolibarr di Alwaysdata
 * Script ini membantu konfigurasi awal untuk deployment
 */

echo "=== Dolibarr Alwaysdata Setup Helper ===\n\n";

// Cek environment
echo "Checking PHP version...\n";
echo "PHP Version: " . phpversion() . "\n";

if (version_compare(phpversion(), '7.2.0', '<')) {
    echo "ERROR: PHP 7.2 or higher is required!\n";
    exit(1);
}

echo "✓ PHP version is compatible\n\n";

// Cek ekstensi PHP yang diperlukan
echo "Checking PHP extensions...\n";
$required_extensions = [
    'pdo',
    'pdo_mysql',
    'gd',
    'zip',
    'xml',
    'mbstring',
    'curl',
    'intl'
];

$missing_extensions = [];
foreach ($required_extensions as $ext) {
    if (extension_loaded($ext)) {
        echo "✓ $ext\n";
    } else {
        echo "✗ $ext (MISSING)\n";
        $missing_extensions[] = $ext;
    }
}

if (!empty($missing_extensions)) {
    echo "\nERROR: Missing required extensions: " . implode(', ', $missing_extensions) . "\n";
    echo "Please enable these extensions in your Alwaysdata PHP configuration.\n";
    exit(1);
}

echo "\n✓ All required PHP extensions are available\n\n";

// Cek direktori dan permission
echo "Checking directories and permissions...\n";

$dirs_to_check = [
    '../htdocs',
    '../htdocs/conf',
    '../htdocs/document',
    '../htdocs/custom',
];

foreach ($dirs_to_check as $dir) {
    if (is_dir($dir)) {
        echo "✓ Directory $dir exists\n";
        if (is_writable($dir)) {
            echo "  ✓ Writable\n";
        } else {
            echo "  ⚠ Not writable - may need permission adjustment\n";
        }
    } else {
        echo "✗ Directory $dir missing\n";
    }
}

// Buat file conf.php jika belum ada
$conf_file = '../htdocs/conf/conf.php';
if (!file_exists($conf_file)) {
    echo "\nCreating empty conf.php file...\n";
    if (touch($conf_file)) {
        chmod($conf_file, 0666);
        echo "✓ Created $conf_file\n";
    } else {
        echo "✗ Failed to create $conf_file\n";
    }
} else {
    echo "\n✓ conf.php already exists\n";
}

// Informasi database setup
echo "\n=== Database Configuration Info ===\n";
echo "For Alwaysdata, use these database settings:\n";
echo "- Host: mysql-[YOUR_USERNAME].alwaysdata.net\n";
echo "- Database: [YOUR_DATABASE_NAME]\n";
echo "- Username: [YOUR_USERNAME]\n";
echo "- Password: [YOUR_PASSWORD]\n";
echo "- Port: 3306 (default)\n\n";

// URL untuk instalasi
echo "=== Installation URL ===\n";
echo "After uploading to Alwaysdata, access:\n";
echo "https://[your-domain]/install/\n\n";

echo "=== Next Steps ===\n";
echo "1. Upload 'htdocs' folder to your Alwaysdata public_html\n";
echo "2. Create MySQL database in Alwaysdata panel\n";
echo "3. Access the installation URL in your browser\n";
echo "4. Follow the installation wizard\n";
echo "5. After installation, delete or rename 'install' folder\n";
echo "6. Set conf.php permissions to 644\n\n";

echo "Setup check completed!\n";
?>