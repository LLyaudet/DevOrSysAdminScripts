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
# This file was renamed from "create_PDF.sh" to "create_PDF.exec.sh".

verbose=""
if [[ "$1" == "--verbose" ]]; then
  echo "$0 $*"
  verbose="--verbose"
fi

subdir="build_and_checks_dependencies"
source "./${subdir}/generate_from_template.libr.sh"
source "./${subdir}/lines_counts.libr.sh"
source "./${subdir}/lines_filters.libr.sh"
source "./${subdir}/lines_maps.libr.sh"
source "./${subdir}/overwrite_if_not_equal.libr.sh"
source "./${subdir}/strings_functions.libr.sh"
subdir2="${subdir}/listings"

grep_variable repository_data.txt repository_name

cp "./latex/$repository_name.tex.tpl"\
   "./latex/$repository_name.tex"

sed -i "s|@repository_name@|$repository_name|g"\
  "./latex/$repository_name.tex"

grep_variable repository_data.txt abstract
echo "$abstract" | sed -e 's/\\n/\n/g' > "abstract_temp"
insert_file_at_token "./latex/$repository_name.tex" @abstract@\
  "abstract_temp"
rm "abstract_temp"

grep_variable repository_data.txt acknowledgments
echo "$acknowledgments" | sed -e 's/\\n/\n/g' > "acknowledgments_temp"
insert_file_at_token "./latex/$repository_name.tex" @acknowledgments@\
  "acknowledgments_temp"
rm "acknowledgments_temp"

grep_variable repository_data.txt author_full_name
sed -i "s|@author_full_name@|$author_full_name|g"\
  "./latex/$repository_name.tex"

grep_variable repository_data.txt author_website
sed -i "s|@author_website@|$author_website|g"\
  "./latex/$repository_name.tex"

grep_variable repository_data.txt author_email
sed -i "s|@author_email@|$author_email|g"\
  "./latex/$repository_name.tex"

current_date=$(date -I"date")
sed -i "s|@current_date@|$current_date|g"\
  "./latex/$repository_name.tex"

current_git_SHA1=$(git rev-parse HEAD)
sed -i "s|@current_git_SHA1@|$current_git_SHA1|g"\
  "./latex/$repository_name.tex"

number_of_commits=$(git shortlog | space_starting_lines | wc -l)
sed -i "s|@number_of_commits@|$number_of_commits|g"\
  "./latex/$repository_name.tex"

number_of_lines="$(code_lines_count_all) total lines,"
number_of_lines+=" $(code_lines_count_not_empty) not empty lines,"
number_of_lines+=" $(code_lines_count_empty) empty lines."
sed -i "s|@number_of_lines@|$number_of_lines|g"\
  "./latex/$repository_name.tex"

tree -a --gitignore\
  -I "$repository_name.aux"\
  -I "$repository_name.log"\
  -I "$repository_name.out"\
  -I current_tree.txt\
  -I current_tree_light.txt\
  -I "node_modules/"\
  -I "__pycache__/"\
  -I ".mypy_cache/"\
  -I ".git/"\
  | replace_non_ascii_spaces\
  > current_tree_light.txt

tree -a -DFh --gitignore\
  -I "$repository_name.aux"\
  -I "$repository_name.log"\
  -I "$repository_name.out"\
  -I current_tree.txt\
  -I current_tree_light.txt\
  -I "node_modules/"\
  -I "__pycache__/"\
  -I ".mypy_cache/"\
  -I ".git/"\
  | replace_non_ascii_spaces\
  > current_tree.txt

temp_files_listing="./${subdir2}/files_listing.tex.tpl.temp"
> "$temp_files_listing"
get_split_score_after_before 70 /
# split_score_command="$LFBFL_generic_result"
score_command="$LFBFL_generic_result"
get_split_score_after_before 70 ':'
# split_score_command2="$LFBFL_generic_result"
score_command2="$LFBFL_generic_result"
suffix='%'
sed_expression='s/\\\n//Mg'
cat "./${subdir2}/files_names_listing.txt"\
  | sed -Ez "$sed_expression" | sed -Ez "$sed_expression"\
  | sed -Ez "$sed_expression" | sed -Ez "$sed_expression"\
  | grep -v '^// '\
  | while read -r file_name;
