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
# shellcheck disable=SC1090
source "./${LFBFL_subdir}/overwrite_if_not_equal.libr.sh"

build_md_from_printable_md(){
  declare -i LFBFL_verbose=0
  if [[ "$*" == *--verbose* ]]; then
    echo "$0 $*"
    LFBFL_verbose=1
  fi
  # shellcheck disable=SC2034
  readonly LFBFL_verbose

  LFBFL_sed_expression='s/(\[[a-zA-Z0-9:-]*\]: [^\n\\]*)\\\n/\1/Mg'
  LFBFL_sed_expression+=';s/(<http[^\n\\]*)\\\n/\1/Mg'
  LFBFL_sed_expression+=';s/(- <http[^\n\\]*)\\\n/\1/Mg'

  declare -i LFBFL_cd_result
  pushd .
  if [[ -n "$1" ]];
  then
    cd "$1" || {
      LFBFL_cd_result=$?;
      echo "build_md_from_printable_md no such directory";
      # shellcheck disable=SC2248,2250
      exit $LFBFL_cd_result;
    }
  fi

  file_name="README"
  if [[ -n "$2" ]];
  then
    file_name="$2"
  fi

  if [[ -f "${file_name}.md.tpl" ]];
  then
    sed -Ez "${LFBFL_sed_expression}" "${file_name}.md.tpl"\
      > "${file_name}_temp1.md"
    sed -Ez "${LFBFL_sed_expression}" "${file_name}_temp1.md"\
      > "${file_name}_temp2.md"
    sed -Ez "${LFBFL_sed_expression}" "${file_name}_temp2.md"\
      > "${file_name}_temp3.md"
    sed -Ez "${LFBFL_sed_expression}" "${file_name}_temp3.md"\
      > "${file_name}_temp4.md"
    overwrite_if_not_equal "${file_name}.md" "${file_name}_temp4.md"
    rm "${file_name}_temp1.md" "${file_name}_temp2.md"\
      "${file_name}_temp3.md"
  else
    echo "No file ${file_name}.md.tpl"
  fi

  pandoc -f markdown "${file_name}.md" > "${file_name}.html.temp"
  overwrite_if_not_equal "${file_name}.html" "${file_name}.html.temp"

  declare -i LFBFL_popd_result
  popd || {
    LFBFL_popd_result=$?;
    echo "build_md_from_printable_md no popd";
    # shellcheck disable=SC2248,2250
    exit $LFBFL_popd_result;
  }
}

build_md_from_printable_md "$@"
