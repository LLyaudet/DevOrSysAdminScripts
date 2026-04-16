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
# 2026-03-22T15:30+01:00: This file was renamed from
# "grammar_and_spell_check.libr.sh"
# to
# "grammar_and_spelling_check.libr.sh".
# This file was renamed from "grammar_and_spell_check.sh"
# to "grammar_and_spell_check.libr.sh".

LFBFL_subdir="build_and_checks_dependencies"
# shellcheck source=common_options.libr.sh
source "./${LFBFL_subdir}/common_options.libr.sh"
# shellcheck source=get_common_text_glob_patterns.libr.sh
source "./${LFBFL_subdir}/get_common_text_glob_patterns.libr.sh"
# shellcheck source=lines_filters.libr.sh
source "./${LFBFL_subdir}/lines_filters.libr.sh"

grammar_and_spelling_check(){
  # $1=configuration_path build_and_checks_variables/repository_data.txt
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
  local LFBFL_grammar_and_spelling_checker_command=""
  grep_variable "$1" grammar_and_spelling_checker_command\
    --result-variable-prefix=LFBFL_\
    --replace-line-returns-by=""
  declare -r LFBFL_command="${LFBFL_grammar_and_spelling_checker_command}"
  if [[ -z "${LFBFL_command}" ]]; then
    if [[ LFBFL_i_verbose -eq 1 ]]; then
      printf "grammar_and_spelling_check: No command in configuration.\n"
    fi
    return
  fi
  if [[ LFBFL_i_verbose -eq 1 ]]; then
    printf "grammar_and_spelling_check: Command found: %s.\n"\
      "${LFBFL_command}"
  fi
  local LFBFL_file_path
  local LFBFL_s_files_paths
  declare -a LFBFL_arr_files_paths
  local LFBFL_pattern
  local LFBFL_eval_string
  for LFBFL_pattern in "${COMMON_TEXT_FILES_GLOB_PATTERNS[@]}"; do
    if [[ LFBFL_i_verbose -eq 1 ]]; then
      printf "grammar_and_spelling_check: Iterating on pattern: %s.\n"\
        "${LFBFL_pattern}"
    fi
    LFBFL_s_files_paths=$(
      find . -type f -name "${LFBFL_pattern}" -printf '%P\n'\
      | relevant_find
    )
    if [[ -z "${LFBFL_s_files_paths}" ]]; then
      [[ LFBFL_i_verbose -eq 1 ]]\
        && printf "grammar_and_spelling_check: No file found.\n"
      continue
    fi
    mapfile -t LFBFL_arr_files_paths <<< "${LFBFL_s_files_paths}"
    for LFBFL_file_path in "${LFBFL_arr_files_paths[@]}"; do
      LFBFL_eval_string="${LFBFL_command} ${LFBFL_file_path}"
      eval -- "${LFBFL_eval_string}"
    done
  done
}
