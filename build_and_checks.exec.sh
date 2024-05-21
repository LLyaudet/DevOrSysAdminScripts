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
# The file "build_and_checks.exec.sh.tpl" was renamed from
# "build_and_checks.sh.tpl" to "build_and_checks.exec.sh.tpl".
# The file "build_and_checks.exec.sh" generated from the file
# "build_and_checks.sh.tpl" or "build_and_checks.exec.sh.tpl"
# was renamed from
# "build_and_checks.sh" to "build_and_checks.exec.sh".

verbose=""
if [[ "$2" == "--verbose" ]]; then
  echo "$0 $*"
  verbose="--verbose"
fi

source ./wget_sha512.libr.sh

mkdir -p build_and_checks_dependencies/licenses_templates
mkdir -p build_and_checks_dependencies/listings
subdir="build_and_checks_dependencies"

personal_github="https://raw.githubusercontent.com/LLyaudet/"
dependencies="DevOrSysAdminScripts/main/${subdir}"
URL_beginning="${personal_github}${dependencies}"

common_file_name="common_build_and_checks.exec.sh"
script="${URL_beginning}/${common_file_name}"
correct_sha512='b30bb1a4435f1fb50273274558cfce91bb5480bf9eda539760842'
correct_sha512+='55908bdba84b96e524f9671c4c7263ede86d2807aef20efa1c2a'
correct_sha512+='d96fb5101909a1bd31a43b2'
wget_sha512 "./$subdir/${common_file_name}" "$script"\
  "$correct_sha512" "$verbose"
chmod +x "./$subdir/${common_file_name}"

cwd="."
if [[ -n "$1" ]];
then
  cwd="$1"
fi

./build_and_checks_dependencies/${common_file_name} "$cwd" "$verbose"
