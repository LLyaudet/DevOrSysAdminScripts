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

use Exception;

/*
Max value for Unicode is 10FFFF != 16*255*255 = 16*65025 = 1040400... XD
Max value for Unicode is 10FFFF = (16*256+255)*256+255
  = (2560+1536+255)*256+255 = (4096+255)*256+255 = 4351*256+255
  = 4351*1000/4 + 4351*6 + 255
  4351000 2175500 1087750
  = 1087750 + 26106 + 255 = 1114111
so there is 1114112 possible values in the "uncarved" range.
244,143,191,191 for UTF-8 yields max code point is ((4*64+15)*64+63)*64+63
  = ((256+15)*64+63)*64+63 = (271*64+63)*64+63 = (16260+1084+63)*64+63
  = 17407*64+63 = 1044420 + 69628 + 63 = 1114111
*/
const MAX_UNICODE_CODE_POINT = 1114111;



/**
Converts an int to the byte-string corresponding to the UTF-8 encoding
of the Unicode code point of same integer value.
Note that not all integers between 0 and 1114111 are valid code points
for UTF-8.

@param int<0, 1114111> $i_unicode_code_point The code point.

@throws \Exception When the code point is outside of Unicode range.

@return string The corresponding UTF-8 character.
*/
function unicode_code_point_to_UTF8(int $i_unicode_code_point) : string {
  // var_dump($i_unicode_code_point);
  if($i_unicode_code_point < 0){
    throw new \Exception('A unicode code point must not be negative.');
  }
  // 0xxxxxxx ASCII
  if($i_unicode_code_point < 128){
    return chr($i_unicode_code_point);
  }
  $i_continuation_base_value = 128;
  // 110xxxxx 10xxxxxx
  if($i_unicode_code_point < 2048){  // 2**11
    $i_first_byte_base_value = 192;
    /*
    $i_last_byte_significant_bits = $i_unicode_code_point % 64  // 2**6;
    $i_first_byte_significant_bits = intdiv(
      $i_unicode_code_point - $i_last_byte_significant_bits,
      64,  // 2**6
    );
    $s_result = chr(
      $i_first_byte_base_value
      + $i_first_byte_significant_bits
    );
    $s_result .= chr(
      $i_continuation_base_value
      + $i_last_byte_significant_bits
    );
    return $s_result;
    */
    return (
      chr($i_first_byte_base_value + ($i_unicode_code_point >> 6))
      .chr($i_continuation_base_value + ($i_unicode_code_point & 63))
    );
  }//end if($i_unicode_code_point < 2048)
  // 1110xxxx 10xxxxxx 10xxxxxx
  if($i_unicode_code_point < 65536){  // 2**16
    $i_first_byte_base_value = 224;
    /*
    $arr_arr_data_per_byte_reverse = [
      ['i_bits' => 6, 'i_base_value' => $i_continuation_base_value],
      ['i_bits' => 6, 'i_base_value' => $i_continuation_base_value],
      ['i_bits' => 4, 'i_base_value' => $i_first_byte_base_value],
    ];
    $i_rest = $i_unicode_code_point;
    $s_result = '';
    foreach($arr_arr_data_per_byte_reverse as $arr_data){
      // _Pragma unroll
      // J'aurais pu "roller" les 4 cas des ifs.
      // Mais pour les perfs, il faudrait tout unroller vu le nombre
      // d'itérations. Et j'aimerais bien comparer du code unrollé
      // aux 2 niveaux à la main avec celui unrollé par le compilateur
      // sur les 2 niveaux. Je préjuge/présuppose qu'il unroll
      // l'intérieur d'abord (pour ne pas refaire le même boulot)
      // puis l'extérieur et qu'il oublie de réoptimiser l'intérieur
      // en fonction de l'extérieur unrollé. Est-ce que j'ai raison ?
      $i_significant_bits = $i_rest % (2**$arr_data['i_bits']);
      $i_rest = intdiv(
        $i_rest - $i_significant_bits,
        2**$arr_data['i_bits'],
      );
      // .= or =.
      // Below could have been a case of "=.".
      $s_result = (
        chr($i_significant_bits + $arr_data['i_base_value'])
        .$s_result
      );
    }//end foreach($arr_arr_data_per_byte_reverse as $arr_data)
    return $s_result;
    */
    return (
      chr($i_first_byte_base_value + ($i_unicode_code_point >> 12))
      .chr(
        $i_continuation_base_value
        + (($i_unicode_code_point >> 6) & 63)
      )
      .chr($i_continuation_base_value + ($i_unicode_code_point & 63))
    );
  }//end if($i_unicode_code_point < 65536)
  // 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
  // if($i_unicode_code_point < 2097152){  // 2**21
  if($i_unicode_code_point < MAX_UNICODE_CODE_POINT){
    $i_first_byte_base_value = 240;
    /*
    $arr_arr_data_per_byte_reverse = [
      ['i_bits' => 6, 'i_base_value' => $i_continuation_base_value],
      ['i_bits' => 6, 'i_base_value' => $i_continuation_base_value],
      ['i_bits' => 6, 'i_base_value' => $i_continuation_base_value],
      ['i_bits' => 3, 'i_base_value' => $i_first_byte_base_value],
    ];
    $i_rest = $i_unicode_code_point;
    $s_result = '';
    foreach($arr_arr_data_per_byte_reverse as $arr_data){
      // _Pragma unroll
      $i_significant_bits = $i_rest % (2**$arr_data['i_bits']);
      $i_rest = intdiv(
        $i_rest - $i_significant_bits,
        2**$arr_data['i_bits'],
      );
      // .= or =.
      // Below could have been a case of "=.".
      $s_result = (
        chr($i_significant_bits + $arr_data['i_base_value'])
        .$s_result
      );
    }
    return $s_result;
    */
    return (
      chr($i_first_byte_base_value + ($i_unicode_code_point >> 18))
      .chr(
        $i_continuation_base_value
        + (($i_unicode_code_point >> 12) & 63)
      )
      .chr(
        $i_continuation_base_value
        + (($i_unicode_code_point >> 6) & 63)
      )
      .chr($i_continuation_base_value + ($i_unicode_code_point & 63))
    );
  }//end if($i_unicode_code_point < MAX_UNICODE_CODE_POINT)
  // phpcs:disable Squiz.Strings.DoubleQuoteUsage.NotRequired
  throw new \Exception(
    "UTF-8 avec jusqu'à 6 octets a été abandonné il y a longtemps."
    ." Autre anecdote \"débile\" : MySQL a de base UTF-8 avec jusqu'à"
    ." 3 octets au lieu de 4 :face-palm:."
    ." Du coup, ça peut donner quelques \"surprises\"."
    ." Sinon, y'a aussi ASCII dans MySQL."
    ." Et comme ça joue sur la mémoire et les performances,"
    ." pourquoi ils n'ont pas fait ASCII, UTF-8-2, UTF-8-3, UTF-8-4 ?"
    ." :)"
  );
  // phpcs:enable Squiz.Strings.DoubleQuoteUsage.NotRequired
}//end unicode_code_point_to_UTF8()



