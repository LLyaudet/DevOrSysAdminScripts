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

# RETURN traps handling
# Add the following lines at the start of a function.
#   declare -a LFBFL_return_traps_stack
#   local LFBFL_previous_return_trap
#   init_return_trap

init_return_trap(){
  local LFBFL_previous_return_trap2
  LFBFL_previous_return_trap2=$(trap -p RETURN)
  # shellcheck disable=SC2154,SC2309
  if [[ LFBFL_i_verbose -eq 1 ]]; then
    local LFBFL_where_was_i
    get_where_was_i 2
    printf "%s previous_return_trap is: %s.\n"\
      "${LFBFL_where_was_i}"\
      "${LFBFL_previous_return_trap2}"
  fi
  if [[ -z "${LFBFL_previous_return_trap2}" ]]; then
    LFBFL_previous_return_trap2="trap - RETURN"
  fi
  declare -ir LFBFL_function_depth=$((${#FUNCNAME[@]} - 1))
  LFBFL_previous_return_trap="${LFBFL_function_depth}:"
  LFBFL_previous_return_trap+="${LFBFL_previous_return_trap2}"
  trap 'execute_return_traps' RETURN
}

execute_return_traps(){
  if [[ "${FUNCNAME[1]}" == "init_return_trap" ]]; then
    return
  fi
  # -----------------------------------------------------------------------
  # See https://lists.gnu.org/archive/html/help-bash/2026-03/msg00052.html
  if [[ "${FUNCNAME[1]}" == "source" ]]; then
    # Not Working
    return
  fi
  if [[ ${LFBFL_i_no_return_traps:-0} -eq 1 ]]; then
    return
  fi
  # -----------------------------------------------------------------------
  local LFBFL_some_return_trap
  local LFBFL_where_was_i
  get_where_was_i 2
  declare -ir LFBFL_function_depth=$((${#FUNCNAME[@]} - 1))
  while [[ -n "${LFBFL_return_traps_stack}" ]]; do
    LFBFL_some_return_trap="${LFBFL_return_traps_stack[-1]}"
    if [[ "${LFBFL_some_return_trap}" != ${LFBFL_function_depth}:* ]]; then
      # We only treat the top of the stack that should correspond to the
      # current function.
      break
    fi
    LFBFL_some_return_trap=${LFBFL_some_return_trap#*:}
    # shellcheck disable=SC2154,SC2309
    if [[ LFBFL_i_verbose -eq 1 ]]; then
      printf "%s executing some return trap: %s.\n"\
        "${LFBFL_where_was_i}"\
        "${LFBFL_some_return_trap}"
    fi
    eval "${LFBFL_some_return_trap}"
    unset 'LFBFL_return_traps_stack[-1]'
  done
  if [[ "${LFBFL_previous_return_trap}" != ${LFBFL_function_depth}:* ]];
  then
    # We only set the previous return trap if such a trap was replaced
    # by an init_return_trap.
    return
  fi
  LFBFL_previous_return_trap=${LFBFL_previous_return_trap#*:}
  # shellcheck disable=SC2154,SC2309
  if [[ LFBFL_i_verbose -eq 1 ]]; then
    printf "%s setting back to previous_return_trap: %s.\n"\
      "${LFBFL_where_was_i}"\
      "${LFBFL_previous_return_trap}"
  fi
  eval "${LFBFL_previous_return_trap}"
}


is_top_dirstack_directory(){
  # Altough "${DIRSTACK[0]}" may seem to be already a realpath,
  # possible use of symbolic links makes this function necessary.
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
  # shellcheck disable=SC2154,SC2309
  [[ LFBFL_i_verbose -eq 1 ]]\
    && printf "enhanced_pushd requested: %s\n" "$1"
  declare -gi i_enhanced_pushd_result=0
  if [[ -z "$1" ]]; then
    i_enhanced_pushd_result=110
    # shellcheck disable=SC2248
    return ${i_enhanced_pushd_result}
  fi
  # shellcheck disable=SC2154,SC2309
  [[ LFBFL_i_verbose -eq 1 ]] && printf "enhanced_pushd validated1\n"
  is_top_dirstack_directory "$1" && {
    i_enhanced_pushd_result=111
    # shellcheck disable=SC2248
    return ${i_enhanced_pushd_result}
  }
  # shellcheck disable=SC2154,SC2309
  [[ LFBFL_i_verbose -eq 1 ]] && printf "enhanced_pushd validated2\n"

  pushd "$1" || {
    i_enhanced_pushd_result=$?
    local LFBFL_where_was_i
    get_where_was_i "$2"
    printf "%s %s%s no such directory.\n" "${LFBFL_where_was_i}" "$3" "$1"
    # shellcheck disable=SC2248
    return ${i_enhanced_pushd_result}
  }
  # shellcheck disable=SC2154,SC2309
  [[ LFBFL_i_verbose -eq 1 ]] && printf "enhanced_pushd executed\n"
  # shellcheck disable=SC2248
  return ${i_enhanced_pushd_result}
}

enhanced_popd(){
  # Auxiliary function needed below.
  # See usages below if you want to reuse it.
  # $1=to_directory
  # $2=offset_for_where_was_i
  # shellcheck disable=SC2154,SC2309
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
  # shellcheck disable=SC2154,SC2309
  [[ LFBFL_i_verbose -eq 1 ]] && printf "enhanced_popd executed\n"
  return 0
}

can_continue_after_enhanced_pushd(){
  [[ i_enhanced_pushd_result -eq 0
  || i_enhanced_pushd_result -eq 110
  || i_enhanced_pushd_result -eq 111
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

get_some_flag(){
  # $1=variable_name
  # $2=some_flag_long_name
  # $3=read_only 0 or 1 to make the variable readonly
  # This command is to be called in another one with same arguments on top
  # of the three previous.
  # This test:
  # if [[ "$*" == *--verbose* ]]; then
  # is faster than below.
  # But it is not bug free in a calling function,
  # and even incompatible with the current function where
  # the flag_long_name is a mandatory argument.
  printf -v "$1" "%s" "0"
  declare -i LFBFL_i
  local LFBFL_arg
  for ((LFBFL_i = 4; LFBFL_i <= $#; ++LFBFL_i)); do
    LFBFL_arg="${!LFBFL_i}"
    if [[ "${LFBFL_arg}" == "$2" ]]; then
      printf -v "$1" "%s" "1"
      break
    fi
  done
  if [[ $3 -eq 1 ]]; then
    readonly "$1"
  fi
}

get_verbose_option(){
  # This command is to be called in another one with same arguments.
  # Options:
  #   --verbose
  get_some_flag LFBFL_i_verbose --verbose 1 "$@"
  # shellcheck disable=SC2154,SC2309
  if [[ LFBFL_i_verbose -eq 1 ]]; then
    local LFBFL_where_was_i
    get_where_was_i 2
    printf "%s %s\n" "${LFBFL_where_was_i}" "$*"
  fi
}


get_some_option(){
  # $1=variable_name
  # $2=some_option_long_name
  # $3=option_default_value
  # $4=read_only 0 or 1 to make the variable readonly
  # This command is to be called in another one with same arguments on top
  # of the four previous.
  local LFBFL_arg
  for LFBFL_arg in "$@"; do
    if [[ "${LFBFL_arg}" == "$2"=* ]]; then
      printf -v "$1" "%s" "${LFBFL_arg#"$2"=}"
      break
    fi
  done
  printf -v "$1" "%s" "${!1:-$3}"
  if [[ $4 -eq 1 ]]; then
    readonly "$1"
  fi
}

keep_options(){
  # $1=variable_name of array of options
  # Other arguments: the options to keep.
  declare -a LFBFL_array_of_filtered_options
  declare -n LFBFL_array_of_options=$1
  local LFBFL_some_argument
  local LFBFL_some_argument2
  for LFBFL_some_argument in "${LFBFL_array_of_options[@]}"; do
    for LFBFL_some_argument2 in "$@"; do
      if [[
        "${LFBFL_some_argument}" == "${LFBFL_some_argument2}"
        || "${LFBFL_some_argument}" == "${LFBFL_some_argument2}"=*
      ]]; then
        LFBFL_array_of_filtered_options+=("${LFBFL_some_argument}")
      fi
    done
  done
  LFBFL_array_of_options=("${LFBFL_array_of_filtered_options[@]}")
}


# Main usage for the next functions relative to work_directory:
# Add the five following lines at the start of a function.
#   local LFBFL_work_directory=""
#   get_work_directory_option "$@"
#   pushd_to_work_directory\
#     && trap 'popd_from_work_directory' RETURN
#   can_continue_after_enhanced_pushd || return 1
# Or:
#   local LFBFL_work_directory=""
#   get_work_directory_option "$@"
#   pushd_to_work_directory --trap-popd
#   can_continue_after_enhanced_pushd || return 1

get_work_directory_option(){
  # This command is to be called in another one with same arguments.
  # Options:
  #   --work-directory=""
  get_some_option LFBFL_work_directory --work-directory "." 0 "$@"
  LFBFL_work_directory=$(realpath "${LFBFL_work_directory}")
  readonly LFBFL_work_directory
}

pushd_to_work_directory(){
  # Options:
  #   --trap-popd
  enhanced_pushd "${LFBFL_work_directory}" 3 " --work-directory="
  if [[ i_enhanced_pushd_result -eq 0 ]]; then
    declare -i LFBFL_i_trap_popd
    get_some_flag LFBFL_i_trap_popd --trap-popd 1 "$@"
    if [[ LFBFL_i_trap_popd -eq 1 ]]; then
      declare -ir LFBFL_function_depth=$((${#FUNCNAME[@]} - 1))
      local LFBFL_some_return_trap
      LFBFL_some_return_trap="${LFBFL_function_depth}:"
      LFBFL_some_return_trap+="popd_from_work_directory 4"
      readonly LFBFL_some_return_trap
      LFBFL_return_traps_stack+=("${LFBFL_some_return_trap}")
    fi
  fi
  # shellcheck disable=SC2248
  return ${i_enhanced_pushd_result}
}

popd_from_work_directory(){
  # $1=offset for where_was_i
  enhanced_popd "${LFBFL_work_directory}" "${1:-3}"
}

work_directory_is_top_dirstack_directory(){
  is_top_dirstack_directory "${LFBFL_work_directory}"
}


get_offset_option(){
  # This command is to be called in another one with same arguments on top
  # of the default value.
  # $1=option_default_value
  # Options:
  #   --offset=2
  get_some_option LFBFL_i_offset --offset "$1" 1 "$@"
}

get_max_line_length_option(){
  # This command is to be called in another one with same arguments.
  # Its most useful feature is that it factorizes the default maximum line
  # length of 70 characters.
  # Options:
  #   --max-line-length
  get_some_option LFBFL_i_max_line_length --max-line-length 70 1 "$@"
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
#   or better if you use my RETURN traps handler:
#     enhanced_set_shell_option pipefail --trap-unset
#     enhanced_unset_shell_option pipefail --trap-set
# - bash options usage, example with globstar:
#     enhanced_set_bash_option globstar\
#       && trap 'enhanced_unset_bash_option globstar' RETURN
#   or maybe:
#     enhanced_unset_bash_option globstar\
#       && trap 'enhanced_set_bash_option globstar' RETURN
#   or better if you use my RETURN traps handler:
#     enhanced_set_bash_option globstar --trap-unset
#     enhanced_unset_bash_option globstar --trap-set

enhanced_set_shell_option(){
  # $1=optname some shell option for set
  # Options:
  #   --offset=2
  #   --trap-unset
  declare -r LFBFL_result_name="i_enhanced_set_shell_option_$1_result"
  declare -gi "${LFBFL_result_name}"=0
  if [[ -o "$1" ]]; then
    printf -v "${LFBFL_result_name}" "%d" "1"
    # shellcheck disable=SC2086
    return ${!LFBFL_result_name}
  fi
  set -o "$1"
  declare -i LFBFL_i_offset=2
  get_offset_option 2 "$@"
  # shellcheck disable=SC2154,SC2309
  if [[ LFBFL_i_verbose -eq 1 ]]; then
    local LFBFL_where_was_i
    # shellcheck disable=SC2248
    get_where_was_i ${LFBFL_i_offset}
    printf "%s %s shell option activated.\n" "${LFBFL_where_was_i}" "$1"
  fi
  declare -i LFBFL_i_trap_unset
  get_some_flag LFBFL_i_trap_unset --trap-unset 1 "$@"
  if [[ LFBFL_i_trap_unset -eq 1 ]]; then
    declare -ir LFBFL_function_depth=$((${#FUNCNAME[@]} - 1))
    local LFBFL_some_return_trap
    LFBFL_some_return_trap="${LFBFL_function_depth}:"
    LFBFL_some_return_trap+="enhanced_unset_shell_option '$1' --offset=3"
    readonly LFBFL_some_return_trap
    LFBFL_return_traps_stack+=("${LFBFL_some_return_trap}")
  fi
  # shellcheck disable=SC2086
  return ${!LFBFL_result_name}
}

enhanced_unset_shell_option(){
  # $1=optname some shell option for set
  # Options:
  #   --offset=2
  #   --trap-set
  declare -r LFBFL_result_name="i_enhanced_unset_shell_option_$1_result"
  declare -gi "${LFBFL_result_name}"=0
  if [[ ! -o "$1" ]]; then
    printf -v "${LFBFL_result_name}" "%d" "1"
    # shellcheck disable=SC2086
    return ${!LFBFL_result_name}
  fi
  set +o "$1"
  declare -i LFBFL_i_offset=2
  get_offset_option 2 "$@"
  # shellcheck disable=SC2154,SC2309
  if [[ LFBFL_i_verbose -eq 1 ]]; then
    local LFBFL_where_was_i
    # shellcheck disable=SC2248
    get_where_was_i ${LFBFL_i_offset}
    printf "%s %s shell option unactivated.\n" "${LFBFL_where_was_i}" "$1"
  fi
  declare -i LFBFL_i_trap_set
  get_some_flag LFBFL_i_trap_set --trap-set 1 "$@"
  if [[ LFBFL_i_trap_set -eq 1 ]]; then
    declare -ir LFBFL_function_depth=$((${#FUNCNAME[@]} - 1))
    local LFBFL_some_return_trap
    LFBFL_some_return_trap="${LFBFL_function_depth}:"
    LFBFL_some_return_trap+="enhanced_set_shell_option '$1' --offset=3"
    readonly LFBFL_some_return_trap
    LFBFL_return_traps_stack+=("${LFBFL_some_return_trap}")
  fi
  # shellcheck disable=SC2086
  return ${!LFBFL_result_name}
}

enhanced_set_bash_option(){
  # $1=optname some bash option for shopt
  # Options:
  #   --offset=2
  #   --trap-unset
  declare -r LFBFL_result_name="i_enhanced_set_bash_option_$1_result"
  declare -gi "${LFBFL_result_name}"=0
  # declare -r LFBFL_regexp="^(.*:)?$1(:.*)?$" funny but brainfucked
  # if [[ "${BASHOPTS}" =~ ${LFBFL_regexp} ]]; then
  if shopt -q "$1"; then
    printf -v "${LFBFL_result_name}" "%d" "1"
    # shellcheck disable=SC2086
    return ${!LFBFL_result_name}
  fi
  shopt -s "$1"
  declare -i LFBFL_i_offset=2
  get_offset_option 2 "$@"
  # shellcheck disable=SC2154,SC2309
  if [[ LFBFL_i_verbose -eq 1 ]]; then
    local LFBFL_where_was_i
    # shellcheck disable=SC2248
    get_where_was_i ${LFBFL_i_offset}
    printf "%s %s bash option activated.\n" "${LFBFL_where_was_i}" "$1"
  fi
  declare -i LFBFL_i_trap_unset
  get_some_flag LFBFL_i_trap_unset --trap-unset 1 "$@"
  if [[ LFBFL_i_trap_unset -eq 1 ]]; then
    declare -ir LFBFL_function_depth=$((${#FUNCNAME[@]} - 1))
    local LFBFL_some_return_trap
    LFBFL_some_return_trap="${LFBFL_function_depth}:"
    LFBFL_some_return_trap+="enhanced_unset_bash_option '$1' --offset=3"
    readonly LFBFL_some_return_trap
    LFBFL_return_traps_stack+=("${LFBFL_some_return_trap}")
  fi
  # shellcheck disable=SC2086
  return ${!LFBFL_result_name}
}

enhanced_unset_bash_option(){
  # $1=optname some bash option for shopt
  # Options:
  #   --offset=2
  #   --trap-set
  declare -r LFBFL_result_name="i_enhanced_unset_bash_option_$1_result"
  declare -gi "${LFBFL_result_name}"=0
  if ! shopt -q "$1"; then
    printf -v "${LFBFL_result_name}" "%d" "1"
    # shellcheck disable=SC2086
    return ${!LFBFL_result_name}
  fi
  shopt -u "$1"
  declare -i LFBFL_i_offset=2
  get_offset_option 2 "$@"
  # shellcheck disable=SC2154,SC2309
  if [[ LFBFL_i_verbose -eq 1 ]]; then
    local LFBFL_where_was_i
    # shellcheck disable=SC2248
    get_where_was_i ${LFBFL_i_offset}
    printf "%s %s bash option unactivated.\n" "${LFBFL_where_was_i}" "$1"
  fi
  declare -i LFBFL_i_trap_set
  get_some_flag LFBFL_i_trap_set --trap-set 1 "$@"
  if [[ LFBFL_i_trap_set -eq 1 ]]; then
    declare -ir LFBFL_function_depth=$((${#FUNCNAME[@]} - 1))
    local LFBFL_some_return_trap
    LFBFL_some_return_trap="${LFBFL_function_depth}:"
    LFBFL_some_return_trap+="enhanced_set_bash_option '$1' --offset=3"
    readonly LFBFL_some_return_trap
    LFBFL_return_traps_stack+=("${LFBFL_some_return_trap}")
  fi
  # shellcheck disable=SC2086
  return ${!LFBFL_result_name}
}
