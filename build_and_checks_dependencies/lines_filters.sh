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

# The goal of ths file is to have some common line filters
# for bash processing and pipes.
# As is the case for other .sh files in this repository,
# it can be copied somewhere in your home directory
# and sourced in your .bashrc.

empty_lines(){
  grep '^$'
}

not_empty_lines(){
  grep -v '^$'
}

space_starting_lines(){
  grep '^[ ]'
}

not_space_starting_lines(){
  grep '^[^ ]'
}

not_JS_dependencies(){
  grep -v "^[^:]*node_modules/" | grep -v "^[^:]*package-lock.json"
}

not_dependencies(){
  not_JS_dependencies
}
