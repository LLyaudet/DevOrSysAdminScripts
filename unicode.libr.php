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



/**
Converts an int to the byte-string corresponding to the UTF-8 encoding
of the Unicode code point of same integer value.
decimal_code_point is a slight abuse of language to say that you write the
code point in decimal notation in PHP code and you get the UTF-8.
If you provide the integer of the code point without using decimal
notation, it will also work.

@param int<0, 2097151> $i_code_point_in_decimal_notation The code point.

@throws Exception When the code point is outside of Unicode range.

@return string The corresponding UTF-8 character.
*/
function decimal_code_point_to_UTF8(
  int $i_code_point_in_decimal_notation
) : string {
  // var_dump($i_code_point_in_decimal_notation);
  // 0xxxxxxx ASCII
  if($i_code_point_in_decimal_notation < 128){
    return chr($i_code_point_in_decimal_notation);
  }
  $i_continuation_base_value = 128;
  // 110xxxxx 10xxxxxx
  if($i_code_point_in_decimal_notation < 2048){  // 2**11
    $i_first_byte_base_value = 192;
    /*
    $i_last_byte_significant_bits = (
      $i_code_point_in_decimal_notation % 64  // 2**6
    );
    $i_first_byte_significant_bits = intdiv(
      (
        $i_code_point_in_decimal_notation
        - $i_last_byte_significant_bits
      ),
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
      chr(
        $i_first_byte_base_value
        + ($i_code_point_in_decimal_notation >> 6)
      )
      .chr(
        $i_continuation_base_value
        + ($i_code_point_in_decimal_notation & 63)
      )
    );
  }//end if($i_code_point_in_decimal_notation < 2048)
  // 1110xxxx 10xxxxxx 10xxxxxx
  if($i_code_point_in_decimal_notation < 65536){  // 2**16
    $i_first_byte_base_value = 224;
    /*
    $arr_arr_data_per_byte_reverse = [
      ['i_bits' => 6, 'i_base_value' => $i_continuation_base_value],
      ['i_bits' => 6, 'i_base_value' => $i_continuation_base_value],
      ['i_bits' => 4, 'i_base_value' => $i_first_byte_base_value],
    ];
    $i_rest = $i_code_point_in_decimal_notation;
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
      chr(
        $i_first_byte_base_value
        + ($i_code_point_in_decimal_notation >> 12)
      )
      .chr(
        $i_continuation_base_value
        + (($i_code_point_in_decimal_notation >> 6) & 63)
      )
      .chr(
        $i_continuation_base_value
        + ($i_code_point_in_decimal_notation & 63)
      )
    );
  }//end if($i_code_point_in_decimal_notation < 65536)
  // 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
  // if($i_code_point_in_decimal_notation < 2097152){  // 2**21
    $i_first_byte_base_value = 240;
    /*
    $arr_arr_data_per_byte_reverse = [
      ['i_bits' => 6, 'i_base_value' => $i_continuation_base_value],
      ['i_bits' => 6, 'i_base_value' => $i_continuation_base_value],
      ['i_bits' => 6, 'i_base_value' => $i_continuation_base_value],
      ['i_bits' => 3, 'i_base_value' => $i_first_byte_base_value],
    ];
    $i_rest = $i_code_point_in_decimal_notation;
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
      chr(
        $i_first_byte_base_value
        + ($i_code_point_in_decimal_notation >> 18)
      )
      .chr(
        $i_continuation_base_value
        + (($i_code_point_in_decimal_notation >> 12) & 63)
      )
      .chr(
        $i_continuation_base_value
        + (($i_code_point_in_decimal_notation >> 6) & 63)
      )
      .chr(
        $i_continuation_base_value
        + ($i_code_point_in_decimal_notation & 63)
      )
    );
  // }//end if($i_code_point_in_decimal_notation < 2097152)
  /*
  // phpcs:disable Squiz.Strings.DoubleQuoteUsage.NotRequired
  throw new Exception(
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
  */
}//end decimal_code_point_to_UTF8()



/**
Converts a string of hexadecimal digits to the byte-string corresponding
to the UTF-8 encoding of the Unicode code point of same integer value
that is denoted by the hexadecimal digits.

@param string $s_code_point_in_hexadecimal_notation The code point.

@throws Exception When the code point is outside of Unicode range.

@return string The corresponding UTF-8 character.
*/
function hexa_code_point_to_UTF8(
  string $s_code_point_in_hexadecimal_notation
) : string {
  $s_code_point_in_hexadecimal_notation = strtoupper(
    $s_code_point_in_hexadecimal_notation
  );
  $i_code_point_in_decimal_notation = 0;
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
    $i_code_point_in_decimal_notation *= 16;
    if(ctype_digit($s_hexa_digit)){
      $i_code_point_in_decimal_notation += (
        ord($s_hexa_digit) + $i_digit_offset
      );
      continue;
    }
    if(ctype_xdigit($s_hexa_digit)){
      $i_code_point_in_decimal_notation += (
        ord($s_hexa_digit) + $i_letter_offset
      );
      continue;
    }
    throw new Exception('Not an hexadecimal digit.');
  }
  if($i_code_point_in_decimal_notation > 2097151){
    throw new Exception(
      'Hexadecimal integer is greater than UTF-8 maximum code point.'
    );
  }
  return decimal_code_point_to_UTF8(
    $i_code_point_in_decimal_notation
  );
}//end hexa_code_point_to_UTF8()




class DOSAS_WithDataArrayException extends \Exception{
  /**
  @var array
  */
  protected $arr_data;

