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

too_long_code_lines() {
  grep -r -H '.\{71\}' -- **/*.c
  grep -r -H '.\{71\}' -- **/*.css
  grep -r -H '.\{71\}' -- **/*.h
  grep -r -H '.\{71\}' -- **/*.htm
  grep -r -H '.\{71\}' -- **/*.html
  grep -r -H '.\{71\}' -- **/*.js
  grep -r -H '.\{71\}' -- **/*.json
  grep -r -H '.\{71\}' -- **/*.md
  grep -r -H '.\{71\}' -- **/*.php
  grep -r -H '.\{71\}' -- **/*.py
  grep -r -H '.\{71\}' -- **/*.sql
  grep -r -H '.\{71\}' -- **/*.tex
  grep -r -H '.\{71\}' -- **/*.toml
  grep -r -H '.\{71\}' -- **/*.ts
  grep -r -H '.\{71\}' -- **/*.txt
  grep -r -H '.\{71\}' -- **/*.yml
  grep -r -H '.\{71\}' -- **/COPYING
  grep -r -H '.\{71\}' -- **/COPYING.LESSER
}

