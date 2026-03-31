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
  # $1=file_path
  # $2=download_URL
  # $3=correct_sha512
  # Options:
  #   --check-download (=keep to keep the downloaded file)
  #   --verbose
  local LFBFL_verbose=""
  if [[ "$*" == *--verbose* ]]; then
    printf "%s wget_sha512 %s\n" "$0" "$*"
    LFBFL_verbose="--verbose"
  fi
  readonly LFBFL_verbose
  local LFBFL_check_download=""
  if [[ "$*" == *--check-download=keep* ]]; then
    LFBFL_check_download="--check-download=keep"
  elif [[ "$*" == *--check-download* ]]; then
    LFBFL_check_download="--check-download"
  fi
  readonly LFBFL_check_download
  declare -i LFBFL_i_error=0

  if [[ ! -f "$1" ]]; then
    wget ${LFBFL_verbose:+"${LFBFL_verbose}"} --output-document="$1" "$2"
  fi
  declare -r LFBFL_present_sha512=$(
    sha512sum "$1"\
    | cut --fields=1 --delimiter=' '
  )
  if [[ "${LFBFL_present_sha512}" != "$3" ]]; then
    printf "%s does not have correct sha512:\n - wanted %s\n - found %s\n"\
      "$1" "$3" "${LFBFL_present_sha512}"
    LFBFL_i_error=1
  fi
  if [[ -n "${LFBFL_check_download}" ]]; then
    wget ${LFBFL_verbose:+"${LFBFL_verbose}"}\
      --output-document="$1.wget_sha512.temp"\
      "$2"
    declare -r LFBFL_present_sha512_2=$(
      sha512sum "$1.wget_sha512.temp"\
      | cut --fields=1 --delimiter=' '
    )
    if [[ "${LFBFL_check_download}" != "--check-download=keep" ]]; then
      rm "$1.wget_sha512.temp"
    fi
    if [[ "${LFBFL_present_sha512_2}" != "$3" ]]; then
      printf\
        "%s does not have correct sha512:\n - wanted %s\n - found %s\n"\
        "Online version of $1" "$3" "${LFBFL_present_sha512_2}"
      LFBFL_i_error=1
    fi
  fi
  # shellcheck disable=SC2248
  return ${LFBFL_i_error}
}
