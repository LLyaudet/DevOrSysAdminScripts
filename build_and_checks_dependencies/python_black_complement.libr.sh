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
  # Options:
  #   --verbose
  #   --root-directory=""
  local LFBFL_arg

  declare -i LFBFL_verbose=0
  if [[ "$*" == *--verbose* ]]; then
    echo "$0 $*"
    LFBFL_verbose=1
  fi
  readonly LFBFL_verbose

  local LFBFL_root_directory=""
  for LFBFL_arg in "$@"; do
    if [[ "${LFBFL_arg}" == --root-directory=* ]]; then
      LFBFL_root_directory=${LFBFL_arg#--root-directory=}
      LFBFL_root_directory=${LFBFL_root_directory/#~/${HOME}}
      break
    fi
  done

  if [[ -n "${LFBFL_root_directory}" ]]; then
    declare -i LFBFL_pushd_result
    pushd "${LFBFL_root_directory}" || {
      LFBFL_pushd_result=$?
      echo "python_black_complement.libr.sh"\
        "--root-directory=${LFBFL_root_directory} no such directory."
      # shellcheck disable=SC2248
      return ${LFBFL_pushd_result}
    }
  fi

  check_no_empty_line_after_python_function_docstring

  if [[ -n "${LFBFL_root_directory}" ]]; then
    declare -i LFBFL_popd_result
    popd || {
      LFBFL_popd_result=$?
      echo "python_black_complement.libr.sh popd failed."
      # shellcheck disable=SC2248
      return ${LFBFL_popd_result}
    }
  fi
}
