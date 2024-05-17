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
source "./$subdir/lines_counts.sh"
source "./$subdir/lines_filters.sh"

grep_variable repository_data.txt repository_name

cp "./latex/$repository_name.tex.tpl"\
   "./latex/$repository_name.tex"
# We need a variant of the template with long lines.
cp "./latex/$repository_name.tex.tpl"\
   "./latex/$repository_name.tex.tpl2"
sed -i -Ez "s/%\n//Mg" "./latex/$repository_name.tex.tpl2"

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
  -I "$repository_name.tex.tpl2"\
  -I current_tree.txt\
  -I current_tree_light.txt\
  -I "node_modules/"\
  -I "__pycache__/"\
  -I ".mypy_cache/"\
  -I ".git/"\
  | sed -e 's/\xc2\xa0/ /g'\
  > current_tree_light.txt

tree -a -DFh --gitignore\
  -I "$repository_name.aux"\
  -I "$repository_name.log"\
  -I "$repository_name.out"\
  -I "$repository_name.tex.tpl2"\
  -I current_tree.txt\
  -I current_tree_light.txt\
  -I "node_modules/"\
  -I "__pycache__/"\
  -I ".mypy_cache/"\
  -I ".git/"\
  | sed -e 's/\xc2\xa0/ /g'\
  > current_tree.txt

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
  if [[ "$base_file_name" == *.md ]]; then
    if [ -f "$file_name.tpl" ]; then
      # in_place_grep -v "$base_file_name$" current_tree.txt
      # in_place_grep -v "$base_file_name$" current_tree_light.txt
      continue
    fi
  fi
  cleaned_path1=$(sed -e 's/_/\\_/g' <(echo "$file_name"))
  cleaned_path2=$(sed -e 's/\//:/g' -e 's/\.//g' <(echo "$file_name"))
  if grep -q "  $file_name\$" "./latex/$repository_name.tex.tpl2";
  then
    echo ""
    # sed -i -Ez\
    #   "s/$file_name\n/\
    #   ${file_name/./\\./g}\\hyperref\{${file_name/./\\./g}\}\n/Mg"\
    #   "current_tree_light.txt"
  else
    echo "The file $file_name is not listed"\
         " in ./latex/$repository_name.tex.tpl"
    echo "TODO:\subsection{"
    echo "TODO:  $cleaned_path1"
    echo "TODO:}"
    echo "TODO:\label{"
    echo "TODO:  $cleaned_path2"
    echo "TODO:}"
    echo "TODO:"
    echo "TODO:\VerbatimInput[numbers=left,xleftmargin=-5mm]{"
    echo "TODO:  $file_name"
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
    LFBFL_start=$(\
      echo "$1" | sed -e 's/\\n/\n/g' | head --lines=-1\
      | sed -z 's/\n/\\n/g'\
    )
    # echo "start: $LFBFL_start"
    LFBFL_last_line=$(\
      echo "$1" | sed -e 's/\\n/\n/g' | tail --lines=1\
    )
    # echo "last_line: $LFBFL_last_line"
    split_last_line_result=""
    if [[ -n "$LFBFL_start" ]]; then
      split_last_line_result="$LFBFL_start\n"
    fi
    split_last_line_result+="${LFBFL_last_line:0:69}\n"
    split_last_line_result+="$2${LFBFL_last_line:69}"
  fi
}

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
    prefix+="│ "
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
  "./latex/$repository_name.tex"
sed -i -e '/@current_tree@/{r current_tree.txt' -e 'd}'\
  "./latex/$repository_name.tex"

pdflatex "./latex/$repository_name.tex" > /dev/null
pdflatex "./latex/$repository_name.tex" > /dev/null
pdflatex "./latex/$repository_name.tex" > /dev/null

files_to_delete=(\
  "$repository_name.aux"\
  "$repository_name.log"\
  "$repository_name.out"\
  "current_tree.txt"
  "current_tree_light.txt"
  "./latex/$repository_name.tex.tpl2"
)
# Comment the following line if you need to debug.
for file_name in "${files_to_delete[@]}"; do
  rm -f "$file_name"
done
