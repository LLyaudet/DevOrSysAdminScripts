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
correct_sha512='aa052d684b542929e9bc1a7c0768ea424cebbb5df3db01f103afd'
correct_sha512+='620abd35f2f2ad2ff5f7ff18644d84ad8051a00cc8c3205d5951'
correct_sha512+='d3aec6d8c14a0183c49b0b9'
wget_sha512 "./$subdir/check_URLs.sh" "$script" "$correct_sha512"

script="$URL_beginning/create_PDF.sh"
correct_sha512='09dd5992de55dcdedd3e024546fd653c7ce6389d889ee17ddff9d'
correct_sha512+='16b3ad0fddefe836f11693b1704ff52e1cf00cbd090d2d504b7c'
correct_sha512+='35af31a49281e9ea51d5d15'
wget_sha512 "./$subdir/create_PDF.sh" "$script" "$correct_sha512"
chmod +x "./$subdir/create_PDF.sh"

script="$URL_beginning/get_common_text_glob_patterns.sh"
correct_sha512='0c131dd3afa78d9875e0ef5ee0683ccf58d58b0077f7fc728f9fe'
correct_sha512+='77fee52e70963b50963ef0dd4b0fb14277eaca308abef04aeb8c'
correct_sha512+='56b6493fe4f16d597403039'
wget_sha512 "./$subdir/get_common_text_glob_patterns.sh" "$script"\
  "$correct_sha512"

script="$URL_beginning/lines_counts.sh"
correct_sha512='85549707a7152d578caca30f84f2f6b6e6f57d8f26df2ab83e834'
correct_sha512+='e62d7f57019fc24f3363ef031b880c65c255d9dabe976dc7a416'
correct_sha512+='cccde75d1b73af652bd51ca'
wget_sha512 "./$subdir/lines_counts.sh" "$script" "$correct_sha512"

script="$URL_beginning/lines_filters.sh"
correct_sha512='b102cc7b29b7bc590c8090f13d1a3397f893a13bd0c4d894ce0fa'
correct_sha512+='b4c44be6b2c01c01c6e1787288ccf7fed75027192dc057bebfdd'
correct_sha512+='ac0ae13c76196f492c88ad8'
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
correct_sha512='4d4728b3fc530281680dfa836fe396e5ad3ea0df15e3c0ce4809b'
correct_sha512+='98c8e009de5862de42deb63128117516a0d9e0687e0e7bd6a7d8'
correct_sha512+='5daabeda07320b49e443b46'
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
too_long_code_lines | relevant_grep | not_license_grep

echo "Analyzing shell scripts beginning"
check_shell_scripts_beginning | relevant_grep

echo "Analyzing URLs"
check_URLs | relevant_grep

echo "Creating the PDF file of the listing of the source code"
./build_and_checks_dependencies/create_PDF.sh

popd
