#!/usr/bin/env bash
# This file is part of DevOrSysAdminScripts library.
#
# DevOrSysAdminScripts is free software:
# you can redistribute it and/or modify it under the terms
# of the GNU General Public License
# as published by the Free Software Foundation,
# either version 3 of the License,
# or (at your option) any later version.
#
# DevOrSysAdminScripts is distributed in the hope
# that it will be useful,
# but WITHOUT ANY WARRANTY;
# without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.
#
# You should have received a copy of
# the GNU General Public License
# along with DevOrSysAdminScripts.
# If not, see <https://www.gnu.org/licenses/>.
#
# ©Copyright 2023-2026 Laurent Frédéric Bernard François Lyaudet
# This file was renamed from "overwrite_if_not_equal.sh"
# to "overwrite_if_not_equal.libr.sh".

overwrite_if_not_equal(){
  # $1=target_file_path
  # $2=temp_file_path
  # $3=keep_temp
  # $4=tree_mode : when the two files are the output of tree command,
  # we ignore if all the differences are only on directories timestamps.
  # $5=--quiet : we even don't want the message of diff saying that
  #              files are distinct
  # Return 0 target was the same
  #        1 target was different
  #        2 target did not already exist
  if [[ ! -f "$1" ]]; then
    if [[ -n "$3" ]]; then
      cp --preserve=mode,ownership,timestamps -- "$2" "$1"
    else
      mv -- "$2" "$1"
    fi
    return 2
  fi
  declare -i LFBFL_i_is_equal
  if [[ -n "$4" ]]; then
    # Not setting pipefail since the result would still be incorrect.
    # shellcheck disable=SC2312
    diff -- "$1" "$2"\
      | grep --extended-regexp "^(>|<)"\
      | grep --invert-match "/$"
    LFBFL_i_is_equal=${PIPESTATUS[2]}
    if [[ LFBFL_i_is_equal -eq 1 ]]; then
      grep --only-matching --regexp="[^ ]*/$" -- "$1"\
        > "overwrite_if_not_equal.file1.temp"
      grep --only-matching --regexp="[^ ]*/$" -- "$2"\
        > "overwrite_if_not_equal.file2.temp"
      if [[ -n "$5" ]]; then
        diff overwrite_if_not_equal.file1.temp\
          overwrite_if_not_equal.file2.temp\
          > /dev/null
      else
        diff overwrite_if_not_equal.file1.temp\
          overwrite_if_not_equal.file2.temp
      fi
      LFBFL_i_is_equal=1-$?
      rm overwrite_if_not_equal.file1.temp\
        overwrite_if_not_equal.file2.temp
    fi
  else
    if [[ -n "$5" ]]; then
      diff --brief -- "$1" "$2" > /dev/null
    else
      diff --brief -- "$1" "$2"
    fi
    LFBFL_i_is_equal=1-$?
  fi
  if [[ LFBFL_i_is_equal -eq 1 ]]; then
    if [[ -z "$3" ]]; then
      rm --"$2"
    fi
    return 0
  fi
  if [[ -n "$3" ]]; then
    cp --preserve=mode,ownership,timestamps -- "$2" "$1"
  else
    mv -- "$2" "$1"
  fi
  return 1
}