/**
Converts a string of hexadecimal digits to the byte-string corresponding
to the UTF-8 encoding of the Unicode code point of same integer value
that is denoted by the hexadecimal digits.

@param string $s_code_point_in_hexadecimal_notation The code point.

@throws \Exception When the code point is outside of Unicode range.

@return string The corresponding UTF-8 character.
*/
function hexa_code_point_to_UTF8(
  string $s_code_point_in_hexadecimal_notation
) : string {
  $s_code_point_in_hexadecimal_notation = strtoupper(
    $s_code_point_in_hexadecimal_notation
  );
  $i_unicode_code_point = 0;
  $i_ord_0 = ord('0');
  $i_ord_A = ord('A');
  $i_digit_offset = -$i_ord_0;
  $i_letter_offset = 10 - $i_ord_A;
  for(
    $i = 0, $i_max = strlen($s_code_point_in_hexadecimal_notation);
    $i < $i_max;
    ++$i
  ){
    $s_hexa_digit = $s_code_point_in_hexadecimal_notation[$i];
    $i_unicode_code_point *= 16;
    if(ctype_digit($s_hexa_digit)){
      $i_unicode_code_point += (
        ord($s_hexa_digit) + $i_digit_offset
      );
      continue;
    }
    if(ctype_xdigit($s_hexa_digit)){
      $i_unicode_code_point += (
        ord($s_hexa_digit) + $i_letter_offset
      );
      continue;
    }
    throw new \Exception('Not an hexadecimal digit.');
  }
  if($i_unicode_code_point > MAX_UNICODE_CODE_POINT){
    throw new \Exception(
      'Hexadecimal integer is greater than UTF-8 maximum code point.'
    );
  }
  return unicode_code_point_to_UTF8($i_unicode_code_point);
}//end hexa_code_point_to_UTF8()



