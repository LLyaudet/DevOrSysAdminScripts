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
# This file was renamed from "create_PDF.sh" to "create_PDF.exec.sh".

LFBFL_verbose=""
if [[ "$1" == "--verbose" ]]; then
  echo "$0 $*"
  LFBFL_verbose="--verbose"
fi

LFBFL_subdir="build_and_checks_dependencies"
# shellcheck disable=SC1090
source "./${LFBFL_subdir}/generate_from_template.libr.sh"
# shellcheck disable=SC1090
source "./${LFBFL_subdir}/lines_counts.libr.sh"
# shellcheck disable=SC1090
source "./${LFBFL_subdir}/lines_filters.libr.sh"
# shellcheck disable=SC1090
source "./${LFBFL_subdir}/lines_maps.libr.sh"
# shellcheck disable=SC1090
source "./${LFBFL_subdir}/overwrite_if_not_equal.libr.sh"
# shellcheck disable=SC1090
source "./${LFBFL_subdir}/strings_functions.libr.sh"
LFBFL_subdir2="${LFBFL_subdir}/listings"

LFBFL_data_file_name="build_and_checks_variables/repository_data.txt"
repository_name=""
grep_variable "${LFBFL_data_file_name}" repository_name

cp "./latex/${repository_name}.tex.tpl"\
   "./latex/${repository_name}.tex"

sed -i "s|@repository_name@|${repository_name}|g"\
  "./latex/${repository_name}.tex"

abstract=""
grep_variable "${LFBFL_data_file_name}" abstract
# shellcheck disable=SC2001,SC2312
echo "${abstract}" | sed -e 's/\\n/\n/g' > "abstract_temp"
insert_file_at_token "./latex/${repository_name}.tex" @abstract@\
  "abstract_temp"
rm "abstract_temp"

acknowledgments=""
grep_variable "${LFBFL_data_file_name}" acknowledgments
# shellcheck disable=SC2001,SC2312
echo "${acknowledgments}" | sed -e 's/\\n/\n/g'\
  > "acknowledgments_temp"
insert_file_at_token "./latex/${repository_name}.tex"\
  @acknowledgments@ "acknowledgments_temp"
rm "acknowledgments_temp"

author_full_name=""
grep_variable "${LFBFL_data_file_name}" author_full_name
sed -i "s|@author_full_name@|${author_full_name}|g"\
  "./latex/${repository_name}.tex"

author_website=""
grep_variable "${LFBFL_data_file_name}" author_website
sed -i "s|@author_website@|${author_website}|g"\
  "./latex/${repository_name}.tex"

author_email=""
grep_variable "${LFBFL_data_file_name}" author_email
sed -i "s|@author_email@|${author_email}|g"\
  "./latex/${repository_name}.tex"

# shellcheck disable=SC2155
declare -r LFBFL_current_date=$(date -I"date")
sed -i "s|@current_date@|${LFBFL_current_date}|g"\
  "./latex/${repository_name}.tex"

# shellcheck disable=SC2155
declare -r LFBFL_current_git_SHA1=$(git rev-parse HEAD)
sed -i "s|@current_git_SHA1@|${LFBFL_current_git_SHA1}|g"\
  "./latex/${repository_name}.tex"

# shellcheck disable=SC2155
declare -r LFBFL_number_of_commits=$(
  git shortlog | space_starting_lines | wc -l
)
sed -i "s|@number_of_commits@|${LFBFL_number_of_commits}|g"\
  "./latex/${repository_name}.tex"

LFBFL_number_of_lines="$(code_lines_count_all) total lines,"
LFBFL_number_of_lines+=" $(code_lines_count_not_empty)"
LFBFL_number_of_lines+=" not empty lines,"
LFBFL_number_of_lines+=" $(code_lines_count_empty) empty lines."
sed -i "s|@number_of_lines@|${LFBFL_number_of_lines}|g"\
  "./latex/${repository_name}.tex"

# shellcheck disable=SC2094,SC2312
tree -a --gitignore\
  -I "${repository_name}.aux"\
  -I "${repository_name}.log"\
  -I "${repository_name}.out"\
  -I current_tree.txt\
  -I current_tree_light.txt\
  -I "node_modules/"\
  -I "__pycache__/"\
  -I ".mypy_cache/"\
  -I ".git/"\
  | replace_non_ascii_spaces\
  > current_tree_light.txt

