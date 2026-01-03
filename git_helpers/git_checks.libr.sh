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
  declare -r LFBFL_send_summary_1="ATTENTION : models modifiés"
  declare -r LFBFL_send_body_1="Vérifiez si besoin de migrations"
  local LFBFL_send_body_2="Pensez aussi aux contraintes d'unicités"
  LFBFL_send_body_2+=" dès la création du modèle"
  readonly LFBFL_send_body_2
  declare -r LFBFL_send_summary_2="ATTENTION : serializers modifiés"
  declare -r LFBFL_send_body_3=\
"Les nouveaux preloadings sont interdits -> #Prefetch()"
  # shellcheck disable=SC2312
  if git diff --cached --name-only | grep models;
  then
    notify-send "${LFBFL_send_summary_1}" "${LFBFL_send_body_1}"
    notify-send "${LFBFL_send_summary_1}" "${LFBFL_send_body_2}"
  fi
  # shellcheck disable=SC2312
  if git diff --cached --name-only | grep serializer;
  then
    notify-send "${LFBFL_send_summary_2}" "${LFBFL_send_body_3}"
  fi
  return 0
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
  # shellcheck disable=SC2312
  if git diff --cached -r | grep ' = .*,\s*$';
  then
    notify-send "${LFBFL_send_summary_1}" "${LFBFL_send_body_1}"
    return 1
  fi
  return 0
}


check_black_code_formatting(){
  # attention ça ne marche que sur les fichiers "stagés" avec git add
  declare -r LFBFL_files_string=$(\
    git diff --cached --name-only | grep '\.py'\
  )
  echo "${LFBFL_files_string}"
  declare -a LFBFL_some_files
  mapfile -t LFBFL_some_files <<< "${LFBFL_files_string}"
  readonly LFBFL_some_files
  declare -i LFBFL_error=0
  # Not very useful since LFBFL_file should be local to the loop by
  # default.
  local LFBFL_file
  for LFBFL_file in "${LFBFL_some_files[@]}"; do
    echo "Black will check formatting on file ${LFBFL_file}"
    if ! black --check --diff "${LFBFL_file}";
    then
      LFBFL_error=1
    fi
  done
  # shellcheck disable=SC2248,SC2250
  return $LFBFL_error
}
