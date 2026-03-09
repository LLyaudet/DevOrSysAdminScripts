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

# 2025-12-30T21:33+01:00: This file was moved from
# "./build_and_checks_dependencies/listings"
# to
# "./build_and_checks_dependencies".
# This file was renamed from "update_or_check_files_names_listing.sh"
# to "update_or_check_files_names_listing.exec.sh".
# This file was renamed from "update_or_check_file_names_listing.sh"
# to "update_or_check_files_names_listing.sh"?

LFBFL_subdir="build_and_checks_dependencies"
# shellcheck source=common_options.libr.sh
source "./${LFBFL_subdir}/common_options.libr.sh"
# shellcheck source=lines_filters.libr.sh
source "./${LFBFL_subdir}/lines_filters.libr.sh"
# shellcheck source=strings_functions.libr.sh
source "./${LFBFL_subdir}/strings_functions.libr.sh"

update_or_check_files_names_listing(){
  # Options:
  #   --verbose
  #   --work-directory=""
  declare -i LFBFL_i_verbose=0
  get_verbose_option "$@"
  local LFBFL_work_directory=""
  get_work_directory_option "$@"
  pushd_to_work_directory\
    && trap 'popd_from_work_directory' RETURN
  can_continue_after_enhanced_pushd || return

  declare -i LFBFL_write=0
  if [[ "$*" == *--write* ]]; then
    LFBFL_write=1
  fi
  readonly LFBFL_write

  declare -i LFBFL_append=0
  if [[ "$*" == *--append* ]]; then
    LFBFL_append=1
  fi
  readonly LFBFL_append

  enhanced_set_shell_option pipefail\
    && trap 'enhanced_unset_shell_option pipefail' RETURN

  LFBFL_subdir2="build_and_checks_variables"
  local LFBFL_listing="./${LFBFL_subdir2}/files_names_listing.txt"
  readonly LFBFL_listing
  local LFBFL_data_file_name="./${LFBFL_subdir2}/repository_data.txt"
  readonly LFBFL_data_file_name

  declare -i LFBFL_max_line_length
  grep_variable "${LFBFL_data_file_name}" max_line_length\
    --result-variable-prefix="LFBFL_"

  if [[ LFBFL_write -eq 1 ]]; then
    : > "${LFBFL_listing}"
  fi
  # Remove line returns that are here to keep lines short.
  sed -Ez 's/(.)\\\n/\1/Mg' "${LFBFL_listing}"\
    > "${LFBFL_listing}.temp"
  # shopt -s dotglob was needed at some point but I don't see why now.
  # shellcheck disable=SC2248
  get_split_score_simple 1 ${LFBFL_max_line_length} /
  declare -r LFBFL_split_score_command="${get_split_score_result}"
  local LFBFL_split_score_command_properties
  LFBFL_split_score_command_properties="${get_split_score_result2}"
  readonly LFBFL_split_score_command_properties
  local LFBFL_suffix=\\ # instead of '\' to avoid shellcheck SC1003
  readonly LFBFL_suffix
  # There is always a $'\n' final suffix from >>.
  # But when origin string ends with the suffix we must add something.

  local LFBFL_s_file_paths
  LFBFL_s_file_paths=$(
    find . -type f -printf '%P\n'\
    | relevant_find\
    | sort
  )
  declare -a LFBFL_arr_file_paths
  mapfile -t LFBFL_arr_file_paths <<< "${LFBFL_s_file_paths}"

  declare -r LFBFL_final_suffix=$'\n\\'
  local LFBFL_file_path
  local LFBFL_base_file_name
  for LFBFL_file_path in "${LFBFL_arr_file_paths[@]}"; do
    git check-ignore -q "${LFBFL_file_path}" && continue
    LFBFL_base_file_name=$(basename "${LFBFL_file_path}")
    [[ "${LFBFL_base_file_name}" != files_names_listing.txt* ]]\
      || continue
    if [[ "${LFBFL_base_file_name}" == *.md ]]; then
      if [[ -f "${LFBFL_file_path}.tpl" ]]; then
        continue
      fi
    fi
    if [[ LFBFL_i_verbose -eq 1 ]]; then
      printf "Non-ignored file: %s\n" "${LFBFL_file_path}"
    fi
    # shellcheck disable=SC2248
    repeated_split_last_line "${LFBFL_file_path}"\
      ""\
      ${LFBFL_max_line_length}\
      "${LFBFL_suffix}"\
      "${LFBFL_split_score_command}"\
      "${LFBFL_split_score_command_properties}"\
      ""\
      "${LFBFL_final_suffix}"
    if [[ LFBFL_write -eq 1 ]]; then
      # shellcheck disable=SC2001
      printf "%s\n" "${repeated_split_last_line_result}"\
        >> "${LFBFL_listing}"
      continue
    fi
    if grep_fixed_string_with_anchor "${LFBFL_listing}.temp"\
        "${LFBFL_file_path}" --quiet --enforce-line-ends-with-fixed-string;
    then
      :
    else
      printf "The file %s is not listed in %s.\n"\
        "${LFBFL_file_path}"\
        "${LFBFL_listing}"
      if [[ LFBFL_append -eq 1 ]]; then
        # shellcheck disable=SC2001
        printf "%s\n" "${repeated_split_last_line_result}"\
          >> "${LFBFL_listing}"
      fi
    fi
  done

  LFBFL_s_file_paths=$(cat "${LFBFL_listing}.temp")
  mapfile -t LFBFL_arr_file_paths <<< "${LFBFL_s_file_paths}"

  for LFBFL_file_path in "${LFBFL_arr_file_paths[@]}"; do
    [[ "${LFBFL_file_path}" != '//'* ]] || continue
    LFBFL_base_file_name=$(basename "${LFBFL_file_path}")
    if ! [[ -f "${LFBFL_file_path}" ]]; then
      printf "The non-file %s is listed in %s.\n"\
        "${LFBFL_file_path}"\
        "${LFBFL_listing}"
    fi
  done

  rm "${LFBFL_listing}.temp"

  if [[ LFBFL_i_verbose -eq 1 ]]; then
    cat "${LFBFL_listing}"
  fi
}

update_or_check_files_names_listing "$@"
