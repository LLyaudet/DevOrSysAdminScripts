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
# shellcheck source=comparisons.libr.sh
source "./${LFBFL_subdir}/comparisons.libr.sh"
# shellcheck source=generate_from_template.libr.sh
source "./${LFBFL_subdir}/generate_from_template.libr.sh"
# shellcheck source=lines_filters.libr.sh
source "./${LFBFL_subdir}/lines_filters.libr.sh"
# shellcheck source=overwrite_if_not_equal.libr.sh
source "./${LFBFL_subdir}/overwrite_if_not_equal.libr.sh"

build_licenses_templates(){
  local LFBFL_working_directory=$1
  if [[ -z "$1" ]]; then
    LFBFL_working_directory="."
  fi
  readonly LFBFL_working_directory
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

  # Source
  local LFBFL_license_source_subdir
  LFBFL_license_source_subdir="./${LFBFL_subdir}/licenses_templates/"
  readonly LFBFL_license_source_subdir
  local LFBFL_source_license_prefix="${LFBFL_license_source_subdir}"
  LFBFL_source_license_prefix+="license_file_header_"
  readonly LFBFL_source_license_prefix
  # Target
  local LFBFL_license_target_subdir
  LFBFL_license_target_subdir="${LFBFL_working_directory}/"
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
  declare -i LFBFL_equal_result=$?
  if [[ LFBFL_equal_result -eq 0 ]]; then
    echo $'/!\\Problem with the definitions of languages arrays 1/!\\'
  fi

  declare -ar LFBFL_line_comment_languages=(
    "sh"
    "tex"
  )
  declare -ar LFBFL_line_comment_prefixes=(
    '# '
    '% '
  )
  equal "${#LFBFL_line_comment_languages[@]}"\
        "${#LFBFL_line_comment_prefixes[@]}"
  LFBFL_equal_result=$?
  if [[ LFBFL_equal_result -eq 0 ]]; then
    echo $'/!\\Problem with the definitions of languages arrays 2/!\\'
  fi
  # ------------------------------------------------------------------

  # ------------------------------------------------------------------
  # We generate the license header templates adapted to various text
  # files formats.
  # Kamoulox do endfor, Jacques Beauregard XD
  # (C'est toujours mieux que l'inverse :) !)
  # for do endfor -> for do done (Fort Doux Donne).
  local LFBFL_license
  local LFBFL_license_prefix
  local LFBFL_license_prefix2
  local LFBFL_extension
  local LFBFL_license_file_name
  local LFBFL_enter_string
  local LFBFL_exit_string
  local LFBFL_temp2
  local LFBFL_prefix_string
  local LFBFL_intermediate_file_name
  local LFBFL_file_prefix
  declare -i LFBFL_generate_from_template_result
  for LFBFL_license in "${LFBFL_licenses[@]}"; do
    LFBFL_license_prefix="${LFBFL_source_license_prefix}"
    LFBFL_license_prefix+="${LFBFL_license}"
    LFBFL_license_prefix2="${LFBFL_target_license_prefix}"
    LFBFL_license_prefix2+="${LFBFL_license}"
    for ((i=0; i<${#LFBFL_block_comment_languages[@]}; i++)); do
      LFBFL_extension=${LFBFL_block_comment_languages[i]}
      LFBFL_license_file_name="${LFBFL_license_prefix2}"
      LFBFL_license_file_name+=".${LFBFL_extension}"
      LFBFL_enter_string=${LFBFL_block_comment_enters[i]}
      LFBFL_exit_string=${LFBFL_block_comment_exits[i]}
      generate_from_template_with_block_comments\
        "${LFBFL_license_prefix}.tpl"\
        "${LFBFL_license_file_name}.tpl"\
        "${LFBFL_enter_string}" "${LFBFL_exit_string}"
      LFBFL_generate_from_template_result=$?
      if [[ LFBFL_verbose -eq 1 ]]; then
        if [[ LFBFL_generate_from_template_result -eq 1 ]]; then
          echo\
            "License template ${LFBFL_license_file_name}.tpl updated"
        elif [[ LFBFL_generate_from_template_result -eq 2 ]]; then
          echo\
            "License template ${LFBFL_license_file_name}.tpl created"
        fi
      fi
    done
    LFBFL_temp2=".generate_from_template_with_line_comments.temp"
    for ((i=0; i<${#LFBFL_line_comment_languages[@]}; i++)); do
      LFBFL_extension=${LFBFL_line_comment_languages[i]}
      LFBFL_license_file_name="${LFBFL_license_prefix2}"
      LFBFL_license_file_name+=".${LFBFL_extension}"
      LFBFL_prefix_string=${LFBFL_line_comment_prefixes[i]}
      LFBFL_intermediate_file_name="${LFBFL_license_file_name}.tpl"
      LFBFL_intermediate_file_name+="${LFBFL_temp2}"
      LFBFL_file_prefix=""
      if [[ "${LFBFL_extension}" == "sh" ]]; then
        LFBFL_file_prefix="#!/usr/bin/env bash"
      fi
      generate_from_template_with_line_comments\
        "${LFBFL_license_prefix}.tpl"\
        "${LFBFL_license_file_name}.tpl"\
        "${LFBFL_prefix_string}"\
        "sed -Ei -e 's/\s*$//g' '${LFBFL_intermediate_file_name}'"\
        "${LFBFL_file_prefix}"
      LFBFL_generate_from_template_result=$?
      if [[ LFBFL_verbose -eq 1 ]]; then
        if [[ LFBFL_generate_from_template_result -eq 1 ]]; then
          echo\
            "License template ${LFBFL_license_file_name}.tpl updated"
        elif [[ LFBFL_generate_from_template_result -eq 2 ]]; then
          echo\
            "License template ${LFBFL_license_file_name}.tpl created"
        fi
      fi
    done
  done
  # ------------------------------------------------------------------

  # Now that base license templates generated languages license
  # templates in working directory, we can go there.
  declare -i LFBFL_cd_result
  pushd .
  cd "${LFBFL_working_directory}" || {
    LFBFL_cd_result=$?
    echo "build_licenses_templates no such directory"
    # shellcheck disable=SC2248
    return ${LFBFL_cd_result}
  }

  local LFBFL_data_file_name="build_and_checks_variables/"
  LFBFL_data_file_name+="repository_data.txt"
  readonly LFBFL_data_file_name
  repository_name=""
  license=""
  license2=""
  author_full_name=""
  grep_variable "${LFBFL_data_file_name}" repository_name
  grep_variable "${LFBFL_data_file_name}" license
  grep_variable "${LFBFL_data_file_name}" license2
  grep_variable "${LFBFL_data_file_name}" author_full_name

  LFBFL_license_prefix="build_and_checks_variables/temp/"
  LFBFL_license_prefix+="license_file_header_"
  readonly LFBFL_license_prefix
  LFBFL_license_prefix2="${LFBFL_license_prefix}${license}"
  readonly LFBFL_license_prefix2
  declare -r\
    LFBFL_license_prefix3="${LFBFL_license_prefix}${license2}"

  # First year according to current state of git repository.
  declare -r LFBFL_first_year=$(
    git log\
    | grep 'Date:'\
    | cut -f 8 -d ' '\
    | tail -1
  )
  # Last year according to current state of git repository.
  declare -r LFBFL_last_year=$(
    git log\
    | grep 'Date:'\
    | cut -f 8 -d ' '\
    | head -1
  )
  local LFBFL_copyright_string
  LFBFL_copyright_string="${LFBFL_first_year}-${LFBFL_last_year}"
  LFBFL_copyright_string+=" ${author_full_name}"
  readonly LFBFL_copyright_string

  prepare_filled_license_file_block(){
    # $1=license_file_name
    sed -e "s/@repository_name@/${repository_name}/g"\
        -e "s/@copyright_string@/${LFBFL_copyright_string}/g"\
        "$1.tpl"\
      > "$1.temp"
    overwrite_if_not_equal "$1" "$1.temp"
    declare -r LFBFL_result=$?
    if [[ LFBFL_verbose -eq 1 ]]; then
      if [[ LFBFL_result -eq 1 ]]; then
        echo "License template $1 updated"
      elif [[ LFBFL_result -eq 2 ]]; then
        echo "License template $1 created"
      fi
    fi
    head --lines=-1 "$1"\
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
  )

  local LFBFL_key
  local LFBFL_dest
  local LFBFL_license_file_name2
  declare -i LFBFL_not_subfile
  declare -i LFBFL_not_subfile2
  for LFBFL_key in "${!LFBFL_all_block_comment_languages[@]}"; do
    LFBFL_dest=${LFBFL_all_block_comment_languages[${LFBFL_key}]}
    LFBFL_license_file_name="${LFBFL_license_prefix2}.${LFBFL_dest}"
    prepare_filled_license_file_block "${LFBFL_license_file_name}"
    if [[ -n "${license2}" ]]; then
      LFBFL_license_file_name2="${LFBFL_license_prefix3}"
      LFBFL_license_file_name2+=".${LFBFL_dest}"
      prepare_filled_license_file_block "${LFBFL_license_file_name2}"
    fi
    find . -type f -name "*.${LFBFL_key}" -printf '%P\n'\
      | relevant_find\
      | while read -r LFBFL_file_name;
    do
      is_subfile "${LFBFL_file_name}"\
        "${LFBFL_license_file_name}.temp"
      LFBFL_not_subfile=$?
      LFBFL_not_subfile2=1
      if [[ -n "${license2}" ]]; then
        is_subfile "${LFBFL_file_name}"\
          "${LFBFL_license_file_name2}.temp"
        LFBFL_not_subfile2=$?
      fi
      if [[ LFBFL_not_subfile -ge 1 && LFBFL_not_subfile2 -ge 1 ]];
      then
        echo "File ${LFBFL_file_name} has no/wrong license header?"
      fi
    done
    rm "${LFBFL_license_file_name}.temp"
    if [[ -n "${license2}" ]]; then
      rm "${LFBFL_license_file_name2}.temp"
    fi
  done

  prepare_filled_license_file_line(){
    # $1=LFBFL_license_file_name
    sed -e "s/@repository_name@/${repository_name}/g"\
        -e "s/@copyright_string@/${LFBFL_copyright_string}/g"\
        "$1.tpl"\
      > "$1.temp"
    overwrite_if_not_equal "$1" "$1.temp"
    declare -r LFBFL_result=$?
    if [[ LFBFL_verbose -eq 1 ]]; then
      if [[ LFBFL_result -eq 1 ]]; then
        echo "License template $1 updated"
      elif [[ LFBFL_result -eq 2 ]]; then
        echo "License template $1 created"
      fi
    fi
  }

  declare -Ar LFBFL_all_line_comment_languages=(
    ["sh"]="sh"
    ["tex"]="tex"
  )

  for LFBFL_key in "${!LFBFL_all_line_comment_languages[@]}"; do
    LFBFL_dest=${LFBFL_all_line_comment_languages[${LFBFL_key}]}
    LFBFL_license_file_name="${LFBFL_license_prefix2}.${LFBFL_dest}"
    prepare_filled_license_file_line "${LFBFL_license_file_name}"
    if [[ -n "${license2}" ]]; then
      LFBFL_license_file_name2="${LFBFL_license_prefix3}"
      LFBFL_license_file_name2+=".${LFBFL_dest}"
      prepare_filled_license_file_line "${LFBFL_license_file_name2}"
    fi
    find . -type f -name "*.${LFBFL_key}" -printf '%P\n'\
      | relevant_find\
      | while read -r LFBFL_file_name;
    do
      is_subfile "${LFBFL_file_name}" "${LFBFL_license_file_name}"
      LFBFL_not_subfile=$?
      LFBFL_not_subfile2=1
      if [[ -n "${license2}" ]]; then
        is_subfile "${LFBFL_file_name}" "${LFBFL_license_file_name2}"
        LFBFL_not_subfile2=$?
      fi
      if [[ LFBFL_not_subfile -ge 1 && LFBFL_not_subfile2 -ge 1 ]];
      then
        echo "File ${LFBFL_file_name} has no/wrong license header?"
      fi
    done
  done

  declare -i LFBFL_popd_result
  popd || {
    LFBFL_popd_result=$?
    echo "build_licenses_templates no popd"
    # shellcheck disable=SC2248
    return ${LFBFL_popd_result}
  }
}

build_licenses_templates "$@"
