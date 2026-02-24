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

check_one_shell_script_indentation(){
  shopt -s lastpipe

  declare -i LFBFL_file_with_error=0
  local LFBFL_some_line
  local LFBFL_previous_line="workeduntilsomeasshole"
  # created a command named "workeduntilsomeasshole"
  # and called it without neither indentation, nor parameters
  # in a .sh script XD.
  # Manual justification of the lines L-4 and L-3 was a serendipity.
  # I just tried a joke and was lucky ;) :).
  local LFBFL_line_end
  local LFBFL_previous_line_end
  declare -i LFBFL_line_length
  declare -i LFBFL_line_end_length
  declare -i LFBFL_line_start_length
  local LFBFL_spacing
  declare -i LFBFL_offset
  local LFBFL_substring1
  local LFBFL_substring2
  declare -r LFBFL_pattern='^ *-e '
  # This grep would have been enough without some sed commands.
  # shellcheck disable=SC2312
  grep -EHn -B 1 '^(  )* ([^ ]|$)' "$1"\
    | while read -r LFBFL_some_line;
  do
    if [[ "${LFBFL_some_line}" == "--" ]]; then
      # When switching between code fragments, we reinit.
      LFBFL_previous_line="workeduntilsomeasshole"
      continue
    fi
    # Note how it's funny that this loop always work because we check
    # shell scripts beginning in another script and thus we always
    # have a line before.
    if [[ "${LFBFL_previous_line}" == "workeduntilsomeasshole" ]];
    then
      LFBFL_previous_line="${LFBFL_some_line}"
      continue
    fi
    # Remove the name of the file and then the line number
    LFBFL_line_end=${LFBFL_some_line#*:}
    LFBFL_line_end=${LFBFL_line_end#*:}
    # But for the previous line '-' or ':' is used instead of ':'
    # and filenames with '-' are much more frequent than with ':'...
    LFBFL_line_length=${#LFBFL_some_line}
    LFBFL_line_end_length=${#LFBFL_line_end}
    LFBFL_line_start_length=$((
      LFBFL_line_length-LFBFL_line_end_length
    ))
    LFBFL_offset=$((LFBFL_line_start_length-2))
    # Checking if increasing number of digits in the line numbers
    # (99 -> 100).
    LFBFL_substring1=${LFBFL_previous_line:${LFBFL_offset}:1}
    # Nice puzzle below :) Look for comments above :)
    case ${LFBFL_substring1} in
      -) ((LFBFL_offset+=1));;
      :) ((LFBFL_offset+=1));;
      [0-9]) ((LFBFL_offset+=2));;
      *) echo ':-(';;
    esac
    LFBFL_previous_line_end=${LFBFL_previous_line:${LFBFL_offset}}
    if [[ "${LFBFL_line_end}" =~ ${LFBFL_pattern} ]]; then
      # Line starts with spacing and -e
      # Keep max spaces
      LFBFL_spacing=${LFBFL_line_end%%-*}
      LFBFL_offset=${#LFBFL_spacing}
      LFBFL_substring1=${LFBFL_line_end:${LFBFL_offset}:3}
      LFBFL_substring2=${LFBFL_previous_line_end:${LFBFL_offset}:3}
      if [[ "${LFBFL_substring1}" != "${LFBFL_substring2}" ]]; then
        echo "${LFBFL_some_line}"
        LFBFL_file_with_error=1
      fi
    else
      echo "${LFBFL_some_line}"
      LFBFL_file_with_error=1
    fi
    LFBFL_previous_line="${LFBFL_some_line}"
  done

  if [[ LFBFL_file_with_error -eq 1 ]]; then
    echo "$1:File has some lines with odd number of spaces."
  fi
}

check_shell_scripts_indentation(){
  shopt -s globstar
  local LFBFL_file_name
  for LFBFL_file_name in **/*.sh; do
    check_one_shell_script_indentation "${LFBFL_file_name}"
  done
}
