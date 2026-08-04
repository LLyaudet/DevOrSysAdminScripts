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

@category Library
@package DevOrSysAdminScripts
@author Laurent Lyaudet <laurent.lyaudet@gmail.com>
@copyright 2023-2026 Laurent Frédéric Bernard François Lyaudet
@license https://www.gnu.org/licenses/lgpl-3.0.html LGPLv3+
*/

declare(strict_types=1);
declare(encoding='UTF-8');



/**
The namespace DOSASfiles contain additional classes and functions
to deal with files.

@package DevOrSysAdminScripts
@subpackage DOSASfiles
*/
namespace DOSASfiles {

  final class FileData {
    static string $s_hash_function = "md5";

    public string $s_filepath;
    public string $s_dirname;
    public string $s_basename;
    public string $s_filename;
    public string $s_extension;
    public string $s_path_from_reference_directory;
    public int $i_size;
    public string $s_hash;
    public $s_content;
    // Status relative to another directory
    // At The Same Time (ATST)
    public bool $b_exists_with_same_relative_path_and_same_content; // ATST
    public bool $b_exists_with_same_relative_path;
    public bool $b_exists_with_same_content;

    public function __construct(
      string $s_filepath,
      string $s_reference_directory_path,
    ){
      $this->s_filepath = $s_filepath;
      $path_parts = pathinfo($this->s_filepath);
      $this->s_dirname = $path_parts['dirname'];
      $this->s_filename = $path_parts['filename'];
      $this->s_basename = $path_parts['basename'];
      $this->s_extension = $path_parts['extension'];
      $this->s_path_from_reference_directory = substr(
        $this->s_filepath,
        strlen($s_reference_directory_path),
      );
      $this->s_content = file_get_contents($this->s_filepath);
      $this->i_size = strlen($this->s_content);
      $this->s_hash = md5($this->s_content);
      $this->b_exists_with_same_relative_path_and_same_content = false;
      $this->b_exists_with_same_relative_path = false;
      $this->b_exists_with_same_content = false;
    }

    public function get_s_content(){
      if($this->i_size <= 0){
        return null;
      }
      if($this->s_content === null){
        $this->s_content = file_get_contents($this->s_filepath);
      }
      return $this->s_content;
    }
  }//end new FileData()




  /**
  Loads the data of files under a given directory,
  but doesn't keep the contents loaded.
  Recusivity is not implemented yet.

  @param string $s_dirpath The directory to search in.

  @return array
  */
  function load_files_data_under_directory(string $s_dirpath) : array {
    $arr_result = [
      "files_by_path_from_reference_directory" => [],
      "files_by_size" => [],
    ];
    $arr_s_paths = glob($s_dirpath."*");
    if($arr_s_paths === false){
      return $arr_result;
    }
    foreach($arr_s_paths as $s_filepath){
      $o_file_data = new FileData($s_filepath, $s_dirpath);
      $o_file_data->s_content = null;
      $arr_result["files_by_path_from_reference_directory"][
        $o_file_data->s_path_from_reference_directory
      ] = $o_file_data;
      if(!isset($arr_result["files_by_size"][$o_file_data->i_size])){
        $arr_result["files_by_size"][$o_file_data->i_size] = [];
      }
      if(
        !isset(
          $arr_result["files_by_size"][$o_file_data->i_size][
            $o_file_data->s_hash
          ]
        )
      ){
        $arr_result["files_by_size"][$o_file_data->i_size][
          $o_file_data->s_hash
        ] = [];
      }
      $arr_result["files_by_size"][$o_file_data->i_size][
        $o_file_data->s_hash
      ] []= $o_file_data;
    }
    return $arr_result;
  }//end load_files_data_under_directory()



