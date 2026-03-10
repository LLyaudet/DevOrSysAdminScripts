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

is_top_dirstack_directory(){
  # This function should not be needed since when testing "${DIRSTACK[0]}"
  # is already a realpath. But I keep it, in case it is needed.
  # https://lists.gnu.org/archive/html/help-bash/2026-03/msg00005.html
  # $1=to_directory needs to be "realpathed" already
  if [[ -z "$1" ]]; then
    return 0
  fi
  local LFBFL_real_path
  LFBFL_real_path=$(realpath "${DIRSTACK[0]}")
  readonly LFBFL_real_path
  [[ "${LFBFL_real_path}" == "$1" ]]
}

enhanced_pushd(){
  # Auxiliary function needed below.
  # See usages below if you want to reuse it.
  # $1=to_directory must be sanitized with realpath before call
  # $2=offset_for_where_was_i
  # $3=error_message_intermediate_complement
  # returns an error code whenever no pushd happened
  [[ LFBFL_i_verbose -eq 1 ]]\
    && printf "enhanced_pushd requested: %s\n" "$1"
  declare -ig enhanced_pushd_result=0
  if [[ -z "$1" ]]; then
    enhanced_pushd_result=110
    # shellcheck disable=SC2248
    return ${enhanced_pushd_result}
  fi
  [[ LFBFL_i_verbose -eq 1 ]] && printf "enhanced_pushd validated1\n"
  is_top_dirstack_directory "$1" && {
    enhanced_pushd_result=111
    # shellcheck disable=SC2248
    return ${enhanced_pushd_result}
  }
  [[ LFBFL_i_verbose -eq 1 ]] && printf "enhanced_pushd validated2\n"

  pushd "$1" || {
    enhanced_pushd_result=$?
    local LFBFL_where_was_i
    get_where_was_i "$2"
    printf "%s %s%s no such directory.\n" "${LFBFL_where_was_i}" "$3" "$1"
    # shellcheck disable=SC2248
    return ${enhanced_pushd_result}
  }
  [[ LFBFL_i_verbose -eq 1 ]] && printf "enhanced_pushd executed\n"
  # shellcheck disable=SC2248
  return ${enhanced_pushd_result}
}

enhanced_popd(){
  # Auxiliary function needed below.
  # See usages below if you want to reuse it.
  # $1=to_directory
  # $2=offset_for_where_was_i
  [[ LFBFL_i_verbose -eq 1 ]]\
    && printf "enhanced_popd requested: %s\n" "$1"
  if [[ -z "$1" ]]; then
    return 0
  fi

  declare -i LFBFL_i_popd_result
  popd || {
    LFBFL_i_popd_result=$?
    readonly LFBFL_i_popd_result
    local LFBFL_where_was_i
    get_where_was_i "$2"
    printf "%s popd failed.\n" "${LFBFL_where_was_i}"
    # shellcheck disable=SC2248
    return ${LFBFL_i_popd_result}
  }
  [[ LFBFL_i_verbose -eq 1 ]] && printf "enhanced_popd executed\n"
  return 0
}

