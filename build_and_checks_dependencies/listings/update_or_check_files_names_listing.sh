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

subdir="build_and_checks_dependencies"
source "./$subdir/lines_filters.sh"
subdir2="$subdir/listings"
files_names_listing="./$subdir2/files_names_listing.txt"

grep_variable repository_data.txt repository_name

if [[ "$1" == "--write" ]]; then
  > "$files_names_listing"
fi
sed_expression='s/\\\n//Mg'
sed -Ez "$sed_expression" "$files_names_listing"\
  > "$files_names_listing.temp1"
sed -Ez "$sed_expression" "$files_names_listing.temp1"\
  > "$files_names_listing.temp2"
sed -Ez "$sed_expression" "$files_names_listing.temp2"\
  > "$files_names_listing.temp3"
sed -Ez "$sed_expression" "$files_names_listing.temp3"\
  > "$files_names_listing.temp4"
shopt -s dotglob
find . -type f -printf '%P\n' | relevant_find | sort\
  | while read -r file_name;
do
  git check-ignore -q "$file_name" && continue
  base_file_name=$(basename "$file_name")
  [ "$base_file_name" != "current_tree_light.txt" ] || continue
  [ "$base_file_name" != "current_tree.txt" ] || continue
  [ "$base_file_name" != "COPYING" ] || continue
  [ "$base_file_name" != "COPYING.LESSER" ] || continue
  [ "$base_file_name" != "$repository_name.pdf" ] || continue
  [ "$base_file_name" != "$repository_name.tex" ] || continue
  [ "$base_file_name" != "$repository_name.tex.tpl2" ] || continue
  [ "$base_file_name" != "files_names_listing.txt.temp1" ] || continue
  [ "$base_file_name" != "files_names_listing.txt.temp2" ] || continue
  [ "$base_file_name" != "files_names_listing.txt.temp3" ] || continue
  [ "$base_file_name" != "files_names_listing.txt.temp4" ] || continue
  if [[ "$1" == "--write" ]]; then
    echo "$file_name" >> "$files_names_listing"
    continue
  fi
  if grep -q "$file_name\$" "$files_names_listing.temp4"; then
    echo ""
  else
    echo "The file $file_name is not listed in $files_names_listing."
    if [[ "$1" == "--append" ]]; then
      echo "$file_name" >> "$files_names_listing"
    fi
  fi
done
rm "$files_names_listing.temp1" "$files_names_listing.temp2"\
  "$files_names_listing.temp3" "$files_names_listing.temp4"
shopt -u dotglob
shopt -s globstar
