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
# This file was renamed from "python_black_complement.sh"
# to "python_black_complement.libr.sh".

# shellcheck source=common_options.libr.sh
source "./build_and_checks_dependencies/common_options.libr.sh"

check_no_size_of_array_first_element(){
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

  enhanced_set_bash_option globstar --trap-unset

  local LFBFL_s="Checking that shell scripts do not"
  LFBFL_s+=" contain wrong array size expansion."
  [[ LFBFL_i_verbose -eq 1 ]]\
    && printf "%s\n" "${LFBFL_s}"

  pcre2grep -M -- $'\$\{#.*(\b|_)arr_(?!.*\[@\])' **/*.sh
}

check_no_misplaced_then(){
  # Options:
  #   --verbose
  #   --work-directory=""
  #   --max-line-length
  declare -i LFBFL_i_verbose=0
  get_verbose_option "$@"
  local LFBFL_work_directory=""
  get_work_directory_option "$@"
  declare -a LFBFL_return_traps_stack
  local LFBFL_previous_return_trap
  init_return_trap
  pushd_to_work_directory --trap-popd
  can_continue_after_enhanced_pushd || return 1

  declare -i LFBFL_i_max_line_length
  get_max_line_length_option "$@"
  declare -i LFBFL_i_max_previous_line_length
  LFBFL_i_max_previous_line_length=$((LFBFL_i_max_line_length - 5))

  enhanced_set_bash_option globstar --trap-unset

  [[ LFBFL_i_verbose -eq 1 ]]\
    && printf\
        "Checking that shell scripts do not contain misplaced 'then'.\n"

  local LFBFL_regexp
  LFBFL_regexp="^[^\n]{1,${LFBFL_i_max_previous_line_length}}"
  LFBFL_regexp+="(?<=\]\];)"
  LFBFL_regexp+="(?<!^\s{0,${LFBFL_i_max_previous_line_length}}\]\];)"
  LFBFL_regexp+="\n\s*then"
  # pcre2grep -M -- '^[^\n]{1,70}(?<=\]\];)(?<!^\s{0,70}\]\];)\n\s*then'
  pcre2grep --multiline -- "${LFBFL_regexp}" **/*.sh
}

check_no_negation_before_bash_test(){
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

  enhanced_set_bash_option globstar --trap-unset

  [[ LFBFL_i_verbose -eq 1 ]]\
    && printf "Checking that shell scripts do not contain ! before [[.\n"

  pcre2grep --multiline -- $'!\s*\[\[' **/*.sh
}

shell_checks_complement(){
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

  declare -a LFBFL_common_options=("$@")
  keep_options LFBFL_common_options --verbose --max-line-length

  check_no_size_of_array_first_element "${LFBFL_common_options[@]}"
  check_no_misplaced_then "${LFBFL_common_options[@]}"
  check_no_negation_before_bash_test "${LFBFL_common_options[@]}"
}
