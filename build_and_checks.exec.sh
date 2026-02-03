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
  LFBFL_correct_sha512='ad94b2510417aba3c0fdef0e6cd1f08c72e12f8997eeb'
  LFBFL_correct_sha512+='46eb5e3a8c32088e37823ba9050021f49ae143396d44'
  LFBFL_correct_sha512+='187ff05a733e561b68e7987e0e6c25f018a285f'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_script}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"
  chmod +x "./${LFBFL_file_path}"

  "${LFBFL_file_path}" "${LFBFL_working_directory}"\
    "${LFBFL_dependencies_URL}" "${LFBFL_verbose}"
}

build_and_checks "$@"
