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

LFBFL_verbose=""
if [[ "$1" == "--verbose" ]]; then
  echo "$0 $*"
  # shellcheck disable=SC2034
  LFBFL_verbose="--verbose"
fi

LFBFL_subdir="build_and_checks_dependencies"
# shellcheck disable=SC1090
source "./${LFBFL_subdir}/comparisons.libr.sh"
# shellcheck disable=SC1090
source "./${LFBFL_subdir}/generate_from_template.libr.sh"
# shellcheck disable=SC1090
source "./${LFBFL_subdir}/lines_filters.libr.sh"
# shellcheck disable=SC1090
source "./${LFBFL_subdir}/overwrite_if_not_equal.libr.sh"

declare -r\
  LFBFL_license_subdir="./${LFBFL_subdir}/licenses_templates/"
declare -r\
  LFBFL_license_prefix="${LFBFL_license_subdir}license_file_header_"
declare -ar LFBFL_licenses=(\
  "AGPLv3+"\
  "GPLv3+"\
  "LGPLv3+"
)

# --------------------------------------------------------------------
# Various language definitions for text file formats
declare -ar LFBFL_block_comment_languages=(\
  "c"\
  "py"\
)
declare -ar LFBFL_block_comment_enters=(\
  '/*'\
  '"""'\
)
declare -ar LFBFL_block_comment_exits=(\
  '*/'\
  '"""'\
)
equal "${#LFBFL_block_comment_languages[@]}"\
      "${#LFBFL_block_comment_enters[@]}"\
      "${#LFBFL_block_comment_exits[@]}"
# shellcheck disable=SC2181
if [[ $? == 0 ]]; then
  # shellcheck disable=SC1003
  echo '/!\'"Problème de définition des tableaux de langages 1"'/!\'
fi

declare -ar LFBFL_line_comment_languages=(\
  "sh"\
  "tex"\
)
declare -ar LFBFL_line_comment_prefixes=(\
  '# '\
  '% '\
)
equal "${#LFBFL_line_comment_languages[@]}"\
      "${#LFBFL_line_comment_prefixes[@]}"
# shellcheck disable=SC2181
if [[ $? == 0 ]]; then
  # shellcheck disable=SC1003
  echo '/!\'"Problème de définition des tableaux de langages 2"'/!\'
fi
# --------------------------------------------------------------------

