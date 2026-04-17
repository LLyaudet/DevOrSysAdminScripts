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
# This file was renamed from "build_licenses_templates.sh"
# to "build_licenses_templates.exec.sh".

LFBFL_subdir="build_and_checks_dependencies"
# shellcheck source=check_shell_scripts_beginnings.libr.sh
source "./${LFBFL_subdir}/check_shell_scripts_beginnings.libr.sh"
# shellcheck source=common_options.libr.sh
source "./${LFBFL_subdir}/common_options.libr.sh"
# shellcheck source=comparisons.libr.sh
source "./${LFBFL_subdir}/comparisons.libr.sh"
# shellcheck source=generate_from_template.libr.sh
source "./${LFBFL_subdir}/generate_from_template.libr.sh"
# shellcheck source=lines_filters.libr.sh
source "./${LFBFL_subdir}/lines_filters.libr.sh"
# shellcheck source=overwrite_if_not_equal.libr.sh
source "./${LFBFL_subdir}/overwrite_if_not_equal.libr.sh"

build_licenses_templates(){
  # Options:
  #   --verbose
  #   --work-directory=""
  declare -i LFBFL_i_verbose=0
  get_verbose_option "$@"
  local LFBFL_work_directory=""
  get_work_directory_option "$@"
  declare -a LFBFL_return_traps_stack
  init_return_trap

  enhanced_set_shell_option pipefail --trap-unset

  local LFBFL_s_format

  # Source
  local LFBFL_license_source_subdir
  LFBFL_license_source_subdir="./${LFBFL_subdir}/licenses_templates/"
  readonly LFBFL_license_source_subdir
  local LFBFL_source_license_prefix="${LFBFL_license_source_subdir}"
  LFBFL_source_license_prefix+="license_file_header_"
  readonly LFBFL_source_license_prefix
  # Target
  local LFBFL_license_target_subdir
  LFBFL_license_target_subdir="${LFBFL_work_directory}/"
  LFBFL_license_target_subdir="build_and_checks_variables/temp/"
  readonly LFBFL_license_target_subdir
  local LFBFL_target_license_prefix="${LFBFL_license_target_subdir}"
  LFBFL_target_license_prefix+="license_file_header_"
  readonly LFBFL_target_license_prefix

  declare -ar LFBFL_licenses=(
    "AGPLv3+"
    "GPLv3+"
    "LGPLv3+"
  )

  # ------------------------------------------------------------------
  # Various language definitions for text file formats
  declare -ar LFBFL_block_comment_languages=(
    "c"
    "py"
  )
  declare -ar LFBFL_block_comment_enters=(
    '/*'
    '"""'
  )
  declare -ar LFBFL_block_comment_exits=(
    '*/'
    '"""'
  )
  equal "${#LFBFL_block_comment_languages[@]}"\
        "${#LFBFL_block_comment_enters[@]}"\
        "${#LFBFL_block_comment_exits[@]}"
  declare -i LFBFL_i_equal_result=$?
  if [[ LFBFL_i_equal_result -eq 0 ]]; then
    printf $'/!\\Problem with the definitions of languages arrays 1/!\\\n'
    return 1
  fi

  declare -ar LFBFL_line_comment_languages=(
    "sh"
    "sql"
    "tex"
  )
  declare -ar LFBFL_line_comment_prefixes=(
    '# '
    '-- '
    '% '
  )
  equal "${#LFBFL_line_comment_languages[@]}"\
        "${#LFBFL_line_comment_prefixes[@]}"
  LFBFL_i_equal_result=$?
  if [[ LFBFL_i_equal_result -eq 0 ]]; then
    printf $'/!\\Problem with the definitions of languages arrays 2/!\\\n'
    return 1
  fi
  # ------------------------------------------------------------------

  # ------------------------------------------------------------------
  # We generate the license header templates adapted to various text
  # files formats.
  # Kamoulox do endfor, Jacques Beauregard XD
  # (C'est toujours mieux que l'inverse :) !)
  # for do endfor -> for do done (Fort Doux Donne).
  local LFBFL_some_license
  local LFBFL_license_prefix
  local LFBFL_license_prefix2
  local LFBFL_extension
  local LFBFL_license_file_path
  local LFBFL_enter_string
  local LFBFL_exit_string
  local LFBFL_temp2
  local LFBFL_prefix_string
  local LFBFL_intermediate_file_path
  local LFBFL_file_prefix
  declare -i LFBFL_i_generate_from_template_result
  declare -i LFBFL_i
  for LFBFL_some_license in "${LFBFL_licenses[@]}"; do
    LFBFL_license_prefix="${LFBFL_source_license_prefix}"
    LFBFL_license_prefix+="${LFBFL_some_license}"
    LFBFL_license_prefix2="${LFBFL_target_license_prefix}"
    LFBFL_license_prefix2+="${LFBFL_some_license}"
    for ((
      LFBFL_i = 0;
      LFBFL_i < ${#LFBFL_block_comment_languages[@]};
      ++LFBFL_i
    )); do
      LFBFL_extension=${LFBFL_block_comment_languages[LFBFL_i]}
      LFBFL_license_file_path="${LFBFL_license_prefix2}"
      LFBFL_license_file_path+=".${LFBFL_extension}"
      LFBFL_enter_string=${LFBFL_block_comment_enters[LFBFL_i]}
      LFBFL_exit_string=${LFBFL_block_comment_exits[LFBFL_i]}
      generate_from_template_with_block_comments\
        "${LFBFL_license_prefix}.tpl"\
        "${LFBFL_license_file_path}.tpl"\
        "${LFBFL_enter_string}" "${LFBFL_exit_string}"
      LFBFL_i_generate_from_template_result=$?
      if [[ LFBFL_i_verbose -eq 1 ]]; then
        if [[ LFBFL_i_generate_from_template_result -eq 1 ]]; then
          printf "License template %s.tpl updated.\n"\
            "${LFBFL_license_file_path}"
        elif [[ LFBFL_i_generate_from_template_result -eq 2 ]]; then
          printf "License template %s.tpl created.\n"\
            "${LFBFL_license_file_path}"
        fi
      fi
    done
    LFBFL_temp2=".generate_from_template_with_line_comments.temp"
    for ((
      LFBFL_i = 0;
      LFBFL_i < ${#LFBFL_line_comment_languages[@]};
      ++LFBFL_i
    )); do
      LFBFL_extension=${LFBFL_line_comment_languages[LFBFL_i]}
      LFBFL_license_file_path="${LFBFL_license_prefix2}"
      LFBFL_license_file_path+=".${LFBFL_extension}"
      LFBFL_prefix_string=${LFBFL_line_comment_prefixes[LFBFL_i]}
      LFBFL_intermediate_file_path="${LFBFL_license_file_path}.tpl"
      LFBFL_intermediate_file_path+="${LFBFL_temp2}"
      LFBFL_file_prefix=""
      if [[ "${LFBFL_extension}" == "sh" ]]; then
        LFBFL_file_prefix="${LFBFL_SHELL_SCRIPT_BEGINNING}"
      fi
      # The sed command is here to remove trailing spaces of previously
      # empty lines after comment prefix is added to the line.
      generate_from_template_with_line_comments\
        "${LFBFL_license_prefix}.tpl"\
        "${LFBFL_license_file_path}.tpl"\
        "${LFBFL_prefix_string}"\
        "sed -Ei -e 's/\s*$//g' '${LFBFL_intermediate_file_path}'"\
        "${LFBFL_file_prefix}"
      LFBFL_i_generate_from_template_result=$?
      if [[ LFBFL_i_verbose -eq 1 ]]; then
        if [[ LFBFL_i_generate_from_template_result -eq 1 ]]; then
          printf "License template %s.tpl updated.\n"\
            "${LFBFL_license_file_path}"
        elif [[ LFBFL_i_generate_from_template_result -eq 2 ]]; then
          printf "License template %s.tpl created.\n"\
            "${LFBFL_license_file_path}"
        fi
      fi
    done
  done
  # ------------------------------------------------------------------

  # Now that base license templates generated languages license
  # templates in work directory, we can go there.
  pushd_to_work_directory --trap-popd
  can_continue_after_enhanced_pushd || return 1

  local LFBFL_data_file_path="build_and_checks_variables/"
  LFBFL_data_file_path+="repository_data.txt"
  readonly LFBFL_data_file_path
  local LFBFL_repository_name=""
  grep_variable "${LFBFL_data_file_path}" repository_name\
    --result-variable-prefix="LFBFL_"\
    --replace-line-returns-by=""
  local LFBFL_license=""
  grep_variable "${LFBFL_data_file_path}" license\
    --result-variable-prefix="LFBFL_"
  local LFBFL_license2=""
  grep_variable "${LFBFL_data_file_path}" license2\
    --result-variable-prefix="LFBFL_"
  local LFBFL_author_full_name=""
  grep_variable "${LFBFL_data_file_path}" author_full_name\
    --result-variable-prefix="LFBFL_"\
    --replace-line-returns-by=" "

  LFBFL_license_prefix="build_and_checks_variables/temp/"
  LFBFL_license_prefix+="license_file_header_"
  readonly LFBFL_license_prefix
  LFBFL_license_prefix2="${LFBFL_license_prefix}${LFBFL_license}"
  readonly LFBFL_license_prefix2
  local LFBFL_license_prefix3="${LFBFL_license_prefix}${LFBFL_license2}"
  readonly LFBFL_license_prefix3

  # First year according to current state of git repository.
  declare -ir LFBFL_i_first_year=$(
    git log\
    | grep 'Date:'\
    | tail --lines=1\
    | cut --delimiter=' ' --fields=8
  )
  # Last year according to current state of git repository.
  declare -ir LFBFL_i_last_year=$(
    git log\
    | grep 'Date:'\
    | head --lines=1\
    | cut --delimiter=' ' --fields=8
  )
  local LFBFL_copyright_string
  LFBFL_copyright_string="${LFBFL_i_first_year}-${LFBFL_i_last_year}"
  LFBFL_copyright_string+=" ${LFBFL_author_full_name}"
  readonly LFBFL_copyright_string

  prepare_filled_license_file_block(){
    # $1=license_file_path
    sed --expression="s/@repository_name@/${LFBFL_repository_name}/g"\
        --expression="s/@copyright_string@/${LFBFL_copyright_string}/g"\
        -- "$1.tpl"\
      > "$1.temp"
    overwrite_if_not_equal "$1" "$1.temp"
    declare -ir LFBFL_i_result=$?
    if [[ LFBFL_i_verbose -eq 1 ]]; then
      if [[ LFBFL_i_result -eq 1 ]]; then
        printf "License template %s updated.\n" "$1"
      elif [[ LFBFL_i_result -eq 2 ]]; then
        printf "License template %s created.\n" "$1"
      fi
    fi
    head --lines=-1 -- "$1"\
      | tail --lines=+2\
      > "$1.temp"
    # Strange world: tail --lines=-1 was working
    # to exclude first line.
    # I tested it months ago, and saw with my eyes the start and end
    # block comments removed with:
    # head --lines=-1 "$1" | tail --lines=-1.
    # Now, man page says to use --lines=+2 instead.
    # Welcome in the world where AI change your environment and your
    # documentation on the fly...
  }

  declare -Ar LFBFL_all_block_comment_languages=(
    ["c"]="c"
    ["php"]="c"
    ["py"]="py"
    ["js"]="c"
  )

  local LFBFL_key
  local LFBFL_dest
  local LFBFL_license_file_path2
  declare -i LFBFL_i_not_subfile
  declare -i LFBFL_i_not_subfile2
  local LFBFL_file_path
  local LFBFL_s_files_paths
  declare -a LFBFL_arr_files_paths
  for LFBFL_key in "${!LFBFL_all_block_comment_languages[@]}"; do
    LFBFL_dest=${LFBFL_all_block_comment_languages[${LFBFL_key}]}
    LFBFL_license_file_path="${LFBFL_license_prefix2}.${LFBFL_dest}"
    prepare_filled_license_file_block "${LFBFL_license_file_path}"
    if [[ -n "${LFBFL_license2}" ]]; then
      LFBFL_license_file_path2="${LFBFL_license_prefix3}"
      LFBFL_license_file_path2+=".${LFBFL_dest}"
      prepare_filled_license_file_block "${LFBFL_license_file_path2}"
    fi

    LFBFL_s_files_paths=$(
      find . -type f -iregex ".*\.\(${LFBFL_key}\|${LFBFL_key}\.tpl\)"\
        -printf '%P\n'\
      | relevant_find
    )
    if [[ -z "${LFBFL_s_files_paths}" ]]; then
      if [[ LFBFL_i_verbose -eq 1 ]]; then
        LFBFL_s_format="build_licenses_templates: "
        LFBFL_s_format+="No file found with extension .%s or .%s.tpl.\n"
        # shellcheck disable=SC2059
        printf "${LFBFL_s_format}" "${LFBFL_key}" "${LFBFL_key}"
      fi
      continue
    fi
    mapfile -t LFBFL_arr_files_paths <<< "${LFBFL_s_files_paths}"
    for LFBFL_file_path in "${LFBFL_arr_files_paths[@]}"; do
      is_subfile "${LFBFL_file_path}"\
        "${LFBFL_license_file_path}.temp"
      LFBFL_i_not_subfile=$?
      LFBFL_i_not_subfile2=1
      if [[ -n "${LFBFL_license2}" ]]; then
        is_subfile "${LFBFL_file_path}"\
          "${LFBFL_license_file_path2}.temp"
        LFBFL_i_not_subfile2=$?
      fi
      if [[ LFBFL_i_not_subfile -ge 1 && LFBFL_i_not_subfile2 -ge 1 ]];
      then
        printf "File %s has no/wrong license header?\n"\
          "${LFBFL_file_path}"
      fi
    done
    rm -- "${LFBFL_license_file_path}.temp"
    if [[ -n "${LFBFL_license2}" ]]; then
      rm -- "${LFBFL_license_file_path2}.temp"
    fi
  done

  prepare_filled_license_file_line(){
    # $1=LFBFL_license_file_path
    sed --expression="s/@repository_name@/${LFBFL_repository_name}/g"\
        --expression="s/@copyright_string@/${LFBFL_copyright_string}/g"\
        -- "$1.tpl"\
      > "$1.temp"
    overwrite_if_not_equal "$1" "$1.temp"
    declare -ir LFBFL_i_result=$?
    if [[ LFBFL_i_verbose -eq 1 ]]; then
      if [[ LFBFL_i_result -eq 1 ]]; then
        printf "License template %s updated.\n" "$1"
      elif [[ LFBFL_i_result -eq 2 ]]; then
        printf "License template %s created.\n" "$1"
      fi
    fi
  }

  declare -Ar LFBFL_all_line_comment_languages=(
    ["sh"]="sh"
    ["sql"]="sql"
    ["tex"]="tex"
  )

  for LFBFL_key in "${!LFBFL_all_line_comment_languages[@]}"; do
    LFBFL_dest=${LFBFL_all_line_comment_languages[${LFBFL_key}]}
    LFBFL_license_file_path="${LFBFL_license_prefix2}.${LFBFL_dest}"
    prepare_filled_license_file_line "${LFBFL_license_file_path}"
    if [[ -n "${LFBFL_license2}" ]]; then
      LFBFL_license_file_path2="${LFBFL_license_prefix3}"
      LFBFL_license_file_path2+=".${LFBFL_dest}"
      prepare_filled_license_file_line "${LFBFL_license_file_path2}"
    fi

    LFBFL_s_files_paths=$(
      find . -type f -iregex ".*\.\(${LFBFL_key}\|${LFBFL_key}\.tpl\)"\
        -printf '%P\n'\
      | relevant_find
    )
    if [[ -z "${LFBFL_s_files_paths}" ]]; then
      if [[ LFBFL_i_verbose -eq 1 ]]; then
        LFBFL_s_format="build_licenses_templates: "
        LFBFL_s_format+="No file found with extension .%s or .%s.tpl.\n"
        # shellcheck disable=SC2059
        printf "${LFBFL_s_format}" "${LFBFL_key}" "${LFBFL_key}"
      fi
      continue
    fi
    mapfile -t LFBFL_arr_files_paths <<< "${LFBFL_s_files_paths}"
    for LFBFL_file_path in "${LFBFL_arr_files_paths[@]}"; do
      is_subfile "${LFBFL_file_path}" "${LFBFL_license_file_path}"
      LFBFL_i_not_subfile=$?
      LFBFL_i_not_subfile2=1
      if [[ -n "${LFBFL_license2}" ]]; then
        is_subfile "${LFBFL_file_path}" "${LFBFL_license_file_path2}"
        LFBFL_i_not_subfile2=$?
      fi
      if [[ LFBFL_i_not_subfile -ge 1 && LFBFL_i_not_subfile2 -ge 1 ]];
      then
        printf "File %s has no/wrong license header?\n"\
          "${LFBFL_file_path}"
      fi
    done
  done
}

build_licenses_templates "$@"
