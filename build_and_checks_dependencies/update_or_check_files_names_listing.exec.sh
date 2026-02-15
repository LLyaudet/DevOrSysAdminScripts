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
# shellcheck disable=SC1090
source "./${LFBFL_subdir}/lines_filters.libr.sh"
# shellcheck disable=SC1090
source "./${LFBFL_subdir}/strings_functions.libr.sh"

update_or_check_files_names_listing(){
  declare -i LFBFL_verbose=0
  if [[ "$*" == *--verbose* ]]; then
    echo "$0 $*"
    LFBFL_verbose=1
  fi
  readonly LFBFL_verbose

  LFBFL_subdir2="build_and_checks_variables"
  files_names_listing="./${LFBFL_subdir2}/files_names_listing.txt"

  if [[ "$*" == *--write* ]]; then
    : > "${files_names_listing}"
  fi
  sed_expression='s/\\\n//Mg'
  sed -Ez "${sed_expression}" "${files_names_listing}"\
    > "${files_names_listing}.temp1"
  sed -Ez "${sed_expression}" "${files_names_listing}.temp1"\
    > "${files_names_listing}.temp2"
  sed -Ez "${sed_expression}" "${files_names_listing}.temp2"\
    > "${files_names_listing}.temp3"
  sed -Ez "${sed_expression}" "${files_names_listing}.temp3"\
    > "${files_names_listing}.temp4"
  shopt -s dotglob
  get_split_score_simple 1 70 /
  # shellcheck disable=SC2154
  split_score_command="${get_split_score_result}"
  # shellcheck disable=SC2154
  split_score_command_properties="${get_split_score_result2}"
  suffix=\\\\ # instead of '\\' to avoid shellcheck SC1003
  # shellcheck disable=SC2312
  find . -type f -printf '%P\n' | relevant_find | sort\
    | while read -r file_name;
  do
    git check-ignore -q "${file_name}" && continue
    base_file_name=$(basename "${file_name}")
    [[ "${base_file_name}" != files_names_listing.txt* ]]\
      || continue
    if [[ "${base_file_name}" == *.md ]]; then
      if [[ -f "${file_name}.tpl" ]]; then
        continue
      fi
    fi
    repeated_split_last_line "${file_name}" "" 70 "${suffix}"\
      "${split_score_command}" "${split_score_command_properties}"
    # shellcheck disable=SC2154
    split_file_name="${repeated_split_last_line_result}"
    if [[ "$1" == "--write" ]]; then
      # shellcheck disable=SC2001
      echo "${file_name}"\
        | sed -e "s|${file_name}|${split_file_name}|g"\
        >> "${files_names_listing}"
      continue
    fi
    if grep -q "${file_name}\$" "${files_names_listing}.temp4"; then
      :
    else
      echo\
      "The file ${file_name} is not listed in ${files_names_listing}."
      if [[ "$1" == "--append" ]]; then
        # shellcheck disable=SC2001
        echo "${file_name}"\
          | sed -e\
          "s|${file_name}|${split_file_name}|g"\
          >> "${files_names_listing}"
      fi
    fi
  done

  while read -r file_name;
  do
    [[ "${file_name}" != '//'* ]] || continue
    base_file_name=$(basename "${file_name}")
    if ! [[ -f "${file_name}" ]]; then
      echo\
      "The non-file ${file_name} is listed in ${files_names_listing}."
    fi
  done < "${files_names_listing}.temp4"

  rm "${files_names_listing}.temp1" "${files_names_listing}.temp2"\
    "${files_names_listing}.temp3" "${files_names_listing}.temp4"
  shopt -u dotglob
  shopt -s globstar

  if [[ LFBFL_verbose -eq 1 ]]; then
    cat "${files_names_listing}"
  fi
}

update_or_check_files_names_listing "$@"
