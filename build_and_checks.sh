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

shopt -s globstar
source ./get_common_text_glob_patterns.sh
source ./too_long_code_lines.sh
source ./check_shell_scripts_beginning.sh
source ./check_URLs.sh
source ./python_black_complement.sh

cwd="."
if [[ -n "$1" ]];
then
  cwd="$1"
fi

echo "Building README.md"
chmod +x ./build_readme.sh
./build_readme.sh "$cwd"

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
too_long_code_lines

echo "Analyzing shell scripts beginning"
check_shell_scripts_beginning

echo "Analyzing URLs"
check_URLs

popd
