#!/usr/bin/env bash
# This file is part of DevOrSysAdminScripts library.
#
# DevOrSysAdminScripts is free software:
# you can redistribute it and/or modify it under the terms
# of the GNU Lesser General Public License
# as published by the Free Software Foundation,
# either version 3 of the License,
# or (at your option) any later version.
#
# DevOrSysAdminScripts is distributed in the hope
# that it will be useful,
# but WITHOUT ANY WARRANTY;
# without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU Lesser General Public License for more details.
#
# You should have received a copy of
# the GNU Lesser General Public License
# along with DevOrSysAdminScripts.
# If not, see <https://www.gnu.org/licenses/>.
#
# ©Copyright 2023-2024 Laurent Frédéric Bernard François Lyaudet

# https://en.wikibooks.org/wiki/Unicode/Character_reference/2000-2FFF
# Some invisible unicode characters that are a problem:
# 2000-200F 2028-202F 205F 2060-206F
# [
#   '2000', '2001', '2002', '2003', '2004', '2005', '2006', '2007',
#   '2008', '2009', '200A', '200B', '200C', '200D', '200E', '200F',
#   '2028', '2029', '202A', '202B', '202C', '202D', '202E', '202F',
#   '205F',
#   '2060', '2061', '2062', '2063', '2064', '2065', '2066', '2067',
#   '2068', '2069', '206A', '206B', '206C', '206D', '206E', '206F',
# ]
replace_non_ascii_spaces(){
  sed -e 's/\xc2\xa0/ /g'\
  | sed -e 's/\xe2\x00\x80/ /g'\
  | sed -e 's/\xe2\x01\x81/ /g'\
  | sed -e 's/\xe2\x02\x82/ /g'\
  | sed -e 's/\xe2\x03\x83/ /g'\
  | sed -e 's/\xe2\x04\x84/ /g'\
  | sed -e 's/\xe2\x05\x85/ /g'\
  | sed -e 's/\xe2\x06\x86/ /g'\
  | sed -e 's/\xe2\x07\x87/ /g'\
  | sed -e 's/\xe2\x08\x88/ /g'\
  | sed -e 's/\xe2\x09\x89/ /g'\
  | sed -e 's/\xe2\x0a\x8a/ /g'\
  | sed -e 's/\xe2\x0b\x8b/ /g'\
  | sed -e 's/\xe2\x0c\x8c/ /g'\
  | sed -e 's/\xe2\x0d\x8d/ /g'\
  | sed -e 's/\xe2\x0e\x8e/ /g'\
  | sed -e 's/\xe2\x0f\x8f/ /g'\
  | sed -e 's/\xe2\x28\xa8/ /g'\
  | sed -e 's/\xe2\x29\xa9/ /g'\
  | sed -e 's/\xe2\x2a\xaa/ /g'\
  | sed -e 's/\xe2\x2b\xab/ /g'\
  | sed -e 's/\xe2\x2c\xac/ /g'\
  | sed -e 's/\xe2\x2d\xad/ /g'\
  | sed -e 's/\xe2\x2e\xae/ /g'\
  | sed -e 's/\xe2\x2f\xaf/ /g'\
  | sed -e 's/\xe2\x20\x9f/ /g'\
  | sed -e 's/\xe2\x21\xa0/ /g'\
  | sed -e 's/\xe2\x22\xa1/ /g'\
  | sed -e 's/\xe2\x23\xa2/ /g'\
  | sed -e 's/\xe2\x24\xa3/ /g'\
  | sed -e 's/\xe2\x25\xa4/ /g'\
  | sed -e 's/\xe2\x26\xa5/ /g'\
  | sed -e 's/\xe2\x27\xa6/ /g'\
  | sed -e 's/\xe2\x28\xa7/ /g'\
  | sed -e 's/\xe2\x29\xa8/ /g'\
  | sed -e 's/\xe2\x2a\xa9/ /g'\
  | sed -e 's/\xe2\x2b\xaa/ /g'\
  | sed -e 's/\xe2\x2c\xab/ /g'\
  | sed -e 's/\xe2\x2d\xac/ /g'\
  | sed -e 's/\xe2\x2e\xad/ /g'\
  | sed -e 's/\xe2\x2f\xae/ /g'\
  | sed -e 's/\xe2\x30\xaf/ /g'
}
