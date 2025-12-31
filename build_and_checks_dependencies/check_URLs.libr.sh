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
# This file was renamed from "check_URLs.sh" to "check_URLs.libr.sh".

LFBFL_subdir="build_and_checks_dependencies"
# shellcheck disable=SC1090
source "./${LFBFL_subdir}/get_common_text_glob_patterns.libr.sh"

check_URLs(){
  get_COMMON_TEXT_FILES_GLOB_PATTERNS

  declare -A LFBFL_substitutions
  LFBFL_substitutions=(\
    ["http://www.gnu.org/licenses/"]="https://www.gnu.org/licenses/"\
  )

  local LFBFL_pattern
  local LFBFL_file_name
  local LFBFL_base_file_name
  local LFBFL_substitution
  # shellcheck disable=SC2154
  for LFBFL_pattern in "${COMMON_TEXT_FILES_GLOB_PATTERNS[@]}"; do
    [[ "$1" != "-v" ]]\
      || echo "Iterating on pattern: ${LFBFL_pattern}"
    # shellcheck disable=SC2312
    find . -type f -name "${LFBFL_pattern}" -printf '%P\n'\
      | xargs grep -H 'http:'\
      | grep -v "| xargs grep -H 'htt"\
      | grep -vP "['\"]http(:[^'\"]*)['\"].*['\"]https\\1['\"]"
    # Last grep just above will remove false positives from
    # substitutions that fit on one line.
    for LFBFL_file_name in ${LFBFL_pattern}; do
      [[ -f "${LFBFL_file_name}" ]] || continue
      LFBFL_base_file_name=$(basename "${LFBFL_file_name}")
      [[ "${LFBFL_base_file_name}" != "check_URLs.libr.sh" ]]\
        || continue
      [[ "$1" != "-v" ]]\
        || echo "Handling the file: ${LFBFL_file_name}"
      for LFBFL_substitution in "${!LFBFL_substitutions[@]}"; do
        LFBFL_substitution2=\
${LFBFL_substitutions[${LFBFL_substitution}]}
        if grep -q "${LFBFL_substitution}" "${LFBFL_file_name}"; then
          sed -i "s|${LFBFL_substitution}|${LFBFL_substitution2}|g"\
            "${LFBFL_file_name}"
        fi
      done
    done
  done
}
