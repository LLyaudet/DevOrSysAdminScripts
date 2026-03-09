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
  can_continue_after_enhanced_pushd || return

  [[ LFBFL_i_verbose -eq 1 ]]\
    && printf "Checking import of _collections_abc is at the right place\n"

  enhanced_set_shell_option pipefail\
    && trap 'enhanced_unset_shell_option pipefail' RETURN

  declare -r LFBFL_temp=".check_collections_abc_place.temp"
  local LFBFL_file_path
  declare -r LFBFL_s_files_paths=$(
    find . -type f -name "*.py" -printf '%P\n'\
    | relevant_find
  )
  declare -a LFBFL_arr_files_paths
  mapfile -t LFBFL_arr_files_paths <<< "${LFBFL_s_files_paths}"
  readonly LFBFL_arr_files_paths
  for LFBFL_file_path in "${LFBFL_arr_files_paths[@]}"; do
    [[ -f "${LFBFL_file_path}" ]] || continue
    sed -Ez 's/\n(\nfrom _collections_abc[^\n]*)/\1\n/Mg'\
      "${LFBFL_file_path}"\
      > "${LFBFL_file_path}${LFBFL_temp}"
    overwrite_if_not_equal "${LFBFL_file_path}"\
      "${LFBFL_file_path}${LFBFL_temp}"
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
  can_continue_after_enhanced_pushd || return

  check_collections_abc_place "$@"
}
