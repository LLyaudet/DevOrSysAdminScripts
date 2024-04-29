#!/bin/bash
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

sed_expression='s/(\[[a-zA-Z0-9:-]*\]: [^\n\\]*)\\\n/\1/Mg'
sed_expression+=';s/(<http[^\n\\]*)\\\n/\1/Mg'
sed_expression+=';s/(- <http[^\n\\]*)\\\n/\1/Mg'

pushd .
if [[ -v "$1" ]];
then
  cd $1
fi

sed -Ez "$sed_expression" README_printable.md > README_temp1.md
sed -Ez "$sed_expression" README_temp1.md > README_temp2.md
sed -Ez "$sed_expression" README_temp2.md > README_temp3.md
sed -Ez "$sed_expression" README_temp3.md > README.md
rm README_temp1.md README_temp2.md README_temp3.md

popd
