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
# This file was renamed from "check_shell_scripts_beginnings.sh"
# to "check_shell_scripts_beginnings.libr.sh".

LFBFL_subdir="build_and_checks_dependencies"
# shellcheck source=common_options.libr.sh
source "./${LFBFL_subdir}/common_options.libr.sh"
# shellcheck source=lines_filters.libr.sh
source "./${LFBFL_subdir}/lines_filters.libr.sh"

declare -gr LFBFL_SHELL_SCRIPT_BEGINNING="#!/usr/bin/env bash"

check_one_shell_script_beginning(){
  # declare -r LFBFL_file_path=$(basename "$1")
  # if [[ "${LFBFL_file_path}" =~ license_file_header_.*\.sh ]]; then
  #   return 0
  # fi
  # diff <(head -n 1 "$1") <(printf '#!/usr/bin/env bash')
  # ------------------------------------------------------------------
  # is of course slower than
  # ------------------------------------------------------------------
  # diff <(head -n 1 "$1") <(printf '#!/usr/bin/env bash')
  # ------------------------------------------------------------------
  # is of course slower than
  # ------------------------------------------------------------------
  declare -r LFBFL_head=$(head -n 1 "$1")
  [[ "${LFBFL_head}" == "${LFBFL_SHELL_SCRIPT_BEGINNING}" ]]\
    || printf "%s:File has wrong shell script beginning.\n" "$1"
}

check_shell_scripts_beginnings(){
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

  # shopt -s globstar
  # for LFBFL_file_path in **/*.sh; do
  local LFBFL_file_path
  local LFBFL_head
  declare -r LFBFL_s_files_paths=$(
    find . -type f -name "*.sh" -printf '%P\n'\
    | relevant_find
  )
  if [[ -z "${LFBFL_s_files_paths}" ]]; then
    [[ LFBFL_i_verbose -eq 1 ]]\
      && printf "check_shell_scripts_beginnings: No file found.\n"
    return
  fi
  declare -a LFBFL_arr_files_paths
  mapfile -t LFBFL_arr_files_paths <<< "${LFBFL_s_files_paths}"
  for LFBFL_file_path in "${LFBFL_arr_files_paths[@]}"; do
    [[ LFBFL_i_verbose -eq 1 ]]\
      && printf "%s:Checking shell script beginning.\n"\
          "${LFBFL_file_path}"
    LFBFL_head=$(head -n 1 "${LFBFL_file_path}")
    [[ "${LFBFL_head}" == "${LFBFL_SHELL_SCRIPT_BEGINNING}" ]]\
      || printf "%s:File has wrong shell script beginning.\n"\
          "${LFBFL_file_path}"
  done
}
