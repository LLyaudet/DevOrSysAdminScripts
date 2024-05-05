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
correct_sha512='4ac0c1dc4f99008280436fe2e2d5a0f8832f4775d9c4765023d9d'
correct_sha512+='519826d5a2b115c4fa619ffb5e28a7e1e8aeb57cc2c5a691d2ba'
correct_sha512+='b8ceb64e92a5d7c07f32ea2'
wget_sha512 "./$subdir/check_URLs.sh" "$script" "$correct_sha512"

script="$URL_beginning/create_PDF.sh"
correct_sha512='89c777a74b531f9cc6228761da65e83d931b7981d0dc599c982a2'
correct_sha512+='c59bd5fc85c356639b5ca43df06482ef64bc21a12bc214c5e58a'
correct_sha512+='09c52db7fcd0b33b90ff93d'
wget_sha512 "./$subdir/create_PDF.sh" "$script" "$correct_sha512"
chmod +x "./$subdir/create_PDF.sh"

script="$URL_beginning/get_common_text_glob_patterns.sh"
correct_sha512='5971e48d543a93c5c14129ea05c31795911a3f17931c883a04518'
correct_sha512+='ac610b65900d6d578626125a2f1d9c1d3cc20d9792e49bff0d8f'
correct_sha512+='6da0c4f59c140b29e539c80'
wget_sha512 "./$subdir/get_common_text_glob_patterns.sh" "$script"\
  "$correct_sha512"

script="$URL_beginning/lines_counts.sh"
correct_sha512='436dee29e612a55519e4a760910c6e679a43c6caec12847f04fb6'
correct_sha512+='c9fd4e786e328ad0bf4f5cb9aec7057362bedd4cb5aea6a75c51'
correct_sha512+='9bc057ec3486ce0259de6d8'
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
correct_sha512='9818f1b00dd4930cc897eb7c3a95c4da2d541e01453147b853a51'
correct_sha512+='09322bdd245384d43b6e39657dd6fc3f44a7c35dd0e81e655db8'
correct_sha512+='751f490656062191f7243ae'
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
