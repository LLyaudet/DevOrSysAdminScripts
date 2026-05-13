#!/usr/bin/env bash
# This file is part of DevOrSysAdminScripts.
#
# DevOrSysAdminScripts is free software:
# you can redistribute it and/or modify it
# under the terms of the GNU General Public License
# as published by the Free Software Foundation,
# either version 3 of the License,
# or (at your option) any later version.
#
# DevOrSysAdminScripts is distributed
# in the hope that it will be useful,
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
# This file was renamed from "upgrade_build_and_checks.sh"
# to "upgrade_build_and_checks.exec.sh".

upgrade_build_and_checks(){
  # Options:
  #   --add-test-files
  #   --check-download=y|keep (=keep to keep the downloaded files)
  #   --fixed-point-build
  #   --verbose
  local LFBFL_verbose=""
  if [[ "$*" == *--verbose* ]]; then
    printf "%s %s\n" "$0" "$*"
    LFBFL_verbose="--verbose"
  fi
  readonly LFBFL_verbose
  local LFBFL_fixed_point_build=""
  if [[ "$*" == *--fixed-point-build* ]]; then
    LFBFL_fixed_point_build="--fixed-point-build"
  fi
  readonly LFBFL_fixed_point_build
  local LFBFL_check_download=""
  if [[ "$*" == *--check-download=keep* ]]; then
    LFBFL_check_download="--check-download=keep"
  elif [[ "$*" == *--check-download=y* ]]; then
    LFBFL_check_download="--check-download=y"
  fi
  readonly LFBFL_check_download
  declare -i LFBFL_add_test_files=0
  if [[ "$*" == *--add-test-files* ]]; then
    LFBFL_add_test_files=1
  fi
  readonly LFBFL_add_test_files
  declare -i LFBFL_remove_test_files=0
  if [[ "$*" == *--remove-test-files* ]]; then
    LFBFL_remove_test_files=1
  fi
  readonly LFBFL_remove_test_files
  (\
    cd build_and_checks_dependencies/\
    && ./update_common_build_and_checks.exec.sh "${LFBFL_verbose}"\
  )

  declare -i LFBFL_i
  local LFBFL_file_path="miscellaneous/123456789012345678901234567890"
  declare -i LFBFL_digit
  if [[ LFBFL_add_test_files -eq 1 ]]; then
    mkdir --parents -- --a/
    {
      printf "<?php\nfunction my_function(:;){\n\n}\n"
      # shellcheck disable=SC2016
      printf '$my_variable = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
      printf 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";\n'
    } > --a.php
    cp -- --a.php --a/
    {
      printf "from typing import Iterable\n"
      printf "from _collections_abc import dict_items\n"
      printf "\n"
      printf "from python_none_objects import NoneIterable\n"
      printf "\n"
      printf "def my_function(my_argument : int) -> None:\n"
      printf "  print(my_argument)\n"
      printf "\n"
      printf "my_function(\"abcd\")\n"
      printf "\n"
      printf "def my_function2(my_argument : int) -> None:\n"
      printf "    \"\"\"Some comment.\"\"\"\n"
      printf "    print(my_argument)\n"
      printf "\n"
      printf "def my_function3(my_argument : int) -> None:\n"
      printf "    \"\"\"Some comment.\"\"\"\n"
      printf "\n"
      printf "    print(my_argument)\n"
      printf "\n"
      printf "def my_function4(my_argument : int):\n"
      printf "    \"\"\"Some comment.\"\"\"\n"
      printf "    def my_sub_function():\n"
      printf "        print(my_argument)\n"
      printf "    return my_sub_function\n"
      printf "\n"
      printf "def my_function5(my_argument : int):\n"
      printf "    \"\"\"Some comment.\"\"\"\n"
      printf "\n"
      printf "    def my_sub_function():\n"
      printf "        print(my_argument)\n"
      printf "    return my_sub_function\n"
      printf "\n"
    } > --a.py
    cat -- --a.py
    cp -- --a.py --a/
    {
      printf "def my_function(:;):\n\n\n"
      printf 'my_variable = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
      printf 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";\n'
    } > --a2.py
    cat -- --a2.py
    cp -- --a2.py --a/
    {
      # Error 0 is missing shell header.
      printf "my_function(){\n"
      printf "   # Error 1: Indentation is not correct.\n"
      printf "  sed -e 's/a/b/g' \\\\\n"
      printf "      -e 's/a/b/g' \"\$1\" # Indentation is correct.\n"
      printf "  my_variable=\"%%s\\n\"\n"
      # shellcheck disable=SC2016
      printf '  printf "${my_variable}"  # Error 2: shellcheck warning\n'
      local LFBFL_ttp="ttp"
      local LFBFL_URL="h${LFBFL_ttp}://example.com"
      printf '  printf "%s" # Error 3: http -> https\n' "${LFBFL_URL}"
      # shellcheck disable=SC2016
      printf '  printf "${#some_'
      printf 'arr_1}" # Error 4: no_size_of_array_first_element\n'
      # shellcheck disable=SC2016
      printf '  printf "${#'
      printf 'arr_1}"  # Error 5: no_size_of_array_first_element\n'
      printf '  if !'
      # shellcheck disable=SC2016
      printf ' [[ $1 -eq 1 ]]; # Error 6: no_negation_before_bash_test\n'
      printf '  then  # Error 7: misplaced then\n'
      printf '    my_variable="a"\n'
      printf '  fi\n'
      printf "\n"
      # shellcheck disable=SC2016
      printf '  if [[ $1 -eq 1 ]];\n'
      printf '  then  # Error 8: another case of misplaced then\n'
      printf '    my_variable="a"\n'
      printf '  fi\n'
      printf '  my_variable="aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
      printf 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"  # Error 9 line too long.\n'
      printf '}\n'
    } > --a.sh
    cp -- --a.sh --a/

    # We add a file with space in it for tests.
    touch "a b.sh"

    # The following files cannot be commited,
    # because the backslash in them breaks CodeFactor.io.
    for ((LFBFL_i = 1; LFBFL_i < 90; ++LFBFL_i)); do
      LFBFL_digit=$((LFBFL_i % 10))
      LFBFL_file_path+="${LFBFL_digit}"
      touch "${LFBFL_file_path}"
      touch "${LFBFL_file_path}\\"
    done
  fi
  ./build_and_checks.exec.sh "."\
    "${LFBFL_verbose}"\
    "${LFBFL_fixed_point_build}"\
    "${LFBFL_check_download}"
  if [[ LFBFL_add_test_files -eq 1 ]]; then
    cat -- --a.py
    cat -- --a2.py
  fi
  if [[ LFBFL_remove_test_files -eq 1 ]]; then
    rm --force --recursive -- --a/
    rm --force -- --a.php --a.py --a2.py --a.sh
    rm "a b.sh"
    for ((LFBFL_i = 1; LFBFL_i < 90; ++LFBFL_i)); do
      LFBFL_digit=$((LFBFL_i % 10))
      LFBFL_file_path+="${LFBFL_digit}"
      rm --force "${LFBFL_file_path}"
      rm --force "${LFBFL_file_path}\\"
    done
  fi
}

upgrade_build_and_checks "$@"
