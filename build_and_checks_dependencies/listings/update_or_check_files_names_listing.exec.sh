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
# This file was renamed from "update_or_check_files_names_listing.sh"
# to "update_or_check_files_names_listing.exec.sh".
# This file was renamed from "update_or_check_file_names_listing.sh"
# to "update_or_check_files_names_listing.sh"?

LFBFL_verbose=""
if [[ "$2" == "--verbose" ]]; then
  echo "$0 $*"
  LFBFL_verbose="--verbose"
fi
readonly LFBFL_verbose

LFBFL_subdir="build_and_checks_dependencies"
# shellcheck disable=SC1090
source "./${LFBFL_subdir}/lines_filters.libr.sh"
# shellcheck disable=SC1090
source "./${LFBFL_subdir}/strings_functions.libr.sh"
LFBFL_subdir2="${LFBFL_subdir}/listings"
files_names_listing="./${LFBFL_subdir2}/files_names_listing.txt"

# Cette fonction est trop sioux pour shellcheck avec sa variable de
# sortie avec un nom dynamique. Du coup, je feinte pour la suite.
repository_name=""
grep_variable repository_data.txt repository_name

if [[ "$1" == "--write" ]]; then
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
get_split_score_after_before 70 /
# shellcheck disable=SC2154
split_score_command="${get_split_score_after_before_result}"
# shellcheck disable=SC1003
suffix='\\'
# shellcheck disable=SC2312
find . -type f -printf '%P\n' | relevant_find | sort\
  | while read -r file_name;
do
  git check-ignore -q "${file_name}" && continue
  base_file_name=$(basename "${file_name}")
  [[ "${base_file_name}" != "current_tree_light.txt" ]] || continue
  [[ "${base_file_name}" != "current_tree.txt" ]] || continue
  [[ "${base_file_name}" != "COPYING" ]] || continue
  [[ "${base_file_name}" != "COPYING.LESSER" ]] || continue
  [[ "${base_file_name}" != "${repository_name}.pdf" ]] || continue
  [[ "${base_file_name}" != "${repository_name}.tex" ]] || continue
  [[ "${base_file_name}" != "files_names_listing.txt.temp1" ]]\
    || continue
  [[ "${base_file_name}" != "files_names_listing.txt.temp2" ]]\
    || continue
  [[ "${base_file_name}" != "files_names_listing.txt.temp3" ]]\
    || continue
  [[ "${base_file_name}" != "files_names_listing.txt.temp4" ]]\
    || continue
  if [[ "${base_file_name}" == *.md ]]; then
    if [[ -f "${file_name}.tpl" ]]; then
      # in_place_grep -v "${base_file_name}\$" current_tree.txt
      # in_place_grep -v "${base_file_name}\$" current_tree_light.txt
      continue
    fi
  fi
  repeated_split_last_line "${file_name}" "" 70 "${suffix}"\
    "${split_score_command}" 3
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
    echo ""
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
rm "${files_names_listing}.temp1" "${files_names_listing}.temp2"\
  "${files_names_listing}.temp3" "${files_names_listing}.temp4"
shopt -u dotglob
shopt -s globstar

if [[ -n "${LFBFL_verbose}" ]]; then
  cat "${files_names_listing}"
fi
