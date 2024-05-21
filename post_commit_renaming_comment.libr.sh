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

# Never forget that the worse security is the illusion of security
# (Kevin Mitnick). So, do not expect to have an accurate trackability
# of code history just because you use this post-commit hook or
# something else more evolved. This is useful but not a guarantee.
# For this reason, this function will only handle when all files
# impacted in the preceding commit are only renamed.
# It assumes that `diff` is the current default difference utility
# parametered with `git`. This point could be enhanced.
commit_a_file_renamed_comment(){
  declare -i LFBFL_verbose=0
  if [[ "$1" == "--verbose" ]]; then
    LFBFL_verbose=1
  fi
  readonly LFBFL_verbose
  # shellcheck disable=SC2155
  declare -r LFBFL_renaming_lines=$(
    git log -p -1 | grep 'diff --git' -A 1
  )
  # shellcheck disable=SC2250
  if [[ $LFBFL_verbose -eq 1 ]]; then
    echo "LFBFL_renaming_lines: ${LFBFL_renaming_lines}"
  fi

  declare -a LFBFL_renaming_lines_array
  mapfile -t LFBFL_renaming_lines_array <<< "${LFBFL_renaming_lines}"
  readonly LFBFL_renaming_lines_array

  # shellcheck disable=SC2155
  declare -r LFBFL_timestamp=$(date --iso-8601="minute")
  # shellcheck disable=SC2250
  if [[ $LFBFL_verbose -eq 1 ]]; then
    echo "LFBFL_timestamp: ${LFBFL_timestamp}"
  fi
  declare -i LFBFL_renaming_happened=0
  declare -i LFBFL_i
  for ((LFBFL_i=0; LFBFL_i<${#LFBFL_renaming_lines_array[@]};)); do
    # shellcheck disable=SC2250
    local LFBFL_diff_line="${LFBFL_renaming_lines_array[$LFBFL_i]}"
    LFBFL_i=$((LFBFL_i + 1))
    # shellcheck disable=SC2250
    local\
      LFBFL_similarity_line="${LFBFL_renaming_lines_array[$LFBFL_i]}"
    LFBFL_i=$((LFBFL_i + 1))
    # We need to increment 3 times since grep adds "--" lines between.
    LFBFL_i=$((LFBFL_i + 1))
    # shellcheck disable=SC2250
    if [[ $LFBFL_verbose -eq 1 ]]; then
      echo "LFBFL_diff_line: ${LFBFL_diff_line}"
      echo "LFBFL_similarity_line: ${LFBFL_similarity_line}"
    fi
    if [[ "${LFBFL_similarity_line:17:4}" == "100%" ]]; then
      # Extract old file name from diff line. ------------------------
      # shellcheck disable=SC2155
      local LFBFL_old_file_path=$(
        echo "${LFBFL_diff_line}" | cut -d ' ' -f 3
      )
      # shellcheck disable=SC2155
      local LFBFL_old_file_name=$(basename "${LFBFL_old_file_path}")
      # Extract new file name from diff line. ------------------------
      # shellcheck disable=SC2155
      local LFBFL_new_file_path=$(
        echo "${LFBFL_diff_line}" | cut -d ' ' -f 4
      )
      # shellcheck disable=SC2155
      local LFBFL_new_file_name=$(basename "${LFBFL_new_file_path}")
      # shellcheck disable=SC2250
      if [[ $LFBFL_verbose -eq 1 ]]; then
        echo "LFBFL_old_file_path: ${LFBFL_old_file_path}"
        echo "LFBFL_old_file_name: ${LFBFL_old_file_name}"
        echo "LFBFL_new_file_path: ${LFBFL_new_file_path}"
        echo "LFBFL_new_file_name: ${LFBFL_new_file_name}"
      fi
      # Extract "extension" with smart guessing for .tpl -------------
      # and set prefix for line with ©Copyright. ---------------------
      local LFBFL_useful_file_name="${LFBFL_new_file_name}"
      if [[ "${LFBFL_useful_file_name:-4}" == ".tpl" ]]; then
        LFBFL_useful_file_name="${LFBFL_useful_file_name:0:-4}"
      fi
      local LFBFL_comment_prefix=""
      if [[ "${useful_file_name:-3}" == ".sh" ]]; then
        LFBFL_comment_prefix="# "
      fi
      if [[ "${useful_file_name:-4}" == ".sql" ]]; then
        LFBFL_comment_prefix="-- "
      fi
      if [[ "${useful_file_name:-4}" == ".tex" ]]; then
        LFBFL_comment_prefix="% "
      fi
      # shellcheck disable=SC2250
      if [[ $LFBFL_verbose -eq 1 ]]; then
        echo "LFBFL_comment_prefix: ${LFBFL_comment_prefix}"
      fi
      # Create new comment string. -----------------------------------
      local LFBFL_new_comment="${LFBFL_comment_prefix}"
      LFBFL_new_comment+="${LFBFL_timestamp}"
      LFBFL_new_comment+=": This file was renamed from\n"
      LFBFL_new_comment+="${LFBFL_comment_prefix}"
      LFBFL_new_comment+='"'"${LFBFL_old_file_name}"'"\n'
      LFBFL_new_comment+="${LFBFL_comment_prefix}"
      LFBFL_new_comment+="to\n"
      LFBFL_new_comment+="${LFBFL_comment_prefix}"
      LFBFL_new_comment+='"'"${LFBFL_new_file_name}"'".'
      # shellcheck disable=SC2250
      if [[ $LFBFL_verbose -eq 1 ]]; then
        echo "LFBFL_new_comment: ${LFBFL_new_comment}"
      fi
      # Find line with ©Copyright. -----------------------------------
      # shellcheck disable=SC2155
      declare -i LFBFL_copyright_line_number=$(
        grep -n '©Copyright' "${LFBFL_new_file_name}"\
        | cut -d ':' -f 1
      )
      # shellcheck disable=SC2250
      if [[ $LFBFL_verbose -eq 1 ]]; then
        echo "LFBFL_copyright_line_number:"\
             " ${LFBFL_copyright_line_number}"
      fi
      if [[ ${LFBFL_copyright_line_number} -eq 0 ]]; then
        local LFBFL_send_summary_2="ATTENTION: No line with copyright"
        notify-send "${LFBFL_send_summary_2}"\
          "${LFBFL_send_summary_2} for: ${LFBFL_new_comment}"
        # shellcheck disable=SC2250
        if [[ $LFBFL_verbose -eq 1 ]]; then
          echo "No copyright line. Skipping file."
        fi
        continue
      fi
      # Get total number of lines. -----------------------------------
      # shellcheck disable=SC2002,SC2155
      declare -i LFBFL_line_count=$(
        cat "${LFBFL_new_file_name}" | wc -l
      )
      # shellcheck disable=SC2250
      if [[ $LFBFL_verbose -eq 1 ]]; then
        echo "LFBFL_line_count: ${LFBFL_line_count}"
      fi
      # Compute number of lines after. -------------------------------
      # shellcheck disable=SC2155
      declare -i LFBFL_lines_after=$((
        LFBFL_line_count - LFBFL_copyright_line_number
      ))
      # shellcheck disable=SC2250
      if [[ $LFBFL_verbose -eq 1 ]]; then
        echo "LFBFL_lines_after: ${LFBFL_lines_after}"
      fi
      # Update file. -------------------------------------------------
      local LFBFL_temp_file_name="${LFBFL_new_file_name}.LFBFL.temp"
      head --lines="${LFBFL_copyright_line_number}"\
        "${LFBFL_new_file_name}" > "${LFBFL_temp_file_name}"
      echo -e "${LFBFL_new_comment}" >> "${LFBFL_temp_file_name}"
      tail --lines="${LFBFL_lines_after}"\
        "${LFBFL_new_file_name}" >> "${LFBFL_temp_file_name}"
      mv "${LFBFL_temp_file_name}" "${LFBFL_new_file_name}"
      # Add file to stage. -------------------------------------------
      git add "${LFBFL_new_file_name}"
      LFBFL_renaming_happened=1
    fi
  done
  readonly LFBFL_renaming_happened
  if [[ LFBFL_renaming_happened -eq 1 ]]; then
    # Commit ---------------------------------------------------------
    local LFBFL_message="commit_a_file_renamed_comment()"
    LFBFL_message+=" post-commit hook, ${LFBFL_timestamp}."
    readonly LFBFL_message
    git commit --message="${LFBFL_message}"
  fi
}
