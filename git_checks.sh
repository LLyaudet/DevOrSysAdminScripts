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
# If not, see <http://www.gnu.org/licenses/>.
#
# ©Copyright 2023-2024 Laurent Lyaudet

check_files(){
  send_summary_1="ATTENTION : models modifiés"
  send_body_1="Vérifiez si besoin de migrations"
  send_body_2="Pensez aussi aux contraintes d'unicités"
  send_body_2+=" dès la création du modèle"
  send_summary_2="ATTENTION : serializers modifiés"
  send_body_3="Les nouveaux preloadings sont interdits -> #Prefetch()"
  if git diff --cached --name-only | grep models;
  then
    notify-send "$send_summary_1" "$send_body_1"
    notify-send "$send_summary_1" "$send_body_2"
  fi
  if git diff --cached --name-only | grep serializer;
  then
    notify-send "$send_summary_2" "$send_body_3"
  fi
  return 0
}


check_no_abusive_trailing_comma(){
  send_summary_1="ATTENTION"
  send_body_1="Il semblerait que vous affectiez un tuple"
  send_body_1+=" au lieu d'une autre valeur dans une variable."
  if git diff --cached -r | grep ' = .*,\s*$';
  then
    notify-send "$send_summary_1" "$send_body_1"
    return 1
  fi
  return 0
}


check_black_code_formatting(){
  # attention ça ne marche que sur les fichiers "stagés" avec git add
  files_string=$(git diff --cached --name-only | grep '\.py')
  echo "$files_string"
  mapfile -t some_files <<< "$files_string"
  my_error=0
  for file in ${some_files[@]};
  do
    echo "Black will check formatting on file $file"
    if ! black --check --diff "$file";
    then
      my_error=1
    fi
  done
  if [ $my_error -eq '1' ];
  then
    return 1
  fi
  return 0
}
