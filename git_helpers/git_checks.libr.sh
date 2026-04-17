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
# 2024-05-31T01:57+02:00: This file was renamed from
# "git_checks.libr.sh"
# to
# "git_checks.libr.sh".
# 2024-05-31T01:57+02:00: This file was moved from
# "."
# to
# "./git_helpers".
# 2024-05-31T01:49+02:00: This file was renamed from
# "git_checks.libr.sh"
# to
# "git_checks.libr.sh".
# 2024-05-31T01:49+02:00: This file was moved from
# "."
# to
# "./git_helpers".
# This file was renamed from "git_checks.sh" to "git_checks.libr.sh".

check_files(){
  # Checks used on Django projects.
  # Use `git commit --no-verify` after check.
  declare -r LFBFL_send_summary_1="ATTENTION : models modifiés"
  declare -r LFBFL_send_body_1="Vérifiez si besoin de migrations"
  local LFBFL_send_body_2="Pensez aussi aux contraintes d'unicités"
  LFBFL_send_body_2+=" dès la création du modèle"
  readonly LFBFL_send_body_2
  declare -r LFBFL_send_summary_2="ATTENTION : serializers modifiés"
  declare -r LFBFL_send_body_3=\
"Les nouveaux preloadings sont interdits -> #Prefetch()"
  declare -i LFBFL_i_error=0
  git diff --cached --name-only\
    > /tmp/DOSAS_django_git_check1.temp
  if grep models /tmp/DOSAS_django_git_check1.temp;
  then
    notify-send "${LFBFL_send_summary_1}" "${LFBFL_send_body_1}"
    notify-send "${LFBFL_send_summary_1}" "${LFBFL_send_body_2}"
    LFBFL_i_error=1
  fi
  if grep serializer /tmp/DOSAS_django_git_check1.temp;
  then
    notify-send "${LFBFL_send_summary_2}" "${LFBFL_send_body_3}"
    LFBFL_i_error=1
  fi
  rm /tmp/DOSAS_django_git_check1.temp
  # shellcheck disable=SC2248
  return ${LFBFL_i_error}
}


check_no_abusive_trailing_comma(){
  # Useful for Python code, although it regularly yields
  # false positives in Python code
  # (but it is easy to distinguish by hand).
  # Use `git commit --no-verify` after check.
  declare -r LFBFL_send_summary_1="ATTENTION"
  local LFBFL_send_body_1="Il semblerait que vous affectiez un tuple"
  LFBFL_send_body_1+=" au lieu d'une autre valeur dans une variable."
  readonly LFBFL_send_body_1
  declare -i LFBFL_i_error=0
  git diff --cached\
    > /tmp/DOSAS_django_git_check2.temp
  if grep --perl-regexp ' = .*,\s*$' /tmp/DOSAS_django_git_check2.temp;
  then
    notify-send "${LFBFL_send_summary_1}" "${LFBFL_send_body_1}"
    LFBFL_i_error=1
  fi
  rm /tmp/DOSAS_django_git_check2.temp
  # shellcheck disable=SC2248
  return ${LFBFL_i_error}
}


check_black_code_formatting(){
  # attention ça ne marche que sur les fichiers "stagés" avec git add
  declare -r LFBFL_s_files_paths=$(
    git diff --cached --name-only\
    | grep '\.py'
  )
  printf "%s\n" "${LFBFL_s_files_paths}"
  declare -a LFBFL_arr_files_paths
  mapfile -t LFBFL_arr_files_paths <<< "${LFBFL_s_files_paths}"
  readonly LFBFL_arr_files_paths
  declare -i LFBFL_i_error=0
  local LFBFL_file_path
  for LFBFL_file_path in "${LFBFL_arr_files_paths[@]}"; do
    printf "Black will check formatting on file %s\n" "${LFBFL_file_path}"
    if ! black --check --diff -- "${LFBFL_file_path}";
    then
      LFBFL_i_error=1
    fi
  done
  # shellcheck disable=SC2248
  return ${LFBFL_i_error}
}
