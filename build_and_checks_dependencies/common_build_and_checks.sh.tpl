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

source ./wget_sha512.sh

personal_github="https://raw.githubusercontent.com/LLyaudet/"
dependencies="DevOrSysAdminScripts/main/build_and_checks_dependencies"
URL_beginning="$personal_github$dependencies"

subdir="build_and_checks_dependencies"

script="$URL_beginning/build_md_from_printable_md.sh"
@sha512_build_md_from_printable_md.sh@
wget_sha512 "./$subdir/build_md_from_printable_md.sh" "$script"\
  "$correct_sha512"
chmod +x "./$subdir/build_md_from_printable_md.sh"

script="$URL_beginning/check_shell_scripts_beginnings.sh"
@sha512_check_shell_scripts_beginnings.sh@
wget_sha512 "./$subdir/check_shell_scripts_beginnings.sh" "$script"\
  "$correct_sha512"

script="$URL_beginning/check_URLs.sh"
@sha512_check_URLs.sh@
wget_sha512 "./$subdir/check_URLs.sh" "$script" "$correct_sha512"

script="$URL_beginning/comparisons.sh"
@sha512_comparisons.sh@
wget_sha512 "./$subdir/comparisons.sh" "$script" "$correct_sha512"

script="$URL_beginning/create_PDF.sh"
@sha512_create_PDF.sh@
wget_sha512 "./$subdir/create_PDF.sh" "$script" "$correct_sha512"
chmod +x "./$subdir/create_PDF.sh"

script="$URL_beginning/generate_from_template.sh"
@sha512_generate_from_template.sh@
wget_sha512 "./$subdir/generate_from_template.sh" "$script"\
  "$correct_sha512"

script="$URL_beginning/get_common_text_glob_patterns.sh"
@sha512_get_common_text_glob_patterns.sh@
wget_sha512 "./$subdir/get_common_text_glob_patterns.sh" "$script"\
  "$correct_sha512"

script="$URL_beginning/grammar_and_spell_check.sh"
@sha512_grammar_and_spell_check.sh@
wget_sha512 "./$subdir/grammar_and_spell_check.sh" "$script"\
  "$correct_sha512"

URL_beginning2="$URL_beginning/licenses_templates"
subdir2="$subdir/licenses_templates"
script="$URL_beginning2/build_licenses_templates.sh"
@sha512_build_licenses_templates.sh@
wget_sha512 "./$subdir2/build_licenses_templates.sh" "$script"\
  "$correct_sha512"
chmod +x "./$subdir2/build_licenses_templates.sh"

script="$URL_beginning2/license_file_header_GPLv3+.tpl"
@sha512_license_file_header_GPLv3+.tpl@
wget_sha512 "./$subdir2/license_file_header_GPLv3+.tpl" "$script"\
  "$correct_sha512"

script="$URL_beginning2/license_file_header_LGPLv3+.tpl"
@sha512_license_file_header_LGPLv3+.tpl@
wget_sha512 "./$subdir2/license_file_header_LGPLv3+.tpl" "$script"\
  "$correct_sha512"

script="$URL_beginning/lines_counts.sh"
@sha512_lines_counts.sh@
wget_sha512 "./$subdir/lines_counts.sh" "$script" "$correct_sha512"

script="$URL_beginning/lines_filters.sh"
@sha512_lines_filters.sh@
wget_sha512 "./$subdir/lines_filters.sh" "$script" "$correct_sha512"

script="$URL_beginning/lines_maps.sh"
@sha512_lines_maps.sh@
wget_sha512 "./$subdir/lines_maps.sh" "$script" "$correct_sha512"

URL_beginning3="$URL_beginning/listings"
subdir3="$subdir/listings"
script="$URL_beginning3/update_or_check_files_names_listing.sh"
@sha512_update_or_check_files_names_listing.sh@
wget_sha512 "./$subdir3/update_or_check_files_names_listing.sh"\
  "$script" "$correct_sha512"
chmod +x "./$subdir3/update_or_check_files_names_listing.sh"

script="$URL_beginning3/files_names_listing.txt"
@sha512_files_names_listing.txt@
wget_sha512 "./$subdir3/files_names_listing.txt" "$script"\
  "$correct_sha512"

script="$URL_beginning/overwrite_if_not_equal.sh"
@sha512_overwrite_if_not_equal.sh@
wget_sha512 "./$subdir/overwrite_if_not_equal.sh" "$script"\
  "$correct_sha512"

script="$URL_beginning/python_black_complement.sh"
@sha512_python_black_complement.sh@
wget_sha512 "./$subdir/python_black_complement.sh" "$script"\
  "$correct_sha512"

script="$URL_beginning/python_isort_complement.sh"
@sha512_python_isort_complement.sh@
wget_sha512 "./$subdir/python_isort_complement.sh" "$script"\
  "$correct_sha512"

script="$URL_beginning/too_long_code_lines.sh"
@sha512_too_long_code_lines.sh@
wget_sha512 "./$subdir/too_long_code_lines.sh" "$script"\
  "$correct_sha512"

shopt -s globstar
source "./$subdir/check_shell_scripts_beginnings.sh"
source "./$subdir/check_URLs.sh"
source "./$subdir/comparisons.sh"
source "./$subdir/generate_from_template.sh"
source "./$subdir/get_common_text_glob_patterns.sh"
source "./$subdir/lines_counts.sh"
source "./$subdir/lines_filters.sh"
source "./$subdir/overwrite_if_not_equal.sh"
source "./$subdir/python_black_complement.sh"
source "./$subdir/python_isort_complement.sh"
source "./$subdir/too_long_code_lines.sh"

cwd="."
if [[ -n "$1" ]];
then
  cwd="$1"
fi

echo "Building license headers"
./$subdir2/build_licenses_templates.sh "$cwd"

echo "Building README.md"
./$subdir/build_md_from_printable_md.sh "$cwd"

pushd .
cd "$cwd"

echo "Running isort"
isort .
python_isort_complement

echo "Running black"
black .
python_black_complement

find . -name "pyproject.toml" | relevant_find\
  | while read -r file_name;
do
  if grep -q "Typing :: Typed" "$file_name"; then
    echo "Running mypy"
    mypy $(dirname "$file_name")
  fi
done

echo "Analyzing too long lines"
too_long_code_lines | relevant_grep | not_license_grep

echo "Analyzing shell scripts beginnings"
check_shell_scripts_beginnings | relevant_grep

echo "Analyzing URLs"
check_URLs | relevant_grep

echo "Analyzing strange characters : hover over in doubt"
usual_characters="\x00-\x7Fàâéèêëîïôç©“”└─├│«»"
grep --exclude-dir '.git' -nPrv "^[$usual_characters]*$" .\
  | grep --color='auto' -nP "[^$usual_characters]"

echo "Creating the PDF file of the listing of the source code"
./build_and_checks_dependencies/create_PDF.sh

popd
