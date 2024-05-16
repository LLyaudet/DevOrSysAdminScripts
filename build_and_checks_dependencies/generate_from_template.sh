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
