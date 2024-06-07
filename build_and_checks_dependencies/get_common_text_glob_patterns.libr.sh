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
# This file was renamed from "get_common_text_glob_patterns.sh"
# to "get_common_text_glob_patterns.libr.sh".

get_COMMON_TEXT_PATHS_GLOB_PATTERNS(){
  # shellcheck disable=SC2034
  declare -gr COMMON_TEXT_PATHS_GLOB_PATTERNS=(\
    '**/*.c'\
    '**/*.css'\
    '**/*.h'\
    '**/*.htm'\
    '**/*.html'\
    '**/*.js'\
    '**/*.json'\
    '**/*.md'\
    '**/*.php'\
    '**/*.py'\
    '**/*.sh'\
    '**/*.sql'\
    '**/*.tex'\
    '**/*.toml'\
    '**/*.tpl'\
    '**/*.ts'\
    '**/*.txt'\
    '**/*.yml'\
    '**/COPYING'\
    '**/COPYING.LESSER'\
    '**/pre-commit'\
    '**/.gitignore'\
    '**/py.typed'\
  )
}


get_COMMON_TEXT_FILES_GLOB_PATTERNS(){
  # shellcheck disable=SC2034
  declare -gr COMMON_TEXT_FILES_GLOB_PATTERNS=(\
    '*.c'\
    '*.css'\
    '*.h'\
    '*.htm'\
    '*.html'\
    '*.js'\
    '*.json'\
    '*.md'\
    '*.php'\
    '*.py'\
    '*.sh'\
    '*.sql'\
    '*.tex'\
    '*.toml'\
    '*.tpl'\
    '*.ts'\
    '*.txt'\
    '*.yml'\
    'COPYING'\
    'COPYING.LESSER'\
    'pre-commit'\
    '.gitignore'\
    'py.typed'\
  )
}
