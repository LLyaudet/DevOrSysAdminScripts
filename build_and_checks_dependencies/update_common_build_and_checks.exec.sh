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
# ©Copyright 2023-2025 Laurent Frédéric Bernard François Lyaudet
# This file was renamed from "update_common_build_and_checks.sh"
# to "update_common_build_and_checks.exec.sh".

update_common_build_and_checks(){
  declare -i LFBFL_verbose=0
  if [[ "$1" == "--verbose" ]]; then
    echo "$0 $*"
    LFBFL_verbose="--verbose"
  fi
  # shellcheck disable=SC2034
  readonly LFBFL_verbose

  declare -r LFBFL_common_file_name="common_build_and_checks.exec.sh"
  cp "./${LFBFL_common_file_name}.tpl" "./${LFBFL_common_file_name}"

  declare -r LFBFL_file_names=(\
    "build_md_from_printable_md.exec.sh"\
    "check_shell_scripts_beginnings.libr.sh"\
    "check_URLs.libr.sh"\
    "comparisons.libr.sh"\
    "create_PDF.exec.sh"\
    "generate_from_template.libr.sh"\
    "get_common_text_glob_patterns.libr.sh"\
    "grammar_and_spell_check.libr.sh"\
    "licenses_templates/build_licenses_templates.exec.sh"\
    "licenses_templates/license_file_header_AGPLv3+.tpl"\
    "licenses_templates/license_file_header_GPLv3+.tpl"\
    "licenses_templates/license_file_header_LGPLv3+.tpl"\
    "lines_counts.libr.sh"\
    "lines_filters.libr.sh"\
    "lines_maps.libr.sh"\
    "update_or_check_files_names_listing.exec.sh"\
    "overwrite_if_not_equal.libr.sh"\
    "python_black_complement.libr.sh"\
    "python_isort_complement.libr.sh"\
    "split_line_at_most.exec.php"\
    "split_line_at_most.libr.php"\
    "strings_functions.libr.sh"\
    "too_long_code_lines.libr.sh"\
  )

  local LFBFL_file_name
  local LFBFL_file_sha512
  local LFBFL_file_sha512_all
  local LFBFL_base_file_name
  for LFBFL_file_name in "${LFBFL_file_names[@]}"; do
    # shellcheck disable=SC2312
    LFBFL_file_sha512=$(
      sha512sum "./${LFBFL_file_name}" | cut -f1 -d' '
    )
    LFBFL_file_sha512_all="local LFBFL_correct_sha512\n"
    LFBFL_file_sha512_all+="  LFBFL_correct_sha512="
    LFBFL_file_sha512_all+="'${LFBFL_file_sha512:0:45}'\n"
    LFBFL_file_sha512_all+="  LFBFL_correct_sha512\+="
    LFBFL_file_sha512_all+="'${LFBFL_file_sha512:45:44}'\n"
    LFBFL_file_sha512_all+="  LFBFL_correct_sha512\+="
    LFBFL_file_sha512_all+="'${LFBFL_file_sha512:89}'"
    LFBFL_base_file_name=$(basename "${LFBFL_file_name}")
    sed -i\
      "s|@sha512_${LFBFL_base_file_name}@|${LFBFL_file_sha512_all}|g"\
      "./${LFBFL_common_file_name}"
  done

  declare -r LFBFL_main_file_name="build_and_checks.exec.sh"
  cp "./${LFBFL_main_file_name}.tpl" "../${LFBFL_main_file_name}"

  # shellcheck disable=SC2312
  LFBFL_file_sha512=$(
    sha512sum "./${LFBFL_common_file_name}" | cut -f1 -d' '
  )
  LFBFL_file_sha512_all="local LFBFL_correct_sha512\n"
  LFBFL_file_sha512_all+="  LFBFL_correct_sha512="
  LFBFL_file_sha512_all+="'${LFBFL_file_sha512:0:45}'\n"
  LFBFL_file_sha512_all+="  LFBFL_correct_sha512\+="
  LFBFL_file_sha512_all+="'${LFBFL_file_sha512:45:44}'\n"
  LFBFL_file_sha512_all+="  LFBFL_correct_sha512\+="
  LFBFL_file_sha512_all+="'${LFBFL_file_sha512:89}'"
  sed -i\
    "s|@sha512_${LFBFL_common_file_name}@|${LFBFL_file_sha512_all}|g"\
    "../${LFBFL_main_file_name}"
}

update_common_build_and_checks "$@"
