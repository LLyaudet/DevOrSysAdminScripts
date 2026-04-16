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

LFBFL_subdir="build_and_checks_dependencies"
# shellcheck source=common_options.libr.sh
source "./${LFBFL_subdir}/common_options.libr.sh"
# shellcheck source=lines_filters.libr.sh
source "./${LFBFL_subdir}/lines_filters.libr.sh"

check_one_shell_script_indentation(){
  # $1=file_path
  declare -i LFBFL_i_file_with_error=0
  local LFBFL_some_line
  local LFBFL_previous_line="workeduntilsomeasshole"
  # created a command named "workeduntilsomeasshole"
  # and called it without neither indentation, nor parameters
  # in a .sh script XD.
  # Manual justification of the lines L-4 and L-3 was a serendipity.
  # I just tried a joke and was lucky ;) :).
  local LFBFL_line_end
  local LFBFL_previous_line_end
  declare -i LFBFL_i_line_length
  declare -i LFBFL_i_line_end_length
  declare -i LFBFL_i_line_start_length
  local LFBFL_spacing
  declare -i LFBFL_i_offset
  local LFBFL_substring1
  local LFBFL_substring2
  declare -r LFBFL_pattern='^ *-e '

  # This grep would have been enough without some sed commands.
  declare -r LFBFL_s_lines=$(
    grep --before-context=1 --extended-regexp --line-number\
      --regexp='^(  )* ([^ ]|$)' --with-filename -- "$1"
  )
  if [[ -z "${LFBFL_s_lines}" ]]; then
    return
  fi

  declare -a LFBFL_arr_lines
  mapfile -t LFBFL_arr_lines <<< "${LFBFL_s_lines}"
  readonly LFBFL_arr_lines

  for LFBFL_some_line in "${LFBFL_arr_lines[@]}"; do
    if [[ "${LFBFL_some_line}" == "--" ]]; then
      # When switching between code fragments, we reinit.
      LFBFL_previous_line="workeduntilsomeasshole"
      continue
    fi
    # Note how it's funny that this loop always work because we check
    # shell scripts beginning in another script and thus we always
    # have a line before.
    if [[ "${LFBFL_previous_line}" == "workeduntilsomeasshole" ]]; then
      LFBFL_previous_line="${LFBFL_some_line}"
      continue
    fi
    # Remove the name of the file and then the line number
    LFBFL_line_end=${LFBFL_some_line#*:}
    LFBFL_line_end=${LFBFL_line_end#*:}
    # But for the previous line '-' or ':' is used instead of ':'
    # and filenames with '-' are much more frequent than with ':'...
    LFBFL_i_line_length=${#LFBFL_some_line}
    LFBFL_i_line_end_length=${#LFBFL_line_end}
    LFBFL_i_line_start_length=$((
      LFBFL_i_line_length - LFBFL_i_line_end_length
    ))
    LFBFL_i_offset=$((LFBFL_i_line_start_length - 2))
    # Checking if increasing number of digits in the line numbers
    # (99 -> 100).
    LFBFL_substring1=${LFBFL_previous_line:${LFBFL_i_offset}:1}
    # Nice puzzle below :) Look for comments above :)
    case ${LFBFL_substring1} in
      -) ((LFBFL_i_offset += 1));;
      :) ((LFBFL_i_offset += 1));;
      [0-9]) ((LFBFL_i_offset += 2));;
      *) printf ":-(\n";;
    esac
    LFBFL_previous_line_end=${LFBFL_previous_line:${LFBFL_i_offset}}
    if [[ "${LFBFL_line_end}" =~ ${LFBFL_pattern} ]]; then
      # Line starts with spacing and -e
      # Keep max spaces
      LFBFL_spacing=${LFBFL_line_end%%-*}
      LFBFL_i_offset=${#LFBFL_spacing}
      LFBFL_substring1=${LFBFL_line_end:${LFBFL_i_offset}:3}
      LFBFL_substring2=${LFBFL_previous_line_end:${LFBFL_i_offset}:3}
      if [[ "${LFBFL_substring1}" != "${LFBFL_substring2}" ]]; then
        printf "%s\n" "${LFBFL_some_line}"
        LFBFL_i_file_with_error=1
      fi
    else
      printf "%s\n" "${LFBFL_some_line}"
      LFBFL_i_file_with_error=1
    fi
    LFBFL_previous_line="${LFBFL_some_line}"
  done

  if [[ LFBFL_i_file_with_error -eq 1 ]]; then
    printf "%s:File has some lines with odd number of spaces.\n" "$1"
  fi
}

check_shell_scripts_indentation(){
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

  # shopt -s globstar
  # for LFBFL_file_path in **/*.sh; do
  local LFBFL_file_path
  declare -r LFBFL_s_files_paths=$(
    find . -type f -name "*.sh" -printf '%P\n'\
    | relevant_find
  )
  if [[ -z "${LFBFL_s_files_paths}" ]]; then
    [[ LFBFL_i_verbose -eq 1 ]]\
      && printf "check_shell_scripts_indentation: No file found.\n"
    return
  fi
  declare -a LFBFL_arr_files_paths
  mapfile -t LFBFL_arr_files_paths <<< "${LFBFL_s_files_paths}"
  readonly LFBFL_arr_files_paths
  for LFBFL_file_path in "${LFBFL_arr_files_paths[@]}"; do
    [[ LFBFL_i_verbose -eq 1 ]]\
      && printf "%s:Checking shell script indentation.\n"\
          "${LFBFL_file_path}"
    check_one_shell_script_indentation "${LFBFL_file_path}"
  done
}
