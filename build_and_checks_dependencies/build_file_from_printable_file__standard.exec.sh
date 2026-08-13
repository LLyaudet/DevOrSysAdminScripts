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
# shellcheck source=overwrite_if_not_equal.libr.sh
source "./${LFBFL_subdir}/overwrite_if_not_equal.libr.sh"

build_file_from_printable_file__standard(){
  # $1=base_name
  # Options:
  #   --verbose
  #   --work-directory=""
  #   --remove-leading-whitespaces-after-escaped-line-return
  declare -i LFBFL_i_verbose=0
  get_verbose_option "$@"
  local LFBFL_work_directory=""
  get_work_directory_option "$@"
  declare -i LFBFL_remove_leading_whitespaces_after_escaped_line_return=0
  get_some_flag LFBFL_remove_leading_whitespaces_after_escaped_line_return\
    --remove-leading-whitespaces-after-escaped-line-return 1 "$@"
  declare -a LFBFL_return_traps_stack
  init_return_trap
  pushd_to_work_directory --trap-popd
  can_continue_after_enhanced_pushd || return 1

  local LFBFL_base_name
  get_some_option LFBFL_base_name --base-name '' '' 1 "$@"
  if [[ LFBFL_i_verbose -eq 1 ]]; then
    if [[ "${LFBFL_base_name}" == "" ]]; then
      return 2
    fi
    printf "Searching file to build from printable file: %s.\n"\
      "${LFBFL_base_name}"
  fi

  local LFBFL_s_expression='s/\\\n//Mg'
  if [[
    LFBFL_remove_leading_whitespaces_after_escaped_line_return -eq 1
  ]]; then
    LFBFL_s_expression='s/\\\n *//Mg'
  fi
  if [[ -f "${LFBFL_base_name}.tpl" ]]; then
    sed --regexp-extended --null-data --expression="${LFBFL_s_expression}"\
      -- "${LFBFL_base_name}.tpl"\
      > "${LFBFL_base_name}.temp"
    overwrite_if_not_equal "${LFBFL_base_name}" "${LFBFL_base_name}.temp"
  else
    printf "No file %s.tpl\n" "${LFBFL_base_name}"
    return 3
  fi

  if [[ ! -f "${LFBFL_base_name}" ]]; then
    printf "No file %s\n" "${LFBFL_base_name}"
    return 4
  fi
}

build_file_from_printable_file__standard "$@"
