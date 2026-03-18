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

namespace string_escaping\HTML {
  function escape_text($s_string){
    return str_replace(
      array(
        '&',
        '<',
      ),
      array(
        '&amp;',
        '&lt;',
      ),
      $s_string,
    );
  }



  function escape_attribute($s_string){
    # in double quotes
    return str_replace(
      array('"'),
      array('&quot;'),
      $s_string,
    );
  }



  function escape_pre($s_string){
    return str_replace(
      array(
        '&',
        '<',
      ),
      array(
        '&amp;',
        '&lt;',
      ),
      $s_string,
    );
  }
}




namespace string_escaping\XHTML {
  function escape_text($s_string){
    return str_replace(
      array(
        '&',
        '<',
      ),
      array(
        '&amp;',
        '&lt;',
      ),
      $s_string,
    );
  }



  function escape_attribute($s_string){
    # in double quotes
    return str_replace(
      array(
        '&',
        '<',
        '"',
        "\n",
      ),
      array(
        '&amp;',
        '&lt;',
        '&quot;',
        '&#10;'
      ),
      $s_string,
    );
  }



  function escape_pre($s_string){
    return str_replace(
      array(
        '&',
        '<',
      ),
      array(
        '&amp;',
        '&lt;',
      ),
      $s_string,
    );
  }
}




namespace string_escaping\JS {
  use function string_escaping\XHTML\escape_text as XHTML_escape_text;

  function escape($s_string){
    return str_replace(
      array(
        '\\',
        "\n",
        "'",
        '"',
      ),
      array(
        '\\\\',
        '\n',
        '\\\'',
        '\\"',
      ),
      $s_string,
    );
  }



  function escape_for_string_definition_inside_XHTML($s_string){
    return XHTML_escape_text(escape($s_string));
  }
}

/*
$ php
<?php
require_once('string_escaping.libr.php');
var_dump(string_escaping\HTML\escape_text('<&"\'truc\\'));
var_dump(string_escaping\HTML\escape_attribute("<&\"\n'truc\\"));
var_dump(string_escaping\HTML\escape_pre("<&\"\n'truc\\"));
var_dump(string_escaping\XHTML\escape_text('<&"\'truc\\'));
var_dump(string_escaping\XHTML\escape_attribute("<&\"\n'truc\\"));
var_dump(string_escaping\XHTML\escape_pre("<&\"\n'truc\\"));
var_dump(string_escaping\JS\escape("abcd & < > \\ \n  \"'"));
var_dump(string_escaping\JS\escape_for_string_definition_inside_XHTML(
  "abcd & < > \\ \n  \"'"
));
*/
