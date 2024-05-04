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

check_URLs(){
  get_common_text_glob_patterns

  declare -A substitutions
  substitutions=(\
    ["http://www.gnu.org/licenses/"]="https://www.gnu.org/licenses/"\
  )

  for pattern in "${common_patterns[@]}"; do
    [ "$1" != "-v" ] || echo "Iterating on pattern: $pattern"
    grep -r -H 'http:' -- "$pattern"
    for filename in $pattern; do
      [ -f "$filename" ] || continue
      base_filename=$(basename "$filename")
      [ "$base_filename" != "check_URLs.sh" ] || continue
      [ "$1" != "-v" ] || echo "Handling the file: $filename"
      for substitution in "${!substitutions[@]}"; do
        substitution2=${substitutions[$substitution]}
        if grep -q "$substitution" "$filename"; then
          sed -i "s|$substitution|$substitution2|g" "$filename"
        fi
      done
    done
  done
}
