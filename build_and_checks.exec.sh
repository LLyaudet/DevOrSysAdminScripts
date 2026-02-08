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
# The file "build_and_checks.exec.sh.tpl" was renamed from
# "build_and_checks.sh.tpl" to "build_and_checks.exec.sh.tpl".
# The file "build_and_checks.exec.sh" generated from the file
# "build_and_checks.sh.tpl" or "build_and_checks.exec.sh.tpl"
# was renamed from
# "build_and_checks.sh" to "build_and_checks.exec.sh".

build_and_checks(){
  local LFBFL_working_directory="."
  if [[ -n "$1" ]]; then
    LFBFL_working_directory="$1"
  fi
  readonly LFBFL_working_directory

  local LFBFL_verbose=""
  if [[ "$2" == "--verbose" ]]; then
    echo "$0 $*"
    LFBFL_verbose="--verbose"
  fi
  readonly LFBFL_verbose

  # shellcheck disable=SC1091
  source ./wget_sha512.libr.sh

  LFBFL_subdir="build_and_checks_dependencies"
  mkdir -p "${LFBFL_subdir}/licenses_templates"
  mkdir -p "build_and_checks_variables/temp"
  if ! [[ -f "build_and_checks_variables/.gitignore" ]]; then
    echo "temp/" > "build_and_checks_variables/.gitignore"
    echo "" >> "build_and_checks_variables/.gitignore"
  fi

  # LFBFL_dependencies_raw_content_download_URL
  local LFBFL_dependencies_URL
  LFBFL_dependencies_URL="https://raw.githubusercontent.com/LLyaudet/"
  LFBFL_dependencies_URL+="DevOrSysAdminScripts/main/${LFBFL_subdir}"
  readonly LFBFL_dependencies_URL

  declare -r LFBFL_common_file_name="common_build_and_checks.exec.sh"
  # LFBFL_script_download_URL
  declare -r\
    LFBFL_script="${LFBFL_dependencies_URL}/${LFBFL_common_file_name}"
  declare -r\
    LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_common_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='b2909cec1438f2d864e1d75bbefee9fb53cdee514df53'
  LFBFL_correct_sha512+='c34bf468265d56de8ea5f35fbe695bd2cfc0d65ad0de'
  LFBFL_correct_sha512+='2c72eb3e21319fbd802d06c416e13b68048dd1a'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_script}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"
  chmod +x "./${LFBFL_file_path}"

  "${LFBFL_file_path}" "${LFBFL_working_directory}"\
    "${LFBFL_dependencies_URL}" "${LFBFL_verbose}"
}

if [[ "$*" == *--fixed_point_build* ]]; then
  echo "--fixed_point_build"
  source "./build_and_checks_dependencies/lines_filters.libr.sh"
  LFBFL_data_file_name="./build_and_checks_variables/"
  LFBFL_data_file_name+="repository_data.txt"
  grep_variable "${LFBFL_data_file_name}" repository_name
  # Touching the 3 following files first let us iterate
  # upgrade_build_and_checks 2 times instead of 3 to reach
  # a fixed point.
  touch "./build_and_checks_variables/${repository_name}.tex"
  touch "./${repository_name}.pdf"
  touch "./${repository_name}.html"
  # The two iterations of build_and_checks needs to complete
  # during the same minute to have a fixed point.
  build_and_checks "$@"
  # build_and_checks "$@" second iteration below
  # Then calling this script without --fixed_point_build should not
  # yield any new superficial modifications.
fi

build_and_checks "$@"
