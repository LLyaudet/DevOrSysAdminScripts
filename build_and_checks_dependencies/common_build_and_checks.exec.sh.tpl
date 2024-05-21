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
# The file "common_build_and_checks.exec.sh.tpl" was renamed from
# "common_build_and_checks.sh.tpl" to
# "common_build_and_checks.exec.sh.tpl".
# The file "common_build_and_checks.exec.sh" generated from the file
# "common_build_and_checks.sh.tpl"
# or "common_build_and_checks.exec.sh.tpl"
# was renamed from
# "common_build_and_checks.sh" to "common_build_and_checks.exec.sh".

verbose=""
if [[ "$2" == "--verbose" ]]; then
  echo "$0 $*"
  verbose="--verbose"
fi

source ./wget_sha512.libr.sh

subdir="build_and_checks_dependencies"

personal_github="https://raw.githubusercontent.com/LLyaudet/"
dependencies="DevOrSysAdminScripts/main/${subdir}"
URL_beginning="${personal_github}${dependencies}"

script="${URL_beginning}/build_md_from_printable_md.exec.sh"
@sha512_build_md_from_printable_md.exec.sh@
wget_sha512 "./${subdir}/build_md_from_printable_md.exec.sh"\
  "${script}" "${correct_sha512}" "${verbose}"
chmod +x "./${subdir}/build_md_from_printable_md.exec.sh"

script="${URL_beginning}/check_shell_scripts_beginnings.libr.sh"
@sha512_check_shell_scripts_beginnings.libr.sh@
wget_sha512 "./${subdir}/check_shell_scripts_beginnings.libr.sh"\
  "${script}" "${correct_sha512}" "${verbose}"

script="${URL_beginning}/check_URLs.libr.sh"
@sha512_check_URLs.libr.sh@
wget_sha512 "./${subdir}/check_URLs.libr.sh" "${script}"\
  "${correct_sha512}" "${verbose}"

script="${URL_beginning}/comparisons.libr.sh"
@sha512_comparisons.libr.sh@
wget_sha512 "./${subdir}/comparisons.libr.sh" "${script}"\
  "${correct_sha512}" "${verbose}"

script="${URL_beginning}/create_PDF.exec.sh"
@sha512_create_PDF.exec.sh@
wget_sha512 "./${subdir}/create_PDF.exec.sh" "${script}"\
  "${correct_sha512}" "${verbose}"
chmod +x "./${subdir}/create_PDF.exec.sh"

script="${URL_beginning}/generate_from_template.libr.sh"
@sha512_generate_from_template.libr.sh@
wget_sha512 "./${subdir}/generate_from_template.libr.sh" "${script}"\
  "${correct_sha512}" "${verbose}"

script="${URL_beginning}/get_common_text_glob_patterns.libr.sh"
@sha512_get_common_text_glob_patterns.libr.sh@
wget_sha512 "./${subdir}/get_common_text_glob_patterns.libr.sh"\
  "${script}" "${correct_sha512}" "${verbose}"

script="${URL_beginning}/grammar_and_spell_check.libr.sh"
@sha512_grammar_and_spell_check.libr.sh@
wget_sha512 "./${subdir}/grammar_and_spell_check.libr.sh" "${script}"\
  "${correct_sha512}" "${verbose}"

URL_beginning2="${URL_beginning}/licenses_templates"
subdir2="${subdir}/licenses_templates"
script="${URL_beginning2}/build_licenses_templates.exec.sh"
@sha512_build_licenses_templates.exec.sh@
wget_sha512 "./${subdir2}/build_licenses_templates.exec.sh"\
  "${script}" "${correct_sha512}" "${verbose}"
chmod +x "./${subdir2}/build_licenses_templates.exec.sh"

script="${URL_beginning2}/license_file_header_GPLv3+.tpl"
@sha512_license_file_header_GPLv3+.tpl@
wget_sha512 "./${subdir2}/license_file_header_GPLv3+.tpl" "${script}"\
  "${correct_sha512}" "${verbose}"

