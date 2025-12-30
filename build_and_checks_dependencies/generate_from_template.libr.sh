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
# ©Copyright 2023-2025 Laurent Frédéric Bernard François Lyaudet
# This file was renamed from "generate_from_template.sh" to
# "generate_from_template.libr.sh".

LFBFL_subdir="build_and_checks_dependencies"
# shellcheck disable=SC1090
source "./${LFBFL_subdir}/lines_filters.libr.sh"

generate_from_template_with_block_comments(){
  # $1=base_file_name
  # $2=target_file_name
  # $3=enter_block_comment
  # $4=exit_block_comment
  local LFBFL_temp
  LFBFL_temp="$2.generate_from_template_with_block_comments.temp"
  readonly LFBFL_temp
  echo "$3" > "${LFBFL_temp}"
  cat "$1" >> "${LFBFL_temp}"
  echo "$4" >> "${LFBFL_temp}"
  overwrite_if_not_equal "$2" "${LFBFL_temp}"
}

generate_from_template_with_line_comments(){
  # $1=base_file_name
  # $2=target_file_name
  # $3=line_comment_prefix
  # $4=optional_post_processing
  local LFBFL_temp
  LFBFL_temp="$2.generate_from_template_with_line_comments.temp"
  readonly LFBFL_temp
  sed -e "s/^/$3/g" "$1" > "${LFBFL_temp}"
  if [[ -n "$4" ]]; then
    eval "$4"
  fi
  overwrite_if_not_equal "$2" "${LFBFL_temp}"
}

split_file_in_two(){
  # $1=$file_name
  # $2=$token assume that token is the only thing on his line.
  # $3=$file_name_part1
  # $4=$file_name_part2
  declare -ir LFBFL_line_number=$(
    grep -n "$2" "$1" | head --lines=1 | cut -f 1 -d ':'
  )
  declare -ir LFBFL_line_count=$(ll_wc -l -n "$1")
  declare -ir LFBFL_lines_after=$((
    LFBFL_line_count - LFBFL_line_number
  ))
  head --lines="$((LFBFL_line_number - 1))" "$1" > "$3"
  tail --lines="${LFBFL_lines_after}" "$1" > "$4"
}

insert_file_at_token(){
  # $1=$file_name
  # $2=$token assume that token is the only thing on his line.
  # $3=$file_name_to_insert
  declare -r LFBFL_start_file_name="$1.insert_file_at_token1.temp"
  declare -r LFBFL_end_file_name="$1.insert_file_at_token2.temp"
  declare -r LFBFL_result_file_name="$1.insert_file_at_token3.temp"
  split_file_in_two "$1" "$2" "${LFBFL_start_file_name}"\
    "${LFBFL_end_file_name}"
  cat "${LFBFL_start_file_name}" "$3" "${LFBFL_end_file_name}"\
    > "${LFBFL_result_file_name}"
  overwrite_if_not_equal "$1" "${LFBFL_result_file_name}"
  rm "${LFBFL_start_file_name}" "${LFBFL_end_file_name}"
}
