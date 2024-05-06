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

current_path=$(pwd)
main_directory=$(basename "$current_path")

in_place_grep(){
  grep $@ > "${!#}"".temp_in_place_grep"
  mv "${!#}"".temp_in_place_grep" "${!#}"
}

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

empty_lines_after_filename(){
  grep '^[^:]\+:$'
}

not_empty_lines_after_filename(){
  grep -v '^[^:]\+:$'
}

space_starting_lines_after_filename(){
  grep '^[^:]\+: '
}

not_space_starting_lines_after_filename(){
  grep '^[^:]\+:[^ ]'
}

not_JS_dependencies_find(){
  grep -vE "(^|/)node_modules/" | grep -vE "(^|/)package-lock\.json$"
}

not_JS_dependencies_grep(){
  grep -v "^[^:]*node_modules/" | grep -v "^[^:]*package-lock\.json:"
}

not_dependencies_find(){
  not_JS_dependencies_find
}

not_dependencies_grep(){
  not_JS_dependencies_grep
}

not_python_cache_find(){
  grep -vE "(^|/)__pycache__/" | grep -vE "(^|/)\.mypy_cache/"
}

not_python_cache_grep(){
  grep -v "^[^:]*__pycache__/" | grep -v "^[^:]*\.mypy_cache/"
}

not_cache_find(){
  not_python_cache_find
}

not_cache_grep(){
  not_python_cache_grep
}

not_git_find(){
  grep -vE "(^|/)\.git/"
}

not_git_grep(){
  grep -v "^[^:]*\.git/"
}

not_archive_find(){
  grep -vE "(\.gz|\.rar|\.tar|\.tgz|\.whl)$"
}

not_archive_grep(){
  grep -vE "^[^:]*(\.gz|\.rar|\.tar|\.tgz|\.whl):"
}

not_license_find(){
  grep -vE "(^|/)COPYING$" | grep -vE "(^|/)COPYING\.LESSER$"
}

not_license_grep(){
  grep -v "^[^:]*COPYING:" | grep -v "^[^:]*COPYING\.LESSER:"
}

not_main_tex_find(){
  grep -vE "(^|/)$main_directory\.tex$"
}

not_main_tex_grep(){
  grep -v "^[^:]*$main_directory\.tex:"
}

relevant_find(){
  not_dependencies_find | not_cache_find | not_git_find\
  | not_archive_find
}

relevant_grep(){
  not_dependencies_grep | not_cache_grep | not_git_grep\
  | not_archive_grep
}
