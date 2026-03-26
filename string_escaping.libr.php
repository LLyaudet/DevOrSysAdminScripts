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



/**
The namespace string_escaping is splitted into subnamespaces for each
language.
This subnamespace is for HTML (surprised?)...

@package DevOrSysAdminScripts
@subpackage string_escaping\HTML
*/
namespace string_escaping\HTML {
  /**
  When you want that the string appears as is in HTML text block.

  @param string $s_string The string you want to escape.

  @return string The escaped string.
  */
  function escape_text(string $s_string) : string {
    return str_replace(
      [
        '&',
        '<',
      ],
      [
        '&amp;',
        '&lt;',
      ],
      $s_string,
    );
  }//end escape_text()



  /**
  When you want that the string appears as is in an HTML tag attribute
  that starts and ends with double quotes: my_attribute="something".
  Example: a title attribute.
  /!\ in double quotes /!\ my_attribute='something' is not supported.

  @param string $s_string The string you want to escape.

  @return string The escaped string.
  */
  function escape_attribute(string $s_string) : string {
    return str_replace(
      ['"'],
      ['&quot;'],
      $s_string,
    );
  }//end escape_attribute()



  /**
  When you want that the string appears verbatim inside HTML <pre> tags.

  @param string $s_string The string you want to escape.

  @return string The escaped string.
  */
  function escape_pre(string $s_string) : string {
    return str_replace(
      [
        '&',
        '<',
      ],
      [
        '&amp;',
        '&lt;',
      ],
      $s_string,
    );
  }//end escape_pre()
}//end namespace string_escaping\HTML




/**
The namespace string_escaping is splitted into subnamespaces for each
language.
This subnamespace is for XHTML (still surprised?)...

@package DevOrSysAdminScripts
@subpackage string_escaping\XHTML
*/
namespace string_escaping\XHTML {
  /**
  When you want that the string appears as is in XHTML text block.

  @param string $s_string The string you want to escape.

  @return string The escaped string.
  */
  function escape_text(string $s_string) : string {
    return str_replace(
      [
        '&',
        '<',
      ],
      [
        '&amp;',
        '&lt;',
      ],
      $s_string,
    );
  }//end escape_text()



  /**
  When you want that the string appears as is in an XHTML tag attribute
  that starts and ends with double quotes: my_attribute="something".
  Example: a title attribute.
  /!\ in double quotes /!\ my_attribute='something' is not supported.

  @param string $s_string The string you want to escape.

  @return string The escaped string.
  */
  function escape_attribute(string $s_string) : string {
    return str_replace(
      [
        '&',
        '<',
        '"',
        "\n",
      ],
      [
        '&amp;',
        '&lt;',
        '&quot;',
        '&#10;',
      ],
      $s_string,
    );
  }//end escape_attribute()



  /**
  When you want that the string appears verbatim inside XHTML <pre> tags.

  @param string $s_string The string you want to escape.

  @return string The escaped string.
  */
  function escape_pre(string $s_string) : string {
    return str_replace(
      [
        '&',
        '<',
      ],
      [
        '&amp;',
        '&lt;',
      ],
      $s_string,
    );
  }//end escape_pre()
}//end namespace string_escaping\XHTML




/**
The namespace string_escaping is splitted into subnamespaces for each
language.
This subnamespace is for JS (you're hopeless?)...

@package DevOrSysAdminScripts
@subpackage string_escaping\JS
*/
namespace string_escaping\JS {

  use function string_escaping\XHTML\escape_text as XHTML_escape_text;



  /**
  When you want that the string can be put in a JS string definition.

  @param string $s_string The string you want to escape.

  @return string The escaped string.
  */
  function escape(string $s_string) : string {
    return str_replace(
      [
        '\\',
        "\n",
        "'",
        '"',
      ],
      [
        '\\\\',
        '\n',
        '\\\'',
        '\\"',
      ],
      $s_string,
    );
  }//end escape()



  /**
  When you want that the string can be put in a JS string definition
  to be included inside an XHTML file <script> tag.

  @param string $s_string The string you want to escape.

  @return string The escaped string.
  */
  function escape_for_string_definition_inside_XHTML(string $s_string)
  : string {
    return XHTML_escape_text(escape($s_string));
  }//end escape_for_string_definition_inside_XHTML()
}//end namespace string_escaping\JS




/**
The namespace string_escaping is splitted into subnamespaces for each
language.
This subnamespace is for TeX.

@package DevOrSysAdminScripts
@subpackage string_escaping\TeX
*/
namespace string_escaping\TeX {
  /**
  When you want that the string can be written to a TeX file inside a
  part where TeX is in text mode.

  @param string $s_string The string you want to escape.

  @return string The escaped string.
  */
  function escape_text(string $s_string) : string {
    // https://tex.stackexchange.com/a/34586/270015
    return str_replace(
      [
        '\\',
        '&',
        '%',
        '$',
        '#',
        '_',
        '{',
        '}',
        '~',
        '^',
      ],
      [
        '\\textbackslash',
        '\\&',
        '\\%',
        '\\$',
        '\\#',
        '\\_',
        '\\{',
        '\\}',
        '\\textasciitilde',
        '\\textasciicircum',
      ],
      $s_string,
    );
  }//end escape_text()
}//end namespace string_escaping\TeX

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
?>
