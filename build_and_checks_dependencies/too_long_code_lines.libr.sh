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
# This file was renamed from "too_long_code_lines.sh"
# to "too_long_code_lines.libr.sh".

LFBFL_subdir="build_and_checks_dependencies"
# shellcheck disable=SC1090
source "./${LFBFL_subdir}/get_common_text_glob_patterns.libr.sh"

too_long_code_lines(){
  get_COMMON_TEXT_FILES_GLOB_PATTERNS
  local LFBFL_pattern
  # shellcheck disable=SC2154
  for LFBFL_pattern in "${COMMON_TEXT_FILES_GLOB_PATTERNS[@]}"; do
    [[ "$1" != "-v" ]]\
      || echo "Iterating on pattern: ${LFBFL_pattern}"
    # shellcheck disable=SC2312
    find . -type f -name "${LFBFL_pattern}" -printf '%P\n'\
      | xargs grep -H '.\{71\}'
  done
}