# shellcheck disable=SC2094,SC2312
tree -a -DFh --gitignore\
  -I "${repository_name}.aux"\
  -I "${repository_name}.log"\
  -I "${repository_name}.out"\
  -I current_tree.txt\
  -I current_tree_light.txt\
  -I "node_modules/"\
  -I "__pycache__/"\
  -I ".mypy_cache/"\
  -I ".git/"\
  | replace_non_ascii_spaces\
  > current_tree.txt

LFBFL_temp_files_listing="./${LFBFL_subdir2}/"
LFBFL_temp_files_listing+="files_listing.tex.tpl.temp"
: > "${LFBFL_temp_files_listing}"
get_split_score_after_before 70 /
# split_score_command="$LFBFL_generic_result"
# shellcheck disable=SC2154
LFBFL_score_command="${get_split_score_after_before_result}"
get_split_score_after_before 70 ':'
# split_score_command2="$LFBFL_generic_result"
# shellcheck disable=SC2154
LFBFL_score_command2="${get_split_score_after_before_result}"
LFBFL_suffix='%'
LFBFL_sed_expression='s/\\\n//Mg'
# shellcheck disable=SC2312
sed -Ez "${LFBFL_sed_expression}"\
  "./${LFBFL_subdir2}/files_names_listing.txt"\
  | sed -Ez "${LFBFL_sed_expression}"\
  | sed -Ez "${LFBFL_sed_expression}"\
  | sed -Ez "${LFBFL_sed_expression}"\
  | grep -v '^// '\
  | while read -r LFBFL_file_name;
