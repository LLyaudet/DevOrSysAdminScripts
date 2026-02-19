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
# This file was renamed from "lines_filters.sh" to
# "lines_filters.libr.sh".

# The goal of this file is to have some common line filters
# for bash processing and pipes.
# As is the case for other .sh files in this repository,
# it can be copied somewhere in your home directory
# and sourced in your .bashrc.

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
  # Since then, they added it as ignored... (-n)
  declare -a ll_wc_var_args=()
  declare -i ll_wc_var_number_only=0
  declare -i ll_wc_var_i=0
  for ll_wc_var_arg in "$@"; do
    # echo "$ll_wc_var_arg"
    if [[ "${ll_wc_var_arg}" == "-n" ]]; then
      ll_wc_var_number_only=1
    elif [[ "${ll_wc_var_arg}" == "--no-filenames" ]]; then
      ll_wc_var_number_only=1
    elif [[ ll_wc_var_number_only -eq 0 ]]; then
      ll_wc_var_args[ll_wc_var_i]="${ll_wc_var_arg}"
      ll_wc_var_i=$((ll_wc_var_i + 1))
    elif [[ "${ll_wc_var_arg}" =~ -.* ]]; then
      ll_wc_var_args[ll_wc_var_i]="${ll_wc_var_arg}"
      ll_wc_var_i=$((ll_wc_var_i + 1))
    fi
  done
  # typeset -p ll_wc_var_args
  # echo "$ll_wc_var_number_only"
  if [[ ll_wc_var_number_only -gt 0 ]]; then
    # Too simple code, only the base use case is handled now.
    # Convenient but incomplete.
    # With more time,
    # the simpler would be to submit a patch to GNU coreutils,
    # unless blockade from assholes.
    # Otherwise, it may be more simply handled in PHP or Python
    # (argparse, etc.).
    # You'll need to start by improving cat first,
    # with --files0-from handling.
    # wc does not display file_name when stream...
    # hence cat of last arg "${!#}"
    # shellcheck disable=SC2312
    cat "${!#}"\
      | wc "${ll_wc_var_args[@]}"
  else
    # echo "normal"
    wc "${ll_wc_var_args[@]}"
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
if [[ "${wc_help_text}" == *" --no-filenames "* ]]; then
  alias ll_wc='wc'
fi

# Trace avant le (2e ?) renommage
# de wget_sha512.sh à wget_sha512.libr.sh.
# $ ll_wc wget_sha512.sh
#  41  189 1224 wget_sha512.sh
# $ ll_wc -n wget_sha512.sh
#     41     189    1224
# $ ll_wc -l wget_sha512.sh
# 41 wget_sha512.sh
# $ ll_wc -l -n wget_sha512.sh
# 41

in_place_grep(){
  declare -r LFBFL_temp="${!#}.in_place_grep.temp"
  grep "$@" > "${LFBFL_temp}"
  declare -r LFBFL_lines_before=$(ll_wc -l -n "${!#}")
  declare -r LFBFL_lines_after=$(ll_wc -l -n "${LFBFL_temp}")
  # echo "$LFBFL_lines_before"
  # echo "$LFBFL_lines_after"
  if [[ "${LFBFL_lines_before}" ==  "${LFBFL_lines_after}" ]]; then
    rm "${LFBFL_temp}"
    return
  fi
  mv "${LFBFL_temp}" "${!#}"
}

grep_variable(){
  # $1=$file
  # $2=$variable_name
  declare -r LFBFL_regexp="(?<=^$2=).*$"
  # echo $LFBFL_regexp
  declare -r LFBFL_variable_value="$(grep -oP "${LFBFL_regexp}" "$1")"
  # echo $LFBFL_variable_value
  declare -g "$2"="${LFBFL_variable_value}"
}

repository_name=""
grep_variable build_and_checks_variables/repository_data.txt\
  repository_name

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

empty_lines_after_file_name(){
  grep '^[^:]\+:$'
}

not_empty_lines_after_file_name(){
  grep -v '^[^:]\+:$'
}

space_starting_lines_after_file_name(){
  grep '^[^:]\+: '
}

not_space_starting_lines_after_file_name(){
  grep '^[^:]\+:[^ ]'
}

not_JS_dependencies_find(){
  # shellcheck disable=SC2312
  grep -vE -e "(^|/)node_modules/" -e "(^|/)package-lock\.json$"
}

not_JS_dependencies_grep(){
  # shellcheck disable=SC2312
  grep -vE -e "^([^:]+/)?node_modules/"\
    -e "^([^:]+/)?package-lock\.json:"
}

not_dependencies_find(){
  not_JS_dependencies_find
}

not_dependencies_grep(){
  not_JS_dependencies_grep
}

not_python_cache_find(){
  # shellcheck disable=SC2312
  grep -vE -e "(^|/)__pycache__/" -e "(^|/)\.mypy_cache/"\
    -e "(^|/)\.ruff_cache/"
}

not_python_cache_grep(){
  # shellcheck disable=SC2312
  grep -vE -e "^([^:]+/)?__pycache__/" -e "^([^:]+/)?\.mypy_cache/"\
    -e "^([^:]+/)?\.ruff_cache/"
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
  grep -vE "^([^:]+/)?\.git/"
}

not_archive_find(){
  grep -vE "(\.gz|\.rar|\.tar|\.tgz|\.whl)$"
}

not_archive_grep(){
  grep -vE "^[^:]*(\.gz|\.rar|\.tar|\.tgz|\.whl):"
}

not_license_find(){
  # shellcheck disable=SC2312
  grep -vE -e "(^|/)COPYING$" -e "(^|/)COPYING\.LESSER$"
}

not_license_grep(){
  # shellcheck disable=SC2312
  grep -vE -e "^([^:]+/)?COPYING:" -e "^([^:]+/)?COPYING\.LESSER:"
}

not_main_tex_find(){
  grep -vE "(^|/)${repository_name}\.tex$"
}

not_main_tex_grep(){
  grep -vE "^([^:]+/)?${repository_name}\.tex:"
}

not_main_html_find(){
  grep -vE "(^|/)${repository_name}\.html$"
}

not_main_html_grep(){
  grep -vE "^([^:]+/)?${repository_name}\.html:"
}

not_temp_file_find(){
  grep -vE "(^|/)build_and_checks_variables/temp/.*$"
}

not_temp_file_grep(){
  grep -vE "^([^:]+/)?build_and_checks_variables/temp/[^:]*:"
}

relevant_find(){
  # shellcheck disable=SC2312
  not_dependencies_find\
    | not_cache_find\
    | not_git_find\
    | not_archive_find\
    | not_temp_file_find
}

relevant_grep(){
  # shellcheck disable=SC2312
  not_dependencies_grep\
    | not_cache_grep\
    | not_git_grep\
    | not_archive_grep\
    | not_temp_file_grep
}
