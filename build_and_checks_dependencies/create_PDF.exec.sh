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
# shellcheck source=common_options.libr.sh
source "./${LFBFL_subdir}/common_options.libr.sh"
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
  # Options:
  #   --verbose
  #   --work-directory=""
  declare -i LFBFL_i_verbose=0
  get_verbose_option "$@"
  local LFBFL_work_directory=""
  get_work_directory_option "$@"
  pushd_to_work_directory\
    && trap 'popd_from_work_directory' RETURN
  can_continue_after_enhanced_pushd || return

  enhanced_set_shell_option pipefail\
    && trap 'enhanced_unset_shell_option pipefail' RETURN

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

  local LFBFL_redirect="/dev/stdout"
  if [[ LFBFL_i_verbose -eq 0 ]]; then
    LFBFL_redirect="/dev/null"
  fi
  {
    code_lines_count_all "$@"
    code_lines_count_not_empty "$@"
    code_lines_count_empty "$@"
  } &> "${LFBFL_redirect}"

  local LFBFL_number_of_lines="${code_lines_count_all_result}"
  LFBFL_number_of_lines+=" total lines,"
  LFBFL_number_of_lines+=" ${code_lines_count_not_empty_result}"
  LFBFL_number_of_lines+=" not empty lines,"
  LFBFL_number_of_lines+=" ${code_lines_count_empty_result}"
  LFBFL_number_of_lines+=" empty lines."
  readonly LFBFL_number_of_lines

  local LFBFL_temp_path
  # LFBFL_temp_path=$(realpath "./${LFBFL_subdir2}/temp") for pushd
  LFBFL_temp_path="./${LFBFL_subdir2}/temp"
  readonly LFBFL_temp_path

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
    > "${LFBFL_temp_path}/current_tree_light.txt"

  tree -a -DFh --gitignore\
    -I "node_modules/"\
    -I "__pycache__/"\
    -I ".mypy_cache/"\
    -I ".ruff_cache/"\
    -I ".git/"\
    | replace_non_ascii_spaces\
    > "${LFBFL_temp_path}/current_tree.txt.temp"

  local LFBFL_s_file_paths
  LFBFL_s_file_paths=$(
    sed -Ez 's/(.)\\\n/\1/Mg' "./${LFBFL_subdir2}/files_names_listing.txt"\
    | grep -v '^//'
  )
  readonly LFBFL_s_file_paths
  declare -a LFBFL_arr_file_paths
  mapfile -t LFBFL_arr_file_paths <<< "${LFBFL_s_file_paths}"
  readonly LFBFL_arr_file_paths

  local LFBFL_temp_files_listing="${LFBFL_temp_path}/"
  LFBFL_temp_files_listing+="files_listing.tex.tpl.temp"
  readonly LFBFL_temp_files_listing
  : > "${LFBFL_temp_files_listing}"
  local LFBFL_temp_files_listing2="${LFBFL_temp_path}/"
  LFBFL_temp_files_listing2+="files_listing.html.tpl.temp"
  readonly LFBFL_temp_files_listing2
  : > "${LFBFL_temp_files_listing2}"
  # HTML <li> elements, hence "lis".
  local LFBFL_temp_files_lis
  LFBFL_temp_files_lis="${LFBFL_temp_path}/files_lis.html.tpl"
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
  local LFBFL_file_path
  local LFBFL_s_format
  # Remove line returns here to keep lines short.
  for LFBFL_file_path in "${LFBFL_arr_file_paths[@]}"; do
    printf "Listing file for tex/HTML : %s\n" "${LFBFL_file_path}"
    # printf "Listing file for tex : %s\n" "${LFBFL_file_path}"
    # LFBFL_base_file_name=$(basename "${LFBFL_file_path}")
    LFBFL_cleaned_path1="${LFBFL_file_path//_/\\_}"
    LFBFL_cleaned_path2=$(
      printf "%s" "${LFBFL_file_path}"\
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
    LFBFL_new_lines3="${LFBFL_file_path}"
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
    LFBFL_s_format="\\subsection{\n%s\n}\n\\label{\n%s\n}\n\n"
    LFBFL_s_format+="\\VerbatimInput[numbers=left,xleftmargin=-5mm]"
    LFBFL_s_format+="{\n%s\n}\n\n\n"
    # shellcheck disable=SC2059
    printf "${LFBFL_s_format}"\
      "${LFBFL_new_lines}"\
      "${LFBFL_new_lines2}"\
      "${LFBFL_new_lines3}"\
      >> "${LFBFL_temp_files_listing}"

    # printf "Listing file for HTML : %s\n" "${LFBFL_file_path}"
    ((++LFBFL_i))
    LFBFL_new_lines="${LFBFL_file_path}"
    if [[ ${#LFBFL_file_path} -gt LFBFL_max_line_length ]]; then
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
      LFBFL_s_format="<h3 id=\"subsection2.%s\">2.%s\n%s\n</h3>\n"
      LFBFL_s_format+="<pre class=\"numbered_lines\">\n"
      # shellcheck disable=SC2059
      printf "${LFBFL_s_format}"\
        "${LFBFL_i}"\
        "${LFBFL_i}"\
        "${LFBFL_new_lines}"
      sed -e 's/&/\&amp;/g' -e 's/</\&lt;/g'\
        < "${LFBFL_file_path}"
      printf "</pre>\n\n\n"
    } >> "${LFBFL_temp_files_listing2}"
    {
      LFBFL_s_format="      <li><a href=\"#subsection2.%s\">\n%s\n"
      LFBFL_s_format+="      </a></li>\n"
      # shellcheck disable=SC2059
      printf "${LFBFL_s_format}"\
        "${LFBFL_i}"\
        "${LFBFL_new_lines}"
    } >> "${LFBFL_temp_files_lis}"
  done
  overwrite_if_not_equal "./${LFBFL_subdir2}/files_listing.tex.tpl"\
    "${LFBFL_temp_files_listing}"
  sed -i -e "s|\\n</pre>|</pre>|g" "${LFBFL_temp_files_listing2}"
  overwrite_if_not_equal\
    "${LFBFL_temp_path}/files_listing.html.tpl"\
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
  local LFBFL_file_name
  local LFBFL_s_lines
  declare -a LFBFL_arr_lines
  declare -i LFBFL_keep_length
  for LFBFL_tree in "${LFBFL_trees[@]}"; do
    LFBFL_tree_path="${LFBFL_temp_path}/${LFBFL_tree}"
    # shellcheck disable=SC2248
    LFBFL_s_lines=$(grep '.\{'${LFBFL_overlength}'\}' "${LFBFL_tree_path}")
    mapfile -t LFBFL_arr_lines <<< "${LFBFL_s_lines}"
    for LFBFL_line in "${LFBFL_arr_lines[@]}"; do
      # printf "LFBFL_line: %s\n" "${LFBFL_line}"
      LFBFL_prefix=$(
        printf "%s" "${LFBFL_line}"\
        | sed -E -e 's/(.*)──[^─]+$/\1/g'
      )
      # printf "LFBFL_prefix: %s\n" "${LFBFL_prefix}"
      LFBFL_prefix_last_position=$((${#LFBFL_prefix}-1))
      LFBFL_char="${LFBFL_prefix:${LFBFL_prefix_last_position}:1}"
      # printf "LFBFL_char: %s\n" "${LFBFL_char}"
      LFBFL_prefix=$(
        printf "%s" "${LFBFL_prefix}"\
        | sed -E -e 's/[^ ]+$//g'
      )
      if [[ "${LFBFL_char}" == "└" ]]; then
        LFBFL_prefix+="  "
      else
        LFBFL_prefix+="│ "
      fi
      # printf "LFBFL_prefix: %s\n" "${LFBFL_prefix}"
      LFBFL_file_name=$(
        printf "%s" "${LFBFL_line}"\
        | sed -E 's|.* (([a-zA-Z0-9\._/-]+).)$|\1|g'
      )
      # printf "LFBFL_file_name: %s\n" "${LFBFL_file_name}"
      LFBFL_keep_length=$((${#LFBFL_line} - ${#LFBFL_file_name}))
      LFBFL_line_start=${LFBFL_line:0:${LFBFL_keep_length}}
      LFBFL_line_start=$(
        printf "%s" "${LFBFL_line_start}"\
        | sed -e 's/ *$//g'
      )
      # printf "LFBFL_line_start: %s\n" "${LFBFL_line_start}"
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
      printf "%s\n%s\n" "${LFBFL_line_start}" "${LFBFL_new_lines}"\
        > "${LFBFL_tree_path}.some_line.temp"
      insert_file_at_token "${LFBFL_tree_path}"\
        "${LFBFL_line}"\
        "${LFBFL_tree_path}.some_line.temp"\
        ""\
        --quiet
    done
    rm -f "${LFBFL_tree_path}.some_line.temp"
  done

  overwrite_if_not_equal "${LFBFL_temp_path}/current_tree.txt"\
    "${LFBFL_temp_path}/current_tree.txt.temp" 1 1

  declare -r LFBFL_tex_path_start=\
"${LFBFL_temp_path}/${LFBFL_repository_name}.tex"
  declare -r LFBFL_html_path_start=\
"${LFBFL_temp_path}/${LFBFL_repository_name}.html"

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
    printf "Neither .tex.tpl, nor .tex in ./%s/\n" "${LFBFL_subdir2}"
  fi

  # Same logic with repository HTML file.
  if [[ -f "./${LFBFL_subdir2}/${LFBFL_repository_name}.html.tpl" ]];
  then
    cp "./${LFBFL_subdir2}/${LFBFL_repository_name}.html.tpl"\
      "${LFBFL_html_path_start}.1"
  elif [[ -f "./${LFBFL_repository_name}.html" ]]; then
    cp "./${LFBFL_repository_name}.html" "${LFBFL_html_path_start}.1"
  else
    printf "Neither .html.tpl in ./%s/, nor .html in ./\n"\
      "${LFBFL_subdir2}"
  fi

  # shellcheck disable=SC2001
  printf "%s\n" "${LFBFL_abstract}"\
    | sed -e 's/\\n/\n/g'\
    > "${LFBFL_temp_path}/abstract_temp"

  # shellcheck disable=SC2001
  printf "%s\n" "${LFBFL_acknowledgments}"\
    | sed -e 's/\\n/\n/g'\
    > "${LFBFL_temp_path}/acknowledgments_temp"

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
      "${LFBFL_temp_path}/abstract_temp"\
      "${LFBFL_tex_path_start}.2"

    insert_file_at_token "${LFBFL_tex_path_start}.2"\
      @acknowledgments@\
      "${LFBFL_temp_path}/acknowledgments_temp"\
      "${LFBFL_tex_path_start}.3"

    insert_file_at_token "${LFBFL_tex_path_start}.3"\
      @current_tree_light@\
      "${LFBFL_temp_path}/current_tree_light.txt"\
      "${LFBFL_tex_path_start}.4"

    insert_file_at_token "${LFBFL_tex_path_start}.4"\
      @current_tree@\
      "${LFBFL_temp_path}/current_tree.txt"\
      "${LFBFL_tex_path_start}.5"

    insert_file_at_token "${LFBFL_tex_path_start}.5"\
      @files_listing_VerbatimInput@\
      "./${LFBFL_subdir2}/files_listing.tex.tpl"\
      "${LFBFL_tex_path_start}.6"

    overwrite_if_not_equal\
      "./${LFBFL_subdir2}/${LFBFL_repository_name}.tex"\
      "${LFBFL_tex_path_start}.6" 1
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
      "${LFBFL_temp_path}/abstract_temp"\
      "${LFBFL_html_path_start}.2"

    insert_file_at_token "${LFBFL_html_path_start}.2"\
      @acknowledgments@\
      "${LFBFL_temp_path}/acknowledgments_temp"\
      "${LFBFL_html_path_start}.3"

    insert_file_at_token "${LFBFL_html_path_start}.3"\
      @files_lis@ "${LFBFL_temp_files_lis}"\
      "${LFBFL_html_path_start}.4"

    insert_file_at_token "${LFBFL_html_path_start}.4"\
      @current_tree_light@\
      "${LFBFL_temp_path}/current_tree_light.txt"\
      "${LFBFL_html_path_start}.5"

    insert_file_at_token "${LFBFL_html_path_start}.5"\
      @current_tree@\
      "${LFBFL_temp_path}/current_tree.txt"\
      "${LFBFL_html_path_start}.6"

    insert_file_at_token "${LFBFL_html_path_start}.6"\
      @files_listing_HTMLPreInput@\
      "${LFBFL_temp_path}/files_listing.html.tpl"\
      "${LFBFL_html_path_start}.7"

    overwrite_if_not_equal "./${LFBFL_repository_name}.html"\
      "${LFBFL_html_path_start}.7" 1
    LFBFL_HTML_updated=$?
  fi

  # The HTML contains everything including listings with source code.
  # If it doesn't get updated,
  # then it is useless to recompute the PDF.
  if [[ LFBFL_HTML_updated -eq 0 ]]; then
    return
  fi

  if [[ LFBFL_i_verbose -eq 1 ]]; then
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
    mv "${LFBFL_file_name}" "${LFBFL_temp_path}/"
  done
}

create_PDF "$@"
