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
This file was renamed from "unicode.php" to "unicode.libr.php".
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
    $i_first_byte_significant_bits = intdiv(
      (
        $i_code_point_in_decimal_notation
        - $i_last_byte_significant_bits
      ),
      (2**6),
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
    $arr_arr_data_per_byte_reverse = [
      ["i_bits" => 6, "i_base_value" => $i_continuation_base_value],
      ["i_bits" => 6, "i_base_value" => $i_continuation_base_value],
      ["i_bits" => 4, "i_base_value" => $i_first_byte_base_value],
    ];
    $i_rest = $i_code_point_in_decimal_notation;
    $s_result = "";
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
      $i_significant_bits = $i_rest % (2**$arr_data["i_bits"]);
      $i_rest = intdiv(
        $i_rest - $i_significant_bits,
        2**$arr_data["i_bits"],
      );
      $s_result = (  // .= or =.
        chr($i_significant_bits + $arr_data["i_base_value"])
        .$s_result
      );
    }
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
      // _Pragma unroll
      $i_significant_bits = $i_rest % (2**$arr_data["i_bits"]);
      $i_rest = intdiv(
        $i_rest - $i_significant_bits,
        2**$arr_data["i_bits"],
      );
      $s_result = (  // .= or =.
        chr($i_significant_bits + $arr_data["i_base_value"])
        .$s_result
      );
    }
    return $s_result;
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



function check_string_is_valid_ASCII($s_string){
  for($i = 0, $i_max = strlen($s_string); $i < $i_max; ++$i){
    if(ord($s_string[$i]) > 127){
      throw new Exception(
        "Non-ASCII character found at octet position "
        .$i
        .", value "
        .ord($s_string[$i])
        ."."
      );
    }
  }
  return true;
}



function check_file_is_valid_ASCII($s_file_name){
  $s_string = file_get_contents($s_file_name);
  if($s_string === false){
    throw new Exception("File ".$s_file_name." not found.");
  }
  return check_string_is_valid_ASCII($s_string);
}



function check_string_is_valid_UTF8($s_string){
  $i_continuation_octet_needed = 0;
  $i_character_start_position = 0;
  for($i = 0, $i_max = strlen($s_string); $i < $i_max; ++$i){
    $i_current_octet = ord($s_string[$i]);
    if($i_continuation_octet_needed > 0){
      if($i_current_octet < 128 || $i_current_octet >= 192){
        throw new Exception(
          "Non-UTF8 character found at start position "
          .$i_character_start_position
          .", octet at position "
          .$i
          ." has value "
          .$i_current_octet
          ." which is not a continuation octet."
        );
      }
      --$i_continuation_octet_needed;
      continue;
    }

    $i_character_start_position = $i;
    if($i_current_octet < 128){ // 0xxxxxxx ASCII
      continue;
    }
    if($i_current_octet >= 128 && $i_current_octet < 192){
      throw new Exception(
        "Non-UTF8 character found at start position "
        .$i_character_start_position
        .", octet at position "
        .$i
        ." has value "
        .$i_current_octet
        ." which is a continuation octet."
      );
    }
    if($i_current_octet >= 192 && $i_current_octet < 224){
      // 110xxxxx 10xxxxxx
      $i_continuation_octet_needed = 1;
      continue;
    }
    if($i_current_octet >= 224 && $i_current_octet < 240){
      // 1110xxxx 10xxxxxx 10xxxxxx
      $i_continuation_octet_needed = 2;
      continue;
    }
    if($i_current_octet >= 240 && $i_current_octet < 248){
      // 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
      $i_continuation_octet_needed = 3;
      continue;
    }
    throw new Exception(
      "Non-UTF8 character found at start position "
      .$i_character_start_position
      .", octet at position "
      .$i
      ." has value "
      .$i_current_octet
      ." which is invalid."
    );
  }
  return true;
}



function check_file_is_valid_UTF8($s_file_name){
  $s_string = file_get_contents($s_file_name);
  if($s_string === false){
    throw new Exception("File ".$s_file_name." not found.");
  }
  return check_string_is_valid_UTF8($s_string);
}



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
  $s3 = "  | sed -e 's/".$s2."/ /g'\\";
  $arr_s3 []= $s3;
  echo($s3."\n");
}
//*/

