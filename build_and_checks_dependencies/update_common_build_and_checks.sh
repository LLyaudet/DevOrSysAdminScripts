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
# ©Copyright 2023-2024 Laurent Lyaudet

cp ./common_build_and_checks.sh.tpl ./common_build_and_checks.sh

file_names=(\
  "build_readme.sh"\
  "check_shell_scripts_beginning.sh"\
  "check_URLs.sh"\
  "get_common_text_glob_patterns.sh"\
  "python_black_complement.sh"\
  "too_long_code_lines.sh"\
)

for file_name in "${file_names[@]}"; do
  file_sha512=$(sha512sum "./$file_name" | cut -f1 -d' ')
  file_sha512_1="correct_sha512='${file_sha512:0:53}'"
  file_sha512_2="correct_sha512\+='${file_sha512:53:52}'"
  file_sha512_3="correct_sha512\+='${file_sha512:105}'"
  file_sha512_all="$file_sha512_1\n"
  file_sha512_all+="$file_sha512_2\n"
  file_sha512_all+="$file_sha512_3"
  sed -i "s|@sha512_$file_name@|$file_sha512_all|g"\
      ./common_build_and_checks.sh
done
