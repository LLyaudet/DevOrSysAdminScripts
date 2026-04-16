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
# This file was renamed from "too_long_code_lines.sh"
# to "too_long_code_lines.libr.sh".

LFBFL_subdir="build_and_checks_dependencies"
# shellcheck source=common_options.libr.sh
source "./${LFBFL_subdir}/common_options.libr.sh"
# shellcheck source=get_common_text_glob_patterns.libr.sh
source "./${LFBFL_subdir}/get_common_text_glob_patterns.libr.sh"
# shellcheck source=lines_filters.libr.sh
source "./${LFBFL_subdir}/lines_filters.libr.sh"

get_overlength_regexp(){
  declare -g get_overlength_regexp_result=".\{$1\}"
  # declare -g get_overlength_regexp_result="^.\{$1\}"
  # declare -g get_overlength_regexp_result=".\{$1\}\$"
  # First one seems to be faster by a few percents when testing like this:
  # time for ((i = 0; i < 1000; ++i)); do grep '.{70}' COPYING; done
  # time for ((i = 0; i < 1000; ++i)); do grep '^.{70}' COPYING; done
  # time for ((i = 0; i < 1000; ++i)); do grep '.{70}$' COPYING; done
}

too_long_code_lines(){
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

  declare -ir LFBFL_i_overlength=$((LFBFL_i_max_line_length+1))
  # shellcheck disable=SC2248
  get_overlength_regexp ${LFBFL_i_overlength}

  enhanced_set_shell_option pipefail --trap-unset

  get_COMMON_TEXT_FILES_GLOB_PATTERNS
  local LFBFL_pattern
  local LFBFL_long_line
  local LFBFL_file_path
  local LFBFL_line
  local LFBFL_extension
  local LFBFL_base_name
  local LFBFL_s_long_lines
  declare -a LFBFL_arr_long_lines
  for LFBFL_pattern in "${COMMON_TEXT_FILES_GLOB_PATTERNS[@]}"; do
    if [[ LFBFL_i_verbose -eq 1 ]]; then
      printf "too_long_code_lines: Iterating on pattern: %s.\n"\
        "${LFBFL_pattern}"
    fi
    # shellcheck disable=SC2248
    LFBFL_s_long_lines=$(
      find . -type f -name "${LFBFL_pattern}" -printf '%P\n'\
      | relevant_find\
      | not_license_find\
      | xargs grep --line-number --with-filename\
        --regexp="${get_overlength_regexp_result}" --
    )
    if [[ -z "${LFBFL_s_long_lines}" ]]; then
      [[ LFBFL_i_verbose -eq 1 ]]\
        && printf "too_long_code_lines: No file found with long lines.\n"
      continue
    fi
    mapfile -t LFBFL_arr_long_lines <<< "${LFBFL_s_long_lines}"
    for LFBFL_long_line in "${LFBFL_arr_long_lines[@]}"; do
      LFBFL_file_path=${LFBFL_long_line%%:*} # Drop long ':*' suffix
      # Remove file_path and line_number
      LFBFL_line=${LFBFL_long_line#*:} # Drop short '*:' prefix
      LFBFL_line=${LFBFL_line#*:} # Drop short '*:' prefix
      # LFBFL_line="${LFBFL_line/%\\/}" # Drop/Replace '\' suffix by ''
      LFBFL_extension=${LFBFL_file_path##*.} # Drop long '*.' prefix
      LFBFL_base_name=${LFBFL_file_path%.*} # Drop short '.*' suffix
      if [[ "${LFBFL_extension}" == "html" ]]; then
        if [[ -f "${LFBFL_base_name}.md" ]]; then
          continue
        fi
        if grep --quiet --fixed-strings -- "${LFBFL_line}"\
          "./build_and_checks_variables/temp/files_listing.html.sub"
        then
          continue
        fi
        printf "%s\n" "${LFBFL_long_line}"
      elif [[ "${LFBFL_extension}" == "md" ]]; then
        if [[ ! -f "${LFBFL_base_name}.md.tpl" ]]; then
          printf "%s\n" "${LFBFL_long_line}"
        fi
      else
        printf "%s\n" "${LFBFL_long_line}"
      fi
    done
  done
}
