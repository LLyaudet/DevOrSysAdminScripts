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
# ©Copyright 2023-2024 Laurent Frédéric Bernard François Lyaudet
# I think I created a file strings_functions.sh or renamed to
# strings_functions.sh at some point, before committing.
# Hence, someone must have changed or reversed the name of this file
# to string_functions.sh at some point.

subdir="build_and_checks_dependencies"
source "./$subdir/get_common_text_glob_patterns.sh"
source "./$subdir/comparisons.sh"

split_line_at(){
  # $1=$line
  # $2=$position
  split_line_at_result_beginning="${1:0:$2}"
  split_line_at_result_end="${1:$2}"
  # echo "$split_line_at_result_beginning"
  # echo "$split_line_at_result_end"
}

split_score_after_before(){
  # No function generator in bash, this function and the following
  # will assume that we just take into account the third argument.
  # $1=$delimiter_string
  # $2=$cut_position
  # $3=$is_cut_after
  if [[ "$3" == "1" ]] then
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
  if [[ "$3" == "0" ]] then
    return 2
  fi
  return 1
}

get_split_score_after_before(){
  # $1=$max_length
  # $2=delimiters_strings_domain
  LFBFL_generic_result="./build_and_checks_dependencies/"
  LFBFL_generic_result+="call_split_score_after_before_or"
  LFBFL_generic_result+="_before_after.php 1 $1 '$2' "
}

get_split_score_before_after(){
  # $1=$max_length
  # $2=delimiters_strings_domain
  LFBFL_generic_result="./build_and_checks_dependencies/"
  LFBFL_generic_result+="call_split_score_after_before_or"
  LFBFL_generic_result+="_before_after.php 0 $1 '$2' "
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
  declare -A split_line_at_most_var_positions
  split_line_at_most_var_positions=(["$2"]=0)
  # echo "$1 $2 $3"
  # For my use case in bash scripts, I will need only an array of
  # characters. See get_split_score_after_before().
  if [[ -n "$4" ]] then
    echo "split_line_at_most() \$4 NOT IMPLEMENTED YET"
  fi
  if [[ "$2" -ge "${#1}" ]] then
    split_line_at_most_result_start=$1
    split_line_at_most_result_end=""
    return
  fi
  split_line_at_most_var_sort_command="sort --numeric-sort"
  LFBFL_length_minus_1=$((${#1} - 1))
  LFBFL_i_max=$(min 'sort --numeric-sort' $LFBFL_length_minus_1 $2)
  for ((i=0; i<$LFBFL_i_max; i++)) do
    j=$(($i+1))
    split_line_at_most_var_current_char="${1:$i:1}"
    LFBFL_command1="$3 '$split_line_at_most_var_current_char' $i 0"
    LFBFL_command2="$3 '$split_line_at_most_var_current_char' $j 1"
    # echo "$LFBFL_command1"
    # echo "$LFBFL_command2"
    LFBFL_temp=$(eval $LFBFL_command1)
    # echo "$LFBFL_temp|$i"
    if [[ $LFBFL_temp -ge 0 ]] then
      # echo "$LFBFL_temp|$i"
      if [[ ${#split_line_at_most_var_positions["$i"]} == 0 ]] then
        split_line_at_most_var_positions["$i"]=$LFBFL_temp
      else
        split_line_at_most_var_positions["$i"]=$(\
          max "$split_line_at_most_var_sort_command"\
            split_line_at_most_var_positions["$i"]\
            $LFBFL_temp
        )
      fi
    fi
    LFBFL_temp=$(eval $LFBFL_command2)
    # echo "$LFBFL_temp|$j"
    if [[ $LFBFL_temp -ge 0 ]] then
      # echo "$LFBFL_temp|$j"
      if [[ ${#split_line_at_most_var_positions["$j"]} == 0 ]] then
        split_line_at_most_var_positions["$j"]=$LFBFL_temp
      else
        split_line_at_most_var_positions["$j"]=$(\
          max "$split_line_at_most_var_sort_command"\
            split_line_at_most_var_positions["$j"]\
            $LFBFL_temp
        )
      fi
    fi
  done
  LFBFL_joined_args=()
  LFBFL_i=0
  for LFBFL_key in "${!split_line_at_most_var_positions[@]}"; do
    LFBFL_value=${split_line_at_most_var_positions[$LFBFL_key]}
    # echo "$LFBFL_key $LFBFL_value"
    LFBFL_joined_args[$LFBFL_i]="$LFBFL_key $LFBFL_value"
    LFBFL_i=$((LFBFL_i + 1))
  done
  while read -r LFBFL_best_position ;
  do
    split_line_at $1 $LFBFL_best_position
    split_line_at_most_result_start=$split_line_at_result_beginning
    split_line_at_most_result_end=$split_line_at_result_end
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
  split_last_line_result="$1"
  LFBFL_max_length_plus=$(($3 + 1))
  LFBFL_length2=$(($3 - ${#4}))
  LFBFL_regexp='.\{'"$LFBFL_max_length_plus"'\}$'
  if echo "$1" | sed -e 's/\\n/\n/g' | grep -q $LFBFL_regexp; then
    LFBFL_start=$(\
      echo "$1" | sed -e 's/\\n/\n/g' | head --lines=-1\
      | sed -z 's/\n/\\n/g'\
    )
    # echo "start: $LFBFL_start"
    LFBFL_last_line=$(\
      echo "$1" | sed -e 's/\\n/\n/g' | tail --lines=1\
    )
    # echo "last_line: $LFBFL_last_line"
    split_last_line_result=""
    if [[ -n "$LFBFL_start" ]] then
      split_last_line_result="$LFBFL_start\n"
    fi
    if [[ -n "$5" ]] then
      split_line_at_most "$LFBFL_last_line" "$LFBFL_length2"\
        "$5"
      split_last_line_result+="$split_line_at_most_result_start$4"
      split_last_line_result+="\n"
      split_last_line_result+="$2$split_line_at_most_result_end"
    else
      split_last_line_result+="${LFBFL_last_line:0:$LFBFL_length2}$4"
      split_last_line_result+="\n"
      split_last_line_result+="$2${LFBFL_last_line:$LFBFL_length2}"
    fi
  fi
}