can_continue_after_enhanced_pushd(){
  [[ enhanced_pushd_result -eq 0
  || enhanced_pushd_result -eq 110
  || enhanced_pushd_result -eq 111
  ]]
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
    readonly LFBFL_where_was_i
    printf "%s %s\n" "${LFBFL_where_was_i}" "$*"
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
#     && trap 'popd_from_work_directory' RETURN
#   can_continue_after_enhanced_pushd || return 1

get_work_directory_option(){
  # This command is to be called in another one with same arguments.
  # Options:
  #   --work-directory=""
  local LFBFL_arg
  for LFBFL_arg in "$@"; do
    if [[ "${LFBFL_arg}" == --work-directory=* ]]; then
      LFBFL_work_directory=${LFBFL_arg#--work-directory=}
      LFBFL_work_directory=${LFBFL_work_directory:-.}
      # LFBFL_work_directory=${LFBFL_work_directory/#~/${HOME}} line below
      LFBFL_work_directory=$(realpath "${LFBFL_work_directory}")
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

work_directory_is_top_dirstack_directory(){
  is_top_dirstack_directory "${LFBFL_work_directory}"
}


# Functions relative to shell and bash options
# (See SHELLOPTS and BASHOPTS, set and shopt):
# - shell options usage, example with pipefail:
#     enhanced_set_shell_option pipefail\
#       && trap 'enhanced_unset_shell_option pipefail' RETURN
#   or maybe:
#     enhanced_unset_shell_option pipefail\
#       && trap 'enhanced_set_shell_option pipefail' RETURN
#   if you need to unset it in some function.
# - bash options usage, example with globstar:
#     enhanced_set_bash_option globstar\
#       && trap 'enhanced_unset_bash_option globstar' RETURN
#   or maybe:
#     enhanced_unset_bash_option globstar\
#       && trap 'enhanced_set_bash_option globstar' RETURN

enhanced_set_shell_option(){
  # $1=optname some shell option for set
  declare -r LFBFL_result_name="enhanced_set_shell_option_$1_result"
  declare -gi "${LFBFL_result_name}"=0
  if [[ -o "$1" ]]; then
    printf -v "${LFBFL_result_name}" "%d" "1"
    # shellcheck disable=SC2086
    return ${!LFBFL_result_name}
  fi
  set -o "$1"
  if [[ LFBFL_i_verbose -eq 1 ]]; then
    local LFBFL_where_was_i
    get_where_was_i 2
    printf "%s %s shell option activated.\n" "${LFBFL_where_was_i}" "$1"
  fi
  # shellcheck disable=SC2086
  return ${!LFBFL_result_name}
}

enhanced_unset_shell_option(){
  # $1=optname some shell option for set
  declare -r LFBFL_result_name="enhanced_unset_shell_option_$1_result"
  declare -gi "${LFBFL_result_name}"=0
  if [[ ! -o "$1" ]]; then
    printf -v "${LFBFL_result_name}" "%d" "1"
    # shellcheck disable=SC2086
    return ${!LFBFL_result_name}
  fi
  set +o "$1"
  if [[ LFBFL_i_verbose -eq 1 ]]; then
    local LFBFL_where_was_i
    get_where_was_i 2
    printf "%s %s shell option unactivated.\n" "${LFBFL_where_was_i}" "$1"
  fi
  # shellcheck disable=SC2086
  return ${!LFBFL_result_name}
}

enhanced_set_bash_option(){
  # $1=optname some bash option for shopt
  declare -r LFBFL_result_name="enhanced_set_bash_option_$1_result"
  declare -gi "${LFBFL_result_name}"=0
  # declare -r LFBFL_regexp="^(.*:)?$1(:.*)?$" funny but brainfucked
  # if [[ "${BASHOPTS}" =~ ${LFBFL_regexp} ]]; then
  if shopt -q "$1"; then
    printf -v "${LFBFL_result_name}" "%d" "1"
    # shellcheck disable=SC2086
    return ${!LFBFL_result_name}
  fi
  shopt -s "$1"
  if [[ LFBFL_i_verbose -eq 1 ]]; then
    local LFBFL_where_was_i
    get_where_was_i 2
    printf "%s %s bash option activated.\n" "${LFBFL_where_was_i}" "$1"
  fi
  # shellcheck disable=SC2086
  return ${!LFBFL_result_name}
}

enhanced_unset_bash_option(){
  # $1=optname some bash option for shopt
  declare -r LFBFL_result_name="enhanced_unset_bash_option_$1_result"
  declare -gi "${LFBFL_result_name}"=0
  if ! shopt -q "$1"; then
    printf -v "${LFBFL_result_name}" "%d" "1"
    # shellcheck disable=SC2086
    return ${!LFBFL_result_name}
  fi
  shopt -u "$1"
  if [[ LFBFL_i_verbose -eq 1 ]]; then
    local LFBFL_where_was_i
    get_where_was_i 2
    printf "%s %s bash option unactivated.\n" "${LFBFL_where_was_i}" "$1"
  fi
  # shellcheck disable=SC2086
  return ${!LFBFL_result_name}
}
