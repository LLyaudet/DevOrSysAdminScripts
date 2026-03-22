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
# The file "common_build_and_checks.exec.sh.tpl" was renamed from
# "common_build_and_checks.sh.tpl" to
# "common_build_and_checks.exec.sh.tpl".
# The file "common_build_and_checks.exec.sh" generated from the file
# "common_build_and_checks.sh.tpl"
# or "common_build_and_checks.exec.sh.tpl"
# was renamed from
# "common_build_and_checks.sh" to "common_build_and_checks.exec.sh".

common_build_and_checks(){
  # $1 LFBFL_work_directory
  # $2 LFBFL_dependencies_URL
  # $3 optional --verbose
  local LFBFL_work_directory="${1:-.}"
  LFBFL_work_directory=$(realpath "${LFBFL_work_directory}")
  local LFBFL_work_directory_option="--work-directory="
  LFBFL_work_directory_option+="${LFBFL_work_directory}"
  declare -r LFBFL_dependencies_URL="$2"
  local LFBFL_verbose=""
  declare -i LFBFL_i_verbose=0
  if [[ "$*" == *--verbose* ]]; then
    printf "%s %s\n" "$0" "$*"
    LFBFL_verbose="--verbose"
    LFBFL_i_verbose=1
  fi
  readonly LFBFL_verbose
  readonly LFBFL_i_verbose
  declare -ar LFBFL_some_common_options=(
    "${LFBFL_verbose}"
    # "$--work-directory={LFBFL_work_directory}" doesn't work
    "${LFBFL_work_directory_option}"
  )

  source ./wget_sha512.libr.sh

  local LFBFL_subdir="build_and_checks_dependencies"
  declare -r LFBFL_subdir2="${LFBFL_subdir}/licenses_templates"
  declare -r LFBFL_subdir3="build_and_checks_variables"
  local LFBFL_file_name
  local LFBFL_script_download_URL
  local LFBFL_file_path
  local LFBFL_correct_sha512

  wrapped_wget_sha512(){
    wget_sha512 "${LFBFL_file_path}"\
      "${LFBFL_script_download_URL}"\
      "${LFBFL_correct_sha512}"\
      "${LFBFL_verbose}"
  }

  LFBFL_file_name="build_md_from_printable_md.exec.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_build_md_from_printable_md.exec.sh@
  wrapped_wget_sha512
  chmod +x "./${LFBFL_file_path}"

  LFBFL_file_name="check_shell_scripts_beginnings.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_check_shell_scripts_beginnings.libr.sh@
  wrapped_wget_sha512

  LFBFL_file_name="check_shell_scripts_indentation.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_check_shell_scripts_indentation.libr.sh@
  wrapped_wget_sha512

  LFBFL_file_name="check_URLs.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_check_URLs.libr.sh@
  wrapped_wget_sha512

  LFBFL_file_name="common_options.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_common_options.libr.sh@
  wrapped_wget_sha512

  LFBFL_file_name="comparisons.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_comparisons.libr.sh@
  wrapped_wget_sha512

  LFBFL_file_name="create_PDF.exec.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_create_PDF.exec.sh@
  wrapped_wget_sha512
  chmod +x "./${LFBFL_file_path}"

  LFBFL_file_name="generate_from_template.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_generate_from_template.libr.sh@
  wrapped_wget_sha512

  LFBFL_file_name="get_common_text_glob_patterns.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_get_common_text_glob_patterns.libr.sh@
  wrapped_wget_sha512

  LFBFL_file_name="grammar_and_spell_check.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_grammar_and_spell_check.libr.sh@
  wrapped_wget_sha512

  # /licenses_templates/ ---------------------------------------------
  local LFBFL_dependencies_URL2
  LFBFL_dependencies_URL2="${LFBFL_dependencies_URL}/licenses_templates"
  readonly LFBFL_dependencies_URL2
  LFBFL_file_name="build_licenses_templates.exec.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL2}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir2}/${LFBFL_file_name}"
  @sha512_build_licenses_templates.exec.sh@
  wrapped_wget_sha512
  chmod +x "./${LFBFL_file_path}"

  LFBFL_file_name="license_file_header_AGPLv3+.tpl"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL2}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir2}/${LFBFL_file_name}"
  @sha512_license_file_header_AGPLv3+.tpl@
  wrapped_wget_sha512

  LFBFL_file_name="license_file_header_GPLv3+.tpl"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL2}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir2}/${LFBFL_file_name}"
  @sha512_license_file_header_GPLv3+.tpl@
  wrapped_wget_sha512

  LFBFL_file_name="license_file_header_LGPLv3+.tpl"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL2}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir2}/${LFBFL_file_name}"
  @sha512_license_file_header_LGPLv3+.tpl@
  wrapped_wget_sha512
  # ------------------------------------------------------------------

  LFBFL_file_name="lines_counts.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_lines_counts.libr.sh@
  wrapped_wget_sha512

  LFBFL_file_name="lines_filters.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_lines_filters.libr.sh@
  wrapped_wget_sha512

  LFBFL_file_name="lines_maps.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_lines_maps.libr.sh@
  wrapped_wget_sha512

  LFBFL_file_name="overwrite_if_not_equal.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_overwrite_if_not_equal.libr.sh@
  wrapped_wget_sha512

  LFBFL_file_name="python_black_complement.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_python_black_complement.libr.sh@
  wrapped_wget_sha512

  LFBFL_file_name="python_isort_complement.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_python_isort_complement.libr.sh@
  wrapped_wget_sha512

  LFBFL_file_name="repository_data.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_repository_data.libr.sh@
  wrapped_wget_sha512

  LFBFL_file_name="shell_checks_complement.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_shell_checks_complement.libr.sh@
  wrapped_wget_sha512

  LFBFL_file_name="split_score.exec.php"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_split_score.exec.php@
  wrapped_wget_sha512

  LFBFL_file_name="split_score.libr.php"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_split_score.libr.php@
  wrapped_wget_sha512

  LFBFL_file_name="strings_functions.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_strings_functions.libr.sh@
  wrapped_wget_sha512

  LFBFL_file_name="too_long_code_lines.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_too_long_code_lines.libr.sh@
  wrapped_wget_sha512

  LFBFL_file_name="update_or_check_files_names_listing.exec.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  @sha512_update_or_check_files_names_listing.exec.sh@
  wrapped_wget_sha512
  chmod +x "./${LFBFL_file_path}"

  # shellcheck source=check_shell_scripts_beginnings.libr.sh
  source "./${LFBFL_subdir}/check_shell_scripts_beginnings.libr.sh"
  # shellcheck source=check_shell_scripts_indentation.libr.sh
  source "./${LFBFL_subdir}/check_shell_scripts_indentation.libr.sh"
  # shellcheck source=check_URLs.libr.sh
  source "./${LFBFL_subdir}/check_URLs.libr.sh"
  # shellcheck source=common_options.libr.sh
  source "./${LFBFL_subdir}/common_options.libr.sh"
  # shellcheck source=comparisons.libr.sh
  source "./${LFBFL_subdir}/comparisons.libr.sh"
  # shellcheck source=generate_from_template.libr.sh
  source "./${LFBFL_subdir}/generate_from_template.libr.sh"
  # shellcheck source=get_common_text_glob_patterns.libr.sh
  source "./${LFBFL_subdir}/get_common_text_glob_patterns.libr.sh"
  # shellcheck source=grammar_and_spell_check.libr.sh
  source "./${LFBFL_subdir}/grammar_and_spell_check.libr.sh"
  # shellcheck source=lines_counts.libr.sh
  source "./${LFBFL_subdir}/lines_counts.libr.sh"
  # shellcheck source=lines_filters.libr.sh
  source "./${LFBFL_subdir}/lines_filters.libr.sh"
  # shellcheck source=lines_maps.libr.sh
  source "./${LFBFL_subdir}/lines_maps.libr.sh"
  # shellcheck source=overwrite_if_not_equal.libr.sh
  source "./${LFBFL_subdir}/overwrite_if_not_equal.libr.sh"
  # shellcheck source=python_black_complement.libr.sh
  source "./${LFBFL_subdir}/python_black_complement.libr.sh"
  # shellcheck source=python_isort_complement.libr.sh
  source "./${LFBFL_subdir}/python_isort_complement.libr.sh"
  # shellcheck source=shell_checks_complement.libr.sh
  source "./${LFBFL_subdir}/shell_checks_complement.libr.sh"
  # shellcheck source=strings_functions.libr.sh
  source "./${LFBFL_subdir}/strings_functions.libr.sh"
  # shellcheck source=too_long_code_lines.libr.sh
  source "./${LFBFL_subdir}/too_long_code_lines.libr.sh"

  enhanced_set_bash_option extglob
  # shellcheck source=repository_data.libr.sh
  source "./${LFBFL_subdir}/repository_data.libr.sh"
  # shellcheck disable=SC2154,SC2309
  [[ i_enhanced_set_bash_option_extglob_result -eq 0 ]]\
    && enhanced_unset_bash_option extglob

  enhanced_set_shell_option pipefail\
    && trap 'enhanced_unset_shell_option pipefail' RETURN

  printf "Building license headers\n"
  "./${LFBFL_subdir2}/build_licenses_templates.exec.sh"\
    "${LFBFL_some_common_options[@]}"

  printf "Building README.md\n"
  "./${LFBFL_subdir}/build_md_from_printable_md.exec.sh"\
    "--work-directory=${LFBFL_work_directory}"\
    "--base-name=README"\
    "${LFBFL_verbose}"

  printf "Building other MarkDown files\n"
  local LFBFL_some_directory
  declare -r LFBFL_readme="${LFBFL_work_directory}/README.md.tpl"
  local LFBFL_s_files_paths
  LFBFL_s_files_paths=$(
    find "${LFBFL_work_directory}" -type f -name "*.md.tpl"\
    | relevant_find
  )
  declare -a LFBFL_arr_files_paths
  if [[ -n "${LFBFL_s_files_paths}" ]]; then
    mapfile -t LFBFL_arr_files_paths <<< "${LFBFL_s_files_paths}"
    for LFBFL_file_path in "${LFBFL_arr_files_paths[@]}"; do
      [[ "${LFBFL_file_path}" == "${LFBFL_readme}" ]] && continue
      printf "Found template %s.\n" "${LFBFL_file_path}"
      LFBFL_some_directory=$(dirname "${LFBFL_file_path}")
      LFBFL_file_name=$(basename "${LFBFL_file_path}")
      LFBFL_file_name=${LFBFL_file_name%.md.tpl}
      "./${LFBFL_subdir}/build_md_from_printable_md.exec.sh"\
        "--work-directory=${LFBFL_some_directory}"\
        "--base-name=${LFBFL_file_name}"\
        "${LFBFL_verbose}"
    done
  fi

  declare -i LFBFL_i_directory_changed
  pushd_to_work_directory
  LFBFL_i_directory_changed=$?
  can_continue_after_enhanced_pushd || return 1

  local LFBFL_data_file_name="${LFBFL_subdir3}/repository_data.txt"

  declare -i LFBFL_i_max_line_length
  grep_variable "${LFBFL_data_file_name}" max_line_length\
    --result-variable-prefix="LFBFL_i_"

  declare -i LFBFL_i_upgrade_venvs=0
  local LFBFL_upgrade_venvs_ts_file="${LFBFL_subdir3}/upgrade_venvs_ts"
  readonly LFBFL_upgrade_venvs_ts_file
  declare -i LFBFL_i_upgrade_venvs_ts
  declare -i LFBFL_i_current_ts
  local LFBFL_upgrade_venvs_answer

  local LFBFL_upgrade_venvs_time_interval_in_seconds=""
  get_upgrade_venvs_time_interval_in_seconds "${LFBFL_data_file_name}"\
    "${LFBFL_some_common_options[@]}"

  if [[ -f "${LFBFL_upgrade_venvs_ts_file}" ]]; then
    LFBFL_i_upgrade_venvs_ts=$(
      stat -c %Y "${LFBFL_upgrade_venvs_ts_file}"
    )
    LFBFL_i_current_ts=$(date +%s)
    ((LFBFL_i_current_ts -= LFBFL_i_upgrade_venvs_ts))
    ((LFBFL_i_current_ts -= LFBFL_upgrade_venvs_time_interval_in_seconds))
    if [[ LFBFL_i_current_ts -gt 0 ]]; then
      LFBFL_i_upgrade_venvs=1
    fi
  else
    LFBFL_i_upgrade_venvs=1
  fi
  if [[ LFBFL_i_upgrade_venvs -eq 1 ]]; then
    local LFBFL_upgrade_venvs=""
    grep_variable "${LFBFL_data_file_name}" upgrade_venvs\
      --result-variable-prefix="LFBFL_"
    if [[ "${LFBFL_upgrade_venvs}" != "auto" ]]; then
      read -r -n 1 -t 10\
        -p "Upgrade venvs and composer global? [Y/n]"\
        LFBFL_upgrade_venvs_answer
      if [[ "${LFBFL_upgrade_venvs_answer}" == "n" ]]; then
        LFBFL_i_upgrade_venvs=0
      fi
    fi
  fi

  printf "Running shellcheck\n"
  LFBFL_s_files_paths=$(
    find . -type f -name "*.sh"\
    | relevant_find
  )
  if [[ -n "${LFBFL_s_files_paths}" ]]; then
    mapfile -t LFBFL_arr_files_paths <<< "${LFBFL_s_files_paths}"
    for LFBFL_file_path in "${LFBFL_arr_files_paths[@]}"; do
      shellcheck "--rcfile=${LFBFL_subdir3}/shellcheck.ini"\
        "${LFBFL_file_path}"
    done
  fi
  printf "Running shell_checks_complement\n"
  shell_checks_complement "${LFBFL_some_common_options[@]}"

  printf -- "---Python---\n"

  maybe_deactivate(){
    if command -v deactivate
    then
      deactivate
    fi
  }

  printf "Running isort\n"
  local LFBFL_isort_venv=""
  grep_variable "${LFBFL_data_file_name}" isort_venv\
    --result-variable-prefix="LFBFL_"\
    --replace-line-returns-by=""
  if [[ -n "${LFBFL_isort_venv}" ]]; then
    maybe_deactivate
    # shellcheck disable=SC1090,SC1091
    source "${LFBFL_isort_venv}/bin/activate"
  fi
  if [[ LFBFL_i_upgrade_venvs -eq 1 ]]; then
    pip install --upgrade isort
  fi
  isort --profile=black .
  if [[ -n "${LFBFL_isort_venv}" ]]; then
    deactivate
  fi
  printf "Running python_isort_complement\n"
  python_isort_complement "${LFBFL_some_common_options[@]}"

  printf "Running black\n"
  # First, we update the configuration file with max_line_length.
  local LFBFL_update_max_length="s/^line-length = [0-9]*$"
  LFBFL_update_max_length+="/line-length = ${LFBFL_i_max_line_length}/"
  sed -E -e "${LFBFL_update_max_length}"\
    "${LFBFL_subdir3}/black.toml"\
    > "${LFBFL_subdir3}/black.toml.temp"
  overwrite_if_not_equal "${LFBFL_subdir3}/black.toml"\
    "${LFBFL_subdir3}/black.toml.temp"

  local LFBFL_black_venv=""
  grep_variable "${LFBFL_data_file_name}" black_venv\
    --result-variable-prefix="LFBFL_"\
    --replace-line-returns-by=""
  if [[ -n "${LFBFL_black_venv}" ]]; then
    maybe_deactivate
    # shellcheck disable=SC1090,SC1091
    source "${LFBFL_black_venv}/bin/activate"
  fi
  if [[ LFBFL_i_upgrade_venvs -eq 1 ]]; then
    pip install --upgrade black
  fi
  black --config "${LFBFL_subdir3}/black.toml" .
  if [[ -n "${LFBFL_black_venv}" ]]; then
    deactivate
  fi
  printf "Running python_black_complement\n"
  python_black_complement "${LFBFL_some_common_options[@]}"

  printf "Probing if mypy should be runned\n"
  local LFBFL_mypy_venv=""
  grep_variable "${LFBFL_data_file_name}" mypy_venv\
    --result-variable-prefix="LFBFL_"\
    --replace-line-returns-by=""
  if [[ -n "${LFBFL_mypy_venv}" ]]; then
    maybe_deactivate
    # shellcheck disable=SC1090,SC1091
    source "${LFBFL_mypy_venv}/bin/activate"
  fi
  if [[ LFBFL_i_upgrade_venvs -eq 1 ]]; then
    pip install --upgrade mypy
  fi
  local LFBFL_directory_path
  declare -i LFBFL_i_no_toml=1
  LFBFL_s_files_paths=$(
    find . -type f -name "pyproject.toml"\
    | relevant_find
  )
  if [[ -n "${LFBFL_s_files_paths}" ]]; then
    mapfile -t LFBFL_arr_files_paths <<< "${LFBFL_s_files_paths}"
    for LFBFL_file_path in "${LFBFL_arr_files_paths[@]}"; do
      if grep -q "Typing :: Typed" "${LFBFL_file_path}"; then
        printf "Running mypy\n"
        LFBFL_directory_path=$(dirname "${LFBFL_file_path}")
        mypy "${LFBFL_directory_path}"
      fi
      LFBFL_i_no_toml=0
    done
  fi
  if [[ LFBFL_i_no_toml -eq 1 ]]; then
    printf "Running mypy\n"
    mypy .
  fi
  if [[ -n "${LFBFL_mypy_venv}" ]]; then
    deactivate
  fi

  printf "Running bandit\n"
  LFBFL_bandit_venv=""
  grep_variable "${LFBFL_data_file_name}" bandit_venv\
    --result-variable-prefix="LFBFL_"\
    --replace-line-returns-by=""
  if [[ -n "${LFBFL_bandit_venv}" ]]; then
    maybe_deactivate
    # shellcheck disable=SC1090,SC1091
    source "${LFBFL_bandit_venv}/bin/activate"
  fi
  if [[ LFBFL_i_upgrade_venvs -eq 1 ]]; then
    pip install --upgrade bandit
  fi
  bandit --ini "${LFBFL_subdir3}/bandit.ini"\
    -b "${LFBFL_subdir3}/bandit_baseline.json"\
    -r .
  # Saving new baseline in temp if necessary.
  bandit --ini "${LFBFL_subdir3}/bandit.ini"\
    -f json -o "${LFBFL_subdir3}/temp/bandit_baseline.json"\
    -r .
  if [[ -n "${LFBFL_bandit_venv}" ]]; then
    deactivate
  fi

  printf "Running pylint\n"
  LFBFL_pylint_venv=""
  grep_variable "${LFBFL_data_file_name}" pylint_venv\
    --result-variable-prefix="LFBFL_"\
    --replace-line-returns-by=""
  if [[ -n "${LFBFL_pylint_venv}" ]]; then
    maybe_deactivate
    # shellcheck disable=SC1090,SC1091
    source "${LFBFL_pylint_venv}/bin/activate"
  fi
  if [[ LFBFL_i_upgrade_venvs -eq 1 ]]; then
    pip install --upgrade pylint
  fi
  pylint --rcfile="${LFBFL_subdir3}/pylintrc.toml" --recursive=y .
  if [[ -n "${LFBFL_pylint_venv}" ]]; then
    deactivate
  fi

  printf "Running ruff\n"
  LFBFL_ruff_venv=""
  grep_variable "${LFBFL_data_file_name}" ruff_venv\
    --result-variable-prefix="LFBFL_"\
    --replace-line-returns-by=""
  if [[ -n "${LFBFL_ruff_venv}" ]]; then
    maybe_deactivate
    # shellcheck disable=SC1090,SC1091
    source "${LFBFL_ruff_venv}/bin/activate"
  fi
  if [[ LFBFL_i_upgrade_venvs -eq 1 ]]; then
    pip install --upgrade ruff
  fi
  ruff check --config="${LFBFL_subdir3}/ruff.toml"
  if [[ -n "${LFBFL_ruff_venv}" ]]; then
    deactivate
  fi
  printf -- "---Python end---\n"

  printf -- "---PHP---\n"
  printf "Running PHPMD\n"
  if [[ LFBFL_i_upgrade_venvs -eq 1 ]]; then
    composer global require phpmd/phpmd
  fi

  declare -r LFBFL_phpmd_baseline="${LFBFL_subdir3}/phpmd_baseline.xml"
  local LFBFL_temp_phpmd_baseline="${LFBFL_subdir3}/temp/"
  LFBFL_temp_phpmd_baseline+="phpmd_baseline.xml"
  readonly LFBFL_temp_phpmd_baseline

  local LFBFL_phpmd_rulesets="cleancode,codesize,controversial,"
  LFBFL_phpmd_rulesets+="design,naming,unusedcode"
  readonly LFBFL_phpmd_rulesets

  phpmd --color --baseline-file="${LFBFL_phpmd_baseline}"\
    . text "${LFBFL_phpmd_rulesets}"
  # Saving new baseline in temp if necessary.
  rm "${LFBFL_temp_phpmd_baseline}"
  phpmd --color --generate-baseline\
    --baseline-file="${LFBFL_temp_phpmd_baseline}"\
    . text "${LFBFL_phpmd_rulesets}"
  sed -i -e 's/" file="/"\n    file="/g' "${LFBFL_temp_phpmd_baseline}"
  diff "${LFBFL_phpmd_baseline}" "${LFBFL_temp_phpmd_baseline}"
  printf -- "---PHP end---\n"

  printf -- "---JS---\n"
  LFBFL_npm_lint_directories=""
  grep_variable "${LFBFL_data_file_name}" npm_lint_directories\
    --result-variable-prefix="LFBFL_"
  if [[ -n "${LFBFL_npm_lint_directories}" ]]; then
    printf "Running ESLint\n"
    local LFBFL_JS_directory
    declare -a LFBFL_arr_paths
    mapfile -t LFBFL_arr_paths <<< "${LFBFL_npm_lint_directories}"
    for LFBFL_JS_directory in "${LFBFL_arr_paths[@]}"; do
      (cd "${LFBFL_JS_directory}" && npm run lint)
    done
  fi
  printf -- "---JS end---\n"

  printf "Analyzing too long lines\n"
  # shellcheck disable=SC2248
  too_long_code_lines "${LFBFL_some_common_options[@]}" \
    --max-line-length=${LFBFL_i_max_line_length}

  printf "Analyzing shell scripts beginnings\n"
  check_shell_scripts_beginnings "${LFBFL_some_common_options[@]}" \
    | relevant_grep

  printf "Analyzing shell scripts indentation\n"
  check_shell_scripts_indentation "${LFBFL_some_common_options[@]}" \
    | relevant_grep

  printf "Analyzing URLs\n"
  check_URLs "${LFBFL_some_common_options[@]}" \
    | relevant_grep

  printf "Analyzing strange characters: hover over in doubt\n"
  # shellcheck disable=SC1111
  LFBFL_usual_characters="\x00-\x7Fàâéèêëîïôûç©“”└─├│«»"
  grep --exclude-dir .git --binary-files=without-match --color=always\
    -nPr "[^${LFBFL_usual_characters}]" .

  [[ LFBFL_i_directory_changed -eq 0 ]] && popd_from_work_directory

  printf "Checking listed files\n"
  "./${LFBFL_subdir}/update_or_check_files_names_listing.exec.sh"\
    "${LFBFL_some_common_options[@]}"

  printf "Creating the PDF file of the listing of the source code\n"
  "./${LFBFL_subdir}/create_PDF.exec.sh" "${LFBFL_some_common_options[@]}"

  pushd_to_work_directory\
    && trap 'popd_from_work_directory' RETURN
  can_continue_after_enhanced_pushd || return 1

  if [[ -f "${LFBFL_subdir3}/post_build.sh" ]]; then
    "./${LFBFL_subdir3}/post_build.sh" "${LFBFL_verbose}"
  fi

  # ------------------------------------------------------------------
  # It is at the end that all the HTML files are generated and that
  # we can check there are no mistakes.
  printf "Running Nu W3C HTML CSS and SVG validator\n"
  local LFBFL_upgrade_vnu_jar_time_interval_in_seconds=""
  grep_variable "${LFBFL_data_file_name}"\
    upgrade_vnu_jar_time_interval_in_seconds\
    --result-variable-prefix="LFBFL_"

  if [[ "${LFBFL_upgrade_vnu_jar_time_interval_in_seconds}" == "wat" ]];
  then
    LFBFL_upgrade_vnu_jar_time_interval_in_seconds=${RANDOM}
  fi

  declare -i LFBFL_i_vnu_jar_ts
  local LFBFL_vnu_jar_path=""
  grep_variable "${LFBFL_data_file_name}" vnu_jar_path\
    --result-variable-prefix="LFBFL_"\
    --replace-line-returns-by=""
  if [[ -f "${LFBFL_vnu_jar_path}" ]]; then
    LFBFL_i_vnu_jar_ts=$(stat -c %Y "${LFBFL_vnu_jar_path}")
    LFBFL_i_current_ts=$(date +%s)
    ((LFBFL_i_current_ts -= LFBFL_i_vnu_jar_ts))
    ((
      LFBFL_i_current_ts -= LFBFL_upgrade_vnu_jar_time_interval_in_seconds
    ))
    if [[ LFBFL_i_current_ts -gt 0 ]]; then
      printf $'/!\\ATTENTION: Nu W3C validator is too old./!\\\n'
      printf "Go get the latest version here:\n"
      printf "https://github.com/validator/validator/releases\n"
    fi
    # vnu has false positives for xhtml
    # find . -iregex ".*\.\(css\|html\|svg\|xhtml\)"
    declare -r LFBFL_files_for_Nu=$(
      find . -iregex ".*\.\(css\|html\|svg\)"\
      | relevant_find
    )
    if [[ -n "${LFBFL_files_for_Nu}" ]]; then
      declare -a LFBFL_files_for_Nu2
      mapfile -t LFBFL_files_for_Nu2 <<< "${LFBFL_files_for_Nu}"
      readonly LFBFL_files_for_Nu2
      java -Xss128M -jar "${LFBFL_vnu_jar_path}" --exit-zero-always\
        --verbose "${LFBFL_files_for_Nu2[@]}"
    fi
  fi
  # ------------------------------------------------------------------

  if [[ LFBFL_i_upgrade_venvs -eq 1 ]]; then
    touch "${LFBFL_upgrade_venvs_ts_file}"
  fi
}

common_build_and_checks "$@"
