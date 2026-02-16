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

equal(){
  # Returns 1 if all the arguments strings are equal.
  # Renvoie 1 dans $? si toutes les chaînes en arguments sont égales.
  # J'ai rerepensé au 3-way-merge
  # et à mon article sur le principe de première différence
  # appliqué à la largeur modulaire, de clique ou de rang avec
  # l'idée d'un principe de première différence ternaire.
  declare -i LFBFL_first=1
  local LFBFL_current
  local LFBFL_arg
  for LFBFL_arg in "$@"; do
    if [[ LFBFL_first -eq 1 ]]; then
      LFBFL_current="${LFBFL_arg}"
      LFBFL_first=0
      continue
    fi
    if [[ "${LFBFL_current}" != "${LFBFL_arg}" ]]; then
      return 0
    fi
  done
  return 1
}

some_distinct(){
  declare -i LFBFL_result
  equal "$@"
  LFBFL_result=1-$?
  # shellcheck disable=SC2248
  return ${LFBFL_result}
}

all_distinct(){
  # Returns 1 if all the arguments strings are distinct.
  declare -ir LFBFL_ij_max=$#
  declare -i LFBFL_i
  declare -i LFBFL_j
  for ((LFBFL_i=1; LFBFL_i<=LFBFL_ij_max; ++LFBFL_i)); do
    for ((LFBFL_j=1; LFBFL_j<=LFBFL_ij_max; ++LFBFL_j)); do
      [[ LFBFL_i -eq LFBFL_j ]] && continue
      [[ "${!LFBFL_i}" == "${!LFBFL_j}" ]] && return 0
    done
  done
  return 1
}

all_distinct2(){
  # Returns 1 if all the arguments strings are distinct.
  declare -i LFBFL_first=1
  local LFBFL_element
  local LFBFL_previous_element
  if [[ "$#" == 0 ]]; then
    return 1
  fi
  # shellcheck disable=SC2312
  printf "%s\n" "${@:1}" | sort | while read -r LFBFL_element; do
    echo "${LFBFL_element}"
    if [[ LFBFL_first -eq 1 ]]; then
      LFBFL_previous_element="${LFBFL_element}"
      LFBFL_first=0
      continue
    fi
    echo "'${LFBFL_element}'" "'${LFBFL_previous_element}'"
    if [[ "${LFBFL_previous_element}" == "${LFBFL_element}" ]]; then
      echo "WAT"
      return 0
    fi
    LFBFL_previous_element="${LFBFL_element}"
  done
  return 1
}

some_equal(){
  declare -i LFBFL_result
  all_distinct "$@"
  LFBFL_result=1-$?
  # shellcheck disable=SC2248
  return ${LFBFL_result}
}

some_equal2(){
  declare -i LFBFL_result
  all_distinct2 "$@"
  echo $?
  LFBFL_result=1-$?
  # shellcheck disable=SC2248
  return ${LFBFL_result}
}

max(){
  # Returns the maximum string among the arguments.
  # Renvoie la chaîne la plus grande parmi celles proposées.
  # $1=$sort command with the flags you want to be applied.
  # $ max sort a b c
  # c
  if [[ "$#" == 0 ]]; then
    return 1
  fi
  # shellcheck disable=SC2312
  printf "%s\n" "${@:2}" | eval "$1 -r" | head -1
}

min(){
  # Returns the minimum string among the arguments.
  # Renvoie la chaîne la plus petite parmi celles proposées.
  # $1=$sort command with the flags you want to be applied.
  # $ min sort a b c
  # a
  if [[ "$#" == 0 ]]; then
    return 1
  fi
  # shellcheck disable=SC2312
  printf "%s\n" "${@:2}" | eval "$1" | head -1
}

is_substring(){
  # $1=$string
  # $2=$substring
  declare -r LFBFL_var_1=$(\
    echo "$1" | sed -e 's/\\/\\&/g' -e "s/'/\\\\&/g"\
  )
  declare -r LFBFL_var_2=$(\
    echo "$2" | sed -e 's/\\/\\&/g' -e "s/'/\\\\&/g"\
  )
  local LFBFL_var_3="\$a = '${LFBFL_var_1}';"
  LFBFL_var_3+=" \$b = preg_quote('${LFBFL_var_2}');"
  LFBFL_var_3+=" \$c = '/'.addcslashes(\$b, '/').'/';"
  LFBFL_var_3+=" die(1 - preg_match(\$c, \$a));"
  readonly LFBFL_var_3
  php -r "${LFBFL_var_3}"
  return $?
}

is_subfile(){
  # $1=$file_name
  # $2=$sub_file_name
  local LFBFL_var_1="\$a = file_get_contents('$1');"
  LFBFL_var_1+=" \$b = preg_quote(file_get_contents('$2'));"
  LFBFL_var_1+=" \$c = '/'.addcslashes(\$b, '/').'/';"
  LFBFL_var_1+=" die(1 - preg_match(\$c, \$a));"
  readonly LFBFL_var_1
  php -r "${LFBFL_var_1}"
  return $?
}

alias min_from_int_sort="min 'sort --numeric-sort'"
alias max_from_int_sort="max 'sort --numeric-sort'"
