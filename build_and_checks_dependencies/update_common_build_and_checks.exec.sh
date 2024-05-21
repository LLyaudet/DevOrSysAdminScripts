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

verbose=""
if [[ "$1" == "--verbose" ]]; then
  echo "$0 $*"
  verbose="--verbose"
fi

cp ./common_build_and_checks.sh.tpl ./common_build_and_checks.sh

file_names=(\
  "build_md_from_printable_md.sh"\
  "check_shell_scripts_beginnings.sh"\
  "check_URLs.sh"\
  "comparisons.sh"\
  "create_PDF.sh"\
  "generate_from_template.sh"\
  "get_common_text_glob_patterns.sh"\
  "grammar_and_spell_check.sh"\
  "licenses_templates/build_licenses_templates.sh"\
  "licenses_templates/license_file_header_GPLv3+.tpl"\
  "licenses_templates/license_file_header_LGPLv3+.tpl"\
  "lines_counts.sh"\
  "lines_filters.sh"\
  "lines_maps.sh"\
  "listings/update_or_check_files_names_listing.sh"\
  "listings/files_names_listing.txt"\
  "overwrite_if_not_equal.sh"\
  "python_black_complement.sh"\
  "python_isort_complement.sh"\
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
  base_file_name=$(basename "$file_name")
  sed -i "s|@sha512_$base_file_name@|$file_sha512_all|g"\
      ./common_build_and_checks.sh
done

cp ./build_and_checks.sh.tpl ../build_and_checks.sh

file_sha512=$(sha512sum common_build_and_checks.sh | cut -f1 -d' ')
file_sha512_1="correct_sha512='${file_sha512:0:53}'"
file_sha512_2="correct_sha512\+='${file_sha512:53:52}'"
file_sha512_3="correct_sha512\+='${file_sha512:105}'"
file_sha512_all="$file_sha512_1\n"
file_sha512_all+="$file_sha512_2\n"
file_sha512_all+="$file_sha512_3"
sed -i "s|@sha512_common_build_and_checks.sh@|$file_sha512_all|g"\
    ../build_and_checks.sh
