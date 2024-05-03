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
# If not, see <http://www.gnu.org/licenses/>.
#
# ©Copyright 2023-2024 Laurent Lyaudet

shopt -s globstar
source ./too_long_code_lines.sh
source ./check_shell_scripts_beginning.sh

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

# echo "Running isort"
# isort .

# echo "Running black"
# black .

# It was rejected to enhance black with this currently.
# And moreover, at some point, I saw the reverse rule
# in black or pylint to add an empty line...
# This regexp may give false positives,
# but that's not the end of the world.
echo "Checking empty lines after Python function docstrings"
pcregrep -M $'def [^"]*"""([^"]|"(?!""))*"""\n\n' **/*.py

# echo "Running pylint"
# pylint .

# echo "Running mypy"
# mypy .

echo "Analyzing too long lines"
too_long_code_lines

echo "Analyzing shell scripts beginning"
check_shell_scripts_beginning

popd
