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
correct_sha512='939544fb24512401ad0d0e77da5131e5ee470005d6c8ce68ee167'
correct_sha512+='0cd225c0fa6a82623cce3b854d89b9e23b93b47cd3e4dbddf44d'
correct_sha512+='ed58f907e63f024f2882bc7'
wget_sha512 "./$subdir/common_build_and_checks.sh" "$script"\
  "$correct_sha512"
chmod +x "./$subdir/common_build_and_checks.sh"

cwd="."
if [[ -n "$1" ]];
then
  cwd="$1"
fi

./build_and_checks_dependencies/common_build_and_checks.sh "$cwd"
