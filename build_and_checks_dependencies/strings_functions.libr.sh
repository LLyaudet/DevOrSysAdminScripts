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

split_score_simple(){
  # $1=$after_before
  # $2=$delimiters_strings_domain concatenated characters/delimiters
  # $3=$delimiter_string a single character
  # $4=$is_cut_after
  declare -gi split_score_result
  if [[ "$2" != *$3* ]]; then
    split_score_result=0
    return
  fi
  if [[ "$4" == "$1" ]]; then
    split_score_result=2
    return
  fi
  split_score_result=1
}

get_split_score_simple(){
  # $1=$after_before
  # $2=$max_length
  # $3=$delimiters_strings_domain
  declare -g get_split_score_result="split_score_simple $1 '$3'"
  declare -gi get_split_score_result2
  # shellcheck disable=SC2034,SC2125
  get_split_score_result2=7+$1*4
  # if [[ $1 -eq 1 ]]; then
  #   get_split_score_result2=7
  # else
  #   get_split_score_result2=11
  # fi
}

get_split_score_exec(){
  declare -g SPLIT_SCORE_EXEC="./build_and_checks_dependencies"
  SPLIT_SCORE_EXEC+="/split_score.exec.php"
}

split_score(){
  # $1=$after_before
  # $2=$max_length
  # $3=$delimiters_strings_domain concatenated characters/delimiters
  # $4=$delimiter_string a single character
  # $5=$cut_position
  # $6=$is_cut_after
  get_split_score_exec
  declare -r LFBFL_command="${SPLIT_SCORE_EXEC} $1 $2 '$3' '$4' $5 $6"
  declare -gi split_score_result
  split_score_result=$(eval "${LFBFL_command}")
}

get_split_score(){
  # $1=$after_before
  # $1=$max_length
  # $2=$delimiters_strings_domain
  # shellcheck disable=SC2034
  declare -g get_split_score_result="split_score $1 $2 '$3'"
  declare -gi get_split_score_result2
  # shellcheck disable=SC2034,SC2125
  get_split_score_result2=5+$1*4
}

