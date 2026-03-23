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
# This file was renamed from "check_URLs.sh" to "check_URLs.libr.sh".

LFBFL_subdir="build_and_checks_dependencies"
# shellcheck source=common_options.libr.sh
source "./${LFBFL_subdir}/common_options.libr.sh"
# shellcheck source=get_common_text_glob_patterns.libr.sh
source "./${LFBFL_subdir}/get_common_text_glob_patterns.libr.sh"
# shellcheck source=lines_filters.libr.sh
source "./${LFBFL_subdir}/lines_filters.libr.sh"

check_URLs(){
  # Options:
  #   --verbose
  #   --work-directory=""
  declare -i LFBFL_i_verbose=0
  get_verbose_option "$@"
  local LFBFL_work_directory=""
  get_work_directory_option "$@"
  declare -a LFBFL_return_traps_stack
  local LFBFL_previous_return_trap
  init_return_trap
  pushd_to_work_directory --trap-popd
  can_continue_after_enhanced_pushd || return 1

  enhanced_set_shell_option pipefail --trap-unset

  get_COMMON_TEXT_FILES_GLOB_PATTERNS

  declare -Ar LFBFL_substitutions=(
    ["http://www.gnu.org/licenses/"]="https://www.gnu.org/licenses/"
  )

  local LFBFL_pattern
  local LFBFL_base_file_name
  local LFBFL_substitution
  local LFBFL_substitution2
  local LFBFL_file_path
  local LFBFL_s_files_paths
  declare -a LFBFL_arr_files_paths
  for LFBFL_pattern in "${COMMON_TEXT_FILES_GLOB_PATTERNS[@]}"; do
    if [[ LFBFL_i_verbose -eq 1 ]]; then
      printf "check_URLs: Iterating on pattern: %s.\n" "${LFBFL_pattern}"
    fi
    find . -type f -name "${LFBFL_pattern}" -printf '%P\n'\
      | xargs grep -H 'http:'\
      | grep -v "| xargs grep -H 'htt"\
      | grep -vP "['\"]http(:[^'\"]*)['\"].*['\"]https\\1['\"]"\
      | grep -v 'http://www.w3.org/1999/xhtml'\
      | grep -v 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'
    # Second grep after xargs grep just above will remove false positives
    # from substitutions that fit on one line.

    LFBFL_s_files_paths=$(
      find . -type f -name "${LFBFL_pattern}" -printf '%P\n'\
      | relevant_find\
      | not_main_html_find
    )
    if [[ -z "${LFBFL_s_files_paths}" ]]; then
      [[ LFBFL_i_verbose -eq 1 ]] && printf "check_URLs: No file found.\n"
      continue
    fi
    mapfile -t LFBFL_arr_files_paths <<< "${LFBFL_s_files_paths}"
    for LFBFL_file_path in "${LFBFL_arr_files_paths[@]}"; do
      LFBFL_base_file_name=$(basename "${LFBFL_file_path}")
      [[ "${LFBFL_base_file_name}" != "check_URLs.libr.sh" ]]\
        || continue
      if [[ LFBFL_i_verbose -eq 1 ]]; then
        printf "check_URLs: Handling the file: %s.\n" "${LFBFL_file_path}"
      fi
      for LFBFL_substitution in "${!LFBFL_substitutions[@]}"; do
        LFBFL_substitution2=${LFBFL_substitutions[${LFBFL_substitution}]}
        if grep -q "${LFBFL_substitution}" "${LFBFL_file_path}"; then
          sed -i "s|${LFBFL_substitution}|${LFBFL_substitution2}|g"\
            "${LFBFL_file_path}"
        fi
      done
    done
  done
}
