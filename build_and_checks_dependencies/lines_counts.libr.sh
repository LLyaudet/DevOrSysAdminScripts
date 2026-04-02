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
# This file was renamed from "lines_counts.sh" to
# "lines_counts.libr.sh".

LFBFL_subdir="build_and_checks_dependencies"
# shellcheck source=common_options.libr.sh
source "./${LFBFL_subdir}/common_options.libr.sh"
# shellcheck source=get_common_text_glob_patterns.libr.sh
source "./${LFBFL_subdir}/get_common_text_glob_patterns.libr.sh"
# shellcheck source=lines_filters.libr.sh
source "./${LFBFL_subdir}/lines_filters.libr.sh"

all_code_lines(){
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
  local LFBFL_pattern
  for LFBFL_pattern in "${COMMON_TEXT_FILES_GLOB_PATTERNS[@]}"; do
    if [[ LFBFL_i_verbose -eq 1 ]]; then
      printf -- "all_code_lines: Iterating on pattern: %s.\n"\
        "${LFBFL_pattern}"
    fi
    find . -type f -name "${LFBFL_pattern}" -printf '%P\n'\
      | xargs grep --invert-match --perl-regexp --with-filename\
        -- 'a(?!a)a'
  done
}

all_self_code_lines(){
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

  declare -a LFBFL_common_options=("$@")
  keep_options LFBFL_common_options --verbose

  # below and another lines, see SC2145 false positive
  all_code_lines "${LFBFL_common_options[@]}" \
    | relevant_grep\
    | not_license_grep\
    | not_main_tex_grep\
    | not_main_html_grep
}

# shellcheck disable=SC2120
all_self_empty_code_lines(){
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

  declare -a LFBFL_common_options=("$@")
  keep_options LFBFL_common_options --verbose

  all_self_code_lines "${LFBFL_common_options[@]}" \
    | empty_lines_after_file_name
}

# shellcheck disable=SC2120
all_self_not_empty_code_lines(){
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

  declare -a LFBFL_common_options=("$@")
  keep_options LFBFL_common_options --verbose

  all_self_code_lines "${LFBFL_common_options[@]}" \
    | not_empty_lines_after_file_name
}

code_lines_count_all(){
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

  declare -gi i_code_lines_count_all_result
  i_code_lines_count_all_result=$(
    all_self_code_lines\
    | wc --lines
  )
  # The printf is for command line use.
  # A script should use the result value instead.
  # shellcheck disable=SC2248
  printf "%s\n" ${i_code_lines_count_all_result}
}

code_lines_count_empty(){
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

  declare -gi i_code_lines_count_empty_result
  # shellcheck disable=SC2119
  i_code_lines_count_empty_result=$(
    all_self_empty_code_lines\
    | wc --lines
  )
  # The printf is for command line use.
  # A script should use the result value instead.
  # shellcheck disable=SC2248
  printf "%s\n" ${i_code_lines_count_empty_result}
}

code_lines_count_not_empty(){
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

  declare -gi i_code_lines_count_not_empty_result
  # shellcheck disable=SC2119
  i_code_lines_count_not_empty_result=$(
    all_self_not_empty_code_lines\
    | wc --lines
  )
  # The printf is for command line use.
  # A script should use the result value instead.
  # shellcheck disable=SC2248
  printf "%s\n" ${i_code_lines_count_not_empty_result}
}