/**
Converts a string of decimal digits to the byte-string corresponding
to the UTF-8 encoding of the Unicode code point of same integer value
that is denoted by the decimal digits.

@param string $s_code_point_in_decimal_notation The code point.

@throws \Exception When the code point is outside of Unicode range.

@return string The corresponding UTF-8 character.
*/
function decimal_code_point_to_UTF8(
  string $s_code_point_in_decimal_notation
) : string {
  $i_unicode_code_point = 0;
  $i_ord_0 = ord('0');
  $i_digit_offset = -$i_ord_0;
  for(
    $i = 0, $i_max = strlen($s_code_point_in_decimal_notation);
    $i < $i_max;
    ++$i
  ){
    $s_digit = $s_code_point_in_decimal_notation[$i];
    $i_unicode_code_point *= 10;
    if(ctype_digit($s_digit)){
      $i_unicode_code_point += (ord($s_digit) + $i_digit_offset);
      continue;
    }
    throw new \Exception('Not a decimal digit.');
  }
  if($i_unicode_code_point > MAX_UNICODE_CODE_POINT){
    throw new \Exception(
      'Decimal integer is greater than UTF-8 maximum code point.'
    );
  }
  return unicode_code_point_to_UTF8($i_unicode_code_point);
}//end decimal_code_point_to_UTF8()



/**
This function throws an exception with extended debug informations
if the input string is not valid ASCII.
Otherwise, it returns true.

@param string $s_string The input string.

@throws DOSAS_unicode\InvalidEncodingException When the input string is not
                                               valid ASCII.

@return bool
*/
function check_string_is_valid_ASCII(string $s_string) : bool {
  //Fast-path
  if(mb_check_encoding($s_string, 'ASCII')){
    return true;
  }

  $i_offset_in_octets_from_string_start = 0;
  $i_current_line_number = 1;
  $i_offset_in_octets_from_line_start = -1;
  for($i = 0, $i_max = strlen($s_string); $i < $i_max; ++$i){
    $i_current_octet = ord($s_string[$i]);
    $i_offset_in_octets_from_string_start = $i;
    ++$i_offset_in_octets_from_line_start;

    if($i_current_octet > 127){
      throw new InvalidEncodingException(
        'Non-ASCII character found on line '
        .$i_current_line_number
        .'; the octet/character '
        .($i_offset_in_octets_from_line_start + 1)
        .' has value '
        .$i_current_octet
        .' which is not ASCII.'
        .' (Sequential position without line splitting:'
        .' This is at octet/character '
        .($i_offset_in_octets_from_string_start + 1)
        .'.)',
        [
          'current_octet' => $i_current_octet,
          'offset_from_string_start'
            => $i_offset_in_octets_from_string_start,
          'line' => $i_current_line_number,
          'offset_from_line_start'
            => $i_offset_in_octets_from_line_start,
        ],
      );
    }//end if($i_current_octet > 127)

    // if($s_string[$i] === "\n"){
    if($i_current_octet === 10){
      ++$i_current_line_number;
      $i_offset_in_octets_from_line_start = -1;
    }
  }//for($i = 0, $i_max = strlen($s_string); $i < $i_max; ++$i)
  return true;
}//end check_string_is_valid_ASCII()



