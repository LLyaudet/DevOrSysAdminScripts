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

unprotected_funny(){
  # Works in a script but not in shell if job control is active.
  shopt -s lastpipe
  declare -i LFBFL_i_result=0
  local LFBFL_line
  printf "hahaha\n" | while read -r LFBFL_line; do
    if [[ "${LFBFL_line}" == "hahaha" ]]; then
      LFBFL_i_result=1
    fi
  done
  [[ LFBFL_i_result -eq 1 ]] && printf "I had a good laugh.\n"
}

protected_funny(){
  # Always works regarding the echoes.
  printf "hahaha\n" | while read -r LFBFL_line; do
    unprotected_funny
  done
}
