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
# This file was renamed from "build_md_from_printable_md.sh"
# to "build_md_from_printable_md.exec.sh".

verbose=""
if [[ "$3" == "--verbose" ]]; then
  echo "$0 $*"
  verbose="--verbose"
fi

subdir="build_and_checks_dependencies"
source "./$subdir/overwrite_if_not_equal.libr.sh"

sed_expression='s/(\[[a-zA-Z0-9:-]*\]: [^\n\\]*)\\\n/\1/Mg'
sed_expression+=';s/(<http[^\n\\]*)\\\n/\1/Mg'
sed_expression+=';s/(- <http[^\n\\]*)\\\n/\1/Mg'

pushd .
if [[ -n "$1" ]];
then
  cd "$1"
fi

file_name="README"
if [[ -n "$2" ]];
then
  file_name="$2"
fi

if [[ -f "${file_name}.md.tpl" ]];
then
  sed -Ez "$sed_expression" "${file_name}.md.tpl"\
    > "${file_name}_temp1.md"
  sed -Ez "$sed_expression" "${file_name}_temp1.md"\
    > "${file_name}_temp2.md"
  sed -Ez "$sed_expression" "${file_name}_temp2.md"\
    > "${file_name}_temp3.md"
  sed -Ez "$sed_expression" "${file_name}_temp3.md"\
    > "${file_name}_temp4.md"
  overwrite_if_not_equal "${file_name}.md" "${file_name}_temp4.md"
  rm "${file_name}_temp1.md" "${file_name}_temp2.md"\
    "${file_name}_temp3.md"
else
  echo "No file ${file_name}.md.tpl"
fi

popd
