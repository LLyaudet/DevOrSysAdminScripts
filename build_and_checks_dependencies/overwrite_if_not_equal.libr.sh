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
# ©Copyright 2023-2025 Laurent Frédéric Bernard François Lyaudet
# This file was renamed from "overwrite_if_not_equal.sh"
# to "overwrite_if_not_equal.libr.sh".

overwrite_if_not_equal(){
  # $1=$target_file_name
  # $2=$temp_file_name
  if [[ ! -f "$1" ]]; then
    mv "$2" "$1"
    return
  fi
  diff -q "$1" "$2"
  declare -ri LFBFL_is_equal=$?
  # shellcheck disable=SC2250
  if [[ $LFBFL_is_equal == 0 ]]; then
    rm "$2"
  else
    mv "$2" "$1"
  fi
}
