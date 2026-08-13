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

some_diff(){
  for ((i=0; i < 1000; ++i)); do
    # shellcheck disable=SC2312
    diff --suppress-common-lines\
      build_and_checks_variables/phpmd_baseline.xml\
      build_and_checks_variables/temp/phpmd_baseline.xml\
      | grep --invert-match\
        --regexp='<!-- '\
        --regexp='^[0-9]\+d[0-9]\+$'\
        --regexp='^[0-9]\+,[0-9]\+d[0-9]\+$'
  done
}

some_diff2(){
  for ((i=0; i < 1000; ++i)); do
    # shellcheck disable=SC2312
    diff --suppress-common-lines\
      build_and_checks_variables/phpmd_baseline.xml\
      build_and_checks_variables/temp/phpmd_baseline.xml\
      | grep --invert-match\
        --regexp='<!-- '\
        --regexp='^[0-9]\+\(,[0-9]\+\)\?d[0-9]\+$'
  done
}

some_diff3(){
  for ((i=0; i < 1000; ++i)); do
    # shellcheck disable=SC2312
    diff --suppress-common-lines\
      build_and_checks_variables/phpmd_baseline.xml\
      build_and_checks_variables/temp/phpmd_baseline.xml\
      | grep --invert-match\
        --regexp='\(<!-- \|^[0-9]\+d[0-9]\+$\|^[0-9]\+,[0-9]\+d[0-9]\+$\)'
  done
}

some_diff4(){
  for ((i=0; i < 1000; ++i)); do
    # shellcheck disable=SC2312
    diff --suppress-common-lines\
      build_and_checks_variables/phpmd_baseline.xml\
      build_and_checks_variables/temp/phpmd_baseline.xml\
      | grep --invert-match\
        --regexp='\(<!-- \|^[0-9]\+\(,[0-9]\+\)\?d[0-9]\+$\)'
  done
}

#$ time some_diff
# real	0m1,663s
# user	0m0,795s
# sys	0m1,975s
#$ time some_diff2
# real	0m1,597s
# user	0m0,705s
# sys	0m2,009s
#$ time some_diff3
# real	0m1,619s
# user	0m0,758s
# sys	0m1,969s
#$ time some_diff4
# real	0m1,574s
# user	0m0,750s
# sys	0m1,932s
