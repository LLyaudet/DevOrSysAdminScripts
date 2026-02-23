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
  if [[ "$*" == *--verbose* ]]; then
    echo "$0 $*"
    LFBFL_verbose="--verbose"
  fi
  readonly LFBFL_verbose

  if [[ ! -o pipefail ]]; then
    [[ "${LFBFL_verbose}" == "--verbose" ]]\
      && echo "pipefail option activated"
    set -o pipefail
    trap 'set +o pipefail' RETURN
  fi

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
  LFBFL_correct_sha512='5e6560b6f4d0792ab065e5ee5746560d68aa8e0609ffe'
  LFBFL_correct_sha512+='953fabd5e4bc740c972956375b043f1556dee03aa49a'
  LFBFL_correct_sha512+='3a6edf10bd6e2586141baf435ce35d78df2213f'
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

  LFBFL_file_name="check_shell_scripts_indentation.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='3ea84e05116a57d056431466256ec71c6530a563acd4e'
  LFBFL_correct_sha512+='e4aad13cc4116ae7875dba2deb7d6022b399c2023f5b'
  LFBFL_correct_sha512+='e11a0fdc980083ac886803dd19cfacc27da26e0'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="check_URLs.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='bd3d085710ce3ee75034daea6286adc21b0309cf3004a'
  LFBFL_correct_sha512+='41b65af1878bed263c392dd8159716996420abb03cb8'
  LFBFL_correct_sha512+='34d9b91c8859bdf8455c5b9d85d9b8d80fec062'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="comparisons.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='1abcc547d6baf661c339489967108fd744321419e8e6d'
  LFBFL_correct_sha512+='2a25896280a23243106dc72be30a4f400caf6789e9be'
  LFBFL_correct_sha512+='740223b9e12d6155bb931aaf94bb946455c8c5c'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="create_PDF.exec.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='226edc0b170e6c903a7974a5ef5b3917ec2a38f0ae109'
  LFBFL_correct_sha512+='96a1a8d9b19d51aadaf56daecfca1d543e4f88052422'
  LFBFL_correct_sha512+='b2de449e9148e761c5fce4e74c405842fc22046'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"
  chmod +x "./${LFBFL_file_path}"

  LFBFL_file_name="generate_from_template.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='5779c3d2c64d0bb403525c410e37b0b06fcf1ef97d503'
  LFBFL_correct_sha512+='21fd27345545a8ebea020b2d3d809ac5c1bc66f9cebe'
  LFBFL_correct_sha512+='a8e8ea63aa539eaa179cf09a3860239c96df8e9'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="get_common_text_glob_patterns.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='4e0915efcc9a4088b1f79c9c7efbf7da5d68e8e1b21ff'
  LFBFL_correct_sha512+='feb4746c9d468be80affa30babf35938e15f9161db3e'
  LFBFL_correct_sha512+='3f6d95c913b86638563d7bd2995dc58a26f8e3a'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="grammar_and_spell_check.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='02715a24232540522fad3617c702ce7e0003242dffd32'
  LFBFL_correct_sha512+='174f7b823538bd618066328b1f71ff6888dfcde1e3ed'
  LFBFL_correct_sha512+='9ccacf09b0e2e9e8bbbc03b5e4453f33377ae4d'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  # /licenses_templates/ ---------------------------------------------
  declare -r LFBFL_subdir2="${LFBFL_subdir}/licenses_templates"
  declare -r LFBFL_start_URL2="${LFBFL_start_URL}/licenses_templates"
  LFBFL_file_name="build_licenses_templates.exec.sh"
  LFBFL_URL="${LFBFL_start_URL2}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir2}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='d3b80f26b922dbfbdf8ca44134b1350e0746d6703c2a7'
  LFBFL_correct_sha512+='1cd147ac7f870c52428d6b975a743f905254159658e8'
  LFBFL_correct_sha512+='6d66a3ea408b473e1f73911a2547b876077223b'
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
  LFBFL_correct_sha512='d8c22afd747f1e255b773edbf705030d0064f711dd5d9'
  LFBFL_correct_sha512+='4d8cb51049310f0fad2495103dfb7cd200500ebcc85d'
  LFBFL_correct_sha512+='884f087a2d54fe9a47bc5c5e58b68963ee432a8'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="lines_filters.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='d60575393ddf0ed29ad0b7f5e8614812de4c4d61ce094'
  LFBFL_correct_sha512+='b0e03dbc3298a7cd5696d5e5d4f875cfa51624e334e1'
  LFBFL_correct_sha512+='f8abd24fddfe688dde9bcd2afada03c9d9a468b'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="lines_maps.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='25c3e5082951260295b5f0e87ba1f2c978efdea1e8926'
  LFBFL_correct_sha512+='072ce4d2062dc2a47bb92b9098f081e553eeae5d9154'
  LFBFL_correct_sha512+='fdc50c9d88ae5365b776a23eb6e026b884a8374'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="overwrite_if_not_equal.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='8df9334f8204bdb9b098f638d15a3db2dd0ce4446203f'
  LFBFL_correct_sha512+='fe26678cb3c2b3b26cb0b89957490af5fa21c149a525'
  LFBFL_correct_sha512+='baf5e3d4999f432f9ff384616631cdc111507cf'
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
  LFBFL_correct_sha512='97a9fa46b975d81c68f910d5a7d1efcd476c1a4be6570'
  LFBFL_correct_sha512+='37066f5178cd5761d1079d86bd266a83000c37149327'
  LFBFL_correct_sha512+='3b8d7647da5dea4c962ea3a4c3643cb4e07b778'
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
  LFBFL_correct_sha512='d4236ad2b43dfebbaa3eead93b953f735821b8b3548d8'
  LFBFL_correct_sha512+='8e12f8f2e5640f03b329a61e7352bc561bc1aa35a6e5'
  LFBFL_correct_sha512+='65b93280b0521f714f20bb4f9fcf4c299da04a6'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="too_long_code_lines.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='4a293149e4a4c2c09405ecd689007755d172f4f8996a0'
  LFBFL_correct_sha512+='bbe8668d20a003a001f72d09a3bd46d07187de4788c4'
  LFBFL_correct_sha512+='54415ea3a428e7563b36963a7f12acb9850297d'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="update_or_check_files_names_listing.exec.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='11b509de8c58906143b8b7152b636313e86bf3de748d7'
  LFBFL_correct_sha512+='20ccc70ecae35379ab3c568dec2e746378609fda229c'
  LFBFL_correct_sha512+='e644f24ac30e8c5958d0af12e529afc818d5422'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"
  chmod +x "./${LFBFL_file_path}"

  shopt -s globstar
  # shellcheck source=check_shell_scripts_beginnings.libr.sh
  source "./${LFBFL_subdir}/check_shell_scripts_beginnings.libr.sh"
  # shellcheck source=check_shell_scripts_indentation.libr.sh
  source "./${LFBFL_subdir}/check_shell_scripts_indentation.libr.sh"
  # shellcheck source=check_URLs.libr.sh
  source "./${LFBFL_subdir}/check_URLs.libr.sh"
  # shellcheck source=comparisons.libr.sh
  source "./${LFBFL_subdir}/comparisons.libr.sh"
  # shellcheck source=generate_from_template.libr.sh
  source "./${LFBFL_subdir}/generate_from_template.libr.sh"
  # shellcheck source=get_common_text_glob_patterns.libr.sh
  source "./${LFBFL_subdir}/get_common_text_glob_patterns.libr.sh"
  # shellcheck source=grammar_and_spell_check.libr.sh
  source "./${LFBFL_subdir}/grammar_and_spell_check.libr.sh"
  # shellcheck source=lines_counts.libr.sh
  source "./${LFBFL_subdir}/lines_counts.libr.sh"
  # shellcheck source=lines_filters.libr.sh
  source "./${LFBFL_subdir}/lines_filters.libr.sh"
  # shellcheck source=lines_maps.libr.sh
  source "./${LFBFL_subdir}/lines_maps.libr.sh"
  # shellcheck source=overwrite_if_not_equal.libr.sh
  source "./${LFBFL_subdir}/overwrite_if_not_equal.libr.sh"
  # shellcheck source=python_black_complement.libr.sh
  source "./${LFBFL_subdir}/python_black_complement.libr.sh"
  # shellcheck source=python_isort_complement.libr.sh
  source "./${LFBFL_subdir}/python_isort_complement.libr.sh"
  # shellcheck source=strings_functions.libr.sh
  source "./${LFBFL_subdir}/strings_functions.libr.sh"
  # shellcheck source=too_long_code_lines.libr.sh
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
    LFBFL_upgrade_venvs_ts=$(
      stat -c %Y "${LFBFL_upgrade_venvs_ts_file}"
    )
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
    "${LFBFL_working_directory}" "${LFBFL_verbose}"

  echo "Building README.md"
  "./${LFBFL_subdir}/build_md_from_printable_md.exec.sh"\
    "${LFBFL_working_directory}" "README" "${LFBFL_verbose}"

  echo "Building other MarkDown files"
  local LFBFL_some_directory
  declare -r LFBFL_readme="${LFBFL_working_directory}/README.md.tpl"
  find "${LFBFL_working_directory}" -name "*.md.tpl"\
    | relevant_find\
    | while read -r LFBFL_file_path;
  do
    [[ "${LFBFL_file_path}" == "${LFBFL_readme}" ]] && continue
    echo "Found template ${LFBFL_file_path}"
    LFBFL_some_directory=$(dirname "${LFBFL_file_path}")
    LFBFL_file_name=$(basename "${LFBFL_file_path}")
    LFBFL_file_name=${LFBFL_file_name%.md.tpl}
    "./${LFBFL_subdir}/build_md_from_printable_md.exec.sh"\
      "${LFBFL_some_directory}" "${LFBFL_file_name}"\
      "${LFBFL_verbose}"
  done

  declare -i LFBFL_cd_result
  pushd .
  cd "${LFBFL_working_directory}" || {
    LFBFL_cd_result=$?
    echo "common_build_and_checks.exec.sh no such directory"
    # shellcheck disable=SC2248
    return ${LFBFL_cd_result}
  }

  echo "Running shellcheck"
  find . -name "*.sh"\
    | relevant_find\
    | while read -r LFBFL_file_path;
  do
    shellcheck --rcfile=build_and_checks_variables/shellcheck.ini\
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
  find . -name "pyproject.toml"\
    | relevant_find\
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

  echo "---JS---"
  npm_lint_directories=""
  grep_variable "${LFBFL_data_file_name}" npm_lint_directories
  if [[ -n "${npm_lint_directories}" ]]; then
    echo "Running ESLint"
    local LFBFL_JS_directory
    echo "${npm_lint_directories}"\
      | sed -e 's/\\n/\n/g'\
      | while read -r LFBFL_JS_directory;
    do
      (cd "${LFBFL_JS_directory}" && npm run lint)
    done
  fi
  echo "---JS end---"

  echo "Analyzing too long lines"
  too_long_code_lines "$@"

  echo "Analyzing shell scripts beginnings"
  check_shell_scripts_beginnings\
    | relevant_grep

  echo "Analyzing shell scripts indentation"
  check_shell_scripts_indentation\
    | relevant_grep

  echo "Analyzing URLs"
  check_URLs "$@" \
    | relevant_grep

  echo "Analyzing strange characters: hover over in doubt"
  # shellcheck disable=SC1111
  LFBFL_usual_characters="\x00-\x7Fàâéèêëîïôûç©“”└─├│«»"
  grep --exclude-dir .git --color=always\
    -nPr "[^${LFBFL_usual_characters}]" .

  echo "Checking listed files"
  "./${LFBFL_subdir}/update_or_check_files_names_listing.exec.sh"

  echo "Creating the PDF file of the listing of the source code"
  "./${LFBFL_subdir}/create_PDF.exec.sh" "${LFBFL_verbose}"

  if [[ -f "build_and_checks_variables/post_build.sh" ]]; then
    ./build_and_checks_variables/post_build.sh
  fi

  # ------------------------------------------------------------------
  # It is at the end that all the HTML files are generated and that
  # we can check there are no mistakes.
  echo "Running Nu W3C HTML CSS and SVG validator"
  upgrade_vnu_jar_time_interval_in_seconds=""
  grep_variable "${LFBFL_data_file_name}"\
     upgrade_vnu_jar_time_interval_in_seconds
  if [[ "${upgrade_vnu_jar_time_interval_in_seconds}" == "wat" ]];
  then
    upgrade_vnu_jar_time_interval_in_seconds=${RANDOM}
  fi

  declare -i LFBFL_vnu_jar_ts
  vnu_jar_path=""
  grep_variable "${LFBFL_data_file_name}" vnu_jar_path
  if [[ -f "${vnu_jar_path}" ]]; then
    LFBFL_vnu_jar_ts=$(stat -c %Y "${vnu_jar_path}")
    LFBFL_current_ts=$(date +%s)
    ((LFBFL_current_ts-=LFBFL_vnu_jar_ts))
    ((LFBFL_current_ts-=upgrade_vnu_jar_time_interval_in_seconds))
    if [[ LFBFL_current_ts -gt 0 ]]; then
      echo $'/!\\ATTENTION: Nu W3C validator is too old./!\\'
      echo "Go get the latest version here:"
      echo "https://github.com/validator/validator/releases"
    fi
    declare -r LFBFL_files_for_Nu=$(
      find . -iregex ".*\.\(css\|html\|svg\|xhtml\)"\
      | relevant_find
    )
    declare -a LFBFL_files_for_Nu2
    mapfile -t LFBFL_files_for_Nu2 <<< "${LFBFL_files_for_Nu}"
    readonly LFBFL_files_for_Nu2
    java -Xss128M -jar "${vnu_jar_path}" --exit-zero-always --verbose\
      "${LFBFL_files_for_Nu2[@]}"
  fi
  # ------------------------------------------------------------------

  if [[ LFBFL_upgrade_venvs -eq 1 ]]; then
    touch "${LFBFL_upgrade_venvs_ts_file}"
  fi

  declare -i LFBFL_popd_result
  popd || {
    LFBFL_popd_result=$?
    echo "common_build_and_checks.exec.sh no popd"
    # shellcheck disable=SC2248
    return ${LFBFL_popd_result}
  }
}

common_build_and_checks "$@"
