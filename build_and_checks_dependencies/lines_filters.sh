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

# The goal of ths file is to have some common line filters
# for bash processing and pipes.
# As is the case for other .sh files in this repository,
# it can be copied somewhere in your home directory
# and sourced in your .bashrc.

current_path=$(pwd)
main_directory=$(basename "$current_path")

ll_wc(){
  # current options to wc:
  # -c --bytes
  # -m --chars
  # -l --lines
  # --files0-from # Incompatible with cat,
  #               # another thing intentional by ?
  #               # I don't see the meaning of "files0".
  # -L --max-line-length
  # -w --words
  # --help
  # --version
  # New option by Laurent Lyaudet (and probably other before):
  # -n --no-filenames display only number(s)
  # I think I did that the first time many years ago (Teliae ?).
  args=""
  number_only=0
  for arg in $@; do
    if [[ $arg == "-n" ]]; then
      number_only=1
    elif [[ $arg == "--no-filenames" ]]; then
      number_only=1
    else
      if [[ $number_only == 0 ]]; then
        args+=" ""$arg"
        continue
      fi
      if [[ "$arg" == "-*" ]]; then
        args+=" ""$arg"
      fi
    fi
  done
  # echo "$args"
  # echo "$number_only"
  if [[ $number_only -gt 0 ]]; then
    # Too simple code, only the base use case is handled now.
    # Convenient but incomplete.
    # With more time,
    # the simpler would be to submit a patch to GNU coreutils,
    # unless blockade from assholes.
    # Otherwise, it may be more simply handled in PHP or Python
    # (argparse, etc.).
    # You'll need to start by improving cat first,
    # with --files0-from handling.
    # echo "hack cat '${!#}' | wc $args"
    cat "${!#}" | wc "${args[@]}"
  else
    # echo "normal"
    wc "${args[@]}"
  fi
}

# I submitted a patch for wc :).
# echo "https://domain/list-path/2024-05/msg00013.html" | \
#   sed -e 's|domain|lists.gnu.org|' \
#       -e 's|list-path|archive/html/bug-coreutils|'
# I found another way to have a long URL fit on 70 characters.
# If it is merged, the following would be better:
# If --no-filenames option available,
# we redefine ll_wc command as an alias.
wc_help_text=$(wc --help)
if [[ "$wc_help_text" == *" --no-filenames "* ]]; then
  alias ll_wc='wc'
fi

in_place_grep(){
  grep $@ > "${!#}"".temp_in_place_grep"
  lines_before=$(ll_wc -l -n "${!#}")
  lines_after=$(ll_wc -l -n "${!#}"".temp_in_place_grep")
  # echo "$lines_before"
  # echo "$lines_after"
  if [[ "$lines_before" ==  "$lines_after" ]]; then
    rm "${!#}"".temp_in_place_grep"
    return
  fi
  mv "${!#}"".temp_in_place_grep" "${!#}"
}

grep_variable(){
  # $1=$file
  # $2=$variable_name
  regexp="(?<=^$2=).*$"
  # echo $regexp
  variable_value="$(grep -oP "$regexp" "$1")"
  # echo $variable_value
  declare -g $2="$variable_value"
}

empty_lines(){
  grep '^$'
}

not_empty_lines(){
  grep -v '^$'
}

space_starting_lines(){
  grep '^[ ]'
}

not_space_starting_lines(){
  grep '^[^ ]'
}

empty_lines_after_filename(){
  grep '^[^:]\+:$'
}

not_empty_lines_after_filename(){
  grep -v '^[^:]\+:$'
}

space_starting_lines_after_filename(){
  grep '^[^:]\+: '
}

not_space_starting_lines_after_filename(){
  grep '^[^:]\+:[^ ]'
}

not_JS_dependencies_find(){
  grep -vE "(^|/)node_modules/" | grep -vE "(^|/)package-lock\.json$"
}

not_JS_dependencies_grep(){
  grep -v "^[^:]*node_modules/" | grep -v "^[^:]*package-lock\.json:"
}

not_dependencies_find(){
  not_JS_dependencies_find
}

not_dependencies_grep(){
  not_JS_dependencies_grep
}

not_python_cache_find(){
  grep -vE "(^|/)__pycache__/" | grep -vE "(^|/)\.mypy_cache/"
}

not_python_cache_grep(){
  grep -v "^[^:]*__pycache__/" | grep -v "^[^:]*\.mypy_cache/"
}

not_cache_find(){
  not_python_cache_find
}

not_cache_grep(){
  not_python_cache_grep
}

not_git_find(){
  grep -vE "(^|/)\.git/"
}

not_git_grep(){
  grep -v "^[^:]*\.git/"
}

not_archive_find(){
  grep -vE "(\.gz|\.rar|\.tar|\.tgz|\.whl)$"
}

not_archive_grep(){
  grep -vE "^[^:]*(\.gz|\.rar|\.tar|\.tgz|\.whl):"
}

not_license_find(){
  grep -vE "(^|/)COPYING$" | grep -vE "(^|/)COPYING\.LESSER$"
}

not_license_grep(){
  grep -v "^[^:]*COPYING:" | grep -v "^[^:]*COPYING\.LESSER:"
}

not_main_tex_find(){
  grep -vE "(^|/)$main_directory\.tex$"
}

not_main_tex_grep(){
  grep -v "^[^:]*$main_directory\.tex:"
}

relevant_find(){
  not_dependencies_find | not_cache_find | not_git_find\
  | not_archive_find
}

relevant_grep(){
  not_dependencies_grep | not_cache_grep | not_git_grep\
  | not_archive_grep
}
