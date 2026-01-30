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
  LFBFL_correct_sha512='38ae695f213ef1c7470a707eaf84d9377e6e636098851'
  LFBFL_correct_sha512+='0878ec6bc7b8f1d37a104816723a2de0327758dec492'
  LFBFL_correct_sha512+='09b2f2535671580d1146b8576cd78bc683c3f2c'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"
  chmod +x "./${LFBFL_file_path}"

  LFBFL_file_name="check_shell_scripts_beginnings.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='c07397f927063fbe31e973461b77d7844ccab1a0db498'
  LFBFL_correct_sha512+='ae9282114f65e6faf3fbe4eb1cd220a1b029334e4f3b'
  LFBFL_correct_sha512+='9139721bb3123b83512df8817c06c00d4a4d559'
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
  LFBFL_correct_sha512='ffed791dabbae1b841fab8b34a2f6d74ec2fa058a1dd5'
  LFBFL_correct_sha512+='010a2cd222f76811f594659bd60ab18839b2aab7d74b'
  LFBFL_correct_sha512+='19641fdaf7668524b079280d46da62d491b7f70'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="create_PDF.exec.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='5a44f7a88c8cc8768de49d7ff1ebc11f8fea6fad9d722'
  LFBFL_correct_sha512+='7a0a4724fd17eb5686086394baa386ecea87c6e50286'
  LFBFL_correct_sha512+='2a6162a2751d04ee44289bf72f6790633cf6956'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"
  chmod +x "./${LFBFL_file_path}"

  LFBFL_file_name="generate_from_template.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='6687afda93cc8d45177eace4ade4e68a1bb9cc88a58e2'
  LFBFL_correct_sha512+='94029ecbacb2c9b6d868bc868647f4262360fab21119'
  LFBFL_correct_sha512+='7663df209b1ab969b5c672afa9c5336cf7bd8c4'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="get_common_text_glob_patterns.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='2b87067b4fb0b3ca6c107fdf76cb605a4e9311375cc0e'
  LFBFL_correct_sha512+='7d0735d4b6a2c182cf738a2f0b91b7210bfa63452943'
  LFBFL_correct_sha512+='89930f17bebad69c64389e47afe8d74ec462216'
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
  LFBFL_correct_sha512='c2fee55a889b379a3de67f0c425821bd2d7876df81221'
  LFBFL_correct_sha512+='b7e5deca4cad459e80713ad834adeb5598e2565a8ef4'
  LFBFL_correct_sha512+='5b55c63eb76ea78cc085c97cd6dc3342b6fd21b'
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
  LFBFL_correct_sha512='61af110e6d03c7f86dc79361c37896e7e3d4fdea18a6d'
  LFBFL_correct_sha512+='b5ffe196ad314422e8479dfb4707c176b249a55509ff'
  LFBFL_correct_sha512+='8413cdf44e130c691200c1e646ce59db14e9b35'
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
  LFBFL_correct_sha512='4a1203b1384133f546b30e2a57f3322b84da0ffc52a5b'
  LFBFL_correct_sha512+='9a75a88d6f96dd6a8c79799f046a28173bb9cf22b5ec'
  LFBFL_correct_sha512+='84f79fcf787aaa4c8bd6f4b6afc0505d3d43362'
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
  LFBFL_correct_sha512='e55922c93c3eaf220c101c0133e2b9b5df50bb24f9683'
  LFBFL_correct_sha512+='21c696dbec80a2207592cf9e7f3270e5fe3a4570ea11'
  LFBFL_correct_sha512+='9f711405efa83894b88ebac85193b8cf98f39d4'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="split_score.libr.php"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='83f3eda17203b34c656353883806d3b2154911cc4d4f7'
  LFBFL_correct_sha512+='592a42413dc9f24bbd08f72bc51d20f9ca26d06d6861'
  LFBFL_correct_sha512+='6c40a2b08517ae25bb3bd87c33c28ab4bd8fdf8'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="strings_functions.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='90569be3419610c3ebff08c98ae9dfb4bdbed722767ab'
  LFBFL_correct_sha512+='4ab5dab201bb8f88f8354fe3b6bff7a7ea9bc5b04a9d'
  LFBFL_correct_sha512+='23071fad903ffd8e91ec50d0d3b2e5e9b6545fa'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="too_long_code_lines.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='69d3b3750ee5e119b3ce4b9a6a3420056fae903a28787'
  LFBFL_correct_sha512+='0c6047df0883cf623925cc2774d1843996b91093611f'
  LFBFL_correct_sha512+='97785dc3087769904aeffe3084887e97a736aed'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="update_or_check_files_names_listing.exec.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='a0ec8202dcc962e5cbaf7908f285c9a182e6298dedaab'
  LFBFL_correct_sha512+='af3d7b04369cf4e8639920b13b1dcc78d97bf195a202'
  LFBFL_correct_sha512+='884d02c0c6c38982cf82ddcb673617d624ad900'
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
      read -r -n 1 -t 10 -p "Upgrade venvs? [Y/n]"\
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
  echo "---Python end---"

  if [[ LFBFL_upgrade_venvs -eq 1 ]]; then
    touch "${LFBFL_upgrade_venvs_ts_file}"
  fi

  echo "Analyzing too long lines"
  # shellcheck disable=SC2312
  too_long_code_lines | relevant_grep | not_license_grep

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
