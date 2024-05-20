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

verbose=""
if [[ "$2" == "--verbose" ]]; then
  echo "$0 $*"
  verbose="--verbose"
fi

source ./wget_sha512.sh

mkdir -p build_and_checks_dependencies/licenses_templates
mkdir -p build_and_checks_dependencies/listings
subdir="build_and_checks_dependencies"

personal_github="https://raw.githubusercontent.com/LLyaudet/"
dependencies="DevOrSysAdminScripts/main/build_and_checks_dependencies"
URL_beginning="$personal_github$dependencies"

script="$URL_beginning/common_build_and_checks.sh"
correct_sha512='4737989615503facb5ad4885fc690a8d14ce8f44e8a921a05d599'
correct_sha512+='c5236bf344c98de7bd0339f1b2aa590a3352370fb0870650b6c0'
correct_sha512+='c7222844f7dcfb99463ff2d'
wget_sha512 "./$subdir/common_build_and_checks.sh" "$script"\
  "$correct_sha512" "$verbose"
chmod +x "./$subdir/common_build_and_checks.sh"

cwd="."
if [[ -n "$1" ]];
then
  cwd="$1"
fi

./build_and_checks_dependencies/common_build_and_checks.sh "$cwd"\
  "$verbose"
