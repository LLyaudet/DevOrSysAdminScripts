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

  use Exception;




  /**
  Kind of a "dataclass" to keep the informations related with a file,
  slightly enhanced with:
  - a constructor that extract the distinct parts of the filepath;
  - a method/getter handling the file content loading.

  @category Library
  @package DevOrSysAdminScripts
  @subpackage DOSASfiles
  @class FileData
  @author Laurent Lyaudet <laurent.lyaudet@gmail.com>
  @license https://www.gnu.org/licenses/lgpl-3.0.html LGPLv3+
  */
  final class FileData {
    /**
    The hash function to use for file contents.

    @var string $s_hash_function
    */
    public static string $s_hash_function = 'md5';

    /**
    The filepath of the file.
    https://www.youtube.com/watch?v=2NRlZ1ZME5U
    Why?
    https://github.com/squizlabs/PHP_CodeSniffer/issues/258

    @var string $s_filepath
    */
    public string $s_filepath;

    /**
    The dirname of the filepath.

    @var string $s_dirname
    */
    public string $s_dirname;

    /**
    The basename of the filepath.

    @var string $s_basename
    */
    public string $s_basename;

    /**
    The filename of the basename.

    @var string $s_filename
    */
    public string $s_filename;

    /**
    The extension of the basename.

    @var string $s_extension
    */
    public string $s_extension;

    /**
    The filesubpath starting from a reference directory.

    @var string $s_path_from_reference_directory
    */
    public string $s_path_from_reference_directory;

    /**
    The size of the content of the file.

    @var int $i_size
    */
    public int $i_size;

    /**
    The hash of the content of the file.

    @var string $s_hash
    */
    public string $s_hash;

    /**
    The content of the file as a string.

    @var string $s_content
    */
    public $s_content;

    /**
    Statuses relative to another directory : 1.

    Does the file exists with same relative path and same content
    At The Same Time (ATST)?

    @var bool $b_exists_with_same__relative_path_and_content
    */
    public bool $b_exists_with_same__relative_path_and_content; // ATST

    /**
    Statuses relative to another directory : 2.

    Does the file exists with same relative path?

    @var bool $b_exists_with_same_relative_path
    */
    public bool $b_exists_with_same_relative_path;

    /**
    Statuses relative to another directory : 3.

    Does the file exists with same content?

    @var bool $b_exists_with_same_content
    */
    public bool $b_exists_with_same_content;

    /**
    Statuses relative to another directory : 4.

    Does the file exists with suffixed relative path?
    Only computed if some regular expression for valid suffixes
    is supplied.
    An empty suffix is always considered valid,
    but it is handled if your regexp doesn't match the empty string.

    @var bool $b_exists_with_suffixed_relative_path
    */
    public bool $b_exists_with_suffixed_relative_path;

    /**
    Statuses relative to another directory : 5.

    Does the file exists with suffixed relative path and same content
    At The Same Time (ATST)?
    Only computed if some regular expression for valid suffixes
    is supplied.
    An empty suffix is always considered valid,
    but it is handled if your regexp doesn't match the empty string.

    @var bool $b_exists_with_suffixed_relative_path_and
    */
    public bool $b_exists_with_suffixed_relative_path_and; // ATST



    /**
    Constructor for FileData.

    @param string $s_filepath The filepath of the file.
    @param string $s_reference_directory_path
                  The directorypath of the reference directory.

    @return void
    */
    public function __construct(
      string $s_filepath,
      string $s_reference_directory_path,
    ) {
      $this->s_filepath = $s_filepath;
      $path_parts = pathinfo($this->s_filepath);
      $this->s_dirname = (
        isset($path_parts['dirname']) ? $path_parts['dirname'] : ''
      );
      $this->s_basename = $path_parts['basename'];
      $this->s_filename = $path_parts['filename'];
      if(!isset($path_parts['extension'])){
        $this->s_extension = '';
      }
      else{
        $this->s_extension = $path_parts['extension'];
        if($this->s_filename === ''){
          // Hidden file
          $this->s_filename = $this->s_basename;
          $this->s_extension = '';
        }
      }
      $this->s_path_from_reference_directory = substr(
        $this->s_filepath,
        strlen($s_reference_directory_path),
      );
      // To enforce a load attempt.
      $this->i_size = 1;
      $this->s_hash = '';
      $this->s_content = '';
      $this->get_s_content();
      $this->b_exists_with_same__relative_path_and_content = false;
      $this->b_exists_with_same_relative_path = false;
      $this->b_exists_with_same_content = false;
      $this->b_exists_with_suffixed_relative_path = false;
      $this->b_exists_with_suffixed_relative_path_and = false;
    }//end __construct() FileData



    /**
    Returns the content of the file as a string after fetching it from
    the filesystem.

    @throws \Exception When the content of the file cannot be retrieved
                       from the filesystem.

    @return string
    */
    public function get_s_content() : string {
      if($this->i_size !== strlen($this->s_content)){
        $s_content = file_get_contents($this->s_filepath);
        if($s_content === false){
          throw new Exception(
            'Unexpected failure when fetching content of '
            .$this->s_filepath
          );
        }
        $this->s_content = $s_content;
        if($this->s_hash === ''){
          $this->i_size = strlen($this->s_content);
          $this->s_hash = md5($this->s_content);
        }
      }
      return $this->s_content;
    }//end get_s_content()
  }//end class FileData




  /**
  Kind of a "dataclass" to keep the informations related with the files
  under a directory.

  @category Library
  @package DevOrSysAdminScripts
  @subpackage DOSASfiles
  @class DataOfFilesUnderDirectory
  @author Laurent Lyaudet <laurent.lyaudet@gmail.com>
  @license https://www.gnu.org/licenses/lgpl-3.0.html LGPLv3+
  */
  final class DataOfFilesUnderDirectory {
    /**
    The path of the reference directory.

    @var string $s_reference_directory_path
    */
    public string $s_reference_directory_path;

    /**
    The data of the files under the reference directory
    put in order by absolute path.

    @var array<string, FileData> $arr_files_by_path
    */
    public array $arr_files_by_path;

    /**
    The data of the files under the reference directory
    put in order by path from reference directory.

    @var array<string, FileData> $arr_files_by_path_from
    */
    public array $arr_files_by_path_from;

    /**
    The data of the files under the reference directory
    put in order by size, hash, and order of addition to this object.

    @var array<int, array<string, array<int, FileData>>> $arr_files_by_size
    */
    public array $arr_files_by_size;



    /**
    Constructor for DataOfFilesUnderDirectory.

    @param string $s_reference_directory_path
                  The directorypath of the reference directory.

    @return void
    */
    public function __construct(string $s_reference_directory_path) {
      $this->s_reference_directory_path = $s_reference_directory_path;
      $this->arr_files_by_path = [];
      $this->arr_files_by_path_from = [];
      $this->arr_files_by_size = [];
    }//end __construct() DataOfFilesUnderDirectory



    /**
    Adds a FileData object in the arrays used for fast access by
    different keys.

    @param FileData $o_file_data The FileData object to add.

    @return void
    */
    public function add_file_data(FileData $o_file_data) : void {
      $this->arr_files_by_path[$o_file_data->s_filepath] = $o_file_data;
      $this->arr_files_by_path_from[
        $o_file_data->s_path_from_reference_directory
      ] = $o_file_data;
      if(!isset($this->arr_files_by_size[$o_file_data->i_size])){
        $this->arr_files_by_size[$o_file_data->i_size] = [];
      }
      if(
        !isset(
          $this->arr_files_by_size[$o_file_data->i_size][
            $o_file_data->s_hash
          ]
        )
      ){
        $this->arr_files_by_size[$o_file_data->i_size][
          $o_file_data->s_hash
        ] = [];
      }
      $this->arr_files_by_size[$o_file_data->i_size][
        $o_file_data->s_hash
      ] []= $o_file_data;
    }//end add_file_data()



    /**
    Create a FileData object for the given FilePath.
    And adds this FileData object in the arrays used for fast access by
    different keys.

    @param string $s_filepath The filepath required.

    @return void
    */
    public function add_file_data_for_file_path(
      string $s_filepath
    ) : void {
      $o_file_data = new FileData(
        $s_filepath,
        $this->s_reference_directory_path,
      );
      $o_file_data->s_content = '';
      $this->add_file_data($o_file_data);
    }//end add_file_data_for_file_path()
  }//end class DataOfFilesUnderDirectory




  /**
  Loads the data of files under a given directory,
  but doesn't keep the contents loaded.
  Recusivity is not implemented yet.

  @param string $s_dirpath The directory to search in.

  @return \DOSASfiles\DataOfFilesUnderDirectory
  */
  function load_files_data_under_directory(
    string $s_dirpath,
  ) : DataOfFilesUnderDirectory {
    $o_data_of_files_under_directory = new DataOfFilesUnderDirectory(
      $s_dirpath
    );
    $arr_s_paths = glob($s_dirpath.'*');
    if($arr_s_paths === false){
      return $o_data_of_files_under_directory;
    }
    foreach($arr_s_paths as $s_filepath){
      $o_data_of_files_under_directory->add_file_data_for_file_path(
        $s_filepath
      );
    }//end foreach($arr_s_paths as $s_filepath)
    return $o_data_of_files_under_directory;
  }//end load_files_data_under_directory()



  /**
  Loads the data of files under two given directories,
  but doesn't keep the contents loaded.
  And then compares the files under both directories.
  Recusivity is not implemented yet.

  @param string $s_source_dirpath The first directory to search in.
  @param string $s_dest_dirpath The second directory to search in.
  @param bool   $b_compute_also_reverse_status
                If you want that the status of files under dest_dirpath
                must also be computed.
  @param string $s_valid_suffixes_regexp A regexp for valid suffixes.

  @return array{
    'source_files_data': \DOSASfiles\DataOfFilesUnderDirectory,
    'dest_files_data': \DOSASfiles\DataOfFilesUnderDirectory
  }
  */
  function compare_files_under_directories(
    string $s_source_dirpath,
    string $s_dest_dirpath,
    bool $b_compute_also_reverse_status = false,
    string $s_valid_suffixes_regexp = '',
  ) : array {
    $o_files_data_source = load_files_data_under_directory(
      $s_source_dirpath
    );
    $o_files_data_dest = load_files_data_under_directory(
      $s_dest_dirpath
    );
    foreach($o_files_data_source->arr_files_by_path_from as $o_file_data){
      if(
        isset(
          $o_files_data_dest->arr_files_by_path_from[
            $o_file_data->s_path_from_reference_directory
          ]
        )
      ){
        $o_file_data->b_exists_with_same_relative_path = true;
        $o_file_data2 = (
          $o_files_data_dest->arr_files_by_path_from[
            $o_file_data->s_path_from_reference_directory
          ]
        );
        $o_file_data2->b_exists_with_same_relative_path = true;
        $o_file_data->b_exists_with_suffixed_relative_path = true;
        $o_file_data2->b_exists_with_suffixed_relative_path = true;
        if(
          $o_file_data2->i_size === $o_file_data->i_size
          && $o_file_data2->s_hash === $o_file_data->s_hash
          && $o_file_data2->get_s_content()
          === $o_file_data->get_s_content()
        ){
          $o_file_data->b_exists_with_same__relative_path_and_content = (
            true
          );
          $o_file_data->b_exists_with_same_content = true;
          $o_file_data->b_exists_with_suffixed_relative_path_and = (
            true
          );
          $o_file_data2->b_exists_with_same__relative_path_and_content = (
            true
          );
          $o_file_data2->b_exists_with_same_content = true;
          $o_file_data2->b_exists_with_suffixed_relative_path_and = (
            true
          );
          $o_file_data->s_content = '';
          $o_file_data2->s_content = '';
          continue;
        }
      }//end if(isset($o_files_data_dest->arr_files_by_path_from[...])
      if(
        isset($o_files_data_dest->arr_files_by_size[$o_file_data->i_size])
        && isset(
          $o_files_data_dest->arr_files_by_size[$o_file_data->i_size][
            $o_file_data->s_hash
          ]
        )
      ){
        foreach(
           $o_files_data_dest->arr_files_by_size[$o_file_data->i_size][
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
            $o_file_data->s_content = '';
            $o_file_data2->s_content = '';
            if($s_valid_suffixes_regexp !== ''){
              if(
                preg_match(
                  '/'
                  .preg_quote(
                    $o_file_data->s_path_from_reference_directory,
                    '/',
                  )
                  .$s_valid_suffixes_regexp
                  .'/',
                  $o_file_data2->s_path_from_reference_directory,
                )
              ){
                $o_file_data->b_exists_with_suffixed_relative_path = true;
                $o_file_data->b_exists_with_suffixed_relative_path_and = (
                  true
                );
              }
              if(
                $b_compute_also_reverse_status
                && preg_match(
                  '/'
                  .preg_quote(
                    $o_file_data2->s_path_from_reference_directory,
                    '/',
                  )
                  .$s_valid_suffixes_regexp
                  .'/',
                  $o_file_data->s_path_from_reference_directory,
                )
              ){
                $o_file_data2->b_exists_with_suffixed_relative_path = true;
                $o_file_data2->b_exists_with_suffixed_relative_path_and = (
                  true
                );
              }
            }//end if($s_valid_suffixes_regexp !== '')
          }//end if(file_data2->content == file_data->content)
        }//end foreach(file with same size and same hash)
      }//end if(there is some file with same size and same hash)
    }//end foreach($arr_files_data_source[...] as $o_file_data)

    if($b_compute_also_reverse_status){
      foreach($o_files_data_dest->arr_files_by_path_from as $o_file_data){
        if($o_file_data->b_exists_with_suffixed_relative_path){
          continue;
        }
        $arr_s_paths = glob(
          $s_source_dirpath.$o_file_data->s_basename.'*'
        );
        if($arr_s_paths === false){
          continue;
        }
        foreach($arr_s_paths as $s_filepath){
          if(!isset($o_files_data_source->arr_files_by_path[$s_filepath])){
            // A newly created file that wasn't previously loaded
            // is ignored.
            continue;
          }
          $o_file_data2 = (
            $o_files_data_source->arr_files_by_path[$s_filepath]
          );
          if(
            preg_match(
              '/'
              .preg_quote(
                $o_file_data->s_path_from_reference_directory,
                '/',
              )
              .$s_valid_suffixes_regexp
              .'/',
              $o_file_data2->s_path_from_reference_directory,
            )
          ){
            $o_file_data->b_exists_with_suffixed_relative_path = true;
          }
        }//end foreach($arr_s_paths as $s_filepath)
      }//end foreach($arr_files_data_dest[...] as $o_file_data)
    }//end if($b_compute_also_reverse_status)

    return [
      'source_files_data' => $o_files_data_source,
      'dest_files_data' => $o_files_data_dest,
    ];
  }//end compare_files_under_directories()



  /**
  Archive some directory files into another directory.

  @param string $s_source_dirpath The source directory to search in.
  @param string $s_dest_dirpath The archive directory to move files in.
  @param bool   $b_archive_if_missing_relative_filepath
                Archive if no destination file is found with a relative
                path that is identical.
  @param bool   $b_archive_if_missing_content
                Archive if no destination file is found with same content.
  @param bool   $b_archive_if_missing_same_relative_path_content
                Archive if no destination file is found with a relative
                path that is identical and with same content.
  @param bool   $b_archive_if_missing_suffixed_relative_path
                Archive if no destination file is found with a relative
                path that has a valid suffix
                after the source relative path.
  @param bool   $b_archive_if_missing_suffixed_relative_path_content
                Archive if no destination file is found with a relative
                path that has a valid suffix
                after the source relative path
                and with same content.
  @param string $s_valid_suffixes_regexp A regexp for valid suffixes.

  @throws \Exception When $s_valid_suffixes_regexp is required
                     and not supplied.

  @return void
  */
  function archive_directory_into_another(
    string $s_source_dirpath,
    string $s_dest_dirpath,
    bool $b_archive_if_missing_relative_filepath,
    bool $b_archive_if_missing_content,
    bool $b_archive_if_missing_same_relative_path_content,
    bool $b_archive_if_missing_suffixed_relative_path,
    bool $b_archive_if_missing_suffixed_relative_path_content,
    string $s_valid_suffixes_regexp = '',
  ) : void {
    if(
      (
        $b_archive_if_missing_suffixed_relative_path
        || $b_archive_if_missing_suffixed_relative_path_content
      )
      && $s_valid_suffixes_regexp === ''
    ){
      throw new Exception(
        'archive_directory_into_another is missing an'
        .' $s_valid_suffixes_regexp argument.'
      );
    }
    $arr_files_data = compare_files_under_directories(
      $s_source_dirpath,
      $s_dest_dirpath,
      false,
      $s_valid_suffixes_regexp,
    );
    foreach(
      $arr_files_data['source_files_data']->arr_files_by_path_from
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
        ||
        (
          $b_archive_if_missing_same_relative_path_content
          && !$o_file_data->b_exists_with_same__relative_path_and_content
        )
        ||
        (
          $b_archive_if_missing_suffixed_relative_path
          && !$o_file_data->b_exists_with_suffixed_relative_path
        )
        ||
        (
          $b_archive_if_missing_suffixed_relative_path_content
          && !$o_file_data->b_exists_with_suffixed_relative_path_and
        )
      ){
        shell_exec(
          'cp --backup=numbered'
          ." '".preg_replace("/'/", "'\"'\"'", $o_file_data->s_filepath)
          ."'"
          ." '".preg_replace("/'/", "'\"'\"'", $s_dest_dirpath)."'"
        );
      }
    }//end foreach($arr_files_data['source_files_data'][] as $o_file_data)
  }//end archive_directory_into_another()
}//end namespace DOSASfiles




/*
$ php
<?php
require_once 'files.libr.php';
var_dump(
  DOSASfiles\compare_files_under_directories(
    '/home/laurent/.config/libreoffice/4/user/backup/',
    '/home/laurent/Documents/LibreOfficeArchives/',
  )
);
DOSASfiles\archive_directory_into_another(
  '/home/laurent/.config/libreoffice/4/user/backup/',
  '/home/laurent/Documents/LibreOfficeArchives/',
  false,
  true,
  false,
  false,
  false,
  '',
);
*/
?>
