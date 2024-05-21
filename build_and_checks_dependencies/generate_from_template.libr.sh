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

subdir="build_and_checks_dependencies"
source "./$subdir/lines_filters.sh"

generate_from_template_with_block_comments(){
  # $1=base_file_name
  # $2=target_file_name
  # $3=enter_block_comment
  # $4=exit_block_comment
  LFBFL_temp=".generate_from_template_with_block_comments.temp"
  echo "$3" > "$2$LFBFL_temp"
  cat "$1" >> "$2$LFBFL_temp"
  echo "$4" >> "$2$LFBFL_temp"
  overwrite_if_not_equal "$2" "$2$LFBFL_temp"
}

generate_from_template_with_line_comments(){
  # $1=base_file_name
  # $2=target_file_name
  # $3=line_comment_prefix
  # $4=optional_post_processing
  LFBFL_temp=".generate_from_template_with_line_comments.temp"
  sed -e "s/^/$3/g" "$1" > "$2$LFBFL_temp"
  if [[ -n "$4" ]]; then
    eval "$4"
  fi
  overwrite_if_not_equal "$2" "$2$LFBFL_temp"
}

split_file_in_two(){
  # $1=$file_name
  # $2=$token assume that token is the only thing on his line.
  # $3=$file_name_part1
  # $4=$file_name_part2
  split_file_in_two_line_number=$(
    grep -n "$2" "$1" | cut -f 1 -d ':'
  )
  split_file_in_two_line_count=$(ll_wc -l -n "$1")
  split_file_in_two_lines_after=$((
    $split_file_in_two_line_count - $split_file_in_two_line_number
  ))
  head --lines="$(($split_file_in_two_line_number - 1))" "$1" > "$3"
  tail --lines="$split_file_in_two_lines_after" "$1" > "$4"
}

insert_file_at_token(){
  # $1=$file_name
  # $2=$token assume that token is the only thing on his line.
  # $3=$file_name_to_insert
  insert_at_token_var_start_file_name="$1.insert_file_at_token1.temp"
  insert_at_token_var_end_file_name="$1.insert_file_at_token2.temp"
  insert_at_token_var_result_file_name="$1.insert_file_at_token3.temp"
  split_file_in_two "$1" "$2" "$insert_at_token_var_start_file_name"\
    "$insert_at_token_var_end_file_name"
  cat "$insert_at_token_var_start_file_name" "$3"\
    "$insert_at_token_var_end_file_name"\
    > "$insert_at_token_var_result_file_name"
  overwrite_if_not_equal "$1"\
    "$insert_at_token_var_result_file_name"
  rm "$insert_at_token_var_start_file_name"\
     "$insert_at_token_var_end_file_name"
}
