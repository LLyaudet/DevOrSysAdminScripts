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
correct_sha512='3cf3e99822eb37f7ce286a8fedc5e5193b5153e8413d77d8feafc'
correct_sha512+='62a8123e00839b8521b2918a3cdb297acabf7cc3a63df899186f'
correct_sha512+='d4a3de7fdc8080abbcbc874'
wget_sha512 "./$subdir/check_URLs.sh" "$script" "$correct_sha512"

script="$URL_beginning/create_PDF.sh"
correct_sha512='45d1e73d74e12a6ac5bd6c7a3623e6d00233999e39f931f13824f'
correct_sha512+='fae62871537c30142a55322a9fe80ad8c4af589d2a5e4527f840'
correct_sha512+='8a2ae03500f29e5e85ca3b0'
wget_sha512 "./$subdir/create_PDF.sh" "$script" "$correct_sha512"
chmod +x "./$subdir/create_PDF.sh"

script="$URL_beginning/get_common_text_glob_patterns.sh"
correct_sha512='5f675b7ed8713bc87cb032773edcddb1da75e718dc6048720e1c7'
correct_sha512+='fd4bdf9b6f0d0a0d2faf657679e9c88617163602acea6f653de8'
correct_sha512+='6656088ba2226706f0af6f1'
wget_sha512 "./$subdir/get_common_text_glob_patterns.sh" "$script"\
  "$correct_sha512"

script="$URL_beginning/lines_counts.sh"
correct_sha512='55be85ff3b92919b80e06cb20aa25807eb1c8f8f5733a3251c401'
correct_sha512+='67ab3f35a52fdae6a31790401d216aa7eb70f77eafeae7c1fd50'
correct_sha512+='5920a486991b39516b73dd7'
wget_sha512 "./$subdir/lines_counts.sh" "$script" "$correct_sha512"

script="$URL_beginning/lines_filters.sh"
correct_sha512='b476606ae910ac521064ffa4930218bd9c9a09c446575ded78ed7'
correct_sha512+='8eea2e2ea576f7b945e2ab56f0c9ef723b6e785b9c9db62e8211'
correct_sha512+='98908fd97fc31433860e996'
wget_sha512 "./$subdir/lines_filters.sh" "$script" "$correct_sha512"

script="$URL_beginning/python_black_complement.sh"
correct_sha512='909ab2453a3448b45e92c60df216d86578528d5151bc8c5efb50b'
correct_sha512+='c8c4007d4c34adc7b2d583f3f5d9629cf37f163c813aebc3dec2'
correct_sha512+='ce6370fcf1bdbea5820ab13'
wget_sha512 "./$subdir/python_black_complement.sh" "$script"\
  "$correct_sha512"

script="$URL_beginning/python_isort_complement.sh"
correct_sha512='b3bf56acdc42371ed60762d48ba8412acf3f7a250b277683696d2'
correct_sha512+='6ac55c21b42d1070aabbbfa200883f7c69e2b0e3ef516862e4ad'
correct_sha512+='25401b7a12da96169758e90'
wget_sha512 "./$subdir/python_isort_complement.sh" "$script"\
  "$correct_sha512"

script="$URL_beginning/too_long_code_lines.sh"
correct_sha512='5455b0497a8ad17d3c327c788bd3e43899758ec789f22880a2475'
correct_sha512+='295c84ffa230e1321747d64089f933b1aff23d5ca2f78731e229'
correct_sha512+='7dd466c5477a13b0b4791c7'
wget_sha512 "./$subdir/too_long_code_lines.sh" "$script"\
  "$correct_sha512"

shopt -s globstar
source "./$subdir/check_shell_scripts_beginning.sh"
source "./$subdir/check_URLs.sh"
source "./$subdir/get_common_text_glob_patterns.sh"
source "./$subdir/lines_counts.sh"
source "./$subdir/lines_filters.sh"
source "./$subdir/python_black_complement.sh"
source "./$subdir/python_isort_complement.sh"
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
python_isort_complement

echo "Running black"
black .
python_black_complement

find . -name "pyproject.toml" | relevant_find\
  | while read -r filename;
do
  if grep -q "Typing :: Typed" "$filename"; then
    echo "Running mypy"
    mypy $(dirname "$filename")
  fi
done

echo "Analyzing too long lines"
too_long_code_lines | relevant_grep

echo "Analyzing shell scripts beginning"
check_shell_scripts_beginning | relevant_grep

echo "Analyzing URLs"
check_URLs | relevant_grep

echo "Creating the PDF file of the listing of the source code"
./build_and_checks_dependencies/create_PDF.sh

popd
