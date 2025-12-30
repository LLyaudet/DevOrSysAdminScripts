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
# ©Copyright 2023-2025 Laurent Frédéric Bernard François Lyaudet
# This file was renamed from "grammar_and_spell_check.sh"
# to "grammar_and_spell_check.libr.sh".

LFBFL_subdir="build_and_checks_dependencies"
# shellcheck disable=SC1090
source "./${LFBFL_subdir}/get_common_text_glob_patterns.libr.sh"
# shellcheck disable=SC1090
source "./${LFBFL_subdir}/lines_filters.libr.sh"

grammar_and_spell_check(){
  get_COMMON_TEXT_FILES_GLOB_PATTERNS
  grammar_or_spell_checker_command=""
  grep_variable "$1" grammar_or_spell_checker_command
  # shellcheck disable=SC2312
  declare -r LFBFL_command=$(\
    echo "${grammar_or_spell_checker_command}"\
    | sed -Ez -e "s/\n//Mg"\
  )
  local LFBFL_file_path
  local LFBFL_pattern
  local LFBFL_eval_string
  # shellcheck disable=SC2154
  for LFBFL_pattern in "${COMMON_TEXT_FILES_GLOB_PATTERNS[@]}"; do
    [[ "$2" != "-v" ]]\
      || echo "Iterating on pattern: ${LFBFL_pattern}"
    # shellcheck disable=SC2312
    find . -type f -name "${LFBFL_pattern}" -printf '%P\n'\
       | while read -r LFBFL_file_path;
    do
      LFBFL_eval_string="${LFBFL_command} ${LFBFL_file_path}"
      eval "${LFBFL_eval_string}"
    done
  done
}
