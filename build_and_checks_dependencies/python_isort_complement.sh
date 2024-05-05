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

subdir="build_and_checks_dependencies"
source "./$subdir/lines_filters.sh"

check_collections_abc_place(){
  echo "Checking import of _collections_abc is at the right place"
  find . -name "*.py" | relevant_find | while read -r filename; do
    [ -f "$filename" ] || continue
    sed -i -Ez 's/\n(\nfrom _collections_abc[^\n]*)/\1\n/Mg'\
      "$filename"
  done
}

python_isort_complement(){
  check_collections_abc_place
}
