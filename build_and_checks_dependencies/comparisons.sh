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
# ©Copyright 2023-2024 Laurent Lyaudet

equal(){
  # Returns 1 if all the arguments strings are equal.
  # Renvoie 1 dans $? si toutes les chaînes en arguments sont égales.
  # J'ai rerepensé au 3-way-merge
  # et à mon article sur le principe de première différence
  # appliqué à la largeur modulaire, de clique ou de rang avec
  # l'idée d'un principe de première différence ternaire.
  all_args="'$*'"
  current="$all_args"
  for arg in $@; do
    if [[ "$current" == "$all_args" ]]; then
      current="$arg"
      continue
    fi
    if [[ "$current" != "$arg" ]]; then
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
  printf "%s\n" "${@:2}" | $1 -r | head -1
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
  printf "%s\n" "${@:2}" | $1 | head -1
}
