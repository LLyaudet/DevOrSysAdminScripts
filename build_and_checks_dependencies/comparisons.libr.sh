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
# The file "comparisons.sh" was renamed to "comparisons.libr.sh".

# shellcheck source=common_options.libr.sh
source "./build_and_checks_dependencies/common_options.libr.sh"

equal(){
  # Returns 1 if all the arguments strings are equal.
  # Renvoie 1 dans $? si toutes les chaînes en arguments sont égales.
  # J'ai rerepensé au 3-way-merge
  # et à mon article sur le principe de première différence
  # appliqué à la largeur modulaire, de clique ou de rang avec
  # l'idée d'un principe de première différence ternaire.
  declare -i LFBFL_i_first=1
  local LFBFL_current
  local LFBFL_arg
  for LFBFL_arg in "$@"; do
    if [[ LFBFL_i_first -eq 1 ]]; then
      LFBFL_current="${LFBFL_arg}"
      LFBFL_i_first=0
      continue
    fi
    if [[ "${LFBFL_current}" != "${LFBFL_arg}" ]]; then
      return 0
    fi
  done
  return 1
}

some_distinct(){
  ! equal "$@"
}

all_distinct(){
  # Returns 1 if all the arguments strings are distinct.
  declare -ir LFBFL_ij_max=$#
  declare -i LFBFL_i
  declare -i LFBFL_j
  for ((LFBFL_i=1; LFBFL_i<LFBFL_ij_max; ++LFBFL_i)); do
    for ((LFBFL_j = LFBFL_i + 1; LFBFL_j<=LFBFL_ij_max; ++LFBFL_j)); do
      [[ "${!LFBFL_i}" == "${!LFBFL_j}" ]] && return 0
    done
  done
  return 1
}

all_distinct2(){
  # Returns 1 if all the arguments strings are distinct.
  local LFBFL_element
  local LFBFL_previous_element
  if [[ $# -le 1 ]]; then
    return 1
  fi
  declare -r LFBFL_s_sorted_arguments=$(
    printf "%s\n" "$@" \
    | sort
  )
  declare -a LFBFL_arr_sorted_arguments
  mapfile -t LFBFL_arr_sorted_arguments <<< "${LFBFL_s_sorted_arguments}"
  declare -i LFBFL_i
  declare -ir LFBFL_i_max=${#LFBFL_arr_sorted_arguments[@]}
  LFBFL_previous_element=${LFBFL_arr_sorted_arguments[0]}
  for ((LFBFL_i=1; LFBFL_i<LFBFL_i_max; ++LFBFL_i)); do
    LFBFL_element="${LFBFL_arr_sorted_arguments[${LFBFL_i}]}"
    if [[ "${LFBFL_previous_element}" == "${LFBFL_element}" ]]; then
      return 0
    fi
    LFBFL_previous_element="${LFBFL_element}"
  done
  return 1
}

all_distinct3(){
  # Returns 1 if all the arguments strings are distinct.
  # all_distinct3 is slower than old all_distinct2 since a call to sort is
  # needed:
  # the manual of uniq says it doesn't detect non-adjacent repeated lines.
  # A few weeks ago, when testing without sort, I had no bug...
  # I may have tested all_distinct3 a a b and not all_distinct3 a b a
  # There is a sort also in all_distinct2, but uniq could have an option to
  # sort before "applying -d", or sort could have an option for printing
  # duplicates only. It would complement -u option of sort.
  # Both solutions would avoid one pipe and one more shell command call.
  # Note that old all_distinct2 was faster with pipes and read -r commands,
  # but read -r has small drawbacks. Using mapfile is a cleaner way to do
  # it, since it handles arguments with spaces from scratch.
  # Arguments with line-returns are still not handled.
  # Use C, PHP or Python for example for that.
  # Somehow Bash was made to push people to stop being lazy and do actual C
  # code, even if it needs compiling something, adding a makefile, etc. XD
  # Note that C code would be faster with all_distinct2 blueprint,
  # that's the reason I kept all 3 versions, see the (asymptotic)
  # complexity and simple algorithms ideas on this toy problem.
  if [[ $# -le 1 ]]; then
    return 1
  fi
  declare -r LFBFL_s_duplicated_arguments=$(
    printf "%s\n" "$@" \
    | sort\
    | uniq --repeated
  )
  [[ -n "${LFBFL_s_duplicated_arguments}" ]]
}

some_equal(){
  ! all_distinct "$@"
}

some_equal2(){
  ! all_distinct2 "$@"
}

some_equal3(){
  ! all_distinct3 "$@"
}

max(){
  # Returns the maximum string among the arguments.
  # Renvoie la chaîne la plus grande parmi celles proposées.
  # $1=sort_command with the flags you want to be applied.
  # $ max sort a b c
  # c
  if [[ $# -eq 0 ]]; then
    return 1
  fi
  enhanced_set_shell_option pipefail\
    && trap 'enhanced_unset_shell_option pipefail' RETURN
  printf "%s\n" "${@:2}" \
    | eval "$1 --reverse"\
    | head --lines=1
}

min(){
  # Returns the minimum string among the arguments.
  # Renvoie la chaîne la plus petite parmi celles proposées.
  # $1=sort_command with the flags you want to be applied.
  # $ min sort a b c
  # a
  if [[ $# -eq 0 ]]; then
    return 1
  fi
  enhanced_set_shell_option pipefail\
    && trap 'enhanced_unset_shell_option pipefail' RETURN
  printf "%s\n" "${@:2}" \
    | eval "$1"\
    | head --lines=1
}

is_substring(){
  # $1=string
  # $2=substring
  declare -r LFBFL_var_1=$(
    printf "%s" "$1"\
    | sed --expression='s/\\/\\&/g' --expression="s/'/\\\\&/g"
  )
  declare -r LFBFL_var_2=$(
    printf "%s" "$2"\
    | sed --expression='s/\\/\\&/g' --expression="s/'/\\\\&/g"
  )
  local LFBFL_var_3="\$a = '${LFBFL_var_1}';"
  LFBFL_var_3+=" \$b = preg_quote('${LFBFL_var_2}');"
  LFBFL_var_3+=" \$c = '/'.addcslashes(\$b, '/').'/';"
  LFBFL_var_3+=" die(1 - preg_match(\$c, \$a));"
  readonly LFBFL_var_3
  php --run="${LFBFL_var_3}"
  return $?
}

is_subfile(){
  # $1=file_path
  # $2=sub_file_path
  local LFBFL_var_1="\$a = file_get_contents('$1');"
  LFBFL_var_1+=" \$b = preg_quote(file_get_contents('$2'));"
  LFBFL_var_1+=" \$c = '/'.addcslashes(\$b, '/').'/';"
  LFBFL_var_1+=" die(1 - preg_match(\$c, \$a));"
  readonly LFBFL_var_1
  php --run="${LFBFL_var_1}"
  return $?
}

alias min_from_int_sort="min 'sort --numeric-sort'"
alias max_from_int_sort="max 'sort --numeric-sort'"