/**
This function throws an exception with extended debug informations
if the content of the file with given file_path is not valid ASCII.
Otherwise, it returns true.

@param string $s_file_path The input file_path.

@throws \Exception When the file is not found.
@throws DOSAS_unicode\InvalidEncodingException When the input string is not
                                               valid ASCII.

@return bool
*/
function check_file_is_valid_ASCII(string $s_file_path) : bool {
  $s_string = file_get_contents($s_file_path);
  if($s_string === false){
    throw new \Exception('File '.$s_file_path.' not found.');
  }
  return check_string_is_valid_ASCII($s_string);
}//end check_file_is_valid_ASCII()



/**
This function returns the message string and data array for
DOSAS_unicode\InvalidEncodingException inside check_string_is_valid_UTF8().

@param string $s_custom_message The custom part of the message.
@param int $i_current_octet The current octet in the string.
@param int $i_continuation_octet_needed The current number of continuation
                                        octets needed.
@param int $i_offset_in_octets_from_string_start
           The offset in octets from string start.
@param int $i_offset_in_characters_from_string_start
           The offset in characters from string start.
@param int $i_character_start_position_from_string_start
           The offset in octets from string start at which the current
           character starts.
@param int $i_current_line_number The current line number.
@param int $i_offset_in_octets_from_line_start
           The offset in octets from line start.
@param int $i_offset_in_characters_from_line_start
           The offset in characters from line start.
@param int $i_character_start_position_from_line_start
           The offset in octets from line start at which the current
           character starts.
@param int $i_current_continuation_octet_minimum
           The minimum value of the second continuation octet as specified
           by the grammar.
@param int $i_current_continuation_octet_maximum
           The maximum value of the second continuation octet as specified
           by the grammar.

@return array
*/
function get_message_and_data_array(
  string $s_custom_message,
  int $i_current_octet,
  int $i_continuation_octet_needed,
  int $i_offset_in_octets_from_string_start,
  int $i_offset_in_characters_from_string_start,
  int $i_character_start_position_from_string_start,
  int $i_current_line_number,
  int $i_offset_in_octets_from_line_start,
  int $i_offset_in_characters_from_line_start,
  int $i_character_start_position_from_line_start,
  int $i_current_continuation_octet_minimum,
  int $i_current_continuation_octet_maximum,
) : array {
  return [
    'message' => (
      'Non-UTF8 character found on line '
      .$i_current_line_number
      .'; the octet '
      .($i_offset_in_octets_from_line_start + 1)
      .', part of the character '
      .($i_offset_in_characters_from_line_start + 1)
      .', has value '
      .$i_current_octet
      .$s_custom_message
      .' This character starts at octet '
      .($i_character_start_position_from_line_start + 1)
      .' of the current line.'
      .' (Sequential positions without line splitting:'
      .' This is at character '
      .($i_offset_in_characters_from_string_start + 1)
      .' and octet '
      .($i_offset_in_octets_from_string_start + 1)
      .'.'
      .' This character starts at octet '
      .($i_character_start_position_from_string_start + 1)
      .'.)'
    ),
    'data' => [
      'current_octet' => $i_current_octet,
      'continuation_octet_needed' => $i_continuation_octet_needed,
      'offset_in_octets_from_string_start'
        => $i_offset_in_octets_from_string_start,
      'offset_in_characters_from_string_start'
        => $i_offset_in_characters_from_string_start,
      'character_start_position_from_string_start'
        => $i_character_start_position_from_string_start,
      'line' => $i_current_line_number,
      'offset_in_octets_from_line_start'
        => $i_offset_in_octets_from_line_start,
      'offset_in_characters_from_line_start'
        => $i_offset_in_characters_from_line_start,
      'character_start_position_from_line_start'
        => $i_character_start_position_from_line_start,
      'current_continuation_octet_minimum'
        => $i_current_continuation_octet_minimum,
      'current_continuation_octet_maximum'
        => $i_current_continuation_octet_maximum,
    ],
  ];
}//end get_message_and_data_array()



/**
Checks that the version of PHP allows using the fast-path inside
check_string_is_valid_UTF8.

@return bool
*/
function get_use_fast_path() : bool {
  // Before PHP 5.4, Unicode support has bugs,
  // both in mb_check_encoding and preg_match.
  // See https://github.com/php/php-src/issues/22279
  return PHP_VERSION_ID >= 50400;
}//end get_use_fast_path()



