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
# The file "common_build_and_checks.exec.sh.tpl" was renamed from
# "common_build_and_checks.sh.tpl" to
# "common_build_and_checks.exec.sh.tpl".
# The file "common_build_and_checks.exec.sh" generated from the file
# "common_build_and_checks.sh.tpl"
# or "common_build_and_checks.exec.sh.tpl"
# was renamed from
# "common_build_and_checks.sh" to "common_build_and_checks.exec.sh".

common_build_and_checks(){
  # $1 LFBFL_working_directory
  # $2 LFBFL_dependencies_URL
  # $3 optional --verbose
  declare -r LFBFL_working_directory="$1"
  # declare -r LFBFL_dependencies_URL="$2" too long
  declare -r LFBFL_start_URL="$2"
  local LFBFL_verbose=""
  if [[ "$3" == "--verbose" ]]; then
    echo "$0 $*"
    LFBFL_verbose="--verbose"
  fi
  readonly LFBFL_verbose

  source ./wget_sha512.libr.sh

  declare -r LFBFL_subdir="build_and_checks_dependencies"

  local LFBFL_file_name
  local LFBFL_URL
  local LFBFL_file_path

  LFBFL_file_name="build_md_from_printable_md.exec.sh"
  # LFBFL_script_download_URL
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_build_md_from_printable_md.exec.sh@
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"
  chmod +x "./${LFBFL_file_path}"

  LFBFL_file_name="check_shell_scripts_beginnings.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_check_shell_scripts_beginnings.libr.sh@
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="check_URLs.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_check_URLs.libr.sh@
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="comparisons.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_comparisons.libr.sh@
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="create_PDF.exec.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_create_PDF.exec.sh@
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"
  chmod +x "./${LFBFL_file_path}"

  LFBFL_file_name="generate_from_template.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_generate_from_template.libr.sh@
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="get_common_text_glob_patterns.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_get_common_text_glob_patterns.libr.sh@
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="grammar_and_spell_check.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_grammar_and_spell_check.libr.sh@
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  # /licenses_templates/ ---------------------------------------------
  declare -r LFBFL_subdir2="${LFBFL_subdir}/licenses_templates"
  declare -r LFBFL_start_URL2="${LFBFL_start_URL}/licenses_templates"
  LFBFL_file_name="build_licenses_templates.exec.sh"
  LFBFL_URL="${LFBFL_start_URL2}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir2}/${LFBFL_file_name}"
  @sha512_build_licenses_templates.exec.sh@
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"
  chmod +x "./${LFBFL_file_path}"

  LFBFL_file_name="license_file_header_GPLv3+.tpl"
  LFBFL_URL="${LFBFL_start_URL2}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir2}/${LFBFL_file_name}"
  @sha512_license_file_header_GPLv3+.tpl@
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="license_file_header_LGPLv3+.tpl"
  LFBFL_URL="${LFBFL_start_URL2}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir2}/${LFBFL_file_name}"
  @sha512_license_file_header_LGPLv3+.tpl@
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"
  # ------------------------------------------------------------------

  LFBFL_file_name="lines_counts.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_lines_counts.libr.sh@
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="lines_filters.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_lines_filters.libr.sh@
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="lines_maps.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_lines_maps.libr.sh@
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  # /listings/ -------------------------------------------------------
  declare -r LFBFL_subdir3="${LFBFL_subdir}/listings"
  declare -r LFBFL_start_URL3="${LFBFL_start_URL}/listings"
  LFBFL_file_name="update_or_check_files_names_listing.exec.sh"
  LFBFL_URL="${LFBFL_start_URL3}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir3}/${LFBFL_file_name}"
  @sha512_update_or_check_files_names_listing.exec.sh@
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"
  chmod +x "./${LFBFL_file_path}"
  # ------------------------------------------------------------------

  LFBFL_file_name="overwrite_if_not_equal.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_overwrite_if_not_equal.libr.sh@
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="python_black_complement.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_python_black_complement.libr.sh@
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="python_isort_complement.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_python_isort_complement.libr.sh@
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="split_line_at_most.exec.php"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_split_line_at_most.exec.php@
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="split_line_at_most.libr.php"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_split_line_at_most.libr.php@
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="strings_functions.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_strings_functions.libr.sh@
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="too_long_code_lines.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_too_long_code_lines.libr.sh@
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  shopt -s globstar
  source "./${LFBFL_subdir}/check_shell_scripts_beginnings.libr.sh"
  source "./${LFBFL_subdir}/check_URLs.libr.sh"
  source "./${LFBFL_subdir}/comparisons.libr.sh"
  source "./${LFBFL_subdir}/generate_from_template.libr.sh"
  source "./${LFBFL_subdir}/get_common_text_glob_patterns.libr.sh"
  source "./${LFBFL_subdir}/grammar_and_spell_check.libr.sh"
  source "./${LFBFL_subdir}/lines_counts.libr.sh"
  source "./${LFBFL_subdir}/lines_filters.libr.sh"
  source "./${LFBFL_subdir}/lines_maps.libr.sh"
  source "./${LFBFL_subdir}/overwrite_if_not_equal.libr.sh"
  source "./${LFBFL_subdir}/python_black_complement.libr.sh"
  source "./${LFBFL_subdir}/python_isort_complement.libr.sh"
  source "./${LFBFL_subdir}/strings_functions.libr.sh"
  source "./${LFBFL_subdir}/too_long_code_lines.libr.sh"

  echo "Building license headers"
  "./${LFBFL_subdir2}/build_licenses_templates.exec.sh"\
    "${LFBFL_verbose}"

  echo "Building README.md"
  "./${LFBFL_subdir}/build_md_from_printable_md.exec.sh"\
    "${LFBFL_working_directory}" "README" "${LFBFL_verbose}"

  pushd .
  cd "${LFBFL_working_directory}"

  echo "Running shellcheck"
  shellcheck --check-sourced --enable=all --external-sources **/*.sh

  echo "Running isort"
  isort .
  python_isort_complement

  echo "Running black"
  black .
  python_black_complement

  find . -name "pyproject.toml" | relevant_find\
    | while read -r LFBFL_file_name;
  do
    if grep -q "Typing :: Typed" "${LFBFL_file_name}"; then
      echo "Running mypy"
      mypy $(dirname "${LFBFL_file_name}")
    fi
  done

  echo "Analyzing too long lines"
  too_long_code_lines | relevant_grep | not_license_grep

  echo "Analyzing shell scripts beginnings"
  check_shell_scripts_beginnings | relevant_grep

  echo "Analyzing URLs"
  check_URLs | relevant_grep

  echo "Analyzing strange characters: hover over in doubt"
  LFBFL_usual_characters="\x00-\x7Fàâéèêëîïôç©“”└─├│«»"
  grep --exclude-dir '.git' -nPrv "^[${LFBFL_usual_characters}]*$" .\
    | grep --color='auto' -nP "[^${LFBFL_usual_characters}]"

  echo "Creating the PDF file of the listing of the source code"
  "./${LFBFL_subdir}/create_PDF.exec.sh" "${LFBFL_verbose}"

  popd
}

common_build_and_checks "$@"
