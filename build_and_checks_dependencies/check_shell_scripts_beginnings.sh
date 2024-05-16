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

check_one_shell_script_beginning(){
  LFBFL_file_name=$(basename "$1")
  if [[ "$LFBFL_file_name" =~ license_file_header_.*\.sh ]];
  then
    return 0
  fi
  diff <(head -n 1 "$1") <(echo '#!/usr/bin/env bash')
}


check_shell_scripts_beginnings(){
  shopt -s globstar
  for check_shell_scripts_beginnings_var_i in **/*.sh; do
    check_one_shell_script_beginning\
      "$check_shell_scripts_beginnings_var_i"
  done
}