/**
This function throws an exception with extended debug informations
if the input string is not valid UTF-8.
Otherwise, it returns true.

See https://datatracker.ietf.org/doc/html/rfc3629
See https://github.com/Seldaek/jsonlint/pull/98
for why it may be a good idea to have the last two parameters.
Note that a very clever compiler would merge both booleans into
a single integer parameter using binary flags.
If you want to use this function with fast-path and fallback on slow-path
in case of error, then set both booleans to true.
If, for testing/benchmarking purpose, you want to compare the results
of fast-path and slow-path, call this function twice with a single boolean
set, and store/compare the results.

@param string $s_string The input string.
@param bool $b_fast_path Use the fast-path or not to check quickly that
                         there is no error.
@param bool $b_slow_path Use the slow-path or not to check that
                         there is no error or give detailed error message.

@throws \Exception When called with $b_fast_path set to true but PHP
                   version is incompatible.
@throws DOSAS_unicode\InvalidEncodingException When the input string is not
                                               valid UTF-8.

@return bool
*/
function check_string_is_valid_UTF8(
  string $s_string,
  bool $b_fast_path = true,
  bool $b_slow_path = true,
) : bool {
  // Fast-path
  // But before PHP 5.4 Unicode support has bugs.
  // See https://github.com/php/php-src/issues/22279
  if($b_fast_path && !get_use_fast_path()){
    throw new \Exception(
      'Fast-path is not available with version '.PHP_VERSION_ID.' of PHP.'
    );
  }
  if($b_fast_path){
    if(function_exists('mb_check_encoding')){
      if(mb_check_encoding($s_string, 'UTF-8')){
        return true;
      }
    }
    else{
      if(preg_match('//u', $s_string) === 1){
        return true;
      }
    }
  }
  else{
    if(!$b_slow_path){
      throw new \Exception(
        "Don't call check_string_is_valid_UTF8 without at least one of"
        .' fast-path or slow-path required.'
      );
    }
  }

  if(!$b_slow_path){
    return false;
  }

  $i_current_octet = null;
  $i_continuation_octet_needed = 0;
  $i_offset_in_octets_from_string_start = 0;
  $i_offset_in_characters_from_string_start = -1;
  $i_character_start_position_from_string_start = 0;
  $i_current_line_number = 1;
  $i_offset_in_octets_from_line_start = -1;
  $i_offset_in_characters_from_line_start = -1;
  $i_character_start_position_from_line_start = -1;

  // For the second octet of a character, hence first continuation octet,
  // further restriction may apply.
  $I_CONTINUATION_OCTET_MINIMUM = 128;
  $I_CONTINUATION_OCTET_MAXIMUM = 191;
  $i_current_continuation_octet_minimum = $I_CONTINUATION_OCTET_MINIMUM;
  $i_current_continuation_octet_maximum = $I_CONTINUATION_OCTET_MAXIMUM;
  $s_message_for_continuation_octet_above_maximum = null;

  for($i = 0, $i_max = strlen($s_string); $i < $i_max; ++$i){
    $i_current_octet = ord($s_string[$i]);
    $i_offset_in_octets_from_string_start = $i;
    ++$i_offset_in_octets_from_line_start;

    /*
    The octet values C0, C1, F5 to FF never appear.
    C0 = 12*16      = 192 = 11000000
    C1 = 12*16 + 1  = 193 = 11000001
    F5 = 15*16 + 5  = 245 = 11110101
    FF = 15*16 + 15 = 255 = 11111111
    */
    if(
      $i_current_octet === 192
      || $i_current_octet === 193
      || $i_current_octet === 245
      || $i_current_octet === 255
    ){
      [
        'message' => $s_message,
        'data' => $arr_data,
      ] = get_message_and_data_array(
        ' which is one of the four forbidden values (C0, C1, F5, FF).',
        $i_current_octet,
        $i_continuation_octet_needed,
        $i_offset_in_octets_from_string_start,
        $i_offset_in_characters_from_string_start,
        $i_character_start_position_from_string_start,
        $i_current_line_number,
        $i_offset_in_octets_from_line_start,
        $i_offset_in_characters_from_line_start,
        $i_character_start_position_from_line_start,
        $i_current_continuation_octet_minimum,
        $i_current_continuation_octet_maximum,
      );
      throw new InvalidEncodingException($s_message, $arr_data);
    }

    /*
    UTF8-octets = *( UTF8-char )
    UTF8-char   = UTF8-1 / UTF8-2 / UTF8-3 / UTF8-4
    UTF8-1      = %x00-7F
    UTF8-2      = %xC2-DF UTF8-tail
      Notice that values C0 and C1 are forbidden, hence %xC2
    UTF8-3      = %xE0 %xA0-BF UTF8-tail / %xE1-EC 2( UTF8-tail ) /
                  %xED %x80-9F UTF8-tail / %xEE-EF 2( UTF8-tail )
      Notice that E0 = 224 adds a restriction on second octet.
      Notice that ED = 237 adds a restriction on second octet.
    UTF8-4      = %xF0 %x90-BF 2( UTF8-tail ) / %xF1-F3 3( UTF8-tail ) /
                  %xF4 %x80-8F 2( UTF8-tail )
      Notice that F0 = 240 adds a restriction on second octet.
      Notice that F4 = 244 adds a restriction on second octet.
    UTF8-tail   = %x80-BF
    */
    if($i_continuation_octet_needed > 0){
      if(
        $i_current_octet < $i_current_continuation_octet_minimum
        || $i_current_octet > $i_current_continuation_octet_maximum
      ){
        [
          'message' => $s_message,
          'data' => $arr_data,
        ] = get_message_and_data_array(
          $s_message_for_continuation_octet_above_maximum !== null
          && $i_current_octet > $i_current_continuation_octet_maximum
          ? $s_message_for_continuation_octet_above_maximum
          : ' which is not a continuation octet.',
          $i_current_octet,
          $i_continuation_octet_needed,
          $i_offset_in_octets_from_string_start,
          $i_offset_in_characters_from_string_start,
          $i_character_start_position_from_string_start,
          $i_current_line_number,
          $i_offset_in_octets_from_line_start,
          $i_offset_in_characters_from_line_start,
          $i_character_start_position_from_line_start,
          $i_current_continuation_octet_minimum,
          $i_current_continuation_octet_maximum,
        );
        throw new InvalidEncodingException($s_message, $arr_data);
      }//end if($i_current_octet < 128 || $i_current_octet >= 192)
      --$i_continuation_octet_needed;
      $i_current_continuation_octet_minimum = (
        $I_CONTINUATION_OCTET_MINIMUM
      );
      $i_current_continuation_octet_maximum = (
        $I_CONTINUATION_OCTET_MAXIMUM
      );
      continue;
    }//end if($i_continuation_octet_needed > 0)

    ++$i_offset_in_characters_from_string_start;
    ++$i_offset_in_characters_from_line_start;
    $i_character_start_position_from_string_start = (
      $i_offset_in_octets_from_string_start
    );
    $i_character_start_position_from_line_start = (
      $i_offset_in_octets_from_line_start
    );

    if($i_current_octet < 128){ // 0xxxxxxx ASCII
      // if($s_string[$i] === "\n"){
      if($i_current_octet === 10){
        ++$i_current_line_number;
        $i_offset_in_octets_from_line_start = -1;
        $i_offset_in_characters_from_line_start = -1;
      }
      continue;
    }

    if(/*$i_current_octet >= 128 &&*/ $i_current_octet < 192){
      [
        'message' => $s_message,
        'data' => $arr_data,
      ] = get_message_and_data_array(
        ' which is a continuation octet.',
        $i_current_octet,
        $i_continuation_octet_needed,
        $i_offset_in_octets_from_string_start,
        $i_offset_in_characters_from_string_start,
        $i_character_start_position_from_string_start,
        $i_current_line_number,
        $i_offset_in_octets_from_line_start,
        $i_offset_in_characters_from_line_start,
        $i_character_start_position_from_line_start,
        $i_current_continuation_octet_minimum,
        $i_current_continuation_octet_maximum,
      );
      throw new InvalidEncodingException($s_message, $arr_data);
    }//end if($i_current_octet >= 128 && $i_current_octet < 192)

    if(/*$i_current_octet >= 192 &&*/ $i_current_octet < 224){
      // 110xxxxx 10xxxxxx
      $i_continuation_octet_needed = 1;
      continue;
    }

    if(/*$i_current_octet >= 224 &&*/ $i_current_octet < 240){
      // 1110xxxx 10xxxxxx 10xxxxxx
      $i_continuation_octet_needed = 2;
      /*
      UTF8-3 = %xE0 %xA0-BF UTF8-tail / %xE1-EC 2( UTF8-tail ) /
               %xED %x80-9F UTF8-tail / %xEE-EF 2( UTF8-tail )
      Notice that E0 = 224 adds a restriction on second octet.
      Notice that ED = 237 adds a restriction on second octet.

      The definition of UTF-8 prohibits encoding character numbers between
      U+D800 and U+DFFF.
      D8 = 13*16 + 8  = 216 = 11010100
      DF = 13*16 + 15 = 223 = 11010101
      216*256 = 55296       = 1101 1000 0000 0000 = D800
      to
      223*256 + 255 = 57343 = 1101 1111 1111 1111 = DFFF

      1110xxxx
      11101101 = 237 = ED

      237,160,128
      237,191,191
      Thus, the whole "continuation range" is forbidden if start
      is 237 and second octet, first continuation octet, is >= 160.
      */
      if($i_current_octet === 224){
        $i_current_continuation_octet_minimum = 160;
        $i_current_continuation_octet_maximum = 191;  // Normal value
      }
      if($i_current_octet === 237){
        $i_current_continuation_octet_minimum = 128;  // Normal value
        $i_current_continuation_octet_maximum = 159;
        $s_message_for_continuation_octet_above_maximum = (
          ' which is into the forbidden range of surrogate pairs.'
        );
      }
      continue;
    }//end if(/*$i_current_octet >= 224 &&*/ $i_current_octet < 240)

    if(/*$i_current_octet >= 240 &&*/ $i_current_octet < /*248*/ 245){
      // 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
      $i_continuation_octet_needed = 3;
      /*
      UTF8-4 = %xF0 %x90-BF 2( UTF8-tail ) / %xF1-F3 3( UTF8-tail ) /
               %xF4 %x80-8F 2( UTF8-tail )
      Notice that F0 = 240 adds a restriction on second octet.
      Notice that F4 = 244 adds a restriction on second octet.
      */
      if($i_current_octet === 240){
        $i_current_continuation_octet_minimum = 144;
        $i_current_continuation_octet_maximum = 191;  // Normal value
      }
      if($i_current_octet === 244){
        $i_current_continuation_octet_minimum = 128;  // Normal value
        $i_current_continuation_octet_maximum = 143;
      }
      continue;
    }

    [
      'message' => $s_message,
      'data' => $arr_data,
    ] = get_message_and_data_array(
      ' which is invalid.',
      $i_current_octet,
      $i_continuation_octet_needed,
      $i_offset_in_octets_from_string_start,
      $i_offset_in_characters_from_string_start,
      $i_character_start_position_from_string_start,
      $i_current_line_number,
      $i_offset_in_octets_from_line_start,
      $i_offset_in_characters_from_line_start,
      $i_character_start_position_from_line_start,
      $i_current_continuation_octet_minimum,
      $i_current_continuation_octet_maximum,
    );
    throw new InvalidEncodingException($s_message, $arr_data);
  }//end for($i = 0, $i_max = strlen($s_string); $i < $i_max; ++$i)

  if ($i_continuation_octet_needed > 0) {
    [
      'message' => $s_message,
      'data' => $arr_data,
    ] = get_message_and_data_array(
      '; end of string was found instead of a continuation octet.',
      $i_current_octet,
      $i_continuation_octet_needed,
      $i_offset_in_octets_from_string_start,
      $i_offset_in_characters_from_string_start,
      $i_character_start_position_from_string_start,
      $i_current_line_number,
      $i_offset_in_octets_from_line_start,
      $i_offset_in_characters_from_line_start,
      $i_character_start_position_from_line_start,
      $i_current_continuation_octet_minimum,
      $i_current_continuation_octet_maximum,
    );
    throw new InvalidEncodingException($s_message, $arr_data);
  }

  if($b_fast_path){
    throw new InvalidEncodingException(
      "Fast-path detected an error that this function couldn't found."
      .'Please create an issue at '
      .'"https://github.com/LLyaudet/DevOrSysAdminScripts/issues".',
      [],
    );
  }

  return true;
}//end check_string_is_valid_UTF8()



