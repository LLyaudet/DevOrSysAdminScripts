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
# This file was renamed from "check_shell_scripts_beginnings.sh"
# to "check_shell_scripts_beginnings.libr.sh".

check_one_shell_script_beginning(){
  declare -r LFBFL_file_name=$(basename "$1")
  if [[ "${LFBFL_file_name}" =~ license_file_header_.*\.sh ]]; then
    return 0
  fi
  # shellcheck disable=SC2312
  diff <(head -n 1 "$1") <(echo '#!/usr/bin/env bash')
}


check_shell_scripts_beginnings(){
  shopt -s globstar
  local LFBFL_file_name
  for LFBFL_file_name in **/*.sh; do
    check_one_shell_script_beginning "${LFBFL_file_name}"
  done
}
