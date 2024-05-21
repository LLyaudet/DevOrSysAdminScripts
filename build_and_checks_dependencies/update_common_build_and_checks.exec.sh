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
# This file was renamed from "update_common_build_and_checks.sh"
# to "update_common_build_and_checks.exec.sh".

verbose=""
if [[ "$1" == "--verbose" ]]; then
  echo "$0 $*"
  verbose="--verbose"
fi

common_file_name="common_build_and_checks.exec.sh"
cp "./${common_file_name}.tpl"\
   "./${common_file_name}"

file_names=(\
  "build_md_from_printable_md.exec.sh"\
  "check_shell_scripts_beginnings.libr.sh"\
  "check_URLs.libr.sh"\
  "comparisons.libr.sh"\
  "create_PDF.exec.sh"\
  "generate_from_template.libr.sh"\
  "get_common_text_glob_patterns.libr.sh"\
  "grammar_and_spell_check.libr.sh"\
  "licenses_templates/build_licenses_templates.exec.sh"\
  "licenses_templates/license_file_header_GPLv3+.tpl"\
  "licenses_templates/license_file_header_LGPLv3+.tpl"\
  "lines_counts.libr.sh"\
  "lines_filters.libr.sh"\
  "lines_maps.libr.sh"\
  "listings/update_or_check_files_names_listing.exec.sh"\
  "listings/files_names_listing.txt"\
  "overwrite_if_not_equal.libr.sh"\
  "python_black_complement.libr.sh"\
  "python_isort_complement.libr.sh"\
  "too_long_code_lines.libr.sh"\
)

for file_name in "${file_names[@]}"; do
  file_sha512=$(sha512sum "./${file_name}" | cut -f1 -d' ')
  file_sha512_1="correct_sha512='${file_sha512:0:53}'"
  file_sha512_2="correct_sha512\+='${file_sha512:53:52}'"
  file_sha512_3="correct_sha512\+='${file_sha512:105}'"
  file_sha512_all="${file_sha512_1}\n"
  file_sha512_all+="${file_sha512_2}\n"
  file_sha512_all+="${file_sha512_3}"
  base_file_name=$(basename "${file_name}")
  sed -i "s|@sha512_${base_file_name}@|${file_sha512_all}|g"\
      "./${common_file_name}"
done

main_file_name="build_and_checks.exec.sh"
cp "./${main_file_name}.tpl" "../${main_file_name}"

file_sha512=$(sha512sum "${common_file_name}" | cut -f1 -d' ')
file_sha512_1="correct_sha512='${file_sha512:0:53}'"
file_sha512_2="correct_sha512\+='${file_sha512:53:52}'"
file_sha512_3="correct_sha512\+='${file_sha512:105}'"
file_sha512_all="${file_sha512_1}\n"
file_sha512_all+="${file_sha512_2}\n"
file_sha512_all+="${file_sha512_3}"
sed -i "s|@sha512_${common_file_name}@|${file_sha512_all}|g"\
  "../${main_file_name}"
