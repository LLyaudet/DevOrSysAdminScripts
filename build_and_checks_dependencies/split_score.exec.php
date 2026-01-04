#!/usr/bin/php
<?php
/*
This file is part of DevOrSysAdminScripts library.

DevOrSysAdminScripts is free software:
you can redistribute it and/or modify it under the terms
of the GNU Lesser General Public License
as published by the Free Software Foundation,
either version 3 of the License,
or (at your option) any later version.

DevOrSysAdminScripts is distributed in the hope
that it will be useful,
but WITHOUT ANY WARRANTY;
without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU Lesser General Public License for more details.

You should have received a copy of
the GNU Lesser General Public License
along with DevOrSysAdminScripts.
If not, see <https://www.gnu.org/licenses/>.

©Copyright 2023-2026 Laurent Frédéric Bernard François Lyaudet
2026-01-04T13:38+01:00: This file was renamed from
"split_line_at_most.exec.php"
to
"split_score.exec.php".
This file was renamed from
"call_split_score_after_before_or_before_after.exec.php" to
"split_line_at_most.exec.php".
This file was renamed from
"call_split_score_after_before_or_before_after.php" to
"call_split_score_after_before_or_before_after.exec.php".
*/

require_once('./build_and_checks_dependencies/split_score.libr.php');

/*
php -r\
 $'require_once(\'./build_and_checks_dependencies/'\
$'split_score.libr.php\');'\
$' echo(generate_split_score'\
$'(true, 70, [\'/\'])(\'/\', 60, true));'
*/

echo(
  generate_split_score(
    (bool) $argv[1], (int) $argv[2], explode(',', $argv[3]),
  )($argv[4], (int) $argv[5], (bool) $argv[6])
);
