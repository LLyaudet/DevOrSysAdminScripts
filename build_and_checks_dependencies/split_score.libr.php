<?php

/**
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

@category Library
@package DevOrSysAdminScripts
@author Laurent Lyaudet <laurent.lyaudet@gmail.com>
@copyright 2023-2026 Laurent Frédéric Bernard François Lyaudet
@license https://www.gnu.org/licenses/lgpl-3.0.html LGPLv3+
*/

declare(strict_types=1);
declare(encoding='UTF-8');



/**
Given the 3 following arguments, this function returns a closure that can
be used to compute the split score given the current string
(hopefully matching a delimiter), the current cut/split position,
and if that split position is after or before the current string.

@param bool          $b_larger_after
                     Score is larger when splitting after,
                     previous name of this parameter was $b_after_before.
@param int           $i_max_length
                     The maximum length allowed (goal length).
@param array<string> $a_delimiter_strings_domain
                     An array of "delimiters".

@return \Closure {
  The "split_score" closure to use repeatedly afterward.

  @param string $s_delimiter_string The string tested to be a delimiter.
  @param int    $i_cut_position     The offset of the cut in the string.
  @param bool   $b_is_cut_after     Is the offset taken after the string?

  @return int The split score.
}
*/
function generate_split_score(
  bool $b_larger_after,
  int $i_max_length,
  array $a_delimiter_strings_domain,
) : Closure {
  return function (
    string $s_delimiter_string,
    int $i_cut_position,
    bool $b_is_cut_after,
  ) use (
    $b_larger_after,
    $i_max_length,
    $a_delimiter_strings_domain,
  ) : int {
    if(
      !in_array(
        $s_delimiter_string,
        $a_delimiter_strings_domain,
        true,
      )
    ){
      // I do not handle regexps for the moment.
      // I'm too brainfucked. I just want to finish this feature fast
      // for HTML and Tex/PDF listings generation with HTML and Tex on
      // at most 70 characters.
      return 0;
    }
    if($b_is_cut_after === $b_larger_after){
      // When $b_larger_after,
      // always way better to cut after '/' than before it.
      // When !$b_larger_after (aka larger_before),
      // always way better to cut before '/' than after it.
      return 1 + $i_max_length + $i_cut_position;
    }
    return 1 + $i_cut_position;
  };
}//end generate_split_score()
?>
