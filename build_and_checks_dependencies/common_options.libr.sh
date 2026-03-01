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

get_where_was_i(){
  # Auxiliary function needed below.
  # See usages below.
  LFBFL_where_was_i="$0"
  if [[ "${BASH_SOURCE[2]}" != "" && "${BASH_SOURCE[2]}" != "$0" ]]; then
    LFBFL_where_was_i+=" ${BASH_SOURCE[2]}"
  fi
  if [[ "${FUNCNAME[2]}" != "" ]]; then
    LFBFL_where_was_i+=" ${FUNCNAME[2]}()"
  fi
}

# Main usage for the next function relative to verbose mode:
# Add the three following lines at the start of a function.
#   declare -i LFBFL_i_verbose=0
#   local LFBFL_verbose=""
#   get_verbose_option "$@"
# /!\ You really need all of the three lines. /!\
# Otherwise, the call to get_verbose_option may impact a function above;
# in case you didn't copy all of "$@" in nested function calls...
# /!\ The same warning applies for other functions below. /!\
# /!\ I will not repeat it below. /!\

get_verbose_option(){
  # This command is to be called in another one with same arguments.
  # Options:
  #   --verbose
  # This test is faster than:
  #   for LFBFL_arg in "$@"; do
  #     if [[ "${LFBFL_arg}" == "--verbose" ]]; then
  # But it is not bug free.
  if [[ "$*" == *--verbose* ]]; then
    local LFBFL_where_was_i
    get_where_was_i
    echo "${LFBFL_where_was_i} $*"
    LFBFL_i_verbose=1
    LFBFL_verbose="--verbose"
  fi
}

# Main usage for the next functions relative to work_directory:
# Add the four following lines at the start of a function.
#   local LFBFL_work_directory=""
#   get_work_directory_option "$@"
#   pushd_to_work_directory
#   trap 'enhanced_popd' RETURN

get_work_directory_option(){
  # This command is to be called in another one with same arguments.
  # Options:
  #   --work-directory=""
  local LFBFL_arg
  for LFBFL_arg in "$@"; do
    if [[ "${LFBFL_arg}" == --work-directory=* ]]; then
      LFBFL_work_directory=${LFBFL_arg#--work-directory=}
      LFBFL_work_directory=${LFBFL_work_directory/#~/${HOME}}
      break
    fi
  done
}

pushd_to_work_directory(){
  if [[ -n "${LFBFL_work_directory}" ]]; then
    declare -i LFBFL_i_pushd_result
    pushd "${LFBFL_work_directory}" || {
      local LFBFL_where_was_i
      get_where_was_i
      LFBFL_i_pushd_result=$?
      echo "${LFBFL_where_was_i} --root-directory=${LFBFL_work_directory}"\
        "no such directory."
      # shellcheck disable=SC2248
      return ${LFBFL_i_pushd_result}
    }
  fi
}

enhanced_popd(){
  if [[ -n "${LFBFL_work_directory}" ]]; then
    declare -i LFBFL_i_popd_result
    popd || {
      local LFBFL_where_was_i
      get_where_was_i
      LFBFL_i_popd_result=$?
      echo "${LFBFL_where_was_i} popd failed."
      # shellcheck disable=SC2248
      return ${LFBFL_i_popd_result}
    }
  fi
}
