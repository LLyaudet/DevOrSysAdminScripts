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

# 2025-12-30T21:33+01:00: This file was moved from
# "./build_and_checks_dependencies/listings"
# to
# "./build_and_checks_dependencies".
# This file was renamed from "update_or_check_files_names_listing.sh"
# to "update_or_check_files_names_listing.exec.sh".
# This file was renamed from "update_or_check_file_names_listing.sh"
# to "update_or_check_files_names_listing.sh"?

LFBFL_subdir="build_and_checks_dependencies"
# shellcheck source=lines_filters.libr.sh
source "./${LFBFL_subdir}/lines_filters.libr.sh"
# shellcheck source=strings_functions.libr.sh
source "./${LFBFL_subdir}/strings_functions.libr.sh"

update_or_check_files_names_listing(){
  declare -i LFBFL_verbose=0
  if [[ "$*" == *--verbose* ]]; then
    echo "$0 $*"
    LFBFL_verbose=1
  fi
  readonly LFBFL_verbose

  declare -i LFBFL_write=0
  if [[ "$*" == *--write* ]]; then
    LFBFL_write=1
  fi
  readonly LFBFL_write

  declare -i LFBFL_append=0
  if [[ "$*" == *--append* ]]; then
    LFBFL_append=1
  fi
  readonly LFBFL_append

  if [[ ! -o pipefail ]]; then
    [[ LFBFL_verbose -eq 1 ]] && echo "pipefail option activated"
    set -o pipefail
    trap 'set +o pipefail' RETURN
  fi

  LFBFL_subdir2="build_and_checks_variables"
  local LFBFL_listing="./${LFBFL_subdir2}/files_names_listing.txt"
  readonly LFBFL_listing

  if [[ LFBFL_write -eq 1 ]]; then
    : > "${LFBFL_listing}"
  fi
  # Remove line returns here to keep lines short.
  sed -Ez 's/\\\n//Mg' "${LFBFL_listing}"\
    > "${LFBFL_listing}.temp"
  shopt -s dotglob
  get_split_score_simple 1 70 /
  declare -r LFBFL_split_score_command="${get_split_score_result}"
  local LFBFL_split_score_command_properties
  LFBFL_split_score_command_properties="${get_split_score_result2}"
  readonly LFBFL_split_score_command_properties
  local LFBFL_suffix=\\\\ # instead of '\\' to avoid shellcheck SC1003
  readonly LFBFL_suffix
  local LFBFL_file_name
  local LFBFL_base_file_name
  local LFBFL_split_file_name
  find . -type f -printf '%P\n'\
    | relevant_find\
    | sort\
    | while read -r LFBFL_file_name;
  do
    git check-ignore -q "${LFBFL_file_name}" && continue
    LFBFL_base_file_name=$(basename "${LFBFL_file_name}")
    [[ "${LFBFL_base_file_name}" != files_names_listing.txt* ]]\
      || continue
    if [[ "${LFBFL_base_file_name}" == *.md ]]; then
      if [[ -f "${LFBFL_file_name}.tpl" ]]; then
        continue
      fi
    fi
    repeated_split_last_line "${LFBFL_file_name}" "" 70\
      "${LFBFL_suffix}" "${LFBFL_split_score_command}"\
      "${LFBFL_split_score_command_properties}"
    LFBFL_split_file_name="${repeated_split_last_line_result}"
    if [[ LFBFL_write -eq 1 ]]; then
      # shellcheck disable=SC2001
      echo "${LFBFL_file_name}"\
        | sed -e "s|${LFBFL_file_name}|${LFBFL_split_file_name}|g"\
        >> "${LFBFL_listing}"
      continue
    fi
    if grep -q "${LFBFL_file_name}\$" "${LFBFL_listing}.temp"; then
      :
    else
      echo\
      "The file ${LFBFL_file_name} is not listed in ${LFBFL_listing}."
      if [[ LFBFL_append -eq 1 ]]; then
        # shellcheck disable=SC2001
        echo "${LFBFL_file_name}"\
          | sed -e "s|${LFBFL_file_name}|${LFBFL_split_file_name}|g"\
          >> "${LFBFL_listing}"
      fi
    fi
  done

  while read -r LFBFL_file_name;
  do
    [[ "${LFBFL_file_name}" != '//'* ]] || continue
    LFBFL_base_file_name=$(basename "${LFBFL_file_name}")
    if ! [[ -f "${LFBFL_file_name}" ]]; then
      echo\
      "The non-file ${LFBFL_file_name} is listed in ${LFBFL_listing}."
    fi
  done < "${LFBFL_listing}.temp"

  rm "${LFBFL_listing}.temp"
  shopt -u dotglob
  shopt -s globstar

  if [[ LFBFL_verbose -eq 1 ]]; then
    cat "${LFBFL_listing}"
  fi
}

update_or_check_files_names_listing "$@"