script="${URL_beginning2}/license_file_header_LGPLv3+.tpl"
@sha512_license_file_header_LGPLv3+.tpl@
wget_sha512 "./${subdir2}/license_file_header_LGPLv3+.tpl"\
  "${script}" "${correct_sha512}" "${verbose}"

script="${URL_beginning}/lines_counts.libr.sh"
@sha512_lines_counts.libr.sh@
wget_sha512 "./${subdir}/lines_counts.libr.sh" "${script}"\
  "${correct_sha512}" "${verbose}"

script="${URL_beginning}/lines_filters.libr.sh"
@sha512_lines_filters.libr.sh@
wget_sha512 "./${subdir}/lines_filters.libr.sh" "${script}"\
  "${correct_sha512}" "${verbose}"

script="${URL_beginning}/lines_maps.libr.sh"
@sha512_lines_maps.libr.sh@
wget_sha512 "./${subdir}/lines_maps.libr.sh" "${script}"\
  "${correct_sha512}" "${verbose}"

URL_beginning3="${URL_beginning}/listings"
subdir3="${subdir}/listings"
script="${URL_beginning3}/update_or_check_files_names_listing.exec.sh"
@sha512_update_or_check_files_names_listing.exec.sh@
wget_sha512\
  "./${subdir3}/update_or_check_files_names_listing.exec.sh"\
  "${script}" "${correct_sha512}" "${verbose}"
chmod +x "./${subdir3}/update_or_check_files_names_listing.exec.sh"

script="${URL_beginning3}/files_names_listing.txt"
@sha512_files_names_listing.txt@
wget_sha512 "./${subdir3}/files_names_listing.txt" "${script}"\
  "${correct_sha512}" "${verbose}"

script="${URL_beginning}/overwrite_if_not_equal.libr.sh"
@sha512_overwrite_if_not_equal.libr.sh@
wget_sha512 "./${subdir}/overwrite_if_not_equal.libr.sh" "${script}"\
  "${correct_sha512}" "${verbose}"

script="${URL_beginning}/python_black_complement.libr.sh"
@sha512_python_black_complement.libr.sh@
wget_sha512 "./${subdir}/python_black_complement.libr.sh" "${script}"\
  "${correct_sha512}" "${verbose}"

script="${URL_beginning}/python_isort_complement.libr.sh"
@sha512_python_isort_complement.libr.sh@
wget_sha512 "./${subdir}/python_isort_complement.libr.sh" "${script}"\
  "${correct_sha512}" "${verbose}"

script="${URL_beginning}/too_long_code_lines.libr.sh"
@sha512_too_long_code_lines.libr.sh@
wget_sha512 "./${subdir}/too_long_code_lines.libr.sh" "${script}"\
  "${correct_sha512}" "${verbose}"

shopt -s globstar
source "./${subdir}/check_shell_scripts_beginnings.libr.sh"
source "./${subdir}/check_URLs.libr.sh"
source "./${subdir}/comparisons.libr.sh"
source "./${subdir}/generate_from_template.libr.sh"
source "./${subdir}/get_common_text_glob_patterns.libr.sh"
source "./${subdir}/lines_counts.libr.sh"
source "./${subdir}/lines_filters.libr.sh"
source "./${subdir}/overwrite_if_not_equal.libr.sh"
source "./${subdir}/python_black_complement.libr.sh"
source "./${subdir}/python_isort_complement.libr.sh"
source "./${subdir}/too_long_code_lines.libr.sh"

cwd="."
if [[ -n "$1" ]];
then
  cwd="$1"
fi

echo "Building license headers"
./${subdir2}/build_licenses_templates.exec.sh "${verbose}"

echo "Building README.md"
./${subdir}/build_md_from_printable_md.exec.sh "${cwd}" "README" "${verbose}"

pushd .
cd "${cwd}"

echo "Running shellcheck"
shellcheck --check-sourced --enable=all --external-sources **/*.sh

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
./${subdir}/create_PDF.exec.sh "${verbose}"

popd
