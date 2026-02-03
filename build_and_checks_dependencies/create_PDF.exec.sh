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
LFBFL_subdir2="build_and_checks_variables"

LFBFL_data_file_name="build_and_checks_variables/repository_data.txt"
repository_name=""
grep_variable "${LFBFL_data_file_name}" repository_name

abstract=""
grep_variable "${LFBFL_data_file_name}" abstract

acknowledgments=""
grep_variable "${LFBFL_data_file_name}" acknowledgments

author_email=""
grep_variable "${LFBFL_data_file_name}" author_email

author_full_name=""
grep_variable "${LFBFL_data_file_name}" author_full_name

author_website=""
grep_variable "${LFBFL_data_file_name}" author_website

# shellcheck disable=SC2155
declare -r LFBFL_current_date=$(date -I"date")

# shellcheck disable=SC2155
declare -r LFBFL_current_git_SHA1=$(git rev-parse HEAD)

# shellcheck disable=SC2155
declare -r LFBFL_number_of_commits=$(
  git shortlog | space_starting_lines | wc -l
)

LFBFL_number_of_lines="$(code_lines_count_all) total lines,"
LFBFL_number_of_lines+=" $(code_lines_count_not_empty)"
LFBFL_number_of_lines+=" not empty lines,"
LFBFL_number_of_lines+=" $(code_lines_count_empty) empty lines."

# shellcheck disable=SC2094,SC2312
tree -a --gitignore\
  -I "node_modules/"\
  -I "__pycache__/"\
  -I ".mypy_cache/"\
  -I ".git/"\
  | replace_non_ascii_spaces\
  > "${LFBFL_subdir2}/temp/current_tree_light.txt"

# shellcheck disable=SC2094,SC2312
tree -a -DFh --gitignore\
  -I "node_modules/"\
  -I "__pycache__/"\
  -I ".mypy_cache/"\
  -I ".git/"\
  | replace_non_ascii_spaces\
  > "${LFBFL_subdir2}/temp/current_tree.txt.temp"

overwrite_if_not_equal "${LFBFL_subdir2}/temp/current_tree.txt"\
  "${LFBFL_subdir2}/temp/current_tree.txt.temp" 1 1

LFBFL_temp_files_listing="./${LFBFL_subdir2}/temp/"
LFBFL_temp_files_listing+="files_listing.tex.tpl.temp"
: > "${LFBFL_temp_files_listing}"
LFBFL_temp_files_listing2="./${LFBFL_subdir2}/temp/"
LFBFL_temp_files_listing2+="files_listing.html.tpl.temp"
: > "${LFBFL_temp_files_listing2}"
LFBFL_temp_files_lis="./${LFBFL_subdir2}/temp/files_lis.html.tpl"
: > "${LFBFL_temp_files_lis}"
get_split_score_simple 1 70 /
# shellcheck disable=SC2154
declare LFBFL_score_command="${get_split_score_result}"
# shellcheck disable=SC2154
declare LFBFL_score_command_properties="${get_split_score_result2}"
get_split_score_simple 1 70 ':'
# shellcheck disable=SC2154
declare LFBFL_score_command2="${get_split_score_result}"
declare LFBFL_score_command_properties2="${get_split_score_result2}"
declare LFBFL_suffix='%'
declare LFBFL_sed_expression='s/\\\n//Mg'
declare -i LFBFL_i=0
declare LFBFL_suffix2='<!--'
declare LFBFL_prefix2='-->'
# shellcheck disable=SC2312
sed -Ez "${LFBFL_sed_expression}"\
  "./${LFBFL_subdir2}/files_names_listing.txt"\
  | sed -Ez "${LFBFL_sed_expression}"\
  | sed -Ez "${LFBFL_sed_expression}"\
  | sed -Ez "${LFBFL_sed_expression}"\
  | grep -v '^//'\
  | while read -r LFBFL_file_name;
