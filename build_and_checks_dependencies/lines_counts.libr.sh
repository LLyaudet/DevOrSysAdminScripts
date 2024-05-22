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
# This file was renamed from "lines_counts.sh" to
# "lines_counts.libr.sh".

subdir="build_and_checks_dependencies"
# shellcheck disable=SC1090
source "./${subdir}/get_common_text_glob_patterns.libr.sh"
# shellcheck disable=SC1090
source "./${subdir}/lines_filters.libr.sh"

all_code_lines(){
  get_COMMON_TEXT_FILES_GLOB_PATTERNS
  # shellcheck disable=SC2154
  for LFBFL_pattern in "${COMMON_TEXT_FILES_GLOB_PATTERNS[@]}"; do
    [[ "$1" != "-v" ]]\
      || echo "Iterating on pattern: ${LFBFL_pattern}"
    find . -type f -name "${LFBFL_pattern}" -printf '%P\n'\
      | xargs grep -H -v 'a(?!a)a'
  done
}

all_self_code_lines(){
  all_code_lines | relevant_grep\
    | not_license_grep | not_main_tex_grep
}

all_self_empty_code_lines(){
  all_self_code_lines | empty_lines_after_file_name
}

all_self_not_empty_code_lines(){
  all_self_code_lines | not_empty_lines_after_file_name
}

code_lines_count_all(){
  all_self_code_lines | wc -l
}

code_lines_count_empty(){
  all_self_empty_code_lines | wc -l
}

code_lines_count_not_empty(){
  all_self_not_empty_code_lines | wc -l
}
