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

sed_expression='s/(\[[a-zA-Z0-9:-]*\]: [^\n\\]*)\\\n/\1/Mg'
sed_expression+=';s/(<http[^\n\\]*)\\\n/\1/Mg'
sed_expression+=';s/(- <http[^\n\\]*)\\\n/\1/Mg'

pushd .
if [[ -n "$1" ]];
then
  cd "$1"
fi

if [[ -n "$2" ]];
then
  filename="$2"
else
  filename="README"
fi

if [[ -f "${filename}.md.tpl" ]];
then
  sed -Ez "$sed_expression" "${filename}.md.tpl"\
    > "${filename}_temp1.md"
  sed -Ez "$sed_expression" "${filename}_temp1.md"\
    > "${filename}_temp2.md"
  sed -Ez "$sed_expression" "${filename}_temp2.md"\
    > "${filename}_temp3.md"
  sed -Ez "$sed_expression" "${filename}_temp3.md"\
    > "${filename}.md"
  rm "${filename}_temp1.md" "${filename}_temp2.md"\
    "${filename}_temp3.md"
else
  echo "No file ${filename}.md.tpl"
fi

popd
