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

declare -gr LFBFL_SHELL_SCRIPT_BEGINNING="#!/usr/bin/env bash"

check_one_shell_script_beginning(){
  # declare -r LFBFL_file_name=$(basename "$1")
  # if [[ "${LFBFL_file_name}" =~ license_file_header_.*\.sh ]]; then
  #   return 0
  # fi
  # diff <(head -n 1 "$1") <(echo '#!/usr/bin/env bash')
  # ------------------------------------------------------------------
  # is of course slower than
  # ------------------------------------------------------------------
  # diff <(head -n 1 "$1") <(echo '#!/usr/bin/env bash')
  # ------------------------------------------------------------------
  # is of course slower than
  # ------------------------------------------------------------------
  declare -r LFBFL_head=$(head -n 1 "$1")
  [[ "${LFBFL_head}" == "${LFBFL_SHELL_SCRIPT_BEGINNING}" ]]\
    || echo "$1:File has wrong shell script beginning."
}

check_shell_scripts_beginnings(){
  shopt -s globstar
  local LFBFL_file_name
  local LFBFL_head
  for LFBFL_file_name in **/*.sh; do
    LFBFL_head=$(head -n 1 "${LFBFL_file_name}")
    [[ "${LFBFL_head}" == "${LFBFL_SHELL_SCRIPT_BEGINNING}" ]] ||\
      echo "${LFBFL_file_name}:File has wrong shell script beginning."
  done
}
