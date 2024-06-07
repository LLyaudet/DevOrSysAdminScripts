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

LFBFL_license_subdir="./${LFBFL_subdir}/licenses_templates/"
LFBFL_license_prefix="${LFBFL_license_subdir}license_file_header_"
licenses=(\
  "GPLv3+"\
  "LGPLv3+"
)

# --------------------------------------------------------------------
# Various language definitions for text file formats
block_comment_languages=(\
  "c"\
  "py"\
)
block_comment_enters=(\
  '/*'\
  '"""'\
)
block_comment_exits=(\
  '*/'\
  '"""'\
)
equal "${#block_comment_languages[@]}"\
      "${#block_comment_enters[@]}"\
      "${#block_comment_exits[@]}"
# shellcheck disable=SC2181
if [[ $? == 0 ]]; then
  # shellcheck disable=SC1003
  echo '/!\'"Problème de définition des tableaux de langages 1"'/!\'
fi

line_comment_languages=(\
  "sh"\
  "tex"\
)
line_comment_prefixes=(\
  '# '\
  '% '\
)
equal "${#line_comment_languages[@]}"\
      "${#line_comment_prefixes[@]}"
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
for LFBFL_license in "${licenses[@]}"; do
  LFBFL_license_prefix2="${LFBFL_license_prefix}${LFBFL_license}"
  for ((i=0; i<${#block_comment_languages[@]}; i++)); do
    LFBFL_extension=${block_comment_languages[i]}
    license_file_name="${LFBFL_license_prefix2}.${LFBFL_extension}"
    LFBFL_enter_string=${block_comment_enters[i]}
    LFBFL_exit_string=${block_comment_exits[i]}
    generate_from_template_with_block_comments\
      "${LFBFL_license_prefix2}.tpl"\
      "${license_file_name}.tpl"\
      "${LFBFL_enter_string}" "${LFBFL_exit_string}"
  done
  LFBFL_temp2=".generate_from_template_with_line_comments.temp"
  for ((i=0; i<${#line_comment_languages[@]}; i++)); do
    LFBFL_extension=${line_comment_languages[i]}
    license_file_name="${LFBFL_license_prefix2}.${LFBFL_extension}"
    LFBFL_prefix_string=${line_comment_prefixes[i]}
    LFBFL_intermediate_file_name="${license_file_name}.tpl"
    LFBFL_intermediate_file_name+="${LFBFL_temp2}"
    generate_from_template_with_line_comments\
      "${LFBFL_license_prefix2}.tpl"\
      "${license_file_name}.tpl"\
      "${LFBFL_prefix_string}"\
      "sed -Ei -e 's/\s*$//g' '${LFBFL_intermediate_file_name}'"
  done
done
# --------------------------------------------------------------------

LFBFL_file_name=repository_data.txt
repository_name=""
license=""
author_full_name=""
grep_variable "${LFBFL_file_name}" repository_name
grep_variable "${LFBFL_file_name}" license
grep_variable "${LFBFL_file_name}" author_full_name
LFBFL_license_prefix2="${LFBFL_license_prefix}$license"
# First year according to current state of git repository.
first_year="$(git log | grep 'Date:' | cut -f 8 -d ' ' | tail -1)"
# Last year according to current state of git repository.
last_year="$(git log | grep 'Date:' | cut -f 8 -d ' ' | head -1)"
copyright_string="${first_year}-${last_year} ${author_full_name}"
for ((i=0; i<${#block_comment_languages[@]}; i++)); do
  LFBFL_extension=${block_comment_languages[i]}
  license_file_name="${LFBFL_license_prefix2}.${LFBFL_extension}"
  sed -e "s/@repository_name@/${repository_name}/g"\
    -e "s/@copyright_string@/${copyright_string}/g"\
    "${license_file_name}.tpl" > "${license_file_name}.temp"
  overwrite_if_not_equal "${license_file_name}"\
    "${license_file_name}.temp"
  head --lines=-1 "${license_file_name}" | tail --lines=-1\
    > "${license_file_name}.temp"
  find . -type f -name "*.${LFBFL_extension}" -printf '%P\n'\
    | relevant_find | while read -r LFBFL_file_name;
  do
    if is_subfile "${LFBFL_file_name}" "${license_file_name}.temp"
    then
      echo "File ${LFBFL_file_name} has no/wrong license header?"
    fi
  done
  rm "${license_file_name}.temp"
done
for ((i=0; i<${#line_comment_languages[@]}; i++)); do
  LFBFL_extension=${line_comment_languages[i]}
  license_file_name="${LFBFL_license_prefix2}.${LFBFL_extension}"
  sed -e "s/@repository_name@/${repository_name}/g"\
    -e "s/@copyright_string@/${copyright_string}/g"\
    "${license_file_name}.tpl" > "${license_file_name}.temp"
  overwrite_if_not_equal "${license_file_name}"\
    "${license_file_name}.temp"
  find . -type f -name "*.${LFBFL_extension}" -printf '%P\n'\
    | relevant_find | while read -r LFBFL_file_name;
  do
    if is_subfile "${LFBFL_file_name}" "${license_file_name}"
    then
      echo "File ${LFBFL_file_name} has no/wrong license header?"
    fi
  done
done
