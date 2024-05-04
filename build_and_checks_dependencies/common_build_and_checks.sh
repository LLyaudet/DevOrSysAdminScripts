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
correct_sha512='5c702028ab69fc9668d1d1db5bd2ad09eac0ab1cf749463d34387'
correct_sha512+='b87c1db9148f52e5f645407a810d96f2b02c49cd4ed0780eaecf'
correct_sha512+='7e94d2f65671ca634319523'
wget_sha512 "./$subdir/check_URLs.sh" "$script" "$correct_sha512"

script="$URL_beginning/create_PDF.sh"
correct_sha512='111e421e4a316c80543f099928f3d324cab2c593e848bce4310c1'
correct_sha512+='d0c16e668d1d53e7cc754c1e22a2609dc4bc771bec1891402426'
correct_sha512+='392add7d75b3bf1d9cf6c96'
wget_sha512 "./$subdir/create_PDF.sh" "$script" "$correct_sha512"
chmod +x "./$subdir/create_PDF.sh"

script="$URL_beginning/get_common_text_glob_patterns.sh"
correct_sha512='01ebe343563e729f4db880c4ce4bfb2a6c10c8daa4cfde80ee535'
correct_sha512+='1a81f29f99c54cc6ebad003855e86cc4436a4591a5050ef79fdf'
correct_sha512+='93abe52268d4421748e5b27'
wget_sha512 "./$subdir/get_common_text_glob_patterns.sh" "$script"\
  "$correct_sha512"

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

./build_and_checks_dependencies/create_PDF.sh

popd
