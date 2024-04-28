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

sed -Ez -e 's/(\[[a-zA-Z0-9:-]*\]: [^\n\\]*)\\\n/\1/Mg'\
  -e 's/(\[[a-zA-Z0-9:-]*\]: [^\n\\]*)\\\n/\1/Mg'\
  -e 's/(<http[^\n\\]*)\\\n/\1/Mg'\
  -e 's/(<http[^\n\\]*)\\\n/\1/Mg'\
  -e 's/(- <http[^\n\\]*)\\\n/\1/Mg'\
  -e 's/(- <http[^\n\\]*)\\\n/\1/Mg'\
  README_printable.md > README.md

