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
# This file was renamed from "python_black_complement.sh"
# to "python_black_complement.libr.sh".

# shellcheck source=common_options.libr.sh
source "./build_and_checks_dependencies/common_options.libr.sh"

# It was rejected to enhance black with this currently.
# https://github.com/psf/black/issues/2370
# And moreover, at some point, I saw the reverse rule
# in black or pylint to add an empty line...
# This regexp may give false positives,
# but that's not the end of the world.
check_no_empty_line_after_python_function_docstring(){
  # Options:
  #   --verbose
  #   --work-directory=""
  declare -i LFBFL_i_verbose=0
  get_verbose_option "$@"
  local LFBFL_work_directory=""
  get_work_directory_option "$@"
  pushd_to_work_directory\
    && trap 'popd_from_work_directory' RETURN
  can_continue_after_enhanced_pushd || return 1

  enhanced_set_bash_option globstar\
    && trap 'enhanced_unset_bash_option globstar' RETURN

  [[ LFBFL_i_verbose -eq 1 ]]\
    && printf "Checking empty lines after Python function docstrings\n"
  pcre2grep -M --\
    $'def ([^"]|"(?!""))*"""([^"]|"(?!""))*"""\n\n(?!\s*def)'\
    **/*.py
}

python_black_complement(){
  # Options:
  #   --verbose
  #   --work-directory=""
  # shellcheck disable=SC2034
  declare -i LFBFL_i_verbose=0
  get_verbose_option "$@"
  local LFBFL_work_directory=""
  get_work_directory_option "$@"
  pushd_to_work_directory\
    && trap 'popd_from_work_directory' RETURN
  can_continue_after_enhanced_pushd || return 1

  check_no_empty_line_after_python_function_docstring "$@"
}
