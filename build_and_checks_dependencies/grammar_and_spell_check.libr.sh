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
# This file was renamed from "grammar_and_spell_check.sh"
# to "grammar_and_spell_check.libr.sh".

subdir="build_and_checks_dependencies"
source "./$subdir/get_common_text_glob_patterns.libr.sh"
source "./$subdir/lines_filters.libr.sh"

grammar_and_spell_check(){
  get_common_text_files_glob_patterns
  grep_variable "$1" grammar_or_spell_checker_command
  LFBFL_command=$(\
    echo "$grammar_or_spell_checker_command"\
    | sed -Ez -e "s/\n//Mg"\
  )
  for LFBFL_pattern in "${common_file_patterns[@]}"; do
    [ "$2" != "-v" ] || echo "Iterating on pattern: $LFBFL_pattern"
    find . -type f -name "$LFBFL_pattern" -printf '%P\n'\
       | while read -r file_name;
    do
      LFBFL_eval_string="$LFBFL_command $file_name"
      eval "$LFBFL_eval_string"
    done
  done
}
