<?php
/**
 * Copyright (c) 2023 Eric Seigne <eric.seigne@cap-rel.fr>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

if (!defined('NOREQUIRESOC')) {
	define('NOREQUIRESOC', '1');
}
//if (! defined('NOREQUIRETRAN')) define('NOREQUIRETRAN','1');	// Not disabled because need to do translations
if (!defined('NOCSRFCHECK')) {
	define('NOCSRFCHECK', 1);
}
if (!defined('NOTOKENRENEWAL')) {
	define('NOTOKENRENEWAL', 1);
}
if (!defined('NOLOGIN')) {
	define('NOLOGIN', 1); // File must be accessed by logon page so without login.
}
if (!defined('NOREQUIREHTML')) {
	define('NOREQUIREHTML', 1);
}
if (!defined('NOREQUIREAJAX')) {
	define('NOREQUIREAJAX', '1');
}

session_cache_limiter('public');

require_once __DIR__.'/../main.inc.php'; // __DIR__ allow this script to be included in custom themes
/**
 * @var string $dolibarr_nocache
 */
require_once DOL_DOCUMENT_ROOT.'/core/lib/functions2.lib.php';

// Define css type
top_httphead('text/css');
// Important: Following code is to avoid page request by browser and PHP CPU at each Dolibarr page access.
if (empty($dolibarr_nocache)) {
	header('Cache-Control: max-age=10800, public, must-revalidate');
} else {
	header('Cache-Control: no-cache');
}


print '/* Here, the content of the common custom CSS defined into Home - Setup - Display - CSS'."*/\n";
print getDolGlobalString('MAIN_IHM_CUSTOM_CSS');

/* Custom CSS untuk Enterprise ERP - Hide version dan custom styling */
print "
/* Hide Dolibarr version text di login */
.login-dolibarr-logo-version {
    display: none !important;
}

.version-text {
    display: none !important;
}

.dolibarr-version {
    display: none !important;
}

/* Hide version info di footer */
.center.version {
    display: none !important;
}

/* Custom styling untuk logo */
.loginboxlogo img {
    max-width: 250px;
    height: auto;
}

/* Custom header styling */
.tmenu {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

/* Custom login box */
.login_block {
    border-radius: 10px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.3);
}
";
