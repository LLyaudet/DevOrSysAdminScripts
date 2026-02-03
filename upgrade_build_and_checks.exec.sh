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
  readonly LFBFL_verbose
  (\
    cd build_and_checks_dependencies/\
    && ./update_common_build_and_checks.exec.sh "${LFBFL_verbose}"\
  )
  ./build_and_checks.exec.sh "." "${LFBFL_verbose}"
}

if [[ "$*" == *--fixed_point_build* ]]; then
  # shellcheck disable=SC2124
  LFBFL_repository_name="${@: $#}"
  echo "--fixed_point_build"
  # Touching the 3 following files first let us iterate
  # upgrade_build_and_checks 2 times instead of 3 to reach
  # a fixed point.
  touch "./build_and_checks_variables/${LFBFL_repository_name}.tex"
  touch "./${LFBFL_repository_name}.pdf"
  touch "./${LFBFL_repository_name}.html"
  # The two iterations of upgrade_build_and_checks needs to complete
  # during the same minute to have a fixed point.
  upgrade_build_and_checks "$@"
  upgrade_build_and_checks "$@"
  # Then calling this script without --fixed_point_build should not
  # yield any new superficial modifications.
else
  upgrade_build_and_checks "$@"
fi
