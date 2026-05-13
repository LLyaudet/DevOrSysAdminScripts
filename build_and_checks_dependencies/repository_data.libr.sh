#!/usr/bin/env bash
# This file is part of DevOrSysAdminScripts.
#
# DevOrSysAdminScripts is free software:
# you can redistribute it and/or modify it
# under the terms of the GNU General Public License
# as published by the Free Software Foundation,
# either version 3 of the License,
# or (at your option) any later version.
#
# DevOrSysAdminScripts is distributed
# in the hope that it will be useful,
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

LFBFL_subdir="build_and_checks_dependencies"
# shellcheck source=common_options.libr.sh
source "./${LFBFL_subdir}/common_options.libr.sh"
# shellcheck source=lines_filters.libr.sh
source "./${LFBFL_subdir}/lines_filters.libr.sh"

# /!\ You need to activate extglob before parsing this file. /!\
# And I'm kind enough to activate it inside functions that need it below.

get_upgrade_venvs_time_interval_in_seconds(){
  # $1=data_file_path
  # Options:
  #   --verbose
  declare -i LFBFL_i_verbose=0
  get_verbose_option "$@"
  declare -a LFBFL_return_traps_stack
  init_return_trap

  enhanced_set_bash_option extglob --trap-unset

  grep_variable "$1"\
    upgrade_venvs_time_interval_in_seconds\
    --result-variable-prefix="LFBFL_"

  [[ LFBFL_i_verbose -eq 1 ]]\
    && printf "You say \"%s\".\n"\
        "${LFBFL_upgrade_venvs_time_interval_in_seconds}"

  case ${LFBFL_upgrade_venvs_time_interval_in_seconds} in
    +([0-9])) : ;;
    wat) LFBFL_upgrade_venvs_time_interval_in_seconds=${RANDOM};;
    watyouwant\?) LFBFL_upgrade_venvs_time_interval_in_seconds=${SRANDOM};;
    *) printf "No wat for you?\n";; #TempsDeCerveauDisponible XD SC2249 ;)
  esac

  [[ LFBFL_i_verbose -eq 1 ]]\
    && printf "I say \"%s\".\n"\
        "${LFBFL_upgrade_venvs_time_interval_in_seconds}"
}

grep_variable_with_multiple_files(){
  # $1=data_file_path
  # $2=variable_name
  # Options :
  #   --result-variable-prefix="LFBFL_" for example
  local LFBFL_prefix=""
  get_some_option LFBFL_prefix --result-variable-prefix '' '' 1 "$@"
  grep_variable "$1" "$2" --result-variable-prefix="${LFBFL_prefix}"
  declare -r LFBFL_variable_name="${LFBFL_prefix}$2"
  declare -a LFBFL_arr
  if [[ -z "${!LFBFL_variable_name}" ]]; then
    return
  fi
  mapfile -t LFBFL_arr <<< "${!LFBFL_variable_name}"
  local LFBFL_s=""
  local LFBFL_file_path
  local LFBFL_previous_file_path
  for LFBFL_file_path in "${LFBFL_arr[@]}"; do
    if [[
      -n "${LFBFL_previous_file_path}"
      && "${LFBFL_previous_file_path}" != */
    ]]; then
      LFBFL_s+=$'\n'
    fi
    LFBFL_s+="${LFBFL_file_path}"
    LFBFL_previous_file_path="${LFBFL_file_path}"
  done
  printf -v "${LFBFL_variable_name}" "%s" "${LFBFL_s}"
}
