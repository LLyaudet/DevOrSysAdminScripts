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

check_files(){
  check_files_var_send_summary_1="ATTENTION : models modifiés"
  check_files_var_send_body_1="Vérifiez si besoin de migrations"
  check_files_var_send_body_2=\
"Pensez aussi aux contraintes d'unicités"
  check_files_var_send_body_2+=" dès la création du modèle"
  check_files_var_send_summary_2="ATTENTION : serializers modifiés"
  check_files_var_send_body_3=\
"Les nouveaux preloadings sont interdits -> #Prefetch()"
  if git diff --cached --name-only | grep models;
  then
    notify-send "$check_files_var_send_summary_1"\
      "$check_files_var_send_body_1"
    notify-send "$check_files_var_send_summary_1"\
      "$check_files_var_send_body_2"
  fi
  if git diff --cached --name-only | grep serializer;
  then
    notify-send "$check_files_var_send_summary_2"\
      "$check_files_var_send_body_3"
  fi
  return 0
}


check_no_abusive_trailing_comma(){
  LFBFL_send_summary_1="ATTENTION"
  LFBFL_send_body_1="Il semblerait que vous affectiez un tuple"
  LFBFL_send_body_1+=" au lieu d'une autre valeur dans une variable."
  if git diff --cached -r | grep ' = .*,\s*$';
  then
    notify-send "$LFBFL_send_summary_1" "$LFBFL_send_body_1"
    return 1
  fi
  return 0
}


check_black_code_formatting(){
  # attention ça ne marche que sur les fichiers "stagés" avec git add
  LFBFL_files_string=$(\
    git diff --cached --name-only | grep '\.py'\
  )
  echo "$LFBFL_files_string"
  mapfile -t LFBFL_some_files <<< "$LFBFL_files_string"
  LFBFL_error=0
  for LFBFL_file in ${LFBFL_some_files[@]}; do
    echo "Black will check formatting on file $LFBFL_file"
    if ! black --check --diff "$LFBFL_file";
    then
      LFBFL_error=1
    fi
  done
  if [ $LFBFL_error -eq '1' ];
  then
    return 1
  fi
  return 0
}