do
  echo "Listing file for tex/HTML : ${LFBFL_file_name}"
  # echo "Listing file for tex : ${LFBFL_file_name}"
  # LFBFL_base_file_name=$(basename "${LFBFL_file_name}")
  LFBFL_cleaned_path1="${LFBFL_file_name//_/\\_}"
  LFBFL_cleaned_path2=$(
    sed -e 's/\//:/g' -e 's/\.//g' <(echo "${LFBFL_file_name}")
  )
  echo "\subsection{" >> "${LFBFL_temp_files_listing}"
  LFBFL_new_lines="  ${LFBFL_cleaned_path1}"
  if [[ ${#LFBFL_new_lines} -gt 70 ]]; then
    repeated_split_last_line "${LFBFL_new_lines}" "" 70\
      "${LFBFL_suffix}" "${LFBFL_score_command}"\
      "${LFBFL_score_command_properties}" "\\"
    # shellcheck disable=SC2154
    LFBFL_new_lines=${repeated_split_last_line_result}
  fi
  # shellcheck disable=SC2129,SC2312
  echo "  ${LFBFL_file_name}"\
    | sed -e "s|  ${LFBFL_file_name}|${LFBFL_new_lines}|g"\
          -e 's/_/\\_/g'\
    >> "${LFBFL_temp_files_listing}"
  echo "}" >> "${LFBFL_temp_files_listing}"
  echo "\label{" >> "${LFBFL_temp_files_listing}"
  LFBFL_new_lines="  ${LFBFL_cleaned_path2}"
  if [[ ${#LFBFL_new_lines} -gt 70 ]]; then
    repeated_split_last_line "${LFBFL_new_lines}" "" 70\
      "${LFBFL_suffix}" "${LFBFL_score_command2}"\
      "${LFBFL_score_command_properties2}"
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
      "${LFBFL_suffix}" "${LFBFL_score_command}"\
      "${LFBFL_score_command_properties}"
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

  # echo "Listing file for HTML : ${LFBFL_file_name}"
  ((++LFBFL_i))
  echo "<h3 id=\"subsection2.${LFBFL_i}\">2.${LFBFL_i}"\
    >> "${LFBFL_temp_files_listing2}"
  LFBFL_new_lines="${LFBFL_file_name}"
  if [[ ${#LFBFL_file_name} -gt 70 ]]; then
    repeated_split_last_line "${LFBFL_new_lines}" "${LFBFL_prefix2}"\
      70 "${LFBFL_suffix2}" "${LFBFL_score_command}"\
      "${LFBFL_score_command_properties}"
    # shellcheck disable=SC2154
    LFBFL_new_lines=${repeated_split_last_line_result}
  fi
  # shellcheck disable=SC2001,SC2129,SC2312
  echo "${LFBFL_file_name}"\
    | sed -e "s|${LFBFL_file_name}|${LFBFL_new_lines}|g"\
    >> "${LFBFL_temp_files_listing2}"
  echo "</h3>" >> "${LFBFL_temp_files_listing2}"
  echo "<pre class=\"numbered_lines\">"\
    >> "${LFBFL_temp_files_listing2}"
  sed -e 's/&/\&amp;/g' -e 's/</\&lt;/g' < "${LFBFL_file_name}"\
    >> "${LFBFL_temp_files_listing2}"
  echo "</pre>" >> "${LFBFL_temp_files_listing2}"
  echo "" >> "${LFBFL_temp_files_listing2}"
  echo "" >> "${LFBFL_temp_files_listing2}"

  # shellcheck disable=SC2129
  echo "      <li><a href=\"#subsection2.${LFBFL_i}\">"\
    >> "${LFBFL_temp_files_lis}"
  # shellcheck disable=SC2001
  echo "${LFBFL_file_name}"\
    | sed -e "s|${LFBFL_file_name}|${LFBFL_new_lines}|g"\
    >> "${LFBFL_temp_files_lis}"
  echo "      </a></li>" >> "${LFBFL_temp_files_lis}"
done
overwrite_if_not_equal "./${LFBFL_subdir2}/files_listing.tex.tpl"\
  "${LFBFL_temp_files_listing}"
sed -i -e "s|\\n</pre>|</pre>|g" "${LFBFL_temp_files_listing2}"
overwrite_if_not_equal\
  "./${LFBFL_subdir2}/temp/files_listing.html.tpl"\
  "${LFBFL_temp_files_listing2}"

# We verify if some lines are beyond 70 characters
# in current_tree_light.txt and current_tree.txt.
LFBFL_trees=("current_tree_light.txt" "current_tree.txt")
declare LFBFL_tree_path
for LFBFL_tree in "${LFBFL_trees[@]}"; do
  LFBFL_tree_path="${LFBFL_subdir2}/temp/${LFBFL_tree}"
  # shellcheck disable=SC2312
  grep '.\{71\}' "${LFBFL_tree_path}" | while read -r LFBFL_line; do
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
      repeated_split_last_line "${LFBFL_new_lines}" "${LFBFL_prefix}"\
        70 "" "" 3
      # shellcheck disable=SC2154
      LFBFL_new_lines=${repeated_split_last_line_result}
    fi
    sed -i -e\
      "s/${LFBFL_line}/${LFBFL_line_start}\n${LFBFL_new_lines}/g"\
      "${LFBFL_tree_path}"
  done
done

if [[ -f "./${LFBFL_subdir2}/${repository_name}.tex.tpl" ]]; then
  # If there is a template, we init the process from it.
  cp "./${LFBFL_subdir2}/${repository_name}.tex.tpl"\
     "./${LFBFL_subdir2}/temp/${repository_name}.tex.1"
elif [[ -f "./${LFBFL_subdir2}/${repository_name}.tex" ]]; then
  # Otherwise if there is a tex file, we init the process from it.
  cp "./${LFBFL_subdir2}/${repository_name}.tex"\
     "./${LFBFL_subdir2}/temp/${repository_name}.tex.1"
else
  echo "Neither .tex.tpl, nor .tex in ./${LFBFL_subdir2}/"
fi

# Same logic with repository HTML file.
if [[ -f "./${LFBFL_subdir2}/${repository_name}.html.tpl" ]]; then
  cp "./${LFBFL_subdir2}/${repository_name}.html.tpl"\
     "./${LFBFL_subdir2}/temp/${repository_name}.html.1"
elif [[ -f "./${repository_name}.html" ]]; then
  cp "./${repository_name}.html"\
     "./${LFBFL_subdir2}/temp/${repository_name}.html.1"
else
  echo "Neither .html.tpl in ./${LFBFL_subdir2}/, nor .html in ./"
fi

declare -r LFBFL_tex_path_start=\
"./${LFBFL_subdir2}/temp/${repository_name}.tex"
declare -r LFBFL_html_path_start=\
"./${LFBFL_subdir2}/temp/${repository_name}.html"

# shellcheck disable=SC2001,SC2312
echo "${abstract}" | sed -e 's/\\n/\n/g'\
  > "./${LFBFL_subdir2}/temp/abstract_temp"

# shellcheck disable=SC2001,SC2312
echo "${acknowledgments}" | sed -e 's/\\n/\n/g'\
  > "./${LFBFL_subdir2}/temp/acknowledgments_temp"

# But the filling still occurs, in case the dev want to refill
# part of the tex/html file that he modified with @token@
# using some computed results.
# Tex filling:
if [[ -f "${LFBFL_tex_path_start}.1" ]]; then
  sed -i "s|@repository_name@|${repository_name}|g"\
    "${LFBFL_tex_path_start}.1"

  insert_file_at_token "${LFBFL_tex_path_start}.1" @abstract@\
    "./${LFBFL_subdir2}/temp/abstract_temp"\
    "${LFBFL_tex_path_start}.2"

  insert_file_at_token "${LFBFL_tex_path_start}.2" @acknowledgments@\
    "./${LFBFL_subdir2}/temp/acknowledgments_temp"\
    "${LFBFL_tex_path_start}.3"

  sed -i "s|@author_email@|${author_email}|g"\
    "${LFBFL_tex_path_start}.3"

  sed -i "s|@author_full_name@|${author_full_name}|g"\
    "${LFBFL_tex_path_start}.3"

  sed -i "s|@author_website@|${author_website}|g"\
    "${LFBFL_tex_path_start}.3"

  sed -i "s|@current_date@|${LFBFL_current_date}|g"\
    "${LFBFL_tex_path_start}.3"

  sed -i "s|@current_git_SHA1@|${LFBFL_current_git_SHA1}|g"\
    "${LFBFL_tex_path_start}.3"

  sed -i "s|@number_of_commits@|${LFBFL_number_of_commits}|g"\
    "${LFBFL_tex_path_start}.3"

  sed -i "s|@number_of_lines@|${LFBFL_number_of_lines}|g"\
    "${LFBFL_tex_path_start}.3"

  pushd "./${LFBFL_subdir2}/temp/" || (echo "pushd failed" && exit)
  sed -i -e '/@current_tree_light@/{r current_tree_light.txt' -e 'd}'\
    "${repository_name}.tex.3"
  sed -i -e '/@current_tree@/{r current_tree.txt' -e 'd}'\
    "${repository_name}.tex.3"
  popd || (echo "popd failed" && exit)

  insert_file_at_token "${LFBFL_tex_path_start}.3"\
    @files_listing_VerbatimInput@\
    "./${LFBFL_subdir2}/files_listing.tex.tpl"\
    "${LFBFL_tex_path_start}.4"

  overwrite_if_not_equal "./${LFBFL_subdir2}/${repository_name}.tex"\
    "${LFBFL_tex_path_start}.4" 1
fi

# HTML filling:
if [[ -f "${LFBFL_html_path_start}.1" ]]; then
  sed -i "s|@repository_name@|${repository_name}|g"\
    "${LFBFL_html_path_start}.1"

  insert_file_at_token "${LFBFL_html_path_start}.1" @abstract@\
    "./${LFBFL_subdir2}/temp/abstract_temp"\
    "${LFBFL_html_path_start}.2"

  insert_file_at_token "${LFBFL_html_path_start}.2" @acknowledgments@\
    "./${LFBFL_subdir2}/temp/acknowledgments_temp"\
    "${LFBFL_html_path_start}.3"

  sed -i "s|@author_email@|${author_email}|g"\
    "${LFBFL_html_path_start}.3"

  sed -i "s|@author_full_name@|${author_full_name}|g"\
    "${LFBFL_html_path_start}.3"

  sed -i "s|@author_website@|${author_website}|g"\
    "${LFBFL_html_path_start}.3"

  sed -i "s|@current_date@|${LFBFL_current_date}|g"\
    "${LFBFL_html_path_start}.3"

  sed -i "s|@current_git_SHA1@|${LFBFL_current_git_SHA1}|g"\
    "${LFBFL_html_path_start}.3"

  sed -i "s|@number_of_commits@|${LFBFL_number_of_commits}|g"\
    "${LFBFL_html_path_start}.3"

  sed -i "s|@number_of_lines@|${LFBFL_number_of_lines}|g"\
    "${LFBFL_html_path_start}.3"

  insert_file_at_token "${LFBFL_html_path_start}.3"\
    @files_lis@ "${LFBFL_temp_files_lis}"

  pushd "./${LFBFL_subdir2}/temp/" || (echo "pushd failed" && exit)
  sed -i -e '/@current_tree_light@/{r current_tree_light.txt' -e 'd}'\
    "${repository_name}.html.3"
  sed -i -e '/@current_tree@/{r current_tree.txt' -e 'd}'\
    "${repository_name}.html.3"
  popd || (echo "popd failed" && exit)

  insert_file_at_token "${LFBFL_html_path_start}.3"\
    @files_listing_HTMLPreInput@\
    "./${LFBFL_subdir2}/temp/files_listing.html.tpl"\
    "${LFBFL_html_path_start}.4"

  overwrite_if_not_equal "./${repository_name}.html"\
    "${LFBFL_html_path_start}.4" 1
fi

if [[ -n "${LFBFL_verbose}" ]]; then
  for ((i=0; i<3; i++)); do
    pdflatex "./${LFBFL_subdir2}/${repository_name}.tex"
  done
else
  for ((i=0; i<3; i++)); do
    pdflatex "./${LFBFL_subdir2}/${repository_name}.tex" > /dev/null
  done
fi

LFBFL_files_to_temp=(\
  "${repository_name}.aux"\
  "${repository_name}.log"\
  "${repository_name}.out"\
  "${repository_name}.toc"
)
for LFBFL_file_name in "${LFBFL_files_to_temp[@]}"; do
  mv "${LFBFL_file_name}" "${LFBFL_subdir2}/temp/"
done
