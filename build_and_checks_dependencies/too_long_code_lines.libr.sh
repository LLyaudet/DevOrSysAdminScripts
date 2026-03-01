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
# This file was renamed from "too_long_code_lines.sh"
# to "too_long_code_lines.libr.sh".

LFBFL_subdir="build_and_checks_dependencies"
# shellcheck source=get_common_text_glob_patterns.libr.sh
source "./${LFBFL_subdir}/get_common_text_glob_patterns.libr.sh"
# shellcheck source=lines_filters.libr.sh
source "./${LFBFL_subdir}/lines_filters.libr.sh"

too_long_code_lines(){
  # Options:
  #   --verbose
  #   --max-line-length
  #   --root-directory=""
  local LFBFL_arg

  declare -i LFBFL_verbose=0
  if [[ "$*" == *--verbose* ]]; then
    echo "$0 $*"
    LFBFL_verbose=1
  fi
  readonly LFBFL_verbose

  declare -i LFBFL_max_line_length=70
  local LFBFL_root_directory=""
  for LFBFL_arg in "$@"; do
    if [[ "${LFBFL_arg}" == --max-line-length=* ]]; then
      LFBFL_arg=${LFBFL_arg#--max-line-length=}
      LFBFL_max_line_length=$((LFBFL_arg))
      continue
    fi
    if [[ "${LFBFL_arg}" == --root-directory=* ]]; then
      LFBFL_root_directory=${LFBFL_arg#--root-directory=}
      LFBFL_root_directory=${LFBFL_root_directory/#~/${HOME}}
      continue
    fi
  done

  if [[ ! -o pipefail ]]; then
    [[ LFBFL_verbose -eq 1 ]] && echo "pipefail option activated"
    set -o pipefail
    trap 'set +o pipefail' RETURN
  fi

  if [[ -n "${LFBFL_root_directory}" ]]; then
    declare -i LFBFL_pushd_result
    pushd "${LFBFL_root_directory}" || {
      LFBFL_pushd_result=$?
      echo "too_long_code_lines.libr.sh"\
        "--root-directory=${LFBFL_root_directory} no such directory."
      # shellcheck disable=SC2248
      return ${LFBFL_pushd_result}
    }
  fi

  get_COMMON_TEXT_FILES_GLOB_PATTERNS
  local LFBFL_pattern
  local LFBFL_long_line
  local LFBFL_file_name
  local LFBFL_line
  local LFBFL_extension
  local LFBFL_base_name
  declare -ir LFBFL_overlength=$((LFBFL_max_line_length+1))
  for LFBFL_pattern in "${COMMON_TEXT_FILES_GLOB_PATTERNS[@]}"; do
    [[ LFBFL_verbose -eq 0 ]]\
      || echo "Iterating on pattern: ${LFBFL_pattern}"
    # shellcheck disable=SC2248
    find . -type f -name "${LFBFL_pattern}" -printf '%P\n'\
      | relevant_find\
      | not_license_find\
      | xargs grep -H '.\{'${LFBFL_overlength}'\}'\
      | while read -r LFBFL_long_line;
    do
      LFBFL_file_name=${LFBFL_long_line%%:*} # Drop long ':*' suffix
      LFBFL_line=${LFBFL_long_line#*:} # Drop short '*:' prefix
      LFBFL_line="${LFBFL_line/%\\/}" # Drop/Replace '\' suffix by ''
      LFBFL_extension=${LFBFL_file_name##*.} # Drop long '*.' prefix
      LFBFL_base_name=${LFBFL_file_name%.*} # Drop short '.*' suffix
      if [[ "${LFBFL_extension}" == "html" ]]; then
        if [[ -f "${LFBFL_base_name}.md" ]]; then
          continue
        fi
        if grep --quiet --fixed-strings -- "${LFBFL_line}"\
          "./build_and_checks_variables/temp/files_listing.html.tpl"
        then
          continue
        fi
        echo "${LFBFL_long_line}"
      elif [[ "${LFBFL_extension}" == "md" ]]; then
        if ! [[ -f "${LFBFL_base_name}.md.tpl" ]]; then
          echo "${LFBFL_long_line}"
        fi
      else
        echo "${LFBFL_long_line}"
      fi
    done
  done

  if [[ -n "${LFBFL_root_directory}" ]]; then
    declare -i LFBFL_popd_result
    popd || {
      LFBFL_popd_result=$?
      echo "too_long_code_lines.libr.sh popd failed."
      # shellcheck disable=SC2248
      return ${LFBFL_popd_result}
    }
  fi
}