do
  base_file_name=$(basename "$file_name")
  # cleaned_path1=$(sed -e 's/_/\\_/g' <(echo "$file_name"))
  cleaned_path2=$(sed -e 's/\//:/g' -e 's/\.//g' <(echo "$file_name"))
  echo "\subsection{" >> "$temp_files_listing"

  new_lines="  $file_name"
  if [[ ${#new_lines} -gt 60 ]]; then
    split_last_line "$new_lines" "" 60 "$suffix" "$score_command"
    new_lines=$split_last_line_result
    split_last_line "$new_lines" "" 60 "$suffix" "$score_command"
    new_lines=$split_last_line_result
    split_last_line "$new_lines" "" 60 "$suffix" "$score_command"
    new_lines=$split_last_line_result
  fi
  echo "  $file_name" | sed -e "s|  $file_name|$new_lines|g"\
    > "$temp_files_listing.2"
  sed -i -e 's/_/\\_/g' "$temp_files_listing.2"
  cat "$temp_files_listing.2" >> "$temp_files_listing"
  rm "$temp_files_listing.2"

  echo "}" >> "$temp_files_listing"
  echo "\label{" >> "$temp_files_listing"

  new_lines="  $cleaned_path2"
  if [[ ${#new_lines} -gt 68 ]]; then
    split_last_line "$new_lines" "" 70 "$suffix" "$score_command2"
    new_lines=$split_last_line_result
    split_last_line "$new_lines" "" 70 "$suffix" "$score_command2"
    new_lines=$split_last_line_result
    split_last_line "$new_lines" "" 70 "$suffix" "$score_command2"
    new_lines=$split_last_line_result
  fi
  echo "  $cleaned_path2" | sed -e "s|  $cleaned_path2|$new_lines|g"\
    >> "$temp_files_listing"

  echo "}" >> "$temp_files_listing"
  echo "" >> "$temp_files_listing"
  echo "\VerbatimInput[numbers=left,xleftmargin=-5mm]{"\
    >> "$temp_files_listing"

  new_lines="$file_name"
  if [[ ${#new_lines} -gt 68 ]]; then
    split_last_line "$new_lines" "" 70 "$suffix" "$score_command"
    new_lines=$split_last_line_result
    split_last_line "$new_lines" "" 70 "$suffix" "$score_command"
    new_lines=$split_last_line_result
    split_last_line "$new_lines" "" 70 "$suffix" "$score_command"
    new_lines=$split_last_line_result
  fi
  echo "  $file_name" | sed -e "s|  $file_name|$new_lines|g"\
    >> "$temp_files_listing"

  echo "}" >> "$temp_files_listing"
  echo "" >> "$temp_files_listing"
  echo "" >> "$temp_files_listing"
done
overwrite_if_not_equal "./${subdir2}/files_listing.tex.tpl"\
  "$temp_files_listing"
insert_file_at_token "./latex/$repository_name.tex"\
  @files_listing_VerbatimInput@ "./${subdir2}/files_listing.tex.tpl"

# We verify if some lines are beyond 70 characters
# in current_tree_light.txt et current_tree.txt.
trees=("current_tree_light.txt" "current_tree.txt")
for some_tree in "${trees[@]}"; do
  grep '.\{71\}' "$some_tree" | while read -r some_line; do
    # echo "some_line: $some_line"
    prefix=$(\
      echo "$some_line"\
        | sed -E -e 's/(.*)─[^─]+$/\1/g' -e 's/[^ ]+$//g'\
    )
    prefix+="│ "
    # echo "prefix: $prefix"
    file_name=$(\
      echo "$some_line"\
        | sed -E 's|.* (([a-zA-Z0-9\._/-]+).)$|\1|g'\
    )
    # echo "file_name: $file_name"
    line_start=$(\
      echo "$some_line"\
        | sed -E "s/(.*)[ ]*$file_name/\1/g"\
        | sed -e 's/ *$//g'
    )
    # echo "line_start: $line_start"
    some_line=$(\
      echo "$some_line"\
        | sed -E -e 's/\[/\\\[/g' -e 's/\]/\\\]/g'\
    )
    new_lines="$prefix$file_name"
    if [[ ${#new_lines} -gt 68 ]]; then
      split_last_line "$new_lines" "$prefix" 70 ""
      new_lines=$split_last_line_result
      split_last_line "$new_lines" "$prefix" 70 ""
      new_lines=$split_last_line_result
      split_last_line "$new_lines" "$prefix" 70 ""
      new_lines=$split_last_line_result
      split_last_line "$new_lines" "$prefix" 70 ""
      new_lines=$split_last_line_result
    fi
    sed -i -e "s/$some_line/$line_start\n$new_lines/g" "$some_tree"
  done
done

sed -i -e '/@current_tree_light@/{r current_tree_light.txt' -e 'd}'\
  "./latex/$repository_name.tex"
sed -i -e '/@current_tree@/{r current_tree.txt' -e 'd}'\
  "./latex/$repository_name.tex"

if [[ -n "$verbose" ]]; then
  for ((i=0; i<3; i++)); do
    pdflatex "./latex/$repository_name.tex"
  done
else
  for ((i=0; i<3; i++)); do
    pdflatex "./latex/$repository_name.tex" > /dev/null
  done
fi

files_to_delete=(\
  "$repository_name.aux"\
  "$repository_name.log"\
  "$repository_name.out"\
  "current_tree.txt"
  "current_tree_light.txt"
)
# Comment the following line if you need to debug.
for file_name in "${files_to_delete[@]}"; do
  rm -f "$file_name"
done