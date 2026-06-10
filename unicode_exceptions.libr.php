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
This file was renamed from "unicode.php" to "unicode.libr.php".

@category Library
@package DevOrSysAdminScripts
@author Laurent Lyaudet <laurent.lyaudet@gmail.com>
@copyright 2023-2026 Laurent Frédéric Bernard François Lyaudet
@license https://www.gnu.org/licenses/lgpl-3.0.html LGPLv3+
*/

declare(strict_types=1);
declare(encoding='UTF-8');

namespace DOSAS_unicode;

/**
A class to enhance standard PHP Exception with an array of data.

@category Library
@package DevOrSysAdminScripts
@author Laurent Lyaudet <laurent.lyaudet@gmail.com>
@license https://www.gnu.org/licenses/lgpl-3.0.html LGPLv3+
*/
class WithDataArrayException extends \Exception {
  /**
  A data array to store details related to an exception.

  @var array $arr_data
  */
  protected $arr_data;



  /**
  Constructor for WithDataArrayException.

  @param string $message
  @param array $arr_data

  @return void
  */
  public function __construct(string $message, array $arr_data = []) {
    $this->arr_data = $arr_data;
    parent::__construct($message);
  }//end __construct() WithDataArrayException



  /**
  Getter to obtain the data array with details of the exception.

  @return array
  */
  public function get_data() : array {
    return $this->arr_data;
  }//end get_data()
}//end class WithDataArrayException




/**
A class to specialize WithDataArrayException for use with invalid
encoding detection (ASCII and UTF-8 validation) in unicode.libr.php.

@category Library
@package DevOrSysAdminScripts
@author Laurent Lyaudet <laurent.lyaudet@gmail.com>
@license https://www.gnu.org/licenses/lgpl-3.0.html LGPLv3+
*/
class InvalidEncodingException extends WithDataArrayException {
}//end class InvalidEncodingException

?>
