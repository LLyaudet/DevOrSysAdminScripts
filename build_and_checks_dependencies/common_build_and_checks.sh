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

script="$URL_beginning/build_readme.sh"
correct_sha512='a60224c89e6dd94360057bba41ba30b83b4b84c11679a779e3f46'
correct_sha512+='f4187fe5ae65b970c1cc5e5ce15bd39f0fe8c589abd153d4c57a'
correct_sha512+='3277c209303d0de9926b234'
wget_sha512 "./$subdir/build_readme.sh" "$script" "$correct_sha512"
chmod +x "./$subdir/build_readme.sh"

script="$URL_beginning/check_shell_scripts_beginning.sh"
correct_sha512='faf7fe1c59b177d0f74afee6e8fb94e14bf7041b74a36afc41d6d'
correct_sha512+='e71b6325af1d42f5c816024d311751d6e40c197c52ac97188c9c'
correct_sha512+='e75ea4937b966d2b0ff4ac7'
wget_sha512 "./$subdir/check_shell_scripts_beginning.sh" "$script"\
  "$correct_sha512"

script="$URL_beginning/check_URLs.sh"
correct_sha512='3c14d383328f03c98d2efcd1d38e9f191bd1651c7e324de4357b7'
correct_sha512+='a223cf38ed6e848ba11476f88584726b78411870ff243a26a520'
correct_sha512+='a6d8041d2c35aa38dfc5e65'
wget_sha512 "./$subdir/check_URLs.sh" "$script" "$correct_sha512"

script="$URL_beginning/get_common_text_glob_patterns.sh"
correct_sha512='0148af9ef6f559f2f8c1eea0eec3eef6ecabdc3eb395427adf5ef'
correct_sha512+='0d89a4a357b88b9c923659b55b8c4c21c75c5030ec5d76cd248b'
correct_sha512+='e6e3de9ec903146c81ec816'
wget_sha512 "./$subdir/get_common_text_glob_patterns.sh" "$script"\
  "$correct_sha512"

script="$URL_beginning/python_black_complement.sh"
correct_sha512='909ab2453a3448b45e92c60df216d86578528d5151bc8c5efb50b'
correct_sha512+='c8c4007d4c34adc7b2d583f3f5d9629cf37f163c813aebc3dec2'
correct_sha512+='ce6370fcf1bdbea5820ab13'
wget_sha512 "./$subdir/python_black_complement.sh" "$script"\
  "$correct_sha512"

script="$URL_beginning/too_long_code_lines.sh"
correct_sha512='7e613c8c3da4ad617c494fed60c22b08980f2c8b31939d2a67078'
correct_sha512+='73e7312d0ca585e67364d6a459c6f724612328d0f70f2fda2840'
correct_sha512+='c510be19fa699bdfda472a4'
wget_sha512 "./$subdir/too_long_code_lines.sh" "$script"\
  "$correct_sha512"

shopt -s globstar
source "./$subdir/check_shell_scripts_beginning.sh"
source "./$subdir/check_URLs.sh"
source "./$subdir/get_common_text_glob_patterns.sh"
source "./$subdir//python_black_complement.sh"
source "./$subdir/too_long_code_lines.sh"

cwd="."
if [[ -n "$1" ]];
then
  cwd="$1"
fi

echo "Building README.md"
./build_and_checks_dependencies/build_readme.sh "$cwd"

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
too_long_code_lines | grep -v "node_modules/"\
  | grep -v "package-lock.json"

echo "Analyzing shell scripts beginning"
check_shell_scripts_beginning | grep -v "node_modules/"\
  | grep -v "package-lock.json"

echo "Analyzing URLs"
check_URLs | grep -v "node_modules/"\
  | grep -v "package-lock.json"

popd
