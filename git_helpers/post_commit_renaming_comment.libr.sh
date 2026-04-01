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
# 2024-05-31T01:49+02:00: This file was renamed from
# "post_commit_renaming_comment.libr.sh"
# to
# "post_commit_renaming_comment.libr.sh".
# 2024-05-31T01:49+02:00: This file was moved from
# "."
# to
# "./git_helpers".
# This file was renamed from "post_commit_renaming_comment"
# to "post_commit_renaming_comment.libr.sh".
# (Before first commit it seems. But I had the old name in listing.)

LFBFL_this_file_path=$(realpath "${BASH_SOURCE[0]}")
LFBFL_this_file_directory=$(dirname "${LFBFL_this_file_path}")
LFBFL_some_directory="${LFBFL_this_file_directory}/../"
declare -i LFBFL_i_pushd_result2
pushd -- "${LFBFL_some_directory}" || {
  LFBFL_i_pushd_result2=$?
  printf --\
    "post_commit_renaming_comment.libr.sh pushd %s no such directory\n"\
    "${LFBFL_some_directory}"
  # shellcheck disable=SC2248
  exit ${LFBFL_i_pushd_result2}
}
# shellcheck source=common_options.libr.sh
source "build_and_checks_dependencies/common_options.libr.sh"
# shellcheck source=strings_functions.libr.sh
source "build_and_checks_dependencies/strings_functions.libr.sh"
declare -i LFBFL_i_popd_result2
popd || {
  LFBFL_i_popd_result2=$?
  printf "post_commit_renaming_comment.libr.sh no popd\n"
  # shellcheck disable=SC2248
  exit ${LFBFL_i_popd_result2}
}

