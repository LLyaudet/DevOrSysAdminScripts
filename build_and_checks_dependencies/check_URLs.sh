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

subdir="build_and_checks_dependencies"
source "./$subdir/get_common_text_glob_patterns.sh"

check_URLs(){
  get_common_text_files_glob_patterns

  declare -A LFBFL_substitutions
  LFBFL_substitutions=(\
    ["http://www.gnu.org/licenses/"]="https://www.gnu.org/licenses/"\
  )

  for LFBFL_pattern in "${common_file_patterns[@]}"; do
    [ "$1" != "-v" ] || echo "Iterating on pattern: $LFBFL_pattern"
    find . -type f -name "$LFBFL_pattern" -printf '%P\n'\
      | xargs grep -H 'http:'\
      | grep -v "^[^:]*check_URLs.sh:"
    for LFBFL_file_name in $LFBFL_pattern; do
      [ -f "$LFBFL_file_name" ] || continue
      LFBFL_base_file_name=$(basename "$LFBFL_file_name")
      [ "$LFBFL_base_file_name" != "check_URLs.sh" ] || continue
      [ "$1" != "-v" ] || echo "Handling the file: $LFBFL_file_name"
      for LFBFL_substitution in "${!LFBFL_substitutions[@]}"; do
        LFBFL_substitution2=\
${LFBFL_substitutions[$LFBFL_substitution]}
        if grep -q "$LFBFL_substitution" "$LFBFL_file_name"; then
          sed -i "s|$LFBFL_substitution|$LFBFL_substitution2|g"\
            "$LFBFL_file_name"
        fi
      done
    done
  done
}
