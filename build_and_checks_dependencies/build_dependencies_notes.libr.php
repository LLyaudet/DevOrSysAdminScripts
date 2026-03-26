#!/usr/bin/php
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

@category Library
@package DevOrSysAdminScripts
@author Laurent Lyaudet <laurent.lyaudet@gmail.com>
@copyright 2023-2026 Laurent Frédéric Bernard François Lyaudet
@license https://www.gnu.org/licenses/lgpl-3.0.html LGPLv3+
*/

declare(strict_types=1);
declare(encoding='UTF-8');

require_once 'string_escaping.libr.php';



/**
This function looks at the dependencies data found in a working directory,
and generate three files: a txt file, a TeX file (.sub),
and an HTML file (.sub) with the data in a nicer format.

@param string $s_working_directory The directory where the work must be
                                   done.

@return void
*/
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
    $s_URL_word = 'URL';
    if(count($arr_dependency['URLs']) > 1){
      $s_URL_word .= 's';
    }

    $s_result_content3 .= "<p>\n";

    $s_dependency1 = $arr_dependency['dependency_name'];
    $s_dependency2 = string_escaping\TeX\escape_text($s_dependency1);
    $s_dependency3 = string_escaping\HTML\escape_text($s_dependency1);

    $s_sentence_end = ' can be found at the following '.$s_URL_word.':';
    $s_result_content1 .= $s_dependency1.$s_sentence_end."\n";
    $s_result_content2 .= $s_dependency2.$s_sentence_end."\\newline\n";
    $s_result_content3 .= $s_dependency3.$s_sentence_end."<br>\n";

    for(
      $i = 0, $i_max = count($arr_dependency['URLs']) - 1;
      $i <= $i_max;
      ++$i
    ){
      $mixed_URL = $arr_dependency['URLs'][$i];
      $s_comment = '';
      $s_URL = '';
      if(is_array($mixed_URL)){
        $s_URL = $mixed_URL['URL'];
        $s_comment = ' '.$mixed_URL['comment'];
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
      $s_result_content2 .= string_escaping\TeX\escape_text($s_comment);
      if($i === $i_max){
        $s_result_content2 .= ".\n";
      }
      else{
        $s_result_content2 .= ",\\newline\n";
      }

      $s_result_content3 .= (
        "<a\n"
        .'href="'.string_escaping\HTML\escape_attribute($s_URL)."\"\n"
        ."><span style=\"font-family:monospace\"\n"
        .'>'.string_escaping\HTML\escape_text($s_URL)."</span\n"
        .'></a>'
      );
      $s_result_content3 .= string_escaping\HTML\escape_text($s_comment);
      if($i === $i_max){
        $s_result_content3 .= ".\n";
      }
      else{
        $s_result_content3 .= ",<br>\n";
      }
    }//end for urls

    $s_result_content1 .= "\n";
    $s_result_content2 .= "\n";
    $s_result_content3 .= "</p>\n\n";
  }//end foreach($arr_data as $arr_dependency)

  // Add a "footer".
  $s_closing_sentence = (
    "If you see something that I missed regarding my dependencies,\n"
    ."please tell me/email me :).\n"
  );
  $s_result_content1 .= $s_closing_sentence;
  $s_result_content2 .= $s_closing_sentence;
  $s_result_content3 .= "<p>\n".$s_closing_sentence."</p>\n";

  // We overwrite results if needed.
  $s_result_path1 = $s_subdir1.'/dependencies_notes.txt';
  $s_existing_result_content1 = '';
  if(file_exists($s_result_path1)){
    $s_existing_result_content1 = file_get_contents($s_result_path1);
  }
  if($s_result_content1 !== $s_existing_result_content1){
    file_put_contents($s_result_path1, $s_result_content1);
  }
  /*
  Example of generated content of dependencies_notes.txt:
  -------------------------------------------------------------------------
  more of util-linux can be found at the following URLs:
  https://www.kernel.org/pub/linux/utils/util-linux/
  https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/
  https://github.com/util-linux/util-linux official?
  -------------------------------------------------------------------------
  */
  $s_result_path2 = $s_subdir2.'/dependencies_notes.tex.sub';
  $s_existing_result_content2 = '';
  if(file_exists($s_result_path2)){
    $s_existing_result_content2 = file_get_contents($s_result_path2);
  }
  if($s_result_content2 !== $s_existing_result_content2){
    file_put_contents($s_result_path2, $s_result_content2);
  }
  /*
  Example of generated content of dependencies_notes.tex.sub:
  -------------------------------------------------------------------------
  more of util-linux can be found at the following URLs:\newline
  \url{https://www.kernel.org/pub/linux/utils/util-linux/},\newline
  {\small
    \url{https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/}
  },\newline
  \url{https://github.com/util-linux/util-linux} official?.
  -------------------------------------------------------------------------
  */
  $s_result_path3 = $s_subdir2.'/dependencies_notes.html.sub';
  $s_existing_result_content3 = '';
  if(file_exists($s_result_path3)){
    $s_existing_result_content3 = file_get_contents($s_result_path3);
  }
  if($s_result_content3 !== $s_existing_result_content3){
    file_put_contents($s_result_path3, $s_result_content3);
  }
  /*
  Example of generated content of dependencies_notes.html.sub:
  <p>
  more of util-linux can be found at the following URLs:<br>
  <a
  href="https://www.kernel.org/pub/linux/utils/util-linux/"
  ><span style="font-family:monospace"
  >https://www.kernel.org/pub/linux/utils/util-linux/</span
  ></a>,<br>
  <a
  href="https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/"
  ><span style="font-family:monospace"
  >https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/</span
  ></a>,<br>
  <a
  href="https://github.com/util-linux/util-linux"
  ><span style="font-family:monospace"
  >https://github.com/util-linux/util-linux</span
  ></a> official?.
  </p>
  */
}//end build_dependencies_notes()



build_dependencies_notes($argv[1]);
?>
