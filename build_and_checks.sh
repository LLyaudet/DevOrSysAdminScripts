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

mkdir -p build_and_checks_dependencies
subdir="build_and_checks_dependencies"

personal_github="https://raw.githubusercontent.com/LLyaudet/"
dependencies="DevOrSysAdminScripts/main/build_and_checks_dependencies"
URL_beginning="$personal_github$dependencies"

script="$URL_beginning/common_build_and_checks.sh"
correct_sha512='64ce0c0cc3e1d42c59c625298419e8467c9dc7a1a7116d0e6337b'
correct_sha512+='cf5c6cbe1c83ec56327ac609b62e4226ce77104b8e306142ced5'
correct_sha512+='a07a30e3aaff490b0fd967f'
wget_sha512 "./$subdir/common_build_and_checks.sh" "$script"\
  "$correct_sha512"
chmod +x "./$subdir/common_build_and_checks.sh"

cwd="."
if [[ -n "$1" ]];
then
  cwd="$1"
fi

./build_and_checks_dependencies/common_build_and_checks.sh "$cwd"
