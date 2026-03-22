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
# This file was renamed from "wget_sha512.sh"
# to "wget_sha512.libr.sh".

wget_sha512(){
  # $1 file_path
  # $2 download_URL
  # $3 correct_sha512
  # $4 optional --verbose
  local LFBFL_verbose=""
  if [[ "$*" == *--verbose* ]]; then
    printf "%s wget_sha512 %s\n" "$0" "$*"
    LFBFL_verbose="--verbose"
  fi
  readonly LFBFL_verbose
  if [[ ! -f "$1" ]]; then
    wget ${LFBFL_verbose:+"${LFBFL_verbose}"} -O "$1" "$2"
  fi
  declare -r LFBFL_present_sha512=$(
    sha512sum "$1"\
    | cut -f1 -d' '
  )
  if [[ "${LFBFL_present_sha512}" != "$3" ]]; then
    printf "%s does not have correct sha512:\n - wanted %s\n - found %s\n"\
      "$1" "$3" "${LFBFL_present_sha512}"
    return 1
  fi
}
