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
# This file was renamed from "build_md_from_printable_md.sh"
# to "build_md_from_printable_md.exec.sh".

LFBFL_subdir="build_and_checks_dependencies"
# shellcheck source=overwrite_if_not_equal.libr.sh
source "./${LFBFL_subdir}/overwrite_if_not_equal.libr.sh"

build_md_from_printable_md(){
  declare -i LFBFL_verbose=0
  if [[ "$*" == *--verbose* ]]; then
    echo "$0 $*"
    LFBFL_verbose=1
  fi
  readonly LFBFL_verbose

  # Remove line returns here to keep lines short.
  local LFBFL_sed_expression
  LFBFL_sed_expression='s/(\[[a-zA-Z0-9:-]*\]: [^\n\\]*)\\\n/\1/Mg'
  LFBFL_sed_expression+=';s/(<http[^\n\\]*)\\\n/\1/Mg'
  LFBFL_sed_expression+=';s/(- <http[^\n\\]*)\\\n/\1/Mg'
  readonly LFBFL_sed_expression
  # Since Markdown can contain code, it is limited to Markdown URLs.
  # Hence it is way more complicated than 's/\\\n//Mg' expression
  # in other files.
  # Another downside is that more than one pass is needed.

  declare -i LFBFL_cd_result
  pushd .
  if [[ -n "$1" ]];
  then
    if [[ LFBFL_verbose -eq 1 ]]; then
      echo "Moving to directory: $1"
    fi
    cd "$1" || {
      LFBFL_cd_result=$?
      echo "build_md_from_printable_md no such directory"
      # shellcheck disable=SC2248
      return ${LFBFL_cd_result}
    }
  fi

  local LFBFL_base_name="README"
  if [[ -n "$2" ]];
  then
    if [[ LFBFL_verbose -eq 1 ]]; then
      echo "Searching md file: $2"
    fi
    LFBFL_base_name="$2"
  fi
  readonly LFBFL_base_name

  if [[ -f "${LFBFL_base_name}.md.tpl" ]];
  then
    sed -Ez -e "${LFBFL_sed_expression}"\
            -e "${LFBFL_sed_expression}"\
            -e "${LFBFL_sed_expression}"\
            -e "${LFBFL_sed_expression}"\
      "${LFBFL_base_name}.md.tpl"\
      > "${LFBFL_base_name}.md.temp"
    overwrite_if_not_equal "${LFBFL_base_name}.md"\
      "${LFBFL_base_name}.md.temp"
  else
    echo "No file ${LFBFL_base_name}.md.tpl"
  fi

  pandoc -f markdown "${LFBFL_base_name}.md"\
    > "${LFBFL_base_name}.html.temp"
  overwrite_if_not_equal "${LFBFL_base_name}.html"\
    "${LFBFL_base_name}.html.temp"

  declare -i LFBFL_popd_result
  popd || {
    LFBFL_popd_result=$?
    echo "build_md_from_printable_md no popd"
    # shellcheck disable=SC2248
    return ${LFBFL_popd_result}
  }
}

build_md_from_printable_md "$@"
