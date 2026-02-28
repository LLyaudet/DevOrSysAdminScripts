#!/usr/bin/env bash
# This file is part of DevOrSysAdminScripts library.
#
# DevOrSysAdminScripts is free software:
# you can redistribute it and/or modify it under the terms
# of the GNU General Public License
# as published by the Free Software Foundation,
# either version 3 of the License,
# or (at your option) any later version.
#
# DevOrSysAdminScripts is distributed in the hope
# that it will be useful,
# but WITHOUT ANY WARRANTY;
# without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.
#
# You should have received a copy of
# the GNU General Public License
# along with DevOrSysAdminScripts.
# If not, see <https://www.gnu.org/licenses/>.
#
# ©Copyright 2023-2026 Laurent Frédéric Bernard François Lyaudet
# This file was renamed from "python_black_complement.sh"
# to "python_black_complement.libr.sh".

# It was rejected to enhance black with this currently.
# https://github.com/psf/black/issues/2370
# And moreover, at some point, I saw the reverse rule
# in black or pylint to add an empty line...
# This regexp may give false positives,
# but that's not the end of the world.
check_no_empty_line_after_python_function_docstring(){
  echo "Checking empty lines after Python function docstrings"
  pcre2grep -M --\
    $'def ([^"]|"(?!""))*"""([^"]|"(?!""))*"""\n\n(?!\s*def)'\
    **/*.py
}

python_black_complement(){
  check_no_empty_line_after_python_function_docstring
}