  /**
  Loads the data of files under two given directories,
  but doesn't keep the contents loaded.
  And then compares the files under both directories.
  Recusivity is not implemented yet.

  @param string $s_source_dirpath The first directory to search in.
  @param string $s_dest_dirpath The second directory to search in.
  @param bool $b_compute_also_reverse_status
              If you want that the status of files under dest_dirpath
              must also be computed.

  @return array
  */
  function compare_files_under_directories(
    string $s_source_dirpath,
    string $s_dest_dirpath,
    bool $b_compute_also_reverse_status = false,
  ) : array {
    $arr_files_data_source = load_files_data_under_directory(
      $s_source_dirpath
    );
    $arr_files_data_dest = load_files_data_under_directory(
      $s_dest_dirpath
    );
    foreach(
      $arr_files_data_source["files_by_path_from_reference_directory"]
      as $o_file_data
    ){
      if(
        isset(
          $arr_files_data_dest["files_by_path_from_reference_directory"][
            $o_file_data->s_path_from_reference_directory
          ]
        )
      ){
        $o_file_data->b_exists_with_same_relative_path = true;
        $o_file_data2 = (
          $arr_files_data_dest["files_by_path_from_reference_directory"][
            $o_file_data->s_path_from_reference_directory
          ]
        );
        $o_file_data2->b_exists_with_same_relative_path = true;
        if(
          $o_file_data2->i_size === $o_file_data->i_size
          && $o_file_data2->s_hash === $o_file_data->s_hash
          && $o_file_data2->get_s_content()
          === $o_file_data->get_s_content()
        ){
          $o_file_data->b_exists_with_same_relative_path_and_same_content =
            true;
          $o_file_data->b_exists_with_same_content = true;
          $o_file_data2->b_exists_with_same_relative_path_and_same_content =
            true;
          $o_file_data2->b_exists_with_same_content = true;
          $o_file_data->s_content = null;
          $o_file_data2->s_content = null;
          continue;
        }
      }
      if(
        isset($arr_files_data_dest["files_by_size"][$o_file_data->i_size])
        && isset(
          $arr_files_data_dest["files_by_size"][$o_file_data->i_size][
            $o_file_data->s_hash
          ]
        )
      ){
        foreach(
          $arr_files_data_dest["files_by_size"][$o_file_data->i_size][
            $o_file_data->s_hash
          ]
          as $o_file_data2
        ){
          if(
            $o_file_data2->get_s_content()
            === $o_file_data->get_s_content()
          ){
            $o_file_data->b_exists_with_same_content = true;
            $o_file_data2->b_exists_with_same_content = true;
            $o_file_data->s_content = null;
            $o_file_data2->s_content = null;
            continue 2;
          }
        }
      }
    }//end foreach($arr_files_data_source[...] as $o_file_data)

    if($b_compute_also_reverse_status){
      foreach(
        $arr_files_data_dest["files_by_path_from_reference_directory"]
        as $o_file_data
      ){
        if(
          $o_file_data->b_exists_with_same_relative_path_and_same_content
        ){
          continue;
        }
        if(
          isset(
            $arr_files_data_source["files_by_size"][$o_file_data->i_size]
          )
          && isset(
            $arr_files_data_source["files_by_size"][$o_file_data->i_size][
              $o_file_data->s_hash
            ]
          )
        ){
          foreach(
            $arr_files_data_source["files_by_size"][$o_file_data->i_size][
              $o_file_data->s_hash
            ]
            as $o_file_data2
          ){
            if(
              $o_file_data2->get_s_content()
              === $o_file_data->get_s_content()
            ){
              $o_file_data->b_exists_with_same_content = true;
              $o_file_data->s_content = null;
              $o_file_data2->s_content = null;
              continue 2;
            }
          }
        }
      }//end foreach($arr_files_data_dest[...] as $o_file_data)
    }//end if($b_compute_also_reverse_status)

    return [
      "source_files_data" => $arr_files_data_source,
      "dest_files_data" => $arr_files_data_dest,
    ];
  }//end compare_files_under_directories()



  /**
  Archive some directory files into another directory.

  @param string $s_source_dirpath The source directory to search in.
  @param string $s_dest_dirpath The archive directory to move files in.
  @param bool $b_archive_if_missing_relative_filepath
  @param bool $b_archive_if_missing_content

  @return void
  */
  function archive_directory_into_another(
    string $s_source_dirpath,
    string $s_dest_dirpath,
    bool $b_archive_if_missing_relative_filepath,
    bool $b_archive_if_missing_content,
  ){
    $arr_files_data = compare_files_under_directories(
      $s_source_dirpath,
      $s_dest_dirpath,
    );
    foreach(
      $arr_files_data["source_files_data"][
        "files_by_path_from_reference_directory"
      ]
      as $o_file_data
    ){
      if(
        (
          $b_archive_if_missing_relative_filepath
          && !$o_file_data->b_exists_with_same_relative_path
        )
        ||
        (
          $b_archive_if_missing_content
          && !$o_file_data->b_exists_with_same_content
        )
      ){
        shell_exec(
          "cp --backup=numbered"
          ." '".preg_replace("/'/", "'\"'\"'", $o_file_data->s_filepath)."'"
          ." '".preg_replace("/'/", "'\"'\"'", $s_dest_dirpath)."'"
        );
      }
    }//end foreach($arr_files_data["source_files_data"][...] as $o_file_data)
  }//end archive_directory_into_another()
}//end namespace DOSASfiles




/*
$ php
<?php
require_once('files.libr.php');
var_dump(
  DOSASfiles\compare_files_under_directories(
    "/home/laurent/.config/libreoffice/4/user/backup/",
    "/home/laurent/Documents/LibreOfficeArchives/",
  )
);
DOSASfiles\archive_directory_into_another(
  "/home/laurent/.config/libreoffice/4/user/backup/",
  "/home/laurent/Documents/LibreOfficeArchives/",
  false,
  true,
);
*/
?>
