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
# ©Copyright 2023-2024 Laurent Lyaudet

subdir="build_and_checks_dependencies"
source "./$subdir/get_common_text_glob_patterns.sh"

too_long_code_lines(){
  get_common_text_files_glob_patterns
  for pattern in "${common_file_patterns[@]}"; do
    [ "$1" != "-v" ] || echo "Iterating on pattern: $pattern"
    find . -type f -name "$pattern" -printf '%P\n'\
      | xargs grep -H '.\{71\}'
  done
}
