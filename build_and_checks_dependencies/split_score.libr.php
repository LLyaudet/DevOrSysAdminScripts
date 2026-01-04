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
"split_line_at_most.libr.php"
to
"split_score.libr.php".
This file was renamed from "split_line_at_most.php" to
"split_line_at_most.libr.php".
*/

function generate_split_score(
  $b_after_before,
  $i_max_length,
  $a_delimiter_strings_domain,
){
  return function(
    $s_delimiter_string,
    $i_cut_position,
    $b_is_cut_after,
  ) use ($b_after_before, $i_max_length, $s_delimiter_strings_domain){
    if(
      !in_array(
        $s_delimiter_string, $s_delimiter_strings_domain, true
      )
    ){
      // I do not handle regexps for the moment.
      // I'm too brainfucked. I just want to finish this feature fast
      // for HTML and Tex/PDF listings generation with HTML and Tex on
      // at most 70 characters.
      return 0;
    }
    if($b_is_cut_after === $b_after_before){
      // When $b_after_before,
      // always way better to cut after '/' than before it.
      // When !$b_after_before (aka before_after),
      // always way better to cut before '/' than after it.
      return 1 + $i_max_length + $i_cut_position;
    }
    return 1 + $i_cut_position;
  };
}
