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
*/

require_once('string_escaping.libr.php');


function build_dependencies_notes(string $s_working_directory) : void {
  $s_subdir1 = $s_working_directory.'/build_and_checks_variables';
  $s_subdir2 = $s_subdir1.'/temp';
  $s_data_file_path = $s_subdir1.'/dependencies_data.json';
  $s_data = file_get_contents($s_data_file_path);
  $arr_data = json_decode($s_data, true);
  $s_result_content1 = '';
  $s_result_content2 = '';
  $s_result_content3 = '';

  foreach($arr_data as $arr_dependency){
    $s_URL_word = "URL";
    if(count($arr_dependency["URLs"]) > 1){
      $s_URL_word .= "s";
    }

    $s_result_content3 .= "<p>\n";

    $s_result_content1 .= (
      $arr_dependency["dependency_name"]
      ." can be found at the following "
      .$s_URL_word
      .":\n"
    );
    $s_result_content2 .= (
      $arr_dependency["dependency_name"]
      ." can be found at the following "
      .$s_URL_word
      .":\\newline\n"
    );
    $s_result_content3 .= (
      $arr_dependency["dependency_name"]
      ." can be found at the following "
      .$s_URL_word
      .":<br>\n"
    );

    for(
      $i = 0, $i_max = count($arr_dependency["URLs"]) - 1;
      $i <= $i_max;
      ++$i
    ){
      $mixed_URL = $arr_dependency["URLs"][$i];
      $s_comment = '';
      $s_URL = '';
      if(is_array($mixed_URL)){
        $s_URL = $mixed_URL["URL"];
        $s_comment = ' '.$mixed_URL["comment"];
      }
      else{
        $s_URL = $mixed_URL;
      }

      $s_result_content1 .= $s_URL.$s_comment."\n";

      if(strlen($s_URL) > 60){
        $s_result_content2 .= (
          "{\\small\n"
          .'  \url{'.$s_URL."}\n"
          .'}'
        );
      }
      else{
        $s_result_content2 .= '\url{'.$s_URL.'}';
      }
      if($i === $i_max){
        $s_result_content2 .= $s_comment.".\n";
      }
      else{
        $s_result_content2 .= $s_comment.",\\newline\n";
      }

      $s_result_content3 .= (
        "<a\n"
        .'href="'.string_escaping\HTML\escape_attribute($s_URL)."\"\n"
        .'><span style="font-family:monospace"'."\n"
        .'>'.string_escaping\HTML\escape_text($s_URL)."</span\n"
        .'></a>'
      );
      if($i === $i_max){
        $s_result_content3 .= $s_comment.".\n";
      }
      else{
        $s_result_content3 .= $s_comment.",<br>\n";
      }
    }

    $s_result_content1 .= "\n";
    $s_result_content2 .= "\n";
    $s_result_content3 .= "</p>\n\n";
  }

  // Add a "footer".
  $s_result_content1 .= (
    "If you see something that I missed regarding my dependencies,\n"
    ."please tell me/email me :).\n"
  );
  $s_result_content2 .= (
    "If you see something that I missed regarding my dependencies,\n"
    ."please tell me/email me :).\n"
  );
  $s_result_content3 .= (
    "<p>\n"
    ."If you see something that I missed regarding my dependencies,\n"
    .".please tell me/email me :).\n"
    ."</p>\n"
  );

  // We overwrite results if needed.
  $s_result_path1 = $s_subdir1.'/dependencies_notes.txt';
  $s_existing_result_content1 = file_get_contents($s_result_path1);
  if($s_result_content1 !== $s_existing_result_content1){
    file_put_contents($s_result_path1, $s_result_content1);
  }
  $s_result_path2 = $s_subdir2.'/dependencies_notes.tex';
  $s_existing_result_content2 = file_get_contents($s_result_path2);
  if($s_result_content2 !== $s_existing_result_content2){
    file_put_contents($s_result_path2, $s_result_content2);
  }
  $s_result_path3 = $s_subdir2.'/dependencies_notes.html';
  $s_existing_result_content3 = file_get_contents($s_result_path3);
  if($s_result_content3 !== $s_existing_result_content3){
    file_put_contents($s_result_path3, $s_result_content3);
  }
}

build_dependencies_notes($argv[1]);
