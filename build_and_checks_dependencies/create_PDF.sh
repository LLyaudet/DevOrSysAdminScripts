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
# ©Copyright 2023-2024 Laurent Lyaudet

current_path=$(pwd)
main_directory=$(basename $current_path)

subdir="build_and_checks_dependencies"
source "./$subdir/lines_counts.sh"
source "./$subdir/lines_filters.sh"

cp "./latex/$main_directory.tex.tpl"\
   "./latex/$main_directory.tex"
# We need a variant of the template with long lines.
cp "./latex/$main_directory.tex.tpl"\
   "./latex/$main_directory.tex.tpl2"
sed -i -Ez "s/%\n//Mg" "./latex/$main_directory.tex.tpl2"

current_date=$(date -I"date")
sed -i "s|@current_date@|$current_date|g"\
  "./latex/$main_directory.tex"

current_git_SHA1=$(git rev-parse HEAD)
sed -i "s|@current_git_SHA1@|$current_git_SHA1|g"\
  "./latex/$main_directory.tex"

number_of_commits=$(git shortlog | space_starting_lines | wc -l)
sed -i "s|@number_of_commits@|$number_of_commits|g"\
  "./latex/$main_directory.tex"

number_of_lines="$(code_lines_count_all) total lines,"
number_of_lines+=" $(code_lines_count_not_empty) not empty lines,"
number_of_lines+=" $(code_lines_count_empty) empty lines."
sed -i "s|@number_of_lines@|$number_of_lines|g"\
  "./latex/$main_directory.tex"

tree --gitignore\
  -I "$main_directory.aux"\
  -I "$main_directory.log"\
  -I "$main_directory.out"\
  -I "$main_directory.pdf"\
  -I "$main_directory.tex"\
  -I "$main_directory.tex.tpl2"\
  -I current_tree.txt\
  -I current_tree_light.txt\
  > current_tree_light.txt

tree -DFh --gitignore\
  -I "$main_directory.aux"\
  -I "$main_directory.log"\
  -I "$main_directory.out"\
  -I "$main_directory.pdf"\
  -I "$main_directory.tex"\
  -I "$main_directory.tex.tpl2"\
  -I current_tree.txt\
  -I current_tree_light.txt\
  > current_tree.txt

shopt -s dotglob
find * -type f | relevant_find | sort | while read filename; do
  [ -f "$filename" ] || continue
  git check-ignore -q "$filename" && continue
  base_filename=$(basename "$filename")
  [ "$base_filename" != "current_tree_light.txt" ] || continue
  [ "$base_filename" != "current_tree.txt" ] || continue
  [ "$base_filename" != "COPYING" ] || continue
  [ "$base_filename" != "COPYING.LESSER" ] || continue
  [ "$base_filename" != "$main_directory.pdf" ] || continue
  [ "$base_filename" != "$main_directory.tex" ] || continue
  [ "$base_filename" != "$main_directory.tex.tpl2" ] || continue
  if [[ "$base_filename" == *.md ]]; then
    if [ -f "$filename.tpl" ]; then
      in_place_grep -v "$base_filename$" current_tree.txt
      in_place_grep -v "$base_filename$" current_tree_light.txt
      continue
    fi
  fi
  cleaned_path1=$(sed -e 's/_/\\_/g' <(echo "$filename"))
  cleaned_path2=$(sed -e 's/\//:/g' -e 's/\.//g' <(echo "$filename"))
  if grep -q "  $filename\$" "./latex/$main_directory.tex.tpl2"; then
    echo ""
    # sed -i -Ez\
    #   "s/$filename\n/\
    #   ${filename/./\\./g}\\hyperref\{${filename/./\\./g}\}\n/Mg"\
    #   "current_tree_light.txt"
  else
    echo "The file $filename is not listed"\
         " in ./latex/$main_directory.tex.tpl"
    echo "TODO:\subsection{"
    echo "TODO:  $cleaned_path1"
    echo "TODO:}"
    echo "TODO:\label{"
    echo "TODO:  $cleaned_path2"
    echo "TODO:}"
    echo "TODO:"
    echo "TODO:\VerbatimInput[numbers=left,xleftmargin=-5mm]{"
    echo "TODO:  $filename"
    echo "TODO:}"
    echo "TODO:"
    echo "TODO:"
  fi
done
shopt -u dotglob
shopt -s globstar

split_last_line(){
  # $1=$new_lines
  # $2=$prefix
  split_last_line_result="$1"
  if echo "$1" | sed -e 's/\\n/\n/g' | grep -q '.\{71\}$'; then
    start=$(echo "$1" | sed -e 's/\\n/\n/g' | head --lines=-1)
    # echo "start: $start"
    last_line=$(echo "$1" | sed -e 's/\\n/\n/g' | tail --lines=1)
    # echo "last_line: $last_line"
    split_last_line_result=""
    if [[ -n "$start" ]]; then
      split_last_line_result="$start\n"
    fi
    split_last_line_result+="${last_line:0:69}\n"
    split_last_line_result+="$2${last_line:69}"
  fi
}

# We verify if some lines are beyond 70 caracters
# in current_tree_light.txt et current_tree.txt.
trees=("current_tree_light.txt" "current_tree.txt")
for some_tree in "${trees[@]}"; do
  grep '.\{71\}' "$some_tree" | while read some_line; do
    # echo "some_line: $some_line"
    prefix=$(\
      echo "$some_line"\
        | sed -E -e 's/(.*)─[^─]+$/\1/g' -e 's/[^ ]+$//g'\
    )
    prefix+="│ "
    # echo "prefix: $prefix"
    filename=$(\
      echo "$some_line"\
        | sed -E 's|.* (([a-zA-Z0-9\._/-]+).)$|\1|g'\
    )
    # echo "filename: $filename"
    line_start=$(\
      echo "$some_line"\
        | sed -E "s/(.*)[ ]*$filename/\1/g"\
    )
    # echo "line_start: $line_start"
    some_line=$(\
      echo "$some_line"\
        | sed -E -e 's/\[/\\\[/g' -e 's/\]/\\\]/g'\
    )
    new_lines="$prefix$filename"
    split_last_line "$new_lines" "$prefix"
    new_lines=$split_last_line_result
    split_last_line "$new_lines" "$prefix"
    new_lines=$split_last_line_result
    split_last_line "$new_lines" "$prefix"
    new_lines=$split_last_line_result
    split_last_line "$new_lines" "$prefix"
    new_lines=$split_last_line_result
    sed -i -e "s/$some_line/$line_start\n$new_lines/g" "$some_tree"
  done
done

sed -i -e '/@current_tree_light@/{r current_tree_light.txt' -e 'd}'\
  "./latex/$main_directory.tex"
sed -i -e '/@current_tree@/{r current_tree.txt' -e 'd}'\
  "./latex/$main_directory.tex"

pdflatex "./latex/$main_directory.tex" > /dev/null
pdflatex "./latex/$main_directory.tex" > /dev/null
pdflatex "./latex/$main_directory.tex" > /dev/null

files_to_delete=(\
  "$main_directory.aux"\
  "$main_directory.log"\
  "$main_directory.out"\
  "current_tree.txt"
  "current_tree_light.txt"
  "./latex/$main_directory.tex.tpl2"
)
# Comment the following line if you need to debug.
for filename in "${files_to_delete[@]}"; do
  rm -f $filename
done
