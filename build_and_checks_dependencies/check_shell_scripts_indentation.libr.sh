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
# This file was renamed from "check_shell_scripts_beginnings.sh"
# to "check_shell_scripts_beginnings.libr.sh".

declare -g LFBFL_SH_INDENTATION_MESSAGE
LFBFL_SH_INDENTATION_MESSAGE="File has some lines with odd number"
LFBFL_SH_INDENTATION_MESSAGE+=" of spaces."
readonly LFBFL_SH_INDENTATION_MESSAGE

check_one_shell_script_indentation(){
  if grep -EHn '^(  )* ([^ ]|$)' "$1"; then
    echo "$1:${LFBFL_SH_INDENTATION_MESSAGE}"
  fi
}

check_shell_scripts_indentation(){
  shopt -s globstar
  local LFBFL_file_name
  for LFBFL_file_name in **/*.sh; do
    if grep -EHn '^(  )* ([^ ]|$)' "${LFBFL_file_name}"; then
      echo "${LFBFL_file_name}:${LFBFL_SH_INDENTATION_MESSAGE}"
    fi
  done
}