split_line_at_most(){
  # $1=$line
  # $2=$max_length of beginning result string
  # $3=$split_score_command
  #   negative score means do not consider as a possible split
  # $4=$split_score_command_properties :
  #   These properties are flags.
  #   If someday some property is not a flag,
  #   then create split_score_command_properties2.
  #   - null or 0 no property;
  #   - 1 split score doesn't depend on which delimiter matches;
  #   - 2 split score doesn't depend on the current position;
  #   - 4 any split score after is always larger
  #     than any split score before;
  #   - 8 any split score before is always larger
  #     than any split score after;
  # $5=$forbidden_previous_character
  # $6=$split_score_command_delimiter_strings_domain
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
  #
  # Note that we're always looking for the last position to split
  # among maximum score;
  # if some position gets as score from 2 delimiters,
  # its score is always the maximum of the two corresponding scores.
  declare -g split_line_at_most_result_start
  declare -g split_line_at_most_result_end
  declare -A LFBFL_positions
  # echo "$1 $2 $3 $4"
  # For my use case in bash scripts, I will need only an array of
  # characters. See get_split_score_after_before().
  if [[ -n "$6" ]]; then
    echo "split_line_at_most() \$4 NOT IMPLEMENTED YET"
  fi
  if [[ $2 -ge ${#1} ]]; then
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
  local LFBFL_previous_char
  local LFBFL_current_char

  # At the beginning, each position has score 0.
  for ((LFBFL_i=0; LFBFL_i<=LFBFL_i_max; ++LFBFL_i)) do
    LFBFL_positions["${LFBFL_i}"]="0"
  done
  LFBFL_j=$((LFBFL_i+1))
  LFBFL_positions["${LFBFL_j}"]="0"

  # If we have a forbidden previous character,
  # we mark the forbidden positions with -1.
  if [[ -n "$5" ]]; then
    LFBFL_previous_char=""
    for ((LFBFL_i=0; LFBFL_i<LFBFL_i_max; ++LFBFL_i)) do
      LFBFL_j=$((LFBFL_i+1))
      if [[ LFBFL_i -ge 1 ]]; then
        LFBFL_previous_char="${LFBFL_current_char}"
      fi
      LFBFL_current_char="${1:${LFBFL_i}:1}"
      if [[ "${LFBFL_previous_char}" == "$5" ]]; then
        LFBFL_positions["${LFBFL_i}"]="-1"
      fi
      if [[ "${LFBFL_current_char}" == "$5" ]]; then
        LFBFL_positions["${LFBFL_j}"]="-1"
      fi
    done
  fi

  if [[ "$4" == "7" ]]; then
    for ((LFBFL_j=LFBFL_i_max; LFBFL_j>0; --LFBFL_j)) do
      LFBFL_i=$((LFBFL_j-1))
      LFBFL_current_char="${1:${LFBFL_i}:1}"
      eval "$3 '${LFBFL_current_char}' 0"
      # echo "${split_score_result}|${LFBFL_i}"
      if [[ split_score_result -ge 1 ]]; then
        # echo "${split_score_result}|${LFBFL_i}"
        if [[ ${LFBFL_positions["${LFBFL_i}"]} != "-1" ]]; then
          LFBFL_positions["${LFBFL_i}"]=$(
            max "${LFBFL_sort_command}"\
              "${LFBFL_positions["${LFBFL_i}"]}"\
              "${split_score_result}"
          )
        fi
      fi
      eval "$3 '${LFBFL_current_char}' 1"
      # echo "${split_score_result}|${LFBFL_j}"
      if [[ split_score_result -ge 1 ]]; then
        # echo "${split_score_result}|${LFBFL_j}"
        if [[ ${LFBFL_positions["${LFBFL_j}"]} != "-1" ]]; then
          LFBFL_positions["${LFBFL_j}"]=$(
            max "${LFBFL_sort_command}"\
              "${LFBFL_positions["${LFBFL_j}"]}"\
              "${split_score_result}"
          )
          break
        fi
      fi
    done
  else
    for ((LFBFL_i=0; LFBFL_i<LFBFL_i_max; ++LFBFL_i)) do
      LFBFL_j=$((LFBFL_i+1))
      LFBFL_current_char="${1:${LFBFL_i}:1}"
      eval "$3 '${LFBFL_current_char}' ${LFBFL_i} 0"
      # echo "${split_score_result}|${LFBFL_i}"
      if [[ split_score_result -ge 1 ]]; then
        # echo "${split_score_result}|${LFBFL_i}"
        if [[ ${LFBFL_positions["${LFBFL_i}"]} != "-1" ]]; then
          LFBFL_positions["${LFBFL_i}"]=$(
            max "${LFBFL_sort_command}"\
              "${LFBFL_positions["${LFBFL_i}"]}"\
              "${split_score_result}"
          )
        fi
      fi
      eval "$3 '${LFBFL_current_char}' ${LFBFL_j} 1"
      # echo "${split_score_result}|${LFBFL_j}"
      if [[ split_score_result -ge 1 ]]; then
        # echo "${split_score_result}|${LFBFL_j}"
        if [[ ${LFBFL_positions["${LFBFL_j}"]} != "-1" ]]; then
          LFBFL_positions["${LFBFL_j}"]=$(
            max "${LFBFL_sort_command}"\
              "${LFBFL_positions["${LFBFL_j}"]}"\
              "${split_score_result}"
          )
        fi
      fi
    done
  fi
  declare -r LFBFL_max_score=\
$(max 'sort --numeric-sort' "${LFBFL_positions[@]}")
  local LFBFL_best_position
  for ((LFBFL_i=0; LFBFL_i<=LFBFL_i_max; ++LFBFL_i)) do
    local LFBFL_value=${LFBFL_positions[${LFBFL_i}]}
    # echo "${LFBFL_i} ${LFBFL_value}"
    if [[ "${LFBFL_value}" == "${LFBFL_max_score}" ]]; then
      LFBFL_best_position="${LFBFL_i}"
    fi
  done
  split_line_at "$1" "${LFBFL_best_position}"
  split_line_at_most_result_start="${split_line_at_result_beginning}"
  split_line_at_most_result_end="${split_line_at_result_end}"
  # echo "$split_line_at_most_result_start"
  # echo "$split_line_at_most_result_end"
}

split_last_line(){
  # $1=$new_lines
  # $2=$prefix
  # $3=$max_length
  # $4=$suffix
  # $5=$split_score_command
  # $6=$split_score_command_properties
  # $7=$forbidden_previous_character ('\' usually)
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
  # required and continuation line prefixes/suffixes as needed by the
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
  declare -ir LFBFL_max_length_plus=$(($3 + 1))
  declare -ir LFBFL_length2=$(($3 - ${#4}))
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
    # echo "last_line: ${LFBFL_last_line}"
    split_last_line_result=""
    if [[ -n "${LFBFL_start}" ]]; then
      split_last_line_result="${LFBFL_start}\n"
    fi
    if [[ -n "$5" ]]; then
      split_line_at_most "${LFBFL_last_line}" "${LFBFL_length2}"\
        "$5" "$6" "$7"
      split_last_line_result+="${split_line_at_most_result_start}$4"
      split_last_line_result+="\n"
      split_last_line_result+="$2${split_line_at_most_result_end}"
    else
      split_last_line_result+="${LFBFL_last_line:0:${LFBFL_length2}}"
      split_last_line_result+="$4\n"
      split_last_line_result+="$2${LFBFL_last_line:${LFBFL_length2}}"
    fi
  fi
}

repeated_split_last_line(){
  declare -g repeated_split_last_line_result="$1"
  local LFBFL_i
  for ((LFBFL_i=0; LFBFL_i<$6; ++LFBFL_i)) do
    split_last_line "${repeated_split_last_line_result}" "$2" "$3"\
      "$4" "$5" "$6" "$7"
    repeated_split_last_line_result="${split_last_line_result}"
    # echo "${split_last_line_result}"
  done
}
