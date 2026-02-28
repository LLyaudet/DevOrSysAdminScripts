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

LFBFL_subdir="build_and_checks_dependencies"
# shellcheck source=generate_from_template.libr.sh
source "./${LFBFL_subdir}/generate_from_template.libr.sh"
# shellcheck source=lines_counts.libr.sh
source "./${LFBFL_subdir}/lines_counts.libr.sh"
# shellcheck source=lines_filters.libr.sh
source "./${LFBFL_subdir}/lines_filters.libr.sh"
# shellcheck source=lines_maps.libr.sh
source "./${LFBFL_subdir}/lines_maps.libr.sh"
# shellcheck source=overwrite_if_not_equal.libr.sh
source "./${LFBFL_subdir}/overwrite_if_not_equal.libr.sh"
# shellcheck source=strings_functions.libr.sh
source "./${LFBFL_subdir}/strings_functions.libr.sh"

create_PDF(){
  declare -i LFBFL_verbose=0
  if [[ "$*" == *--verbose* ]]; then
    echo "$0 $*"
    LFBFL_verbose=1
  fi
  readonly LFBFL_verbose

  if [[ ! -o pipefail ]]; then
    [[ LFBFL_verbose -eq 1 ]] && echo "pipefail option activated"
    set -o pipefail
    trap 'set +o pipefail' RETURN
  fi

  local LFBFL_subdir2="build_and_checks_variables"
  local LFBFL_data_file_name="${LFBFL_subdir2}/repository_data.txt"
  local LFBFL_repository_name=""
  grep_variable "${LFBFL_data_file_name}" repository_name\
    --result-variable-prefix="LFBFL_"\
    --replace-line-returns-by=""

  local LFBFL_repository_web_url=""
  grep_variable "${LFBFL_data_file_name}" repository_web_url\
    --result-variable-prefix="LFBFL_"\
    --replace-line-returns-by=""

  local LFBFL_repository_git_url=""
  grep_variable "${LFBFL_data_file_name}" repository_git_url\
    --result-variable-prefix="LFBFL_"\
    --replace-line-returns-by=""

  local LFBFL_abstract=""
  grep_variable "${LFBFL_data_file_name}" abstract\
    --result-variable-prefix="LFBFL_"

  local LFBFL_acknowledgments=""
  grep_variable "${LFBFL_data_file_name}" acknowledgments\
    --result-variable-prefix="LFBFL_"

  local LFBFL_author_email=""
  grep_variable "${LFBFL_data_file_name}" author_email\
    --result-variable-prefix="LFBFL_"\
    --replace-line-returns-by=""

  local LFBFL_author_full_name=""
  grep_variable "${LFBFL_data_file_name}" author_full_name\
    --result-variable-prefix="LFBFL_"\
    --replace-line-returns-by=" "

  local LFBFL_author_website=""
  grep_variable "${LFBFL_data_file_name}" author_website\
    --result-variable-prefix="LFBFL_"\
    --replace-line-returns-by=""

  declare -i LFBFL_max_line_length
  grep_variable "${LFBFL_data_file_name}" max_line_length\
    --result-variable-prefix="LFBFL_"

  declare -r LFBFL_current_date=$(date -I"date")

  declare -r LFBFL_current_git_SHA1=$(git rev-parse HEAD)

  declare -ir LFBFL_number_of_commits=$(
    git shortlog\
    | space_starting_lines\
    | wc -l
  )

  declare -ir LFBFL_all_code_lines_count=$(code_lines_count_all "$@")
  declare -ir LFBFL_not_empty_code_lines_count=$(
    code_lines_count_not_empty "$@"
  )
  declare -ir LFBFL_empty_code_lines_count=$(
    code_lines_count_empty "$@"
  )

  local LFBFL_number_of_lines="${LFBFL_all_code_lines_count}"
  LFBFL_number_of_lines+=" total lines,"
  LFBFL_number_of_lines+=" ${LFBFL_not_empty_code_lines_count}"
  LFBFL_number_of_lines+=" not empty lines,"
  LFBFL_number_of_lines+=" ${LFBFL_empty_code_lines_count}"
  LFBFL_number_of_lines+=" empty lines."
  readonly LFBFL_number_of_lines

  # see https://gitlab.com/OldManProgrammer/unix-tree/-/issues
  # ?show=eyJpaWQiOiI0MyIsImZ1bGxfcGF0aCI6Ik9sZE1hblByb2dyYW1t
  # ZXIvdW5peC10cmVlIiwiaWQiOjE4NTE0NTgzOH0%3D
  tree -a --gitignore\
    -I "node_modules/"\
    -I "__pycache__/"\
    -I ".mypy_cache/"\
    -I ".ruff_cache/"\
    -I ".git/"\
    | replace_non_ascii_spaces\
    > "${LFBFL_subdir2}/temp/current_tree_light.txt"

  tree -a -DFh --gitignore\
    -I "node_modules/"\
    -I "__pycache__/"\
    -I ".mypy_cache/"\
    -I ".ruff_cache/"\
    -I ".git/"\
    | replace_non_ascii_spaces\
    > "${LFBFL_subdir2}/temp/current_tree.txt.temp"

  local LFBFL_temp_files_listing="./${LFBFL_subdir2}/temp/"
  LFBFL_temp_files_listing+="files_listing.tex.tpl.temp"
  readonly LFBFL_temp_files_listing
  : > "${LFBFL_temp_files_listing}"
  local LFBFL_temp_files_listing2="./${LFBFL_subdir2}/temp/"
  LFBFL_temp_files_listing2+="files_listing.html.tpl.temp"
  readonly LFBFL_temp_files_listing2
  : > "${LFBFL_temp_files_listing2}"
  # HTML <li> elements, hence "lis".
  local LFBFL_temp_files_lis
  LFBFL_temp_files_lis="./${LFBFL_subdir2}/temp/files_lis.html.tpl"
  readonly LFBFL_temp_files_lis
  : > "${LFBFL_temp_files_lis}"
  # shellcheck disable=SC2248
  get_split_score_simple 1 ${LFBFL_max_line_length} /
  declare -r LFBFL_score_command="${get_split_score_result}"
  local LFBFL_score_command_properties="${get_split_score_result2}"
  readonly LFBFL_score_command_properties
  # shellcheck disable=SC2248
  get_split_score_simple 1 ${LFBFL_max_line_length} ':'
  declare -r LFBFL_score_command2="${get_split_score_result}"
  local LFBFL_score_command_properties2="${get_split_score_result2}"
  readonly LFBFL_score_command_properties2
  declare -r LFBFL_suffix='%'
  declare -i LFBFL_i=0
  local LFBFL_cleaned_path1
  local LFBFL_cleaned_path2
  local LFBFL_new_lines
  local LFBFL_new_lines2
  local LFBFL_new_lines3
  local LFBFL_file_name
  # Remove line returns here to keep lines short.
  sed -Ez 's/\\\n//Mg' "./${LFBFL_subdir2}/files_names_listing.txt"\
    | grep -v '^//'\
    | while read -r LFBFL_file_name;
  do
    echo "Listing file for tex/HTML : ${LFBFL_file_name}"
    # echo "Listing file for tex : ${LFBFL_file_name}"
    # LFBFL_base_file_name=$(basename "${LFBFL_file_name}")
    LFBFL_cleaned_path1="${LFBFL_file_name//_/\\_}"
    LFBFL_cleaned_path2=$(
      echo "${LFBFL_file_name}"\
      | sed -e 's/\//:/g' -e 's/\.//g'
    )
    LFBFL_new_lines="  ${LFBFL_cleaned_path1}"
    if [[ ${#LFBFL_new_lines} -gt LFBFL_max_line_length ]]; then
      # shellcheck disable=SC2248
      repeated_split_last_line "${LFBFL_new_lines}"\
        ""\
        ${LFBFL_max_line_length}\
        "${LFBFL_suffix}"\
        "${LFBFL_score_command}"\
        "${LFBFL_score_command_properties}"\
        "\\"
      LFBFL_new_lines=${repeated_split_last_line_result}
    fi
    LFBFL_new_lines2="  ${LFBFL_cleaned_path2}"
    if [[ ${#LFBFL_new_lines2} -gt LFBFL_max_line_length ]]; then
      # shellcheck disable=SC2248
      repeated_split_last_line "${LFBFL_new_lines2}"\
        ""\
        ${LFBFL_max_line_length}\
        "${LFBFL_suffix}"\
        "${LFBFL_score_command2}"\
        "${LFBFL_score_command_properties2}"
      LFBFL_new_lines2=${repeated_split_last_line_result}
    fi
    LFBFL_new_lines3="${LFBFL_file_name}"
    if [[ ${#LFBFL_new_lines3} -gt LFBFL_max_line_length ]]; then
      # shellcheck disable=SC2248
      repeated_split_last_line "${LFBFL_new_lines3}"\
        ""\
        ${LFBFL_max_line_length}\
        "${LFBFL_suffix}"\
        "${LFBFL_score_command}"\
        "${LFBFL_score_command_properties}"
      LFBFL_new_lines3=${repeated_split_last_line_result}
    fi
    {
      echo "\subsection{"
      echo "  ${LFBFL_file_name}"\
        | sed -e "s|  ${LFBFL_file_name}|${LFBFL_new_lines}|g"\
              -e 's/_/\\_/g'
      echo "}"
      echo "\label{"
      echo "  ${LFBFL_cleaned_path2}"\
        | sed -e "s|  ${LFBFL_cleaned_path2}|${LFBFL_new_lines2}|g"
      echo "}"
      echo ""
      echo "\VerbatimInput[numbers=left,xleftmargin=-5mm]{"
      echo "  ${LFBFL_file_name}"\
        | sed -e "s|  ${LFBFL_file_name}|${LFBFL_new_lines3}|g"
      echo "}"
      echo ""
      echo ""
    } >> "${LFBFL_temp_files_listing}"

    # echo "Listing file for HTML : ${LFBFL_file_name}"
    ((++LFBFL_i))
    LFBFL_new_lines="${LFBFL_file_name}"
    if [[ ${#LFBFL_file_name} -gt LFBFL_max_line_length ]]; then
      # shellcheck disable=SC2248
      repeated_split_last_line "${LFBFL_new_lines}"\
        "-->"\
        ${LFBFL_max_line_length}\
        "<!--"\
        "${LFBFL_score_command}"\
        "${LFBFL_score_command_properties}"
      LFBFL_new_lines=${repeated_split_last_line_result}
    fi
    {
      echo "<h3 id=\"subsection2.${LFBFL_i}\">2.${LFBFL_i}"
      # shellcheck disable=SC2001
      echo "${LFBFL_file_name}"\
        | sed -e "s|${LFBFL_file_name}|${LFBFL_new_lines}|g"
      echo "</h3>"
      echo "<pre class=\"numbered_lines\">"
      sed -e 's/&/\&amp;/g' -e 's/</\&lt;/g'\
        < "${LFBFL_file_name}"
      echo "</pre>"
      echo ""
      echo ""
    } >> "${LFBFL_temp_files_listing2}"
    {
      echo "      <li><a href=\"#subsection2.${LFBFL_i}\">"
      # shellcheck disable=SC2001
      echo "${LFBFL_file_name}"\
        | sed -e "s|${LFBFL_file_name}|${LFBFL_new_lines}|g"
      echo "      </a></li>"
    } >> "${LFBFL_temp_files_lis}"
  done
  overwrite_if_not_equal "./${LFBFL_subdir2}/files_listing.tex.tpl"\
    "${LFBFL_temp_files_listing}"
  sed -i -e "s|\\n</pre>|</pre>|g" "${LFBFL_temp_files_listing2}"
  overwrite_if_not_equal\
    "./${LFBFL_subdir2}/temp/files_listing.html.tpl"\
    "${LFBFL_temp_files_listing2}"

  # We verify if some lines are beyond max_line_length characters
  # in current_tree_light.txt and current_tree.txt.
  declare -ar LFBFL_trees=(
    "current_tree_light.txt"
    "current_tree.txt.temp"
  )
  local LFBFL_tree_path
  local LFBFL_line
  local LFBFL_prefix
  declare -i LFBFL_prefix_last_position
  local LFBFL_char
  local LFBFL_line_start
  declare -ir LFBFL_overlength=$((LFBFL_max_line_length+1))
  local LFBFL_file_name2
  for LFBFL_tree in "${LFBFL_trees[@]}"; do
    LFBFL_tree_path="${LFBFL_subdir2}/temp/${LFBFL_tree}"
    # shellcheck disable=SC2248
    grep '.\{'${LFBFL_overlength}'\}' "${LFBFL_tree_path}"\
      | while read -r LFBFL_line;
    do
      # echo "LFBFL_line: ${LFBFL_line}"
      LFBFL_prefix=$(
        echo "${LFBFL_line}"\
        | sed -E -e 's/(.*)──[^─]+$/\1/g'
      )
      # echo "LFBFL_prefix: ${LFBFL_prefix}"
      LFBFL_prefix_last_position=$((${#LFBFL_prefix}-1))
      LFBFL_char="${LFBFL_prefix:${LFBFL_prefix_last_position}:1}"
      # echo "LFBFL_char: ${LFBFL_char}"
      LFBFL_prefix=$(
        echo "${LFBFL_prefix}"\
        | sed -E -e 's/[^ ]+$//g'
      )
      if [[ "${LFBFL_char}" == "└" ]]; then
        LFBFL_prefix+="  "
      else
        LFBFL_prefix+="│ "
      fi
      # echo "LFBFL_prefix: ${LFBFL_prefix}"
      LFBFL_file_name=$(
        echo "${LFBFL_line}"\
        | sed -E 's|.* (([a-zA-Z0-9\._/-]+).)$|\1|g'
      )
      # echo "LFBFL_file_name: ${LFBFL_file_name}"
      LFBFL_file_name2=$(
        echo "${LFBFL_file_name}"\
        | sed -E -e 's/\*/\\\*/g'
      )
      LFBFL_line_start=$(
        echo "${LFBFL_line}"\
        | sed -E -e "s/(.*)[ ]*${LFBFL_file_name2}/\1/g"\
                 -e 's/ *$//g'
      )
      # echo "LFBFL_line_start: ${LFBFL_line_start}"
      LFBFL_line=$(
        echo "${LFBFL_line}"\
        | sed -E -e 's/\[/\\\[/g' -e 's/\]/\\\]/g' -e 's/\*/\\\*/g'
      )
      LFBFL_new_lines="${LFBFL_prefix}${LFBFL_file_name}"
      if [[ ${#LFBFL_new_lines} -gt LFBFL_max_line_length ]]; then
        # shellcheck disable=SC2248
        repeated_split_last_line "${LFBFL_new_lines}"\
          "${LFBFL_prefix}"\
          ${LFBFL_max_line_length}\
          ""\
          ""\
          ""
        LFBFL_new_lines=${repeated_split_last_line_result}
      fi
      sed -i -e\
        "s/${LFBFL_line}/${LFBFL_line_start}\n${LFBFL_new_lines}/g"\
        "${LFBFL_tree_path}"
    done
  done

  overwrite_if_not_equal "${LFBFL_subdir2}/temp/current_tree.txt"\
    "${LFBFL_subdir2}/temp/current_tree.txt.temp" 1 1

  declare -r LFBFL_tex_path_start=\
"./${LFBFL_subdir2}/temp/${LFBFL_repository_name}.tex"
  declare -r LFBFL_html_path_start=\
"./${LFBFL_subdir2}/temp/${LFBFL_repository_name}.html"

  if [[ -f "./${LFBFL_subdir2}/${LFBFL_repository_name}.tex.tpl" ]];
  then
    # If there is a template, we init the process from it.
    cp "./${LFBFL_subdir2}/${LFBFL_repository_name}.tex.tpl"\
      "${LFBFL_tex_path_start}.1"
  elif [[ -f "./${LFBFL_subdir2}/${LFBFL_repository_name}.tex" ]];
  then
    # Otherwise if there is a tex file, we init the process from it.
    cp "./${LFBFL_subdir2}/${LFBFL_repository_name}.tex"\
      "${LFBFL_tex_path_start}.1"
  else
    echo "Neither .tex.tpl, nor .tex in ./${LFBFL_subdir2}/"
  fi

  # Same logic with repository HTML file.
  if [[ -f "./${LFBFL_subdir2}/${LFBFL_repository_name}.html.tpl" ]];
  then
    cp "./${LFBFL_subdir2}/${LFBFL_repository_name}.html.tpl"\
      "${LFBFL_html_path_start}.1"
  elif [[ -f "./${LFBFL_repository_name}.html" ]]; then
    cp "./${LFBFL_repository_name}.html" "${LFBFL_html_path_start}.1"
  else
    echo "Neither .html.tpl in ./${LFBFL_subdir2}/, nor .html in ./"
  fi

  # shellcheck disable=SC2001
  echo "${LFBFL_abstract}"\
    | sed -e 's/\\n/\n/g'\
    > "./${LFBFL_subdir2}/temp/abstract_temp"

  # shellcheck disable=SC2001
  echo "${LFBFL_acknowledgments}"\
    | sed -e 's/\\n/\n/g'\
    > "./${LFBFL_subdir2}/temp/acknowledgments_temp"

  # But the filling still occurs, in case the dev want to refill
  # part of the tex/html file that he modified with @token@
  # using some computed results.
  # Tex filling:
  if [[ -f "${LFBFL_tex_path_start}.1" ]]; then
    sed -i -e "s|@repository_name@|${LFBFL_repository_name}|g"\
           -e "s|@repository_web_url@|${LFBFL_repository_web_url}|g"\
           -e "s|@repository_git_url@|${LFBFL_repository_git_url}|g"\
           -e "s|@author_email@|${LFBFL_author_email}|g"\
           -e "s|@author_full_name@|${LFBFL_author_full_name}|g"\
           -e "s|@author_website@|${LFBFL_author_website}|g"\
           -e "s|@current_date@|${LFBFL_current_date}|g"\
           -e "s|@current_git_SHA1@|${LFBFL_current_git_SHA1}|g"\
           -e "s|@number_of_commits@|${LFBFL_number_of_commits}|g"\
           -e "s|@number_of_lines@|${LFBFL_number_of_lines}|g"\
      "${LFBFL_tex_path_start}.1"

    insert_file_at_token "${LFBFL_tex_path_start}.1" @abstract@\
      "./${LFBFL_subdir2}/temp/abstract_temp"\
      "${LFBFL_tex_path_start}.2"

    insert_file_at_token "${LFBFL_tex_path_start}.2"\
      @acknowledgments@\
      "./${LFBFL_subdir2}/temp/acknowledgments_temp"\
      "${LFBFL_tex_path_start}.3"

    pushd "./${LFBFL_subdir2}/temp/" || (echo "pushd failed" && exit)
    sed -i\
      -e '/@current_tree_light@/{r current_tree_light.txt' -e 'd}'\
      -e '/@current_tree@/{r current_tree.txt' -e 'd}'\
      "${LFBFL_repository_name}.tex.3"
    popd || (echo "popd failed" && exit)

    insert_file_at_token "${LFBFL_tex_path_start}.3"\
      @files_listing_VerbatimInput@\
      "./${LFBFL_subdir2}/files_listing.tex.tpl"\
      "${LFBFL_tex_path_start}.4"

    overwrite_if_not_equal\
      "./${LFBFL_subdir2}/${LFBFL_repository_name}.tex"\
      "${LFBFL_tex_path_start}.4" 1
  fi

  # HTML filling:
  declare -i LFBFL_HTML_updated=0
  if [[ -f "${LFBFL_html_path_start}.1" ]]; then
    sed -i -e "s|@repository_name@|${LFBFL_repository_name}|g"\
           -e "s|@repository_web_url@|${LFBFL_repository_web_url}|g"\
           -e "s|@repository_git_url@|${LFBFL_repository_git_url}|g"\
           -e "s|@author_email@|${LFBFL_author_email}|g"\
           -e "s|@author_full_name@|${LFBFL_author_full_name}|g"\
           -e "s|@author_website@|${LFBFL_author_website}|g"\
           -e "s|@current_date@|${LFBFL_current_date}|g"\
           -e "s|@current_git_SHA1@|${LFBFL_current_git_SHA1}|g"\
           -e "s|@number_of_commits@|${LFBFL_number_of_commits}|g"\
           -e "s|@number_of_lines@|${LFBFL_number_of_lines}|g"\
      "${LFBFL_html_path_start}.1"

    insert_file_at_token "${LFBFL_html_path_start}.1" @abstract@\
      "./${LFBFL_subdir2}/temp/abstract_temp"\
      "${LFBFL_html_path_start}.2"

    insert_file_at_token "${LFBFL_html_path_start}.2"\
      @acknowledgments@\
      "./${LFBFL_subdir2}/temp/acknowledgments_temp"\
      "${LFBFL_html_path_start}.3"

    insert_file_at_token "${LFBFL_html_path_start}.3"\
      @files_lis@ "${LFBFL_temp_files_lis}"\
      "${LFBFL_html_path_start}.4"

    pushd "./${LFBFL_subdir2}/temp/" || (echo "pushd failed" && exit)
    sed -i\
      -e '/@current_tree_light@/{r current_tree_light.txt' -e 'd}'\
      -e '/@current_tree@/{r current_tree.txt' -e 'd}'\
      "${LFBFL_repository_name}.html.4"
    popd || (echo "popd failed" && exit)

    insert_file_at_token "${LFBFL_html_path_start}.4"\
      @files_listing_HTMLPreInput@\
      "./${LFBFL_subdir2}/temp/files_listing.html.tpl"\
      "${LFBFL_html_path_start}.5"

    overwrite_if_not_equal "./${LFBFL_repository_name}.html"\
      "${LFBFL_html_path_start}.5" 1
    LFBFL_HTML_updated=$?
  fi

  # The HTML contains everything including listings with source code.
  # It it doesn't get updated,
  # then it is useless to recompute the PDF.
  if [[ LFBFL_HTML_updated -eq 0 ]]; then
    return
  fi

  if [[ LFBFL_verbose -eq 1 ]]; then
    for ((i=0; i<3; i++)); do
      pdflatex "./${LFBFL_subdir2}/${LFBFL_repository_name}.tex"
    done
  else
    for ((i=0; i<3; i++)); do
      pdflatex "./${LFBFL_subdir2}/${LFBFL_repository_name}.tex"\
        > /dev/null
    done
  fi

  LFBFL_files_to_temp=(\
    "${LFBFL_repository_name}.aux"\
    "${LFBFL_repository_name}.log"\
    "${LFBFL_repository_name}.out"\
    "${LFBFL_repository_name}.toc"
  )
  for LFBFL_file_name in "${LFBFL_files_to_temp[@]}"; do
    mv "${LFBFL_file_name}" "${LFBFL_subdir2}/temp/"
  done
}

create_PDF "$@"
