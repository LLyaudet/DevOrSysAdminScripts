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
*/

function decimal_code_point_to_UTF8(
  $i_code_point_in_decimal_notation
){
  // var_dump($i_code_point_in_decimal_notation);
  // 0xxxxxxx ASCII
  if($i_code_point_in_decimal_notation < 128){
    return chr($i_code_point_in_decimal_notation);
  }
  $i_continuation_base_value = 128;
  // 110xxxxx 10xxxxxx
  if($i_code_point_in_decimal_notation < 256 * (2**3)){
    $i_first_byte_base_value = 192;
    $i_last_byte_significant_bits = (
      $i_code_point_in_decimal_notation % (2**6)
    );
    $i_first_byte_significant_bits = (int) (
      (
        $i_code_point_in_decimal_notation
        - $i_last_byte_significant_bits
      ) / (2**6)
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
  }
  // 1110xxxx 10xxxxxx 10xxxxxx
  if($i_code_point_in_decimal_notation < 256 * 256){
    $i_first_byte_base_value = 224;
    $i_last_byte_significant_bits = (
      $i_code_point_in_decimal_notation % (2**6)
    );
    $i_first_bytes_significant_bits = (int) (
      (
        $i_code_point_in_decimal_notation
        - $i_last_byte_significant_bits
      ) / (2**6)
    );
    $i_other_continuation_byte_significant_bits = (
      $i_first_bytes_significant_bits % (2**6)
    );
    $i_first_byte_significant_bits = (int) (
      (
        $i_first_bytes_significant_bits
        - $i_other_continuation_byte_significant_bits
      ) / (2**6)
    );
    $s_result = chr(
      $i_first_byte_base_value
      + $i_first_byte_significant_bits
    );
    $s_result .= chr(
      $i_other_continuation_byte_significant_bits
      + $i_last_byte_significant_bits
    );
    $s_result .= chr(
      $i_continuation_base_value
      + $i_last_byte_significant_bits
    );
    return $s_result;
  }
  // 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
  if($i_code_point_in_decimal_notation < 256 * 256 * (2**5)){
    $i_first_byte_base_value = 240;
    $arr_arr_data_per_byte_reverse = [
      ["i_bits" => 6, "i_base_value" => $i_continuation_base_value],
      ["i_bits" => 6, "i_base_value" => $i_continuation_base_value],
      ["i_bits" => 6, "i_base_value" => $i_continuation_base_value],
      ["i_bits" => 3, "i_base_value" => $i_first_byte_base_value],
    ];
    $i_rest = $i_code_point_in_decimal_notation;
    $s_result = "";
    foreach($arr_arr_data_per_byte_reverse as $arr_data){
      $i_significant_bits = $i_rest % (2**$arr_data["i_bits"]);
      $i_rest = (int) (
        ($i_rest - $i_significant_bits) / (2**$arr_data["i_bits"])
      );
      $s_result = chr($i_significant_bits).$s_result; // .= or =.
    }
    return $s_result;
    // TODO factoriser comme ce if, la flemme là tout de suite
    // (5 h 22 du matin).
  }
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
}



function hexa_code_point_to_UTF8(
  $s_code_point_in_hexadecimal_notation
){
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
    throw new Exception("Not an hexadecimal digit.");
  } 
  return decimal_code_point_to_UTF8(
    $i_code_point_in_decimal_notation
  );
}

/*
?>
<?php
require_once("./unicode.php");
var_dump(hexa_code_point_to_UTF8("002B"));
var_dump(hexa_code_point_to_UTF8("00E6"));
var_dump(hexa_code_point_to_UTF8("1400"));
var_dump(hexa_code_point_to_UTF8("10111"));
//*/

