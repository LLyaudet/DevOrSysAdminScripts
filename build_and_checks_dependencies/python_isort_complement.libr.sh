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
# ©Copyright 2023-2026 Laurent Frédéric Bernard François Lyaudet
# This file was renamed from "python_isort_complement.sh"
# to "python_isort_complement.libr.sh".

LFBFL_subdir="build_and_checks_dependencies"
# shellcheck source=common_options.libr.sh
source "./${LFBFL_subdir}/common_options.libr.sh"
# shellcheck source=lines_filters.libr.sh
source "./${LFBFL_subdir}/lines_filters.libr.sh"
# shellcheck source=overwrite_if_not_equal.libr.sh
source "./${LFBFL_subdir}/overwrite_if_not_equal.libr.sh"

check_collections_abc_place(){
  # Options:
  #   --verbose
  #   --work-directory=""
  declare -i LFBFL_i_verbose=0
  get_verbose_option "$@"
  local LFBFL_work_directory=""
  get_work_directory_option "$@"
  pushd_to_work_directory\
    && trap 'popd_from_work_directory' RETURN
  work_directory_is_top_dirstack_directory || return

  [[ LFBFL_i_verbose -eq 1 ]]\
    && echo "Checking import of _collections_abc is at the right place"
  if [[ ! -o pipefail ]]; then
    set -o pipefail
    trap 'set +o pipefail' RETURN
  fi
  declare -r LFBFL_temp=".check_collections_abc_place.temp"
  local LFBFL_file_name
  find . -name "*.py"\
    | relevant_find\
    | while read -r LFBFL_file_name;
  do
    [[ -f "${LFBFL_file_name}" ]] || continue
    sed -Ez 's/\n(\nfrom _collections_abc[^\n]*)/\1\n/Mg'\
      "${LFBFL_file_name}"\
      > "${LFBFL_file_name}${LFBFL_temp}"
    overwrite_if_not_equal "${LFBFL_file_name}"\
      "${LFBFL_file_name}${LFBFL_temp}"
  done
}

python_isort_complement(){
  # Options:
  #   --verbose
  #   --work-directory=""
  # shellcheck disable=SC2034
  declare -i LFBFL_i_verbose=0
  get_verbose_option "$@"
  local LFBFL_work_directory=""
  get_work_directory_option "$@"
  pushd_to_work_directory\
    && trap 'popd_from_work_directory' RETURN
  work_directory_is_top_dirstack_directory || return

  check_collections_abc_place "$@"
}
