#!/usr/bin/php
<?php

/**
This file is part of DevOrSysAdminScripts.

DevOrSysAdminScripts is free software:
you can redistribute it and/or modify it
under the terms of the GNU Lesser General Public License
as published by the Free Software Foundation,
either version 3 of the License,
or (at your option) any later version.

DevOrSysAdminScripts is distributed
in the hope that it will be useful,
but WITHOUT ANY WARRANTY;
without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU Lesser General Public License for more details.

You should have received a copy of
the GNU Lesser General Public License
along with DevOrSysAdminScripts.
If not, see <https://www.gnu.org/licenses/>.

©Copyright 2023-2026 Laurent Frédéric Bernard François Lyaudet

@category Executable
@package DevOrSysAdminScripts
@author Laurent Lyaudet <laurent.lyaudet@gmail.com>
@copyright 2023-2026 Laurent Frédéric Bernard François Lyaudet
@license https://www.gnu.org/licenses/lgpl-3.0.html LGPLv3+
*/

declare(strict_types=1);
declare(encoding='UTF-8');

require_once 'files.libr.php';

if(PHP_SAPI !== 'cli'){
  fwrite(
    STDERR,
    "archive_libre_office_documents.exec.php must be run in a shell.\n",
  );
  die(1);
}

if(count($argv) < 3 || count($argv) > 4){
  fwrite(
    STDERR,
    "split_score.exec.php must be given 2 or 3 arguments.\n",
  );
  die(1);
}

DOSASfiles\archive_directory_into_another(
  '/home/'.$argv[1].'/.config/libreoffice/4/user/backup/',
  '/home/'.$argv[2].'/Documents/LibreOfficeArchives/',
  true,
  true,
  // Following argument is if you want same relative path and same content
  // at the same time.
  // This is in case you want to track when the file goes back to some
  // old state.
  isset($argv[3]) ? (bool) (int) $argv[3] : false,
  true,
  true,
  '\\.~\\d+~',
);
?>
