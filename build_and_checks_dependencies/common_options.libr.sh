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
  # See usages below if you want to reuse it.
  # $1=offset
  LFBFL_where_was_i="$0"
  if [[ "${BASH_SOURCE[$1]}" != "" && "${BASH_SOURCE[$1]}" != "$0" ]]; then
    LFBFL_where_was_i+=" ${BASH_SOURCE[$1]}"
  fi
  if [[ "${FUNCNAME[$1]}" != "" ]]; then
    LFBFL_where_was_i+=" ${FUNCNAME[$1]}()"
  fi
  readonly LFBFL_where_was_i
  # Comment out line above in case someone would use distinct
  # offsets in the same function.
}

enhanced_pushd(){
  # Auxiliary function needed below.
  # See usages below if you want to reuse it.
  # $1=to_directory
  # $2=offset_for_where_was_i
  # $3=error_message_intermediate_complement
  if [[ -n "$1" ]]; then
    local LFBFL_real_path1
    LFBFL_real_path1=$(realpath "${DIRSTACK[0]}")
    readonly LFBFL_real_path1
    local LFBFL_real_path2
    LFBFL_real_path2=$(realpath "$1")
    readonly LFBFL_real_path2
    if [[ "${LFBFL_real_path1}" == "${LFBFL_real_path2}" ]]; then
      return 111
    fi

    declare -i LFBFL_i_pushd_result
    pushd "$1" || {
      LFBFL_i_pushd_result=$?
      readonly LFBFL_i_pushd_result
      local LFBFL_where_was_i
      get_where_was_i "$2"
      echo "${LFBFL_where_was_i} $3$1 no such directory."
      # shellcheck disable=SC2248
      return ${LFBFL_i_pushd_result}
    }
  fi
}

enhanced_popd(){
  # Auxiliary function needed below.
  # See usages below if you want to reuse it.
  # $1=to_directory
  # $2=offset_for_where_was_i
  if [[ -n "$1" ]]; then
    declare -i LFBFL_i_popd_result
    popd || {
      LFBFL_i_popd_result=$?
      readonly LFBFL_i_popd_result
      local LFBFL_where_was_i
      get_where_was_i "$2"
      echo "$2 popd failed."
      # shellcheck disable=SC2248
      return ${LFBFL_i_popd_result}
    }
  fi
}


# Main usage for the next functions relative to verbose mode:
# Add the two following lines at the start of a function.
#   declare -i LFBFL_i_verbose=0
#   get_verbose_option "$@"
# /!\ You really need all of the two lines. /!\
# Otherwise, the call to get_verbose_option may impact a function above;
# in case you didn't copy all of "$@" in nested function calls...
# /!\ The same warning applies for other functions below. /!\
# /!\ I will not repeat it below. /!\
# Use get_verbose_options_array, if needed.

get_verbose_options_array(){
  # Use this constant with code like:
  # "${LFBFL_VERBOSE_OPTIONS[LFBFL_i_verbose]}"
  # It could be extended if there is more than one level of verboseness.
  if [[ -n "${LFBFL_VERBOSE_OPTIONS}" ]]; then
    return
  fi

  declare -agr LFBFL_VERBOSE_OPTIONS=(
    ""
    "--verbose"
  )
}

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
    get_where_was_i 2
    readonly LFBFL_i_popd_result
    echo "${LFBFL_where_was_i} $*"
    LFBFL_i_verbose=1
  fi
  # shellcheck disable=SC2034
  readonly LFBFL_i_verbose
}


# Main usage for the next functions relative to work_directory:
# Add the five following lines at the start of a function.
#   local LFBFL_work_directory=""
#   get_work_directory_option "$@"
#   pushd_to_work_directory\
#     && trap 'popd_from_work_directory' RETURN\
#     || return

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
  readonly LFBFL_work_directory
}

pushd_to_work_directory(){
  enhanced_pushd "${LFBFL_work_directory}" 3 " --work-directory="
}

popd_from_work_directory(){
  enhanced_popd "${LFBFL_work_directory}" 3
}