  /**
  @param string $message
  @param array $data
  @return void
  */
  public function __construct(string $message, array $arr_data = []){
    $this->arr_data = $arr_data;
    parent::__construct($message);
  }

  /**
  @return array
  */
  public function get_data(){
    return $this->arr_data;
  }
}




class DOSAS_InvalidEncodingException extends DOSAS_WithDataArrayException{
}




/**
This function throws an exception with extended debug informations
if the input string is not valid ASCII.
Otherwise, it returns true.

@param string $s_string The input string.

@throws DOSAS_InvalidEncodingException
  When the input string is not valid ASCII.

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
      throw new DOSAS_InvalidEncodingException(
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
    }
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

@throws Exception When the input string is not valid ASCII.

@return bool
*/
function check_file_is_valid_ASCII(string $s_file_path) : bool {
  $s_string = file_get_contents($s_file_path);
  if($s_string === false){
    throw new Exception('File '.$s_file_path.' not found.');
  }
  return check_string_is_valid_ASCII($s_string);
}//end check_file_is_valid_ASCII()



/**
This function returns the message string and data array for
DOSAS_InvalidEncodingException inside check_string_is_valid_UTF8().

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
function DOSAS_get_message_and_data_array(
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
){
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
}//end DOSAS_get_message()



/**
This function throws an exception with extended debug informations
if the input string is not valid UTF-8.
Otherwise, it returns true.

See https://datatracker.ietf.org/doc/html/rfc3629

@param string $s_string The input string.

@throws Exception When the input string is not valid UTF-8.

@return bool
*/
function check_string_is_valid_UTF8(string $s_string) : bool {

  //Fast-path
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
        'message' => $s_message, 'data' => $arr_data
      ] = DOSAS_get_message_and_data_array(
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
      );
      throw new DOSAS_InvalidEncodingException($s_message, $arr_data);
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
          'message' => $s_message, 'data' => $arr_data
        ] = DOSAS_get_message_and_data_array(
          ' which is not a continuation octet.',
          $i_current_octet,
          $i_continuation_octet_needed,
          $i_offset_in_octets_from_string_start,
          $i_offset_in_characters_from_string_start,
          $i_character_start_position_from_string_start,
          $i_current_line_number,
          $i_offset_in_octets_from_line_start,
          $i_offset_in_characters_from_line_start,
          $i_character_start_position_from_line_start,
        );
        throw new DOSAS_InvalidEncodingException($s_message, $arr_data);
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
        'message' => $s_message, 'data' => $arr_data
      ] = DOSAS_get_message_and_data_array(
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
      );
      throw new DOSAS_InvalidEncodingException($s_message, $arr_data);
    }//end if($i_current_octet >= 128 && $i_current_octet < 192)

    /*
    The definition of UTF-8 prohibits encoding character numbers between
    U+D800 and U+DFFF.
    D8 = 13*16 + 8  = 216 = 11010100
    DF = 13*16 + 15 = 223 = 11010101
    */
    if($i_current_octet >= 216 && $i_current_octet <= 223){
      [
        'message' => $s_message, 'data' => $arr_data
      ] = DOSAS_get_message_and_data_array(
        ' which is into forbidden range of values D8 to DF'
        .' for first octet of character.',
        $i_current_octet,
        $i_continuation_octet_needed,
        $i_offset_in_octets_from_string_start,
        $i_offset_in_characters_from_string_start,
        $i_character_start_position_from_string_start,
        $i_current_line_number,
        $i_offset_in_octets_from_line_start,
        $i_offset_in_characters_from_line_start,
        $i_character_start_position_from_line_start,
      );
      throw new DOSAS_InvalidEncodingException($s_message, $arr_data);
    }

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
      */
      if($i_current_octet === 224){
        $i_current_continuation_octet_minimum = 160;
        $i_current_continuation_octet_maximum = 191;  // Normal value
      }
      if($i_current_octet === 237){
        $i_current_continuation_octet_minimum = 128;  // Normal value
        $i_current_continuation_octet_maximum = 159;
      }
      continue;
    }
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
      'message' => $s_message, 'data' => $arr_data
    ] = DOSAS_get_message_and_data_array(
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
    );
    throw new DOSAS_InvalidEncodingException($s_message, $arr_data);
  }//end for($i = 0, $i_max = strlen($s_string); $i < $i_max; ++$i)

  if ($i_continuation_octet_needed > 0) {
    [
      'message' => $s_message, 'data' => $arr_data
    ] = DOSAS_get_message_and_data_array(
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
    );
  }

  return true;
}//end check_string_is_valid_UTF8()



/**
This function throws an exception with extended debug informations
if the content of the file with given file_path is not valid UTF-8.
Otherwise, it returns true.

@param string $s_file_path The input file_path.

@throws Exception When the input string is not valid UTF-8.

@return bool
*/
function check_file_is_valid_UTF8(string $s_file_path) : bool {
  $s_string = file_get_contents($s_file_path);
  if($s_string === false){
    throw new Exception('File '.$s_file_path.' not found.');
  }
  return check_string_is_valid_UTF8($s_string);
}//end check_file_is_valid_UTF8()



/*
?>
<?php
require_once("./unicode.libr.php");
var_dump(hexa_code_point_to_UTF8("002B"));
var_dump(hexa_code_point_to_UTF8("00E6"));
var_dump(hexa_code_point_to_UTF8("1400"));
var_dump(hexa_code_point_to_UTF8("10111"));
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
  $s = hexa_code_point_to_UTF8($s_hexa);
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
//*/
?>
