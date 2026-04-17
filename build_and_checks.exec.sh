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
  # $1=work_directory
  # Options:
  #   --check-download=y|keep (=keep to keep the downloaded files)
  #   --verbose
  local LFBFL_work_directory="."
  if [[ -n "$1" ]]; then
    LFBFL_work_directory="$1"
  fi
  readonly LFBFL_work_directory

  local LFBFL_verbose=""
  if [[ "$*" == *--verbose* ]]; then
    printf "%s %s\n" "$0" "$*"
    LFBFL_verbose="--verbose"
  fi
  readonly LFBFL_verbose

  local LFBFL_check_download=""
  if [[ "$*" == *--check-download=keep* ]]; then
    LFBFL_check_download="--check-download=keep"
  elif [[ "$*" == *--check-download=y* ]]; then
    LFBFL_check_download="--check-download=y"
  fi
  readonly LFBFL_check_download

  source ./wget_sha512.libr.sh

  LFBFL_subdir="build_and_checks_dependencies"
  mkdir --parents "${LFBFL_subdir}/licenses_templates"
  local LFBFL_variables_directory
  LFBFL_variables_directory="${LFBFL_work_directory}/"
  LFBFL_variables_directory+="build_and_checks_variables"
  readonly LFBFL_variables_directory
  mkdir --parents -- "${LFBFL_variables_directory}/temp"
  if [[ ! -f "${LFBFL_variables_directory}/.gitignore" ]]; then
    printf "temp/\nupgrade_venvs_ts\n"\
      > "${LFBFL_variables_directory}/.gitignore"
  fi

  local LFBFL_dependencies_URL
  LFBFL_dependencies_URL="https://raw.githubusercontent.com/LLyaudet/"
  LFBFL_dependencies_URL+="DevOrSysAdminScripts/main/${LFBFL_subdir}"
  readonly LFBFL_dependencies_URL

  declare -r LFBFL_common_file_name="common_build_and_checks.exec.sh"
  local LFBFL_script_download_URL
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/"
  LFBFL_script_download_URL+="${LFBFL_common_file_name}"
  readonly LFBFL_script_download_URL
  declare -r LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_common_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='57142659bb838d120df704f1883dfe74e670e42722250'
  LFBFL_correct_sha512+='f542cae7bfdc4ac378ef61503018bef7296adccf4125'
  LFBFL_correct_sha512+='bcedd17fe744bb5f1874ee26fa0f4fef5609cb6'
  wget_sha512 "${LFBFL_file_path}"\
    "${LFBFL_script_download_URL}"\
    "${LFBFL_correct_sha512}"\
    "${LFBFL_verbose}"\
    "${LFBFL_check_download}"
  chmod +x "${LFBFL_file_path}"

  "${LFBFL_file_path}" "${LFBFL_work_directory}"\
    "${LFBFL_dependencies_URL}"\
    "${LFBFL_verbose}"\
    "${LFBFL_check_download}"
}

if [[ "$*" == *--fixed-point-build* ]]; then
  printf -- "--fixed-point-build\n"
  source "./build_and_checks_dependencies/lines_filters.libr.sh"
  LFBFL_work_directory="."
  if [[ -n "$1" ]]; then
    LFBFL_work_directory="$1"
  fi
  LFBFL_variables_directory="${LFBFL_work_directory}/"
  LFBFL_variables_directory+="build_and_checks_variables"
  LFBFL_data_file_name="${LFBFL_variables_directory}/"
  LFBFL_data_file_name+="repository_data.txt"
  LFBFL_repository_name=""
  grep_variable "${LFBFL_data_file_name}" repository_name\
    --result-variable-prefix="LFBFL_"\
    --replace-line-returns-by=""
  # Touching the 3 following files first let us iterate
  # upgrade_build_and_checks 2 times instead of 3 to reach
  # a fixed point.
  touch -- "${LFBFL_variables_directory}/${LFBFL_repository_name}.tex"
  touch -- "${LFBFL_work_directory}/${LFBFL_repository_name}.pdf"
  touch -- "${LFBFL_work_directory}/${LFBFL_repository_name}.html"
  # The two iterations of build_and_checks needs to complete
  # during the same minute to have a fixed point.
  build_and_checks "$@"
  # build_and_checks "$@" second iteration below
  # Then calling this script without --fixed-point-build should not
  # yield any new superficial modifications.
fi

build_and_checks "$@"
