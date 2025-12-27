#!/usr/bin/env bash
# This file is part of DevOrSysAdminScripts library.
#
# DevOrSysAdminScripts is free software:
# you can redistribute it and/or modify it under the terms
# of the GNU Lesser General Public License
# as published by the Free Software Foundation,
# either version 3 of the License,
# or (at your option) any later version.
#
# DevOrSysAdminScripts is distributed in the hope
# that it will be useful,
# but WITHOUT ANY WARRANTY;
# without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU Lesser General Public License for more details.
#
# You should have received a copy of
# the GNU Lesser General Public License
# along with DevOrSysAdminScripts.
# If not, see <https://www.gnu.org/licenses/>.
#
# ©Copyright 2023-2025 Laurent Frédéric Bernard François Lyaudet
# I think I created a file strings_functions.sh or renamed to
# strings_functions.sh at some point, before committing.
# Hence, someone must have changed or reversed the name of this file
# to string_functions.sh at some point.
# This file was renamed from "string_functions.sh" to
# "strings_functions.libr.sh".

LFBFL_subdir="build_and_checks_dependencies"
# shellcheck disable=SC1090
source "./${LFBFL_subdir}/get_common_text_glob_patterns.libr.sh"
# shellcheck disable=SC1090
source "./${LFBFL_subdir}/comparisons.libr.sh"

split_line_at(){
  # $1=$line
  # $2=$position
  declare -g split_line_at_result_beginning="${1:0:$2}"
  declare -g split_line_at_result_end="${1:$2}"
  # echo "$split_line_at_result_beginning"
  # echo "$split_line_at_result_end"
}

split_score_after_before(){
  # No function generator in bash, this function and the following
  # will assume that we just take into account the third argument.
  # $1=$delimiter_string
  # $2=$cut_position
  # $3=$is_cut_after
  if [[ "$3" == "1" ]]; then
    return 2
  fi
  return 1
}

split_score_before_after(){
  # No function generator in bash, this function and the following
  # will assume that we just take into account the third argument.
  # $1=$delimiter_string
  # $2=$cut_position
  # $3=$is_cut_after
  if [[ "$3" == "0" ]]; then
    return 2
  fi
  return 1
}

get_split_line_at_most_exec(){
  declare -g SPLIT_LINE_AT_MOST_EXEC="./"
  SPLIT_LINE_AT_MOST_EXEC+="build_and_checks_dependencies"
  SPLIT_LINE_AT_MOST_EXEC+="/split_line_at_most.exec.php"
}

get_split_score_after_before(){
  # $1=$max_length
  # $2=$delimiters_strings_domain
  get_split_line_at_most_exec
  declare -g\
    get_split_score_after_before_result="${SPLIT_LINE_AT_MOST_EXEC}"
  get_split_score_after_before_result+=" 1 '$1' '$2'"
}

get_split_score_before_after(){
  # $1=$max_length
  # $2=$delimiters_strings_domain
  get_split_line_at_most_exec
  declare -g\
    get_split_score_before_after_result="${SPLIT_LINE_AT_MOST_EXEC}"
  get_split_score_before_after_result+=" 0 '$1' '$2'"
}