do
  # LFBFL_base_file_name=$(basename "${LFBFL_file_name}")
  # cleaned_path1=$(sed -e 's/_/\\_/g' <(echo "${LFBFL_file_name}"))
  LFBFL_cleaned_path2=$(
    sed -e 's/\//:/g' -e 's/\.//g' <(echo "${LFBFL_file_name}")
  )
  echo "\subsection{" >> "${LFBFL_temp_files_listing}"

  LFBFL_new_lines="  ${LFBFL_file_name}"
  if [[ ${#LFBFL_new_lines} -gt 70 ]]; then
    repeated_split_last_line "${LFBFL_new_lines}" "" 70\
      "${LFBFL_suffix}" "${LFBFL_score_command}" 3
    # shellcheck disable=SC2154
    LFBFL_new_lines=${repeated_split_last_line_result}
  fi
  # shellcheck disable=SC2312
  echo "  ${LFBFL_file_name}"\
    | sed -e "s|  ${LFBFL_file_name}|${LFBFL_new_lines}|g"\
    > "${LFBFL_temp_files_listing}.2"
  sed -i -e 's/_/\\_/g' "${LFBFL_temp_files_listing}.2"
  cat "${LFBFL_temp_files_listing}.2" >> "${LFBFL_temp_files_listing}"
  rm "${LFBFL_temp_files_listing}.2"

  echo "}" >> "${LFBFL_temp_files_listing}"
  echo "\label{" >> "${LFBFL_temp_files_listing}"

  LFBFL_new_lines="  ${LFBFL_cleaned_path2}"
  if [[ ${#LFBFL_new_lines} -gt 70 ]]; then
    repeated_split_last_line "${LFBFL_new_lines}" "" 70\
      "${LFBFL_suffix}" "${LFBFL_score_command2}" 3
    # shellcheck disable=SC2154
    LFBFL_new_lines=${repeated_split_last_line_result}
  fi
  # shellcheck disable=SC2129,SC2312
  echo "  ${LFBFL_cleaned_path2}"\
    | sed -e "s|  ${LFBFL_cleaned_path2}|${LFBFL_new_lines}|g"\
    >> "${LFBFL_temp_files_listing}"

  echo "}" >> "${LFBFL_temp_files_listing}"
  echo "" >> "${LFBFL_temp_files_listing}"
  echo "\VerbatimInput[numbers=left,xleftmargin=-5mm]{"\
    >> "${LFBFL_temp_files_listing}"

  LFBFL_new_lines="${LFBFL_file_name}"
  if [[ ${#LFBFL_new_lines} -gt 70 ]]; then
    repeated_split_last_line "${LFBFL_new_lines}" "" 70\
      "${LFBFL_suffix}" "${LFBFL_score_command}" 3
    # shellcheck disable=SC2154
    LFBFL_new_lines=${repeated_split_last_line_result}
  fi
  # shellcheck disable=SC2129,SC2312
  echo "  ${LFBFL_file_name}"\
    | sed -e "s|  ${LFBFL_file_name}|${LFBFL_new_lines}|g"\
    >> "${LFBFL_temp_files_listing}"

  echo "}" >> "${LFBFL_temp_files_listing}"
  echo "" >> "${LFBFL_temp_files_listing}"
  echo "" >> "${LFBFL_temp_files_listing}"
done
overwrite_if_not_equal "./${LFBFL_subdir2}/files_listing.tex.tpl"\
  "${LFBFL_temp_files_listing}"
insert_file_at_token "./latex/${repository_name}.tex"\
  @files_listing_VerbatimInput@\
  "./${LFBFL_subdir2}/files_listing.tex.tpl"

# We verify if some lines are beyond 70 characters
# in current_tree_light.txt et current_tree.txt.
LFBFL_trees=("current_tree_light.txt" "current_tree.txt")
for LFBFL_tree in "${LFBFL_trees[@]}"; do
  # shellcheck disable=SC2312
  grep '.\{71\}' "${LFBFL_tree}" | while read -r LFBFL_line; do
    # echo "LFBFL_line: ${LFBFL_line}"
    # shellcheck disable=SC2312
    LFBFL_prefix=$(\
      echo "${LFBFL_line}"\
        | sed -E -e 's/(.*)─[^─]+$/\1/g' -e 's/[^ ]+$//g'\
    )
    LFBFL_prefix+="│ "
    # echo "LFBFL_prefix: ${LFBFL_prefix}"
    # shellcheck disable=SC2312
    LFBFL_file_name=$(\
      echo "${LFBFL_line}"\
        | sed -E 's|.* (([a-zA-Z0-9\._/-]+).)$|\1|g'\
    )
    # echo "LFBFL_file_name: ${LFBFL_file_name}"
    # shellcheck disable=SC2312
    LFBFL_line_start=$(\
      echo "${LFBFL_line}"\
        | sed -E "s/(.*)[ ]*${LFBFL_file_name}/\1/g"\
        | sed -e 's/ *$//g'
    )
    # echo "LFBFL_line_start: ${LFBFL_line_start}"
    LFBFL_line=$(\
      echo "${LFBFL_line}"\
        | sed -E -e 's/\[/\\\[/g' -e 's/\]/\\\]/g'\
    )
    LFBFL_new_lines="${LFBFL_prefix}${LFBFL_file_name}"
    if [[ ${#LFBFL_new_lines} -gt 70 ]]; then
      repeated_split_last_line "${LFBFL_new_lines}" "${LFBFL_prefix}" 70\
        "" "" 3
      # shellcheck disable=SC2154
      LFBFL_new_lines=${repeated_split_last_line_result}
    fi
    sed -i -e\
      "s/${LFBFL_line}/${LFBFL_line_start}\n${LFBFL_new_lines}/g"\
      "${LFBFL_tree}"
  done
done

sed -i -e '/@current_tree_light@/{r current_tree_light.txt' -e 'd}'\
  "./latex/${repository_name}.tex"
sed -i -e '/@current_tree@/{r current_tree.txt' -e 'd}'\
  "./latex/${repository_name}.tex"

if [[ -n "${LFBFL_verbose}" ]]; then
  for ((i=0; i<3; i++)); do
    pdflatex "./latex/${repository_name}.tex"
  done
else
  for ((i=0; i<3; i++)); do
    pdflatex "./latex/${repository_name}.tex" > /dev/null
  done
fi

LFBFL_files_to_delete=(\
  "${repository_name}.aux"\
  "${repository_name}.log"\
  "${repository_name}.out"\
  "current_tree.txt"
  "current_tree_light.txt"
)
# Comment the following line if you need to debug.
for LFBFL_file_name in "${LFBFL_files_to_delete[@]}"; do
  rm -f "${LFBFL_file_name}"
done
