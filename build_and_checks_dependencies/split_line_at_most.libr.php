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

©Copyright 2023-2024 Laurent Frédéric Bernard François Lyaudet
This file was renamed from "split_line_at_most.php" to
"split_line_at_most.libr.php".
*/

function generate_split_score_after_before(
  $max_length,
  $delimiter_strings_domain,
){
  return function(
    $delimiter_string,
    $cut_position,
    $is_cut_after,
  ) use ($max_length, $delimiter_strings_domain){
    if(!in_array($delimiter_string, $delimiter_strings_domain, true)){
      // I do not handle regexps for the moment.
      // I'm too brainfucked. I just want to finish this feature fast
      // for HTML and Tex/PDF listings generation with HTML and Tex on
      // at most 70 characters.
      return -1;
    }
    if($is_cut_after){
      return $max_length + $cut_position;
    }
    return $cut_position;
  };
}



function generate_split_score_before_after(
  $max_length,
  $delimiter_strings_domain,
){
  return function(
    $delimiter_string,
    $cut_position,
    $is_cut_after,
  ) use ($max_length, $delimiter_strings_domain){
    if(!in_array($delimiter_string, $delimiter_strings_domain, true)){
      // I do not handle regexps for the moment.
      // I'm too brainfucked. I just want to finish this feature fast
      // for HTML and Tex/PDF listings generation with HTML and Tex on
      // at most 70 characters.
      return -1;
    }
    if(!$is_cut_after){
      return $max_length + $cut_position;
    }
    return $cut_position;
  };
}

