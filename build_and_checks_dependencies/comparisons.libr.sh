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
# The file "comparisons.sh" was renamed to "comparisons.libr.sh".

equal(){
  # Returns 1 if all the arguments strings are equal.
  # Renvoie 1 dans $? si toutes les chaînes en arguments sont égales.
  # J'ai rerepensé au 3-way-merge
  # et à mon article sur le principe de première différence
  # appliqué à la largeur modulaire, de clique ou de rang avec
  # l'idée d'un principe de première différence ternaire.
  equal_var_all_args="'$*'"
  equal_var_current="$equal_var_all_args"
  for equal_var_arg in $@; do
    if [[ "$equal_var_current" == "$equal_var_all_args" ]]; then
      equal_var_current="$equal_var_arg"
      continue
    fi
    if [[ "$equal_var_current" != "$equal_var_arg" ]]; then
      return 0
    fi
  done
  return 1
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
  printf "%s\n" "${@:2}" | eval "$1" | head -1
}

is_substring(){
  # $1=$string
  # $2=$substring
  is_substring_var_1=$(\
    echo "$1" | sed -e 's/\\/\\&/g' -e "s/'/\\\\&/g"\
  )
  is_substring_var_2=$(\
    echo "$2" | sed -e 's/\\/\\&/g' -e "s/'/\\\\&/g"\
  )
  is_substring_var_3="\$a = '$is_substring_var_1';"
  is_substring_var_3+=" \$b = preg_quote('$is_substring_var_2');"
  is_substring_var_3+=" \$c = '/'.addcslashes(\$b, '/').'/';"
  is_substring_var_3+=" die(preg_match(\$c, \$a));"
  php -r "$is_substring_var_3"
}

is_subfile(){
  # $1=$file_name
  # $2=$sub_file_name
  is_subfile_var_1="\$a = file_get_contents('$1');"
  is_subfile_var_1+=" \$b = preg_quote(file_get_contents('$2'));"
  is_subfile_var_1+=" \$c = '/'.addcslashes(\$b, '/').'/';"
  is_subfile_var_1+=" die(preg_match(\$c, \$a));"
  php -r "$is_subfile_var_1"
}

alias min_from_int_sort="min 'sort --numeric-sort'"
alias max_from_int_sort="max 'sort --numeric-sort'"
