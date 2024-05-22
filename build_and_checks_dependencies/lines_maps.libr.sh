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
# This file was renamed from "lines_maps.sh" to "lines_maps.libr.sh".

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
  # shellcheck disable=SC2312
  sed -e 's/\xc2\xa0/ /g'\
  | sed -e 's/\xe2\x80\x80/ /g'\
  | sed -e 's/\xe2\x80\x81/ /g'\
  | sed -e 's/\xe2\x80\x82/ /g'\
  | sed -e 's/\xe2\x80\x83/ /g'\
  | sed -e 's/\xe2\x80\x84/ /g'\
  | sed -e 's/\xe2\x80\x85/ /g'\
  | sed -e 's/\xe2\x80\x86/ /g'\
  | sed -e 's/\xe2\x80\x87/ /g'\
  | sed -e 's/\xe2\x80\x88/ /g'\
  | sed -e 's/\xe2\x80\x89/ /g'\
  | sed -e 's/\xe2\x80\x8a/ /g'\
  | sed -e 's/\xe2\x80\x8b/ /g'\
  | sed -e 's/\xe2\x80\x8c/ /g'\
  | sed -e 's/\xe2\x80\x8d/ /g'\
  | sed -e 's/\xe2\x80\x8e/ /g'\
  | sed -e 's/\xe2\x80\x8f/ /g'\
  | sed -e 's/\xe2\x80\xa8/ /g'\
  | sed -e 's/\xe2\x80\xa9/ /g'\
  | sed -e 's/\xe2\x80\xaa/ /g'\
  | sed -e 's/\xe2\x80\xab/ /g'\
  | sed -e 's/\xe2\x80\xac/ /g'\
  | sed -e 's/\xe2\x80\xad/ /g'\
  | sed -e 's/\xe2\x80\xae/ /g'\
  | sed -e 's/\xe2\x80\xaf/ /g'\
  | sed -e 's/\xe2\x81\x9f/ /g'\
  | sed -e 's/\xe2\x81\xa0/ /g'\
  | sed -e 's/\xe2\x81\xa1/ /g'\
  | sed -e 's/\xe2\x81\xa2/ /g'\
  | sed -e 's/\xe2\x81\xa3/ /g'\
  | sed -e 's/\xe2\x81\xa4/ /g'\
  | sed -e 's/\xe2\x81\xa5/ /g'\
  | sed -e 's/\xe2\x81\xa6/ /g'\
  | sed -e 's/\xe2\x81\xa7/ /g'\
  | sed -e 's/\xe2\x81\xa8/ /g'\
  | sed -e 's/\xe2\x81\xa9/ /g'\
  | sed -e 's/\xe2\x81\xaa/ /g'\
  | sed -e 's/\xe2\x81\xab/ /g'\
  | sed -e 's/\xe2\x81\xac/ /g'\
  | sed -e 's/\xe2\x81\xad/ /g'\
  | sed -e 's/\xe2\x81\xae/ /g'\
  | sed -e 's/\xe2\x81\xaf/ /g'
}
