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
# This file was renamed from "upgrade_build_and_checks.sh"
# to "upgrade_build_and_checks.exec.sh".

upgrade_build_and_checks(){
  local LFBFL_verbose=""
  if [[ "$*" == *--verbose* ]]; then
    echo "$0 $*"
    LFBFL_verbose="--verbose"
  fi
  local LFBFL_fixed_point_build=""
  if [[ "$*" == *--fixed_point_build* ]]; then
    LFBFL_fixed_point_build="--fixed_point_build"
  fi
  readonly LFBFL_verbose
  (\
    cd build_and_checks_dependencies/\
    && ./update_common_build_and_checks.exec.sh "${LFBFL_verbose}"\
  )
  ./build_and_checks.exec.sh "." "${LFBFL_verbose}"\
    "${LFBFL_fixed_point_build}"
}

upgrade_build_and_checks "$@"