# --------------------------------------------------------------------
# We generate the license header templates adapted to various text
# files formats.
# Kamoulox do endfor, Jacques Beauregard XD
# (C'est toujours mieux que l'inverse :) !)
# for do endfor -> for do done (Fort Doux Donne).
declare LFBFL_license
declare LFBFL_license_prefix2
declare LFBFL_extension
declare LFBFL_license_file_name
declare LFBFL_enter_string
declare LFBFL_exit_string
declare LFBFL_temp2
declare LFBFL_prefix_string
declare LFBFL_intermediate_file_name
for LFBFL_license in "${LFBFL_licenses[@]}"; do
  LFBFL_license_prefix2="${LFBFL_license_prefix}${LFBFL_license}"
  for ((i=0; i<${#LFBFL_block_comment_languages[@]}; i++)); do
    LFBFL_extension=${LFBFL_block_comment_languages[i]}
    LFBFL_license_file_name="${LFBFL_license_prefix2}"
    LFBFL_license_file_name+=".${LFBFL_extension}"
    LFBFL_enter_string=${LFBFL_block_comment_enters[i]}
    LFBFL_exit_string=${LFBFL_block_comment_exits[i]}
    generate_from_template_with_block_comments\
      "${LFBFL_license_prefix2}.tpl"\
      "${LFBFL_license_file_name}.tpl"\
      "${LFBFL_enter_string}" "${LFBFL_exit_string}"
  done
  LFBFL_temp2=".generate_from_template_with_line_comments.temp"
  for ((i=0; i<${#LFBFL_line_comment_languages[@]}; i++)); do
    LFBFL_extension=${LFBFL_line_comment_languages[i]}
    LFBFL_license_file_name="${LFBFL_license_prefix2}"
    LFBFL_license_file_name+=".${LFBFL_extension}"
    LFBFL_prefix_string=${LFBFL_line_comment_prefixes[i]}
    LFBFL_intermediate_file_name="${LFBFL_license_file_name}.tpl"
    LFBFL_intermediate_file_name+="${LFBFL_temp2}"
    generate_from_template_with_line_comments\
      "${LFBFL_license_prefix2}.tpl"\
      "${LFBFL_license_file_name}.tpl"\
      "${LFBFL_prefix_string}"\
      "sed -Ei -e 's/\s*$//g' '${LFBFL_intermediate_file_name}'"
  done
done
# --------------------------------------------------------------------

declare -r LFBFL_data_file_name=\
"build_and_checks_variables/repository_data.txt"
repository_name=""
license=""
license2=""
author_full_name=""
grep_variable "${LFBFL_data_file_name}" repository_name
grep_variable "${LFBFL_data_file_name}" license
grep_variable "${LFBFL_data_file_name}" license2
grep_variable "${LFBFL_data_file_name}" author_full_name
LFBFL_license_prefix2="${LFBFL_license_prefix}${license}"
readonly LFBFL_license_prefix2
declare -r LFBFL_license_prefix3="${LFBFL_license_prefix}${license2}"

# First year according to current state of git repository.
# shellcheck disable=SC2155,SC2312
declare -r LFBFL_first_year=\
"$(git log | grep 'Date:' | cut -f 8 -d ' ' | tail -1)"
# Last year according to current state of git repository.
# shellcheck disable=SC2155,SC2312
declare -r LFBFL_last_year=\
"$(git log | grep 'Date:' | cut -f 8 -d ' ' | head -1)"
LFBFL_copyright_string="${LFBFL_first_year}-${LFBFL_last_year}"
LFBFL_copyright_string+=" ${author_full_name}"
readonly LFBFL_copyright_string

prepare_filled_license_file_block(){
  # $1=license_file_name
  sed -e "s/@repository_name@/${repository_name}/g"\
    -e "s/@copyright_string@/${LFBFL_copyright_string}/g"\
    "$1.tpl" > "$1.temp"
  overwrite_if_not_equal "$1" "$1.temp"
  # shellcheck disable=SC2312
  head --lines=-1 "$1" | tail --lines=+2 > "$1.temp"
  # Strange world: tail --lines=-1 was working to exclude first line.
  # I tested it months ago, and saw with my eyes the start and end
  # block comments removed with:
  # head --lines=-1 "$1" | tail --lines=-1.
  # Now, man page says to use --lines=+2 instead.
  # Welcome in the world where AI change your environment and your doc
  # on the fly...
}

declare -A LFBFL_all_block_comment_languages
LFBFL_all_block_comment_languages["c"]="c"
LFBFL_all_block_comment_languages["php"]="c"
LFBFL_all_block_comment_languages["py"]="py"

declare LFBFL_key
declare LFBFL_dest
declare LFBFL_license_file_name2
declare -i LFBFL_not_subfile
declare -i LFBFL_not_subfile2

for LFBFL_key in "${!LFBFL_all_block_comment_languages[@]}"; do
  LFBFL_dest=${LFBFL_all_block_comment_languages[${LFBFL_key}]}
  LFBFL_license_file_name="${LFBFL_license_prefix2}.${LFBFL_dest}"
  prepare_filled_license_file_block "${LFBFL_license_file_name}"
  if [[ -n "${license2}" ]]; then
    LFBFL_license_file_name2="${LFBFL_license_prefix3}.${LFBFL_dest}"
    prepare_filled_license_file_block "${LFBFL_license_file_name2}"
  fi
  # shellcheck disable=SC2312
  find . -type f -name "*.${LFBFL_key}" -printf '%P\n'\
    | relevant_find | while read -r LFBFL_file_name;
  do
    is_subfile "${LFBFL_file_name}" "${LFBFL_license_file_name}.temp"
    LFBFL_not_subfile=$?
    LFBFL_not_subfile2=1
    if [[ -n "${license2}" ]]; then
      is_subfile "${LFBFL_file_name}"\
        "${LFBFL_license_file_name2}.temp"
      LFBFL_not_subfile2=$?
    fi
    if [[ LFBFL_not_subfile -ge 1 && LFBFL_not_subfile2 -ge 1 ]]; then
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
    "$1.tpl" > "$1.temp"
  overwrite_if_not_equal "$1" "$1.temp"
}

declare -A LFBFL_all_line_comment_languages
LFBFL_all_line_comment_languages["sh"]="sh"
LFBFL_all_line_comment_languages["tex"]="tex"

for LFBFL_key in "${!LFBFL_all_line_comment_languages[@]}"; do
  LFBFL_dest=${LFBFL_all_line_comment_languages[${LFBFL_key}]}
  LFBFL_license_file_name="${LFBFL_license_prefix2}.${LFBFL_dest}"
  prepare_filled_license_file_line "${LFBFL_license_file_name}"
  if [[ -n "${license2}" ]]; then
    LFBFL_license_file_name2="${LFBFL_license_prefix3}.${LFBFL_dest}"
    prepare_filled_license_file_line "${LFBFL_license_file_name2}"
  fi
  # shellcheck disable=SC2312
  find . -type f -name "*.${LFBFL_key}" -printf '%P\n'\
    | relevant_find | while read -r LFBFL_file_name;
  do
    is_subfile "${LFBFL_file_name}" "${LFBFL_license_file_name}"
    LFBFL_not_subfile=$?
    LFBFL_not_subfile2=1
    if [[ -n "${license2}" ]]; then
      is_subfile "${LFBFL_file_name}" "${LFBFL_license_file_name2}"
      LFBFL_not_subfile2=$?
    fi
    if [[ LFBFL_not_subfile -ge 1 && LFBFL_not_subfile2 -ge 1 ]]; then
      echo "File ${LFBFL_file_name} has no/wrong license header?"
    fi
  done
done
