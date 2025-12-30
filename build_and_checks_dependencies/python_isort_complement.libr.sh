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
# This file was renamed from "python_isort_complement.sh"
# to "python_isort_complement.libr.sh".

LFBFL_subdir="build_and_checks_dependencies"
# shellcheck disable=SC1090
source "./${LFBFL_subdir}/lines_filters.libr.sh"
# shellcheck disable=SC1090
source "./${LFBFL_subdir}/overwrite_if_not_equal.libr.sh"

check_collections_abc_place(){
  echo "Checking import of _collections_abc is at the right place"
  declare -r LFBFL_temp=".check_collections_abc_place.temp"
  # shellcheck disable=SC2312
  find . -name "*.py" | relevant_find\
    | while read -r LFBFL_file_name; do
    [[ -f "${LFBFL_file_name}" ]] || continue
    sed -Ez 's/\n(\nfrom _collections_abc[^\n]*)/\1\n/Mg'\
      "${LFBFL_file_name}" > "${LFBFL_file_name}${LFBFL_temp}"
    overwrite_if_not_equal "${LFBFL_file_name}"\
      "${LFBFL_file_name}${LFBFL_temp}"
  done
}

python_isort_complement(){
  check_collections_abc_place
}