# Never forget that the worse security is the illusion of security
# (Kevin Mitnick). So, do not expect to have an accurate trackability
# of code history just because you use this post-commit hook or
# something else more evolved. This is useful but not a guarantee.
# For this reason, this function will only handle when all files
# impacted in the preceding commit are only renamed.
# It assumes that `diff` is the current default difference utility
# parametered with `git`. This point could be enhanced.
commit_a_file_renamed_comment(){
  # Options:
  #   --verbose
  #   --log-directory-change
  #   --max-comment-line-length
  declare -i LFBFL_i_verbose=0
  get_verbose_option "$@"
  declare -i LFBFL_i_log_directory_change
  get_some_flag LFBFL_i_log_directory_change --log-directory-change 1 "$@"
  declare -i LFBFL_i_max_comment_line_length
  get_some_option LFBFL_i_max_comment_line_length\
    --max-comment-line-length 70 1 "$@"
  if [[ LFBFL_i_verbose -eq 1 ]]; then
    LFBFL_s_format="LFBFL_i_log_directory_change: %s\n"
    LFBFL_s_format+="LFBFL_i_max_comment_line_length: %s\n"
    # shellcheck disable=SC2059,SC2248
    printf "${LFBFL_s_format}"\
      "${LFBFL_i_log_directory_change}"\
      ${LFBFL_i_max_comment_line_length}
  fi
  local LFBFL_s_format
  #-------------------------------------------------------------------

  enhanced_set_shell_option pipefail\
    && trap 'enhanced_unset_shell_option pipefail' RETURN

  declare -r LFBFL_renaming_lines=$(
    git log --max-count=1 --patch\
    | grep --after-context=1 '^diff --git'
  )
  if [[ LFBFL_i_verbose -eq 1 ]]; then
    printf "LFBFL_renaming_lines: %s\n" "${LFBFL_renaming_lines}"
  fi

  declare -a LFBFL_renaming_lines_array
  mapfile -t LFBFL_renaming_lines_array <<< "${LFBFL_renaming_lines}"
  readonly LFBFL_renaming_lines_array

  declare -r LFBFL_timestamp=$(date --iso-8601="minute")
  if [[ LFBFL_i_verbose -eq 1 ]]; then
    printf "LFBFL_timestamp: %s\n" "${LFBFL_timestamp}"
  fi
  local LFBFL_split_score_command1
  declare -i LFBFL_i_split_score_command_properties1
  # shellcheck disable=SC2248
  get_split_score_simple 1 ${LFBFL_i_max_comment_line_length} _
  LFBFL_split_score_command1="${get_split_score_result}"
  LFBFL_i_split_score_command_properties1=${i_get_split_score_result2}
  readonly LFBFL_split_score_command1
  readonly LFBFL_i_split_score_command_properties1
  local LFBFL_split_score_command2
  declare -i LFBFL_i_split_score_command_properties2
  # shellcheck disable=SC2248
  get_split_score_simple 1 ${LFBFL_i_max_comment_line_length} /
  LFBFL_split_score_command2="${get_split_score_result}"
  LFBFL_i_split_score_command_properties2=${i_get_split_score_result2}
  readonly LFBFL_split_score_command2
  readonly LFBFL_i_split_score_command_properties2
  declare -i LFBFL_i_renaming_happened=0
  declare -i LFBFL_i
  declare -i LFBFL_j
  # declare -r LFBFL_special_file_name="files_names_listing.txt"
  declare -r LFBFL_sfn="files_names_listing.txt"
  local LFBFL_diff_line
  local LFBFL_similarity_line
  local LFBFL_old_file_path
  local LFBFL_old_file_name
  local LFBFL_old_file_directory
  local LFBFL_new_file_path
  local LFBFL_new_file_name
  local LFBFL_new_file_directory
  local LFBFL_useful_file_name
  local LFBFL_extension
  local LFBFL_comment_prefix
  local LFBFL_comment_prefix2
  local LFBFL_old_file_name2
  local LFBFL_old_file_directory2
  local LFBFL_new_file_name2
  local LFBFL_new_file_directory2
  local LFBFL_new_comment
  declare -i LFBFL_i_copyright_line_number
  declare -r LFBFL_send_summary_2="ATTENTION: No line with copyright"
  declare -i LFBFL_i_line_count
  declare -i LFBFL_i_lines_after
  local LFBFL_temp_file_path
  for ((LFBFL_i=0; LFBFL_i<${#LFBFL_renaming_lines_array[@]};)); do
    LFBFL_diff_line="${LFBFL_renaming_lines_array[${LFBFL_i}]}"
    LFBFL_i=$((LFBFL_i + 1))
    LFBFL_similarity_line="${LFBFL_renaming_lines_array[${LFBFL_i}]}"
    LFBFL_i=$((LFBFL_i + 1))
    # We need to increment 3 times since grep adds "--" lines between.
    LFBFL_i=$((LFBFL_i + 1))
    if [[ LFBFL_i_verbose -eq 1 ]]; then
      printf "LFBFL_diff_line: %s\nLFBFL_similarity_line: %s\n"\
        "${LFBFL_diff_line}"\
        "${LFBFL_similarity_line}"
    fi
    if [[ "${LFBFL_similarity_line:17:4}" != "100%" ]]; then
      continue
    fi

    # Extract old file name from diff line. --------------------------
    LFBFL_old_file_path=$(
      printf "%s" "${LFBFL_diff_line}"\
      | cut --delimiter=' ' --fields=3
    )
    # It starts by "a/".
    LFBFL_old_file_path=".${LFBFL_old_file_path:1}"
    LFBFL_old_file_name=$(basename "${LFBFL_old_file_path}")
    LFBFL_old_file_directory=$(dirname "${LFBFL_old_file_path}")
    # Extract new file name from diff line. --------------------------
    LFBFL_new_file_path=$(
      printf "%s" "${LFBFL_diff_line}"\
      | cut --delimiter=' ' --fields=4
    )
    # It starts by "b/".
    LFBFL_new_file_path=".${LFBFL_new_file_path:1}"
    LFBFL_new_file_name=$(basename "${LFBFL_new_file_path}")
    LFBFL_new_file_directory=$(dirname "${LFBFL_new_file_path}")
    if [[ LFBFL_i_verbose -eq 1 ]]; then
      LFBFL_s_format="LFBFL_old_file_path: %s\n"
      LFBFL_s_format+="LFBFL_old_file_name: %s\n"
      LFBFL_s_format+="LFBFL_old_file_directory: %s\n"
      LFBFL_s_format+="LFBFL_new_file_path: %s\n"
      LFBFL_s_format+="LFBFL_new_file_name: %s\n"
      LFBFL_s_format+="LFBFL_new_file_directory: %s\n"
      # shellcheck disable=SC2059
      printf "${LFBFL_s_format}"\
        "${LFBFL_old_file_path}"\
        "${LFBFL_old_file_name}"\
        "${LFBFL_old_file_directory}"\
        "${LFBFL_new_file_path}"\
        "${LFBFL_new_file_name}"\
        "${LFBFL_new_file_directory}"
    fi
    # Extract "LFBFL_extension" with smart guessing for .tpl ---------
    # and set prefix for line with ©Copyright. -----------------------
    LFBFL_useful_file_name="${LFBFL_new_file_name}"
    LFBFL_extension="${LFBFL_useful_file_name##*.}"
    if [[ LFBFL_i_verbose -eq 1 ]]; then
      printf "LFBFL_useful_file_name: %s\nLFBFL_extension: %s\n"\
        "${LFBFL_useful_file_name}"\
        "${LFBFL_extension}"
    fi
    for ((LFBFL_j=0; LFBFL_j<3; ++LFBFL_j)); do
      if [[ "${LFBFL_extension}" != "tpl" ]]; then
        break
      fi
      LFBFL_useful_file_name="${LFBFL_useful_file_name:0:-4}"
      LFBFL_extension="${LFBFL_useful_file_name##*.}"
      if [[ LFBFL_i_verbose -eq 1 ]]; then
        printf "LFBFL_useful_file_name: %s\nLFBFL_extension: %s\n"\
          "${LFBFL_useful_file_name}"\
          "${LFBFL_extension}"
      fi
    done
    LFBFL_comment_prefix=""
    if [[ "${LFBFL_extension}" == "sh" ]]; then
      LFBFL_comment_prefix="# "
    fi
    if [[ "${LFBFL_extension}" == "sql" ]]; then
      LFBFL_comment_prefix="-- "
    fi
    if [[ "${LFBFL_extension}" == "tex" ]]; then
      LFBFL_comment_prefix="% "
    fi
    if [[ "${LFBFL_useful_file_name}" == "${LFBFL_sfn}" ]]; then
      LFBFL_comment_prefix="// "
    fi
    if [[ LFBFL_i_verbose -eq 1 ]]; then
      printf "LFBFL_comment_prefix: %s\n" "${LFBFL_comment_prefix}"
    fi
    #-----------------------------------------------------------------
    # Split if necessary old_file_name, new_file_name, etc. to have
    # comment lines below max_comment_line_length.
    LFBFL_comment_prefix2="${LFBFL_comment_prefix}"'"'
    # -----
    LFBFL_old_file_name2="${LFBFL_comment_prefix2}"
    LFBFL_old_file_name2+="${LFBFL_old_file_name}"
    # shellcheck disable=SC2248
    repeated_split_last_line "${LFBFL_old_file_name2}"\
      "${LFBFL_comment_prefix2}"\
      ${LFBFL_i_max_comment_line_length}\
      '"'\
      "${LFBFL_split_score_command1}"\
      ${LFBFL_i_split_score_command_properties1}
    LFBFL_old_file_name2="${repeated_split_last_line_result}"
    # -----
    LFBFL_old_file_directory2="${LFBFL_comment_prefix2}"
    LFBFL_old_file_directory2+="${LFBFL_old_file_directory}"
    # shellcheck disable=SC2248
    repeated_split_last_line "${LFBFL_old_file_directory2}"\
      "${LFBFL_comment_prefix2}"\
      ${LFBFL_i_max_comment_line_length}\
      '"'\
      "${LFBFL_split_score_command2}"\
      ${LFBFL_i_split_score_command_properties2}
    LFBFL_old_file_directory2="${repeated_split_last_line_result}"
    # -----
    LFBFL_new_file_name2="${LFBFL_comment_prefix2}"
    LFBFL_new_file_name2+="${LFBFL_new_file_name}"
    # shellcheck disable=SC2248
    repeated_split_last_line "${LFBFL_new_file_name2}"\
      "${LFBFL_comment_prefix2}"\
      ${LFBFL_i_max_comment_line_length}\
      '"'\
      "${LFBFL_split_score_command1}"\
      ${LFBFL_i_split_score_command_properties1}
    LFBFL_new_file_name2="${repeated_split_last_line_result}"
    # -----
    LFBFL_new_file_directory2="${LFBFL_comment_prefix2}"
    LFBFL_new_file_directory2+="${LFBFL_new_file_directory}"
    # shellcheck disable=SC2248
    repeated_split_last_line "${LFBFL_new_file_directory2}"\
      "${LFBFL_comment_prefix2}"\
      ${LFBFL_i_max_comment_line_length}\
      '"'\
      "${LFBFL_split_score_command2}"\
      ${LFBFL_i_split_score_command_properties2}
    LFBFL_new_file_directory2="${repeated_split_last_line_result}"
    # Create new comments strings. -----------------------------------
    LFBFL_new_comment=""
    if [[ "${LFBFL_new_file_name}" != "${LFBFL_old_file_name}" ]]; then
      LFBFL_new_comment="${LFBFL_comment_prefix}"
      LFBFL_new_comment+="${LFBFL_timestamp}"
      LFBFL_new_comment+=": This file was renamed from"
      LFBFL_new_comment+=$'\n'
      LFBFL_new_comment+="${LFBFL_old_file_name2}"'"'
      LFBFL_new_comment+=$'\n'
      LFBFL_new_comment+="${LFBFL_comment_prefix}to"
      LFBFL_new_comment+=$'\n'
      LFBFL_new_comment+="${LFBFL_new_file_name2}"'".'
    fi
    if [[ LFBFL_i_log_directory_change -eq 1
      && "${LFBFL_new_file_directory}" != "${LFBFL_old_file_directory}"
    ]];
    then
      if [[ "${LFBFL_new_file_name}" != "${LFBFL_old_file_name}" ]]; then
        LFBFL_new_comment+=$'\n'
      fi
      LFBFL_new_comment+="${LFBFL_comment_prefix}"
      LFBFL_new_comment+="${LFBFL_timestamp}"
      LFBFL_new_comment+=": This file was moved from"
      LFBFL_new_comment+=$'\n'
      LFBFL_new_comment+="${LFBFL_old_file_directory2}"'"'
      LFBFL_new_comment+=$'\n'
      LFBFL_new_comment+="${LFBFL_comment_prefix}to"
      LFBFL_new_comment+=$'\n'
      LFBFL_new_comment+="${LFBFL_new_file_directory2}"'".'
    fi
    if [[ LFBFL_i_verbose -eq 1 ]]; then
      printf "LFBFL_new_comment: %s\n" "${LFBFL_new_comment}"
    fi
    # Find line with ©Copyright. -------------------------------------
    LFBFL_i_copyright_line_number=$(
      grep --line-number '©Copyright' "${LFBFL_new_file_path}"\
      | head --lines=1\
      | cut --delimiter=':' --fields=1
    )
    if [[ LFBFL_i_verbose -eq 1 ]]; then
      printf "LFBFL_i_copyright_line_number: %s\n"\
        "${LFBFL_i_copyright_line_number}"
    fi
    if [[ LFBFL_i_copyright_line_number -eq 0 ]]; then
      notify-send "${LFBFL_send_summary_2}"\
        "${LFBFL_send_summary_2} for: ${LFBFL_new_comment}"
      if [[ LFBFL_i_verbose -eq 1 ]]; then
        printf "No copyright line. Skipping file.\n"
      fi
      continue
    fi
    # Get total number of lines. -------------------------------------
    LFBFL_i_line_count=$(
      wc --lines\
      < "${LFBFL_new_file_path}"
    )
    if [[ LFBFL_i_verbose -eq 1 ]]; then
      printf "LFBFL_i_line_count: %s\n" "${LFBFL_i_line_count}"
    fi
    # Compute number of lines after. ---------------------------------
    LFBFL_i_lines_after=$((
      LFBFL_i_line_count - LFBFL_i_copyright_line_number
    ))
    if [[ LFBFL_i_verbose -eq 1 ]]; then
      printf "LFBFL_i_lines_after: %s\n" "${LFBFL_i_lines_after}"
    fi
    # Update file. ---------------------------------------------------
    LFBFL_temp_file_path="${LFBFL_new_file_path}.LFBFL.temp"
    {
      head --lines="${LFBFL_i_copyright_line_number}"\
        "${LFBFL_new_file_path}"
      printf "%s\n" "${LFBFL_new_comment}"
      tail --lines="${LFBFL_i_lines_after}" "${LFBFL_new_file_path}"
    } >> "${LFBFL_temp_file_path}"
    mv "${LFBFL_temp_file_path}" "${LFBFL_new_file_path}"
    # Add file to stage. ---------------------------------------------
    git add "${LFBFL_new_file_path}"
    LFBFL_i_renaming_happened=1
  done
  readonly LFBFL_i_renaming_happened
  if [[ LFBFL_i_renaming_happened -eq 1 ]]; then
    # Commit ---------------------------------------------------------
    local LFBFL_message="commit_a_file_renamed_comment()"
    LFBFL_message+=" post-commit hook, ${LFBFL_timestamp}."
    readonly LFBFL_message
    printf "Commit message:\n%s\n" "${LFBFL_message}"
    git commit --no-verify --message="${LFBFL_message}"
  fi
}