split_line_at_most(){
  # $1=$line
  # $2=$max_length of beginning result string
  # $3=$split_score_command
  #   negative score means do not consider as a possible split
  # $4=$split_score_command_delimiter_strings_domain
  #   optimisation if small domain
  #   - this argument can be "null", then we will use $3 only instead,
  #     in that case, only mono-character strings are considered,
  #   - this argument can be an array of characters,
  #     optimize accordingly,
  #   - this argument can be an array of strings,
  #     optimize accordingly,
  #   - this argument can be an array of regexps,
  #     optimize accordingly.
  #     Not sure an array of regexps makes more sense than a single
  #     one. Maybe they could be both cases with corresponding
  #     optimizations. Same for a single character or substring.
  declare -g split_line_at_most_result_start
  declare -g split_line_at_most_result_end
  declare -A LFBFL_positions
  LFBFL_positions=(["$2"]="0")
  # echo "$1 $2 $3"
  # For my use case in bash scripts, I will need only an array of
  # characters. See get_split_score_after_before().
  if [[ -n "$4" ]]; then
    echo "split_line_at_most() \$4 NOT IMPLEMENTED YET"
  fi
  if [[ "$2" -ge "${#1}" ]]; then
    split_line_at_most_result_start=$1
    split_line_at_most_result_end=""
    return
  fi
  declare -r LFBFL_sort_command="sort --numeric-sort"
  declare -r LFBFL_length_minus_1=$((${#1} - 1))
  declare -r LFBFL_i_max=$(
    min "${LFBFL_sort_command}" "${LFBFL_length_minus_1}" "$2"
  )
  local LFBFL_i
  local LFBFL_j
  local LFBFL_current_char
  local LFBFL_command1
  local LFBFL_command2
  local LFBFL_temp
  for ((LFBFL_i=0; LFBFL_i<LFBFL_i_max; LFBFL_i++)) do
    LFBFL_j=$((LFBFL_i+1))
    LFBFL_current_char="${1:${LFBFL_i}:1}"
    LFBFL_command1="$3 '${LFBFL_current_char}' ${LFBFL_i} 0"
    LFBFL_command2="$3 '${LFBFL_current_char}' ${LFBFL_j} 1"
    # echo "${LFBFL_command1}"
    # echo "${LFBFL_command2}"
    LFBFL_temp=$(eval "${LFBFL_command1}")
    # echo "${LFBFL_temp}|${LFBFL_i}"
    if [[ ${LFBFL_temp} -ge 0 ]]; then
      # echo "${LFBFL_temp}|${LFBFL_i}"
      if [[ ${#LFBFL_positions["${LFBFL_i}"]} == "0" ]]; then
        LFBFL_positions["${LFBFL_i}"]="${LFBFL_temp}"
      else
        LFBFL_positions["${LFBFL_i}"]=$(
          max "${LFBFL_sort_command}"\
            "${LFBFL_positions["${LFBFL_i}"]}" "${LFBFL_temp}"
        )
      fi
    fi
    LFBFL_temp=$(eval "${LFBFL_command2}")
    # echo "${LFBFL_temp}|${LFBFL_j}"
    if [[ ${LFBFL_temp} -ge 0 ]]; then
      # echo "${LFBFL_temp}|${LFBFL_j}"
      if [[ ${#LFBFL_positions["${LFBFL_j}"]} == "0" ]]; then
        LFBFL_positions["${LFBFL_j}"]="${LFBFL_temp}"
      else
        LFBFL_positions["${LFBFL_j}"]=$(
          max "${LFBFL_sort_command}"\
            "${LFBFL_positions["${LFBFL_j}"]}" "${LFBFL_temp}"
        )
      fi
    fi
  done
  declare -a LFBFL_joined_args=()
  LFBFL_i=0
  local LFBFL_key
  for LFBFL_key in "${!LFBFL_positions[@]}"; do
    local LFBFL_value=${LFBFL_positions[${LFBFL_key}]}
    # echo "$LFBFL_key $LFBFL_value"
    LFBFL_joined_args[LFBFL_i]="${LFBFL_key} ${LFBFL_value}"
    LFBFL_i=$((LFBFL_i + 1))
  done
  # shellcheck disable=SC2145,SC2312
  while read -r LFBFL_best_position ;
  do
    split_line_at "$1" "${LFBFL_best_position}"
    # shellcheck disable=SC2250
    split_line_at_most_result_start=$split_line_at_result_beginning
    split_line_at_most_result_end="${split_line_at_result_end}"
  done <<EOT
$(max 'sort --numeric-sort -k2' "${LFBFL_joined_args[@]}"\
  | cut -d ' ' -f 1)
EOT
  # echo "$split_line_at_most_result_start"
  # echo "$split_line_at_most_result_end"
}

split_last_line(){
  # $1=$new_lines
  # $2=$prefix
  # $3=$max_length
  # $4=$suffix
  # $5=$split_score_command
  # In general, a prefix/suffix can be a required line prefix/suffix
  # for all final lines like a comment prefix,
  # or it can be a continuation line prefix/suffix applied only
  # when splitting a line in 2 lines,
  # or it can be a prefix/suffix for the string made of all the lines.
  # Clearly, there is no gain to couple handling a prefix/suffix for
  # the string made of all the lines in this function.
  # Since we add a prefix/suffix when splitting,
  # it is easy to see that we do not need to distinguish between
  # required line prefix/suffix and continuation line prefix/suffix.
  # The $2 and $4 arguments are given as concatenation of the
  # required and concatenation line prefixes/suffixes as needed by the
  # user.
  # Thus lines arguments should be given already prefixed
  # and suffixed.
  # This is logic, since it would be cumbersome to handle prefixing
  # or not already splitted lines in this function
  # (see repeated_split_last_line).
  # The given max_length is the goal.
  # This function adapts the effective max position for the split by
  # taking into account the length of the suffix.
  declare -g split_last_line_result="$1"
  declare -r LFBFL_max_length_plus=$(($3 + 1))
  declare -r LFBFL_length2=$(($3 - ${#4}))
  declare -r LFBFL_regexp='.\{'"${LFBFL_max_length_plus}"'\}$'
  # shellcheck disable=SC2312
  if echo "$1" | sed -e 's/\\n/\n/g' | grep -q "${LFBFL_regexp}"; then
    # shellcheck disable=SC2312
    declare -r LFBFL_start=$(\
      echo "$1" | sed -e 's/\\n/\n/g' | head --lines=-1\
      | sed -z 's/\n/\\n/g'\
    )
    # echo "start: $LFBFL_start"
    declare -r LFBFL_last_line=$(\
      echo "$1" | sed -e 's/\\n/\n/g' | tail --lines=1\
    )
    # echo "last_line: $LFBFL_last_line"
    split_last_line_result=""
    if [[ -n "${LFBFL_start}" ]]; then
      split_last_line_result="${LFBFL_start}\n"
    fi
    if [[ -n "$5" ]]; then
      split_line_at_most "${LFBFL_last_line}" "${LFBFL_length2}"\
        "$5"
      split_last_line_result+="${split_line_at_most_result_start}$4"
      split_last_line_result+="\n"
      split_last_line_result+="$2${split_line_at_most_result_end}"
    else
      # shellcheck disable=SC2250
      split_last_line_result+="${LFBFL_last_line:0:$LFBFL_length2}$4"
      split_last_line_result+="\n"
      # shellcheck disable=SC2250
      split_last_line_result+="$2${LFBFL_last_line:$LFBFL_length2}"
    fi
  fi
}

repeated_split_last_line(){
  declare -g repeated_split_last_line_result="$1"
  local LFBFL_i
  for ((LFBFL_i=0; LFBFL_i<$6; ++LFBFL_i)) do
    split_last_line "${repeated_split_last_line_result}" "$2" "$3"\
      "$4" "$5"
    repeated_split_last_line_result="${split_last_line_result}"
  done
}
