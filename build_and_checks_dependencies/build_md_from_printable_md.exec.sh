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
# This file was renamed from "build_md_from_printable_md.sh"
# to "build_md_from_printable_md.exec.sh".

LFBFL_subdir="build_and_checks_dependencies"
# shellcheck source=common_options.libr.sh
source "./${LFBFL_subdir}/common_options.libr.sh"
# shellcheck source=overwrite_if_not_equal.libr.sh
source "./${LFBFL_subdir}/overwrite_if_not_equal.libr.sh"

build_md_from_printable_md(){
  # Options:
  #   --verbose
  #   --work-directory=""
  #   --base-name="README"
  declare -i LFBFL_i_verbose=0
  get_verbose_option "$@"
  local LFBFL_work_directory=""
  get_work_directory_option "$@"
  pushd_to_work_directory\
    && trap 'popd_from_work_directory' RETURN
  can_continue_after_enhanced_pushd || return 1

  local LFBFL_base_name="README"
  local LFBFL_arg
  for LFBFL_arg in "$@"; do
    if [[ "${LFBFL_arg}" == --base-name=* ]]; then
      LFBFL_base_name=${LFBFL_arg#--base-name=}
      if [[ LFBFL_i_verbose -eq 1 ]]; then
        printf "Searching md file: %s.\n" "${LFBFL_base_name}"
      fi
      break
    fi
  done
  readonly LFBFL_base_name

  # Remove line returns here to keep lines short.
  local LFBFL_sed_expression
  LFBFL_sed_expression='s/(\[[a-zA-Z0-9:-]*\]: [^\n\\]*)\\\n/\1/Mg'
  LFBFL_sed_expression+=';s/(<http[^\n\\]*)\\\n/\1/Mg'
  LFBFL_sed_expression+=';s/(- <http[^\n\\]*)\\\n/\1/Mg'
  readonly LFBFL_sed_expression
  # Since Markdown can contain code, it is limited to Markdown URLs.
  # Hence it is way more complicated than 's/\\\n//Mg' expression
  # in other files.
  # Another downside is that more than one pass is needed.

  if [[ -f "${LFBFL_base_name}.md.tpl" ]]; then
    sed -Ez -e "${LFBFL_sed_expression}"\
            -e "${LFBFL_sed_expression}"\
            -e "${LFBFL_sed_expression}"\
            -e "${LFBFL_sed_expression}"\
      "${LFBFL_base_name}.md.tpl"\
      > "${LFBFL_base_name}.md.temp"
    overwrite_if_not_equal "${LFBFL_base_name}.md"\
      "${LFBFL_base_name}.md.temp"
  else
    printf "No file %s.md.tpl\n" "${LFBFL_base_name}"
  fi

  pandoc --from markdown --to html --standalone\
    --shift-heading-level-by=-1 "${LFBFL_base_name}.md"\
    -o "${LFBFL_base_name}.html.temp"
  # Correcting pandoc HTML "by hand".
  # https://github.com/jgm/pandoc/issues/10957
  # With the most open-minded answer found on Internet ;) XD.
  # This second sed expression is what I need,
  # but it may be unsuitable for you.
  # Other problems:
  # https://github.com/jgm/pandoc/issues/11484
  local LFBFL_prewrap="s~(code \{(\n|[^}])*)(    \})"
  LFBFL_prewrap+="~\1      white-space: pre-wrap;\n\3~M"
  readonly LFBFL_prewrap
  sed -i -E -e 's~(  <meta .*) />~\1>~g'\
            -e 's~<html .*>~<html lang="en">~'\
            -e '/    code\{white-space: pre-wrap;\}/d'\
    "${LFBFL_base_name}.html.temp"
  sed -i -Ez -e 's~(<img(\n|[^a-z0-9])(\n|[^>])*) />~\1>~Mg'\
             -e "${LFBFL_prewrap}"\
    "${LFBFL_base_name}.html.temp"
  overwrite_if_not_equal "${LFBFL_base_name}.html"\
    "${LFBFL_base_name}.html.temp"

  # java -Xss128M -jar "../jar_venv/vnu.jar" --exit-zero-always\
  #   --verbose ${LFBFL_base_name}.html"
}

build_md_from_printable_md "$@"
