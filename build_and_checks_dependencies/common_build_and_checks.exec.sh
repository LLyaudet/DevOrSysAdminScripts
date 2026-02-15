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
# The file "common_build_and_checks.exec.sh.tpl" was renamed from
# "common_build_and_checks.sh.tpl" to
# "common_build_and_checks.exec.sh.tpl".
# The file "common_build_and_checks.exec.sh" generated from the file
# "common_build_and_checks.sh.tpl"
# or "common_build_and_checks.exec.sh.tpl"
# was renamed from
# "common_build_and_checks.sh" to "common_build_and_checks.exec.sh".

common_build_and_checks(){
  # $1 LFBFL_working_directory
  # $2 LFBFL_dependencies_URL
  # $3 optional --verbose
  declare -r LFBFL_working_directory="$1"
  # declare -r LFBFL_dependencies_URL="$2" too long
  declare -r LFBFL_start_URL="$2"
  local LFBFL_verbose=""
  if [[ "$3" == "--verbose" ]]; then
    echo "$0 $*"
    LFBFL_verbose="--verbose"
  fi
  readonly LFBFL_verbose

  # shellcheck disable=SC1091
  source ./wget_sha512.libr.sh

  LFBFL_subdir="build_and_checks_dependencies"
  local LFBFL_file_name
  local LFBFL_URL
  local LFBFL_file_path

  LFBFL_file_name="build_md_from_printable_md.exec.sh"
  # LFBFL_script_download_URL
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='6cbee842b2a9c9e3b25687ec8963254197c4279585e57'
  LFBFL_correct_sha512+='5e17436f8102e94d9df9b51d56c826e8aefc3d09e4e6'
  LFBFL_correct_sha512+='0ae748d10e076cf0bd592f57c8e342d1f7f0503'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"
  chmod +x "./${LFBFL_file_path}"

  LFBFL_file_name="check_shell_scripts_beginnings.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='e0cdfc2d653daf9f15a3447f40e41fe03a332ac4054c4'
  LFBFL_correct_sha512+='0950efc0b9f58912791068c081babf7a7a9e72bacd57'
  LFBFL_correct_sha512+='8e600bbb5e0c51466e60e91e5b6dda6173b088b'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="check_URLs.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='d966792d05fd23375f5006b5446b9b747a28f1ef1fe9d'
  LFBFL_correct_sha512+='b6f8ff45caa36564bb18ddc38ba91e076bb3abceced2'
  LFBFL_correct_sha512+='b899c7e5987a231c5165d6dacc9ec52cbe665f5'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="comparisons.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='f8b6956234b7d8c18278c262091627fe79d0c28e1978c'
  LFBFL_correct_sha512+='356baeb8d5a29cd32103ef23c71fd4fb59af1249edfb'
  LFBFL_correct_sha512+='dbc10c498e3fdb2cacb9af784916ac2276e8412'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="create_PDF.exec.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='0fcc6dcdb4a458281da4f8489818da89a9fcbbe1fc7d4'
  LFBFL_correct_sha512+='06427ed32fe45c1ac2b0b4d878770f2b531f5c80cd1e'
  LFBFL_correct_sha512+='484ae125243e0557c8489a908141ef13a3c009d'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"
  chmod +x "./${LFBFL_file_path}"

  LFBFL_file_name="generate_from_template.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='61dcd1140cb49211829553c92514eb2b28248b68bf502'
  LFBFL_correct_sha512+='38caed30f85975c67d2f8dc680161c5f2d981fcd39b8'
  LFBFL_correct_sha512+='87f4f081ef391ec9d0bb8e6fcd9e56ef9f10e06'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="get_common_text_glob_patterns.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='c9683a335ad75758d6793970d6aae87aaa8209c7b336e'
  LFBFL_correct_sha512+='43514b8cd409e543629214012125f56c73ecb9c35585'
  LFBFL_correct_sha512+='d815ad674ca078aca5f8d3e2b48c725585f6988'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="grammar_and_spell_check.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='a76c188a7769a1d170d415034331b1ca8574482bc1484'
  LFBFL_correct_sha512+='eccbbb4cadea825c0668caccaca7433fa1c476137fe9'
  LFBFL_correct_sha512+='f2a71ad6e0ee5bfbfd180bee5a775c997d79865'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  # /licenses_templates/ ---------------------------------------------
  declare -r LFBFL_subdir2="${LFBFL_subdir}/licenses_templates"
  declare -r LFBFL_start_URL2="${LFBFL_start_URL}/licenses_templates"
  LFBFL_file_name="build_licenses_templates.exec.sh"
  LFBFL_URL="${LFBFL_start_URL2}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir2}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='1f3d6f004b8bd5067896f8708390039c2572e8e62bec7'
  LFBFL_correct_sha512+='aa791ca8b0a05581293027eb3fad8eaf6bb779f48aab'
  LFBFL_correct_sha512+='e0c0f060c468070504f25f2304b53854fc48cc2'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"
  chmod +x "./${LFBFL_file_path}"

  LFBFL_file_name="license_file_header_AGPLv3+.tpl"
  LFBFL_URL="${LFBFL_start_URL2}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir2}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='9f9aa56d9b90d5003a12c5ec3370ac31aab74fc4a2524'
  LFBFL_correct_sha512+='2c5fbcb0197b0abbb8242f62dafc76eaf60faa5da173'
  LFBFL_correct_sha512+='05924b31b64b037083532fced9f98445000e2d0'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="license_file_header_GPLv3+.tpl"
  LFBFL_URL="${LFBFL_start_URL2}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir2}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='2bdef9a729a5a9ca5ed87ef8a518877c5ee6b31b45336'
  LFBFL_correct_sha512+='08660316a4e595fb31465a4847f4d53a2f7264118bd4'
  LFBFL_correct_sha512+='eab7c1d1892e00bc1861455ed02898f194db067'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="license_file_header_LGPLv3+.tpl"
  LFBFL_URL="${LFBFL_start_URL2}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir2}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='265fd0d086b48ab798f35a072335a4976e4eda8c256fe'
  LFBFL_correct_sha512+='bba6c77c98ca86cdd844c6ac150c3445c80debbb3fc2'
  LFBFL_correct_sha512+='574b5fceeeaf79ec734a759bdef5fe798067c62'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"
  # ------------------------------------------------------------------

  LFBFL_file_name="lines_counts.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='3e34b8768b4356adf397f3ca1f47ef8f44da42808ca8b'
  LFBFL_correct_sha512+='b95b830fa8bd9be46bb3cb1f012736b7a6d53549f8a9'
  LFBFL_correct_sha512+='f60274d6db5d9699bc28270a7d42deaaa6d6d6f'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="lines_filters.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='76d2dccb649501d1e458e2a07535cc9df63e1558d55eb'
  LFBFL_correct_sha512+='42c352844fc4338d0a438cd541cb2eb4d37c00e8ca02'
  LFBFL_correct_sha512+='885d15150762cb3d2a56c4997e29d6a73eefca1'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="lines_maps.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='ca4fbc93c407de6aa742b0d5e4ee767d341777d60b3e8'
  LFBFL_correct_sha512+='e08e8582babb5ee6b305d47e385c1701810691c46ec6'
  LFBFL_correct_sha512+='a34b5f740b8304114f96ee7052da095ee09c789'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="overwrite_if_not_equal.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='2b95072a4b123ec7db186e33a2bac47809721272ca22a'
  LFBFL_correct_sha512+='289d0d528b70bfa3d02d752fed46e6b091247c586ee2'
  LFBFL_correct_sha512+='229081c66cf9e2de98fc41563b570ef2fc67ff9'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="python_black_complement.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='e28c6e0cfffe6b8eebef26bddfbb440f0303d0dcc3987'
  LFBFL_correct_sha512+='6d498d95b9d589e0800b8381124936e5103b372f509c'
  LFBFL_correct_sha512+='aeb6213e909710a2ec1e345e076a44f0006fdbb'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="python_isort_complement.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='637cddfb803fd8866fa2ab1c72bbcd5b55e2c0068a14d'
  LFBFL_correct_sha512+='b6140ee00435a69990a6c5e08b6f0bf13ac9574a9ead'
  LFBFL_correct_sha512+='c59d9b5adcc8f6d99d4d56ca1cc5785c7b22835'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="split_score.exec.php"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='2f7ff107a43716109b1acbd7d89870d05577af00a981a'
  LFBFL_correct_sha512+='05f162a054c96387fb99544f8225c333b1212f74326c'
  LFBFL_correct_sha512+='f9ec6196e796f6257dfbba9347ac8c57b4f09db'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="split_score.libr.php"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='1413898a4fb4f31ca17993fd6110f7e1f32adf31c22c4'
  LFBFL_correct_sha512+='7fa46a31d3c1511a3112a611e04fac19bb838d4476d9'
  LFBFL_correct_sha512+='ecf77a28dd48d3d2732df7392c50e38262852d7'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="strings_functions.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='ef5a942ed4f938d66ffba9292ff998564cbbe37a111b7'
  LFBFL_correct_sha512+='eb83a6340c87a95b65d325103eb4dbc371dde6d31f72'
  LFBFL_correct_sha512+='339674c4b6550c7a30801156b273f74fb97a165'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="too_long_code_lines.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='be622620998f73fceabe75d4cb0d665fbba38ae987e2f'
  LFBFL_correct_sha512+='e1aa8dc9e0009234979c0f9e5a8d18e7a8a4653ab4da'
  LFBFL_correct_sha512+='a2d8249f696f5237fa4e026b9b1ce6346b2fd15'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="update_or_check_files_names_listing.exec.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='8d25ad17fa717e30ce348865cb112ef8d50ebbdc7ec86'
  LFBFL_correct_sha512+='05690b2bc6456c3de96b4588f7be3c7d7440837ac795'
  LFBFL_correct_sha512+='58333c83a99eea5d31389e0ae445e6e2faad3c7'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"
  chmod +x "./${LFBFL_file_path}"

  shopt -s globstar
  # shellcheck disable=SC1090
  source "./${LFBFL_subdir}/check_shell_scripts_beginnings.libr.sh"
  # shellcheck disable=SC1090
  source "./${LFBFL_subdir}/check_URLs.libr.sh"
  # shellcheck disable=SC1090
  source "./${LFBFL_subdir}/comparisons.libr.sh"
  # shellcheck disable=SC1090
  source "./${LFBFL_subdir}/generate_from_template.libr.sh"
  # shellcheck disable=SC1090
  source "./${LFBFL_subdir}/get_common_text_glob_patterns.libr.sh"
  # shellcheck disable=SC1090
  source "./${LFBFL_subdir}/grammar_and_spell_check.libr.sh"
  # shellcheck disable=SC1090
  source "./${LFBFL_subdir}/lines_counts.libr.sh"
  # shellcheck disable=SC1090
  source "./${LFBFL_subdir}/lines_filters.libr.sh"
  # shellcheck disable=SC1090
  source "./${LFBFL_subdir}/lines_maps.libr.sh"
  # shellcheck disable=SC1090
  source "./${LFBFL_subdir}/overwrite_if_not_equal.libr.sh"
  # shellcheck disable=SC1090
  source "./${LFBFL_subdir}/python_black_complement.libr.sh"
  # shellcheck disable=SC1090
  source "./${LFBFL_subdir}/python_isort_complement.libr.sh"
  # shellcheck disable=SC1090
  source "./${LFBFL_subdir}/strings_functions.libr.sh"
  # shellcheck disable=SC1090
  source "./${LFBFL_subdir}/too_long_code_lines.libr.sh"

  local LFBFL_data_file_name=\
"build_and_checks_variables/repository_data.txt"

  declare -i LFBFL_upgrade_venvs=0
  declare -r LFBFL_upgrade_venvs_ts_file=\
"build_and_checks_variables/upgrade_venvs_ts"
  declare -i LFBFL_upgrade_venvs_ts
  declare -i LFBFL_current_ts
  local LFBFL_upgrade_venvs_answer

  upgrade_venvs_time_interval_in_seconds=""
  grep_variable "${LFBFL_data_file_name}"\
     upgrade_venvs_time_interval_in_seconds
  if [[ "${upgrade_venvs_time_interval_in_seconds}" == "wat" ]]; then
    upgrade_venvs_time_interval_in_seconds=${RANDOM}
  fi
  if
   [[ "${upgrade_venvs_time_interval_in_seconds}" == "watyouwant?" ]];
  then
    upgrade_venvs_time_interval_in_seconds=${SRANDOM}
  fi

  if [[ -f "${LFBFL_upgrade_venvs_ts_file}" ]]; then
    LFBFL_upgrade_venvs_ts=\
$(stat -c %Y "${LFBFL_upgrade_venvs_ts_file}")
    LFBFL_current_ts=$(date +%s)
    ((LFBFL_current_ts-=LFBFL_upgrade_venvs_ts))
    ((LFBFL_current_ts-=upgrade_venvs_time_interval_in_seconds))
    if [[ LFBFL_current_ts -gt 0 ]]; then
      LFBFL_upgrade_venvs=1
    fi
  else
    LFBFL_upgrade_venvs=1
  fi
  if [[ LFBFL_upgrade_venvs -eq 1 ]]; then
    upgrade_venvs=""
    grep_variable "${LFBFL_data_file_name}" upgrade_venvs
    if [[ "${upgrade_venvs}" != "auto" ]]; then
      read -r -n 1 -t 10\
        -p "Upgrade venvs and composer global? [Y/n]"\
        LFBFL_upgrade_venvs_answer
      if [[ "${LFBFL_upgrade_venvs_answer}" == "n" ]]; then
        LFBFL_upgrade_venvs=0
      fi
    fi
  fi

  echo "Building license headers"
  "./${LFBFL_subdir2}/build_licenses_templates.exec.sh"\
    "${LFBFL_verbose}"

  echo "Building README.md"
  "./${LFBFL_subdir}/build_md_from_printable_md.exec.sh"\
    "${LFBFL_working_directory}" "README" "${LFBFL_verbose}"

  pushd .
  # shellcheck disable=SC2164
  cd "${LFBFL_working_directory}"

  echo "Running shellcheck"
  declare -i LFBFL_file_path_length
  declare -i LFBFL_to_skip_number
  local LFBFL_file_path_end
  # shellcheck disable=SC2312
  find . -name "*.sh" | relevant_find | while read -r LFBFL_file_path;
  do
    LFBFL_file_path_length=${#LFBFL_file_path}
    LFBFL_to_skip_number=$((LFBFL_file_path_length - 9))
    LFBFL_file_path_end="${LFBFL_file_path:${LFBFL_to_skip_number}}"
    if [[ "${LFBFL_file_path_end}" == "GPLv3+.sh" ]]; then
      continue
    fi
    shellcheck --check-sourced --enable=all --external-sources\
      "${LFBFL_file_path}"
  done

  echo "---Python---"
  echo "Running isort"
  isort_venv=""
  grep_variable "${LFBFL_data_file_name}" isort_venv
  if [[ -n "${isort_venv}" ]]; then
    if command -v deactivate
    then
      deactivate
    fi
    # shellcheck disable=SC1090,SC1091
    source "${isort_venv}/bin/activate"
  fi
  if [[ LFBFL_upgrade_venvs -eq 1 ]]; then
    pip install --upgrade isort
  fi
  isort .
  if [[ -n "${isort_venv}" ]]; then
    deactivate
  fi
  python_isort_complement

  echo "Running black"
  black_venv=""
  grep_variable "${LFBFL_data_file_name}" black_venv
  if [[ -n "${black_venv}" ]]; then
    if command -v deactivate
    then
      deactivate
    fi
    # shellcheck disable=SC1090,SC1091
    source "${black_venv}/bin/activate"
  fi
  if [[ LFBFL_upgrade_venvs -eq 1 ]]; then
    pip install --upgrade black
  fi
  black .
  if [[ -n "${black_venv}" ]]; then
    deactivate
  fi
  python_black_complement

  mypy_venv=""
  grep_variable "${LFBFL_data_file_name}" mypy_venv
  if [[ -n "${mypy_venv}" ]]; then
    if command -v deactivate
    then
      deactivate
    fi
    # shellcheck disable=SC1090,SC1091
    source "${mypy_venv}/bin/activate"
  fi
  if [[ LFBFL_upgrade_venvs -eq 1 ]]; then
    pip install --upgrade mypy
  fi
  shopt -s lastpipe
  local LFBFL_directory_path
  declare -i LFBFL_no_toml=1
  # shellcheck disable=SC2312
  find . -name "pyproject.toml" | relevant_find\
    | while read -r LFBFL_file_path;
  do
    if grep -q "Typing :: Typed" "${LFBFL_file_path}"; then
      echo "Running mypy"
      LFBFL_directory_path=$(dirname "${LFBFL_file_path}")
      mypy "${LFBFL_directory_path}"
    fi
    LFBFL_no_toml=0
  done
  if [[ LFBFL_no_toml -eq 1 ]]; then
    echo "Running mypy"
    mypy .
  fi
  if [[ -n "${mypy_venv}" ]]; then
    deactivate
  fi

  echo "Running bandit"
  bandit_venv=""
  grep_variable "${LFBFL_data_file_name}" bandit_venv
  if [[ -n "${bandit_venv}" ]]; then
    if command -v deactivate
    then
      deactivate
    fi
    # shellcheck disable=SC1090,SC1091
    source "${bandit_venv}/bin/activate"
  fi
  if [[ LFBFL_upgrade_venvs -eq 1 ]]; then
    pip install --upgrade bandit
  fi
  bandit --ini build_and_checks_variables/bandit.ini\
    -b build_and_checks_variables/bandit_baseline.json\
    -r .
  # Saving new baseline in temp if necessary.
  bandit --ini build_and_checks_variables/bandit.ini\
    -f json -o build_and_checks_variables/temp/bandit_baseline.json\
    -r .
  if [[ -n "${bandit_venv}" ]]; then
    deactivate
  fi

  echo "Running pylint"
  pylint_venv=""
  grep_variable "${LFBFL_data_file_name}" pylint_venv
  if [[ -n "${pylint_venv}" ]]; then
    if command -v deactivate
    then
      deactivate
    fi
    # shellcheck disable=SC1090,SC1091
    source "${pylint_venv}/bin/activate"
  fi
  if [[ LFBFL_upgrade_venvs -eq 1 ]]; then
    pip install --upgrade pylint
  fi
  pylint --rcfile build_and_checks_variables/pylintrc.toml\
    --recursive=y .
  if [[ -n "${pylint_venv}" ]]; then
    deactivate
  fi

  echo "Running ruff"
  ruff_venv=""
  grep_variable "${LFBFL_data_file_name}" ruff_venv
  if [[ -n "${ruff_venv}" ]]; then
    if command -v deactivate
    then
      deactivate
    fi
    # shellcheck disable=SC1090,SC1091
    source "${ruff_venv}/bin/activate"
  fi
  if [[ LFBFL_upgrade_venvs -eq 1 ]]; then
    pip install --upgrade ruff
  fi
  ruff check --config build_and_checks_variables/ruff.toml
  if [[ -n "${ruff_venv}" ]]; then
    deactivate
  fi
  echo "---Python end---"

  echo "---PHP---"
  echo "Running PHPMD"
  if [[ LFBFL_upgrade_venvs -eq 1 ]]; then
    composer global require phpmd/phpmd
  fi
  phpmd --color\
    --baseline-file build_and_checks_variables/phpmd_baseline.xml\
    . text cleancode,codesize,controversial,design,naming,unusedcode
  # Saving new baseline in temp if necessary.
  rm build_and_checks_variables/temp/phpmd_baseline.xml
  phpmd --color --generate-baseline\
   --baseline-file build_and_checks_variables/temp/phpmd_baseline.xml\
   . text cleancode,codesize,controversial,design,naming,unusedcode
  echo "---PHP end---"

  if [[ LFBFL_upgrade_venvs -eq 1 ]]; then
    touch "${LFBFL_upgrade_venvs_ts_file}"
  fi

  echo "Analyzing too long lines"
  too_long_code_lines

  echo "Analyzing shell scripts beginnings"
  # shellcheck disable=SC2312
  check_shell_scripts_beginnings | relevant_grep

  echo "Analyzing URLs"
  # shellcheck disable=SC2312
  check_URLs | relevant_grep

  echo "Analyzing strange characters: hover over in doubt"
  # shellcheck disable=SC1111
  LFBFL_usual_characters="\x00-\x7Fàâéèêëîïôûç©“”└─├│«»"
  # shellcheck disable=SC2312
  grep --exclude-dir .git --color=always\
    -nPr "[^${LFBFL_usual_characters}]" .

  echo "Checking listed files"
  "./${LFBFL_subdir}/update_or_check_files_names_listing.exec.sh"

  echo "Creating the PDF file of the listing of the source code"
  "./${LFBFL_subdir}/create_PDF.exec.sh" "${LFBFL_verbose}"

  # shellcheck disable=SC2164
  popd
}

common_build_and_checks "$@"