/**
This function throws an exception with extended debug informations
if the content of the file with given file_path is not valid UTF-8.
Otherwise, it returns true.

@param string $s_file_path The input file_path.
@param bool $b_fast_path Use the fast-path or not to check quickly that
                         there is no error.

@throws \Exception When the file is not found OR when called with
                   $b_fast_path set to true but PHP version is
                   incompatible.
@throws DOSAS_unicode\InvalidEncodingException When the input string is not
                                               valid UTF-8.

@return bool
*/
function check_file_is_valid_UTF8(
  string $s_file_path,
  bool $b_fast_path = true,
) : bool {
  $s_string = file_get_contents($s_file_path);
  if($s_string === false){
    throw new \Exception('File '.$s_file_path.' not found.');
  }
  return check_string_is_valid_UTF8($s_string, $b_fast_path);
}//end check_file_is_valid_UTF8()



/*
?>
<?php
require_once("./unicode_exceptions.libr.php");
require_once("./unicode.libr.php");
var_dump(DOSAS_unicode\hexa_code_point_to_UTF8("002B"));
var_dump(DOSAS_unicode\hexa_code_point_to_UTF8("00E6"));
var_dump(DOSAS_unicode\hexa_code_point_to_UTF8("1400"));
var_dump(DOSAS_unicode\hexa_code_point_to_UTF8("10111"));
// https://en.wikibooks.org/wiki/Unicode/Character_reference/2000-2FFF
// Some invisible unicode characters that are a problem:
// 2000-200F 2028-202F 205F 2060-206F
$arr = [
  '2000', '2001', '2002', '2003', '2004', '2005', '2006', '2007',
  '2008', '2009', '200A', '200B', '200C', '200D', '200E', '200F',
  '2028', '2029', '202A', '202B', '202C', '202D', '202E', '202F',
  '205F',
  '2060', '2061', '2062', '2063', '2064', '2065', '2066', '2067',
  '2068', '2069', '206A', '206B', '206C', '206D', '206E', '206F',
];
$arr_s = [];
$arr_s2 = [];
$arr_s3 = [];
echo("sed\\\n");
foreach($arr as $s_hexa){
  $s = DOSAS_unicode\hexa_code_point_to_UTF8($s_hexa);
  $arr_s []= $s;
  if(strlen($s) === 2){
    $s2 = '\x'.bin2hex($s[0]).'\x'.bin2hex($s[1]);
  }
  if(strlen($s) === 3){
    $s2 = '\x'.bin2hex($s[0]).'\x'.bin2hex($s[1])
      .'\x'.bin2hex($s[2]);
  }
  $arr_s2 []= $s2;
  $s3 = "  --expression='s/".$s2."/ /g'\\";
  $arr_s3 []= $s3;
  echo($s3."\n");
}

?>
<?php
require_once("./unicode_exceptions.libr.php");
require_once("./unicode.libr.php");
// var_dump(DOSAS_unicode\check_file_is_valid_UTF8("validutf8.json"));
// var_dump(DOSAS_unicode\check_file_is_valid_UTF8("nonvalidutf8.json"));
var_dump(DOSAS_unicode\check_string_is_valid_UTF8("abcdé"));
var_dump(DOSAS_unicode\check_string_is_valid_UTF8("abcdé", true, false));
var_dump(DOSAS_unicode\check_string_is_valid_UTF8("abcdé", false, true));
var_dump(
  DOSAS_unicode\check_string_is_valid_UTF8("abcd".chr(233), true, false)
);
if(true){
  var_dump(DOSAS_unicode\check_string_is_valid_UTF8("abcd".chr(233)));
}
else{
  var_dump(
    DOSAS_unicode\check_string_is_valid_UTF8("abcd".chr(233), false, true)
  );
}
//*/
?>
