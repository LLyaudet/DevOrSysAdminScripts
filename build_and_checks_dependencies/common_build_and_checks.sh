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

source ./wget_sha512.sh

personal_github="https://raw.githubusercontent.com/LLyaudet/"
dependencies="DevOrSysAdminScripts/main/build_and_checks_dependencies"
URL_beginning="$personal_github$dependencies"

subdir="build_and_checks_dependencies"

script="$URL_beginning/build_md_from_printable_md.sh"
correct_sha512='aecf84a848a66e22367968b80cf250784d0c85b6bd9bad2fcf75b'
correct_sha512+='98aa77a250c8a74f81ae9c61687d47e29c8712614a4fe44027a9'
correct_sha512+='32224a7d04c2388084cbe25'
wget_sha512 "./$subdir/build_md_from_printable_md.sh" "$script"\
  "$correct_sha512"
chmod +x "./$subdir/build_md_from_printable_md.sh"

script="$URL_beginning/check_shell_scripts_beginning.sh"
correct_sha512='faf7fe1c59b177d0f74afee6e8fb94e14bf7041b74a36afc41d6d'
correct_sha512+='e71b6325af1d42f5c816024d311751d6e40c197c52ac97188c9c'
correct_sha512+='e75ea4937b966d2b0ff4ac7'
wget_sha512 "./$subdir/check_shell_scripts_beginning.sh" "$script"\
  "$correct_sha512"

script="$URL_beginning/check_URLs.sh"
correct_sha512='bc790a05ce8e6b9241c3c32a0d6f2efb7c96447cf1fd095301ab4'
correct_sha512+='6ed20f739a071d8a8c0a88bcaf189bdcbc9f3ad05d5b5e888805'
correct_sha512+='ed0bf0333b229f49e62a613'
wget_sha512 "./$subdir/check_URLs.sh" "$script" "$correct_sha512"

script="$URL_beginning/create_PDF.sh"
correct_sha512='0e5228fd6e6568b259d75ed00fe4a0336e3475b52609febc1df2e'
correct_sha512+='c44f91b3c1ddb3d95515520792d455b1b659d6ffe77f5ca10a51'
correct_sha512+='f53296cd58ceec0535f790d'
wget_sha512 "./$subdir/create_PDF.sh" "$script" "$correct_sha512"
chmod +x "./$subdir/create_PDF.sh"

script="$URL_beginning/get_common_text_glob_patterns.sh"
correct_sha512='5f675b7ed8713bc87cb032773edcddb1da75e718dc6048720e1c7'
correct_sha512+='fd4bdf9b6f0d0a0d2faf657679e9c88617163602acea6f653de8'
correct_sha512+='6656088ba2226706f0af6f1'
wget_sha512 "./$subdir/get_common_text_glob_patterns.sh" "$script"\
  "$correct_sha512"

script="$URL_beginning/lines_counts.sh"
correct_sha512='208648e8838acccb2edaf3f8f93c2ab38a84658074ab99cbffe89'
correct_sha512+='561dfcffd7fd546c50c0aad3afed305b148d4e483c7ec02c926d'
correct_sha512+='8b2ffdb2ac893b2eabdcab9'
wget_sha512 "./$subdir/lines_counts.sh" "$script" "$correct_sha512"

script="$URL_beginning/lines_filters.sh"
correct_sha512='587931f51fa2c6755a8bdaae13048bd5634e0c76f0aab985ef2b2'
correct_sha512+='8bfa4b03a30d526bc356d6e5e2eae0d24401c468bcc80db8366d'
correct_sha512+='3798486934a28701c78c441'
wget_sha512 "./$subdir/lines_filters.sh" "$script" "$correct_sha512"

script="$URL_beginning/python_black_complement.sh"
correct_sha512='909ab2453a3448b45e92c60df216d86578528d5151bc8c5efb50b'
correct_sha512+='c8c4007d4c34adc7b2d583f3f5d9629cf37f163c813aebc3dec2'
correct_sha512+='ce6370fcf1bdbea5820ab13'
wget_sha512 "./$subdir/python_black_complement.sh" "$script"\
  "$correct_sha512"

script="$URL_beginning/too_long_code_lines.sh"
correct_sha512='94e209899adc7a8a165e08590a294fc29b8006900cb7eafc9bf95'
correct_sha512+='6ac9e2f659c6dccf1a55ffb4af1ce08743bf05ff6dc7e5768868'
correct_sha512+='78eddfe56243972cecf4352'
wget_sha512 "./$subdir/too_long_code_lines.sh" "$script"\
  "$correct_sha512"

shopt -s globstar
source "./$subdir/check_shell_scripts_beginning.sh"
source "./$subdir/check_URLs.sh"
source "./$subdir/get_common_text_glob_patterns.sh"
source "./$subdir/lines_counts.sh"
source "./$subdir/lines_filters.sh"
source "./$subdir/python_black_complement.sh"
source "./$subdir/too_long_code_lines.sh"

cwd="."
if [[ -n "$1" ]];
then
  cwd="$1"
fi

echo "Building README.md"
./build_and_checks_dependencies/build_md_from_printable_md.sh "$cwd"

pushd .
cd "$cwd"

echo "Running isort"
isort .

echo "Running black"
black .
python_black_complement

echo "Running mypy"
mypy .

echo "Analyzing too long lines"
too_long_code_lines | relevant_grep

echo "Analyzing shell scripts beginning"
check_shell_scripts_beginning | relevant_grep

echo "Analyzing URLs"
check_URLs | relevant_grep

echo "Creating the PDF file of the listing of the source code"
./build_and_checks_dependencies/create_PDF.sh

popd
