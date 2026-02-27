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
  LFBFL_correct_sha512='d473359eaef8164f8e7ab85fcd8812b3ce46e2731ef96'
  LFBFL_correct_sha512+='ff46df693890131abf064c9f2b1beacbabd50aad778f'
  LFBFL_correct_sha512+='6d3b9b669bc0469f868f1ae69660fd4b89990f1'
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
  LFBFL_correct_sha512='301d75343d9dacd21a09bb93e0b39f7014763cb1a3b0b'
  LFBFL_correct_sha512+='e8295955fceb12ffcbc131d758086d384942fc30952a'
  LFBFL_correct_sha512+='e3cf0ee6bb22c401bca908ca232794f5fbe3b0e'
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
  LFBFL_correct_sha512='a47f723b8e10a924c131f3779d3985758cb9933816f5f'
  LFBFL_correct_sha512+='9b37b4518d6ab94453b71cd67adcd4659fe4757207de'
  LFBFL_correct_sha512+='055c1aca88bd16dbc034497a36a6b5eaec4e55d'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  # /licenses_templates/ ---------------------------------------------
  declare -r LFBFL_subdir2="${LFBFL_subdir}/licenses_templates"
  declare -r LFBFL_start_URL2="${LFBFL_start_URL}/licenses_templates"
  LFBFL_file_name="build_licenses_templates.exec.sh"
  LFBFL_URL="${LFBFL_start_URL2}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir2}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='5e8f15180c1d5661daa8ef4a77800a835a99cb02eae1f'
  LFBFL_correct_sha512+='edee9f223a8433f9309ed7bbc353a0429813ddad0153'
  LFBFL_correct_sha512+='d0b7d39b4e877514c9996d65d7b5fb24117a032'
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
  LFBFL_correct_sha512='74cac859c63a70afdb978ce8516d469ea515b25bb9479'
  LFBFL_correct_sha512+='8d3f0ae9fa3f1e504a04e25d7f1e34a489ddd06e3f91'
  LFBFL_correct_sha512+='c8f60fc10d58afc4696e710603b7658dbb7021f'
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
  LFBFL_correct_sha512='2781a564d264bae84c787321481dc83ae43a1ce324ee6'
  LFBFL_correct_sha512+='d5ceb73d5a98607fad5fe9ff8d03979b898f7cd7c712'
  LFBFL_correct_sha512+='8215d26e76874d56aa67fb63fa9de776617d24a'
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
  LFBFL_correct_sha512='f29cce1e27d2b9483716326938b09b4e9cffdc23f5a39'
  LFBFL_correct_sha512+='1516dd6b1514903b3484b38e9c585c85ff389e5d90a0'
  LFBFL_correct_sha512+='2ffda748385aac01a078dc8aae06f78c08579b6'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="too_long_code_lines.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='433858315341224e32d3e90c6f0c611ba17f88b3d3cd7'
  LFBFL_correct_sha512+='53296c1294c4b838e8b59031e5395bdd16ad898a9030'
  LFBFL_correct_sha512+='4c89b03779abcfc7f68e418b832eb56505f92cf'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="update_or_check_files_names_listing.exec.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='bf330ba727703e9763a04bd7a05f7ad037531f75f420b'
  LFBFL_correct_sha512+='90595d4d8b886310170bfb2f6c423b8d7fb5ab3b5394'
  LFBFL_correct_sha512+='413b3b17d2afcde53019c0ce25730716e77aba8'
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

  declare -i LFBFL_max_line_length
  grep_variable "${LFBFL_data_file_name}" max_line_length\
    --result-variable-prefix="LFBFL_"

  local LFBFL_update_max_length="s/^line-length = [0-9]*$"
  LFBFL_update_max_length+="/line-length = ${LFBFL_max_line_length}/"
  sed -E -e "${LFBFL_update_max_length}"\
    build_and_checks_variables/black.toml\
    > build_and_checks_variables/black.toml.temp
  overwrite_if_not_equal build_and_checks_variables/black.toml\
    build_and_checks_variables/black.toml.temp

  declare -i LFBFL_upgrade_venvs=0
  declare -r LFBFL_upgrade_venvs_ts_file=\
"build_and_checks_variables/upgrade_venvs_ts"
  declare -i LFBFL_upgrade_venvs_ts
  declare -i LFBFL_current_ts
  local LFBFL_upgrade_venvs_answer

  local upgrade_venvs_time_interval_in_seconds=""
  grep_variable "${LFBFL_data_file_name}"\
    upgrade_venvs_time_interval_in_seconds
  case ${upgrade_venvs_time_interval_in_seconds} in
    wat) upgrade_venvs_time_interval_in_seconds=${RANDOM};;
    watyouwant?) upgrade_venvs_time_interval_in_seconds=${SRANDOM};;
    *) echo "No wat for you?";; #TempsDeCerveauDisponible XD SC2249 ;)
  esac

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
    local LFBFL2_upgrade_venvs=""
    grep_variable "${LFBFL_data_file_name}" upgrade_venvs\
      --result-variable-prefix="LFBFL2_"
    if [[ "${LFBFL2_upgrade_venvs}" != "auto" ]]; then
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
  local LFBFL_isort_venv=""
  grep_variable "${LFBFL_data_file_name}" isort_venv\
    --result-variable-prefix="LFBFL_"\
    --replace-line-returns-by=""
  if [[ -n "${LFBFL_isort_venv}" ]]; then
    if command -v deactivate
    then
      deactivate
    fi
    # shellcheck disable=SC1090,SC1091
    source "${LFBFL_isort_venv}/bin/activate"
  fi
  if [[ LFBFL_upgrade_venvs -eq 1 ]]; then
    pip install --upgrade isort
  fi
  isort .
  if [[ -n "${LFBFL_isort_venv}" ]]; then
    deactivate
  fi
  python_isort_complement

  echo "Running black"
  local LFBFL_black_venv=""
  grep_variable "${LFBFL_data_file_name}" black_venv\
    --result-variable-prefix="LFBFL_"\
    --replace-line-returns-by=""
  if [[ -n "${LFBFL_black_venv}" ]]; then
    if command -v deactivate
    then
      deactivate
    fi
    # shellcheck disable=SC1090,SC1091
    source "${LFBFL_black_venv}/bin/activate"
  fi
  if [[ LFBFL_upgrade_venvs -eq 1 ]]; then
    pip install --upgrade black
  fi
  black --config build_and_checks_variables/black.toml .
  if [[ -n "${LFBFL_black_venv}" ]]; then
    deactivate
  fi
  python_black_complement

  local LFBFL_mypy_venv=""
  grep_variable "${LFBFL_data_file_name}" mypy_venv\
    --result-variable-prefix="LFBFL_"\
    --replace-line-returns-by=""
  if [[ -n "${LFBFL_mypy_venv}" ]]; then
    if command -v deactivate
    then
      deactivate
    fi
    # shellcheck disable=SC1090,SC1091
    source "${LFBFL_mypy_venv}/bin/activate"
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
  if [[ -n "${LFBFL_mypy_venv}" ]]; then
    deactivate
  fi

  echo "Running bandit"
  LFBFL_bandit_venv=""
  grep_variable "${LFBFL_data_file_name}" bandit_venv\
    --result-variable-prefix="LFBFL_"\
    --replace-line-returns-by=""
  if [[ -n "${LFBFL_bandit_venv}" ]]; then
    if command -v deactivate
    then
      deactivate
    fi
    # shellcheck disable=SC1090,SC1091
    source "${LFBFL_bandit_venv}/bin/activate"
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
  if [[ -n "${LFBFL_bandit_venv}" ]]; then
    deactivate
  fi

  echo "Running pylint"
  LFBFL_pylint_venv=""
  grep_variable "${LFBFL_data_file_name}" pylint_venv\
    --result-variable-prefix="LFBFL_"\
    --replace-line-returns-by=""
  if [[ -n "${LFBFL_pylint_venv}" ]]; then
    if command -v deactivate
    then
      deactivate
    fi
    # shellcheck disable=SC1090,SC1091
    source "${LFBFL_pylint_venv}/bin/activate"
  fi
  if [[ LFBFL_upgrade_venvs -eq 1 ]]; then
    pip install --upgrade pylint
  fi
  pylint --rcfile build_and_checks_variables/pylintrc.toml\
    --recursive=y .
  if [[ -n "${LFBFL_pylint_venv}" ]]; then
    deactivate
  fi

  echo "Running ruff"
  LFBFL_ruff_venv=""
  grep_variable "${LFBFL_data_file_name}" ruff_venv\
    --result-variable-prefix="LFBFL_"\
    --replace-line-returns-by=""
  if [[ -n "${LFBFL_ruff_venv}" ]]; then
    if command -v deactivate
    then
      deactivate
    fi
    # shellcheck disable=SC1090,SC1091
    source "${LFBFL_ruff_venv}/bin/activate"
  fi
  if [[ LFBFL_upgrade_venvs -eq 1 ]]; then
    pip install --upgrade ruff
  fi
  ruff check --config build_and_checks_variables/ruff.toml
  if [[ -n "${LFBFL_ruff_venv}" ]]; then
    deactivate
  fi
  echo "---Python end---"

  echo "---PHP---"
  echo "Running PHPMD"
  if [[ LFBFL_upgrade_venvs -eq 1 ]]; then
    composer global require phpmd/phpmd
  fi

  local LFBFL_phpmd_baseline="build_and_checks_variables/"
  LFBFL_phpmd_baseline+="phpmd_baseline.xml"
  readonly LFBFL_phpmd_baseline

  local LFBFL_temp_phpmd_baseline="build_and_checks_variables/temp/"
  LFBFL_temp_phpmd_baseline+="phpmd_baseline.xml"
  readonly LFBFL_temp_phpmd_baseline

  local LFBFL_phpmd_rulesets="cleancode,codesize,controversial,"
  LFBFL_phpmd_rulesets+="design,naming,unusedcode"
  readonly LFBFL_phpmd_rulesets

  phpmd --color --baseline-file "${LFBFL_phpmd_baseline}"\
    . text "${LFBFL_phpmd_rulesets}"
  # Saving new baseline in temp if necessary.
  rm "${LFBFL_temp_phpmd_baseline}"
  phpmd --color --generate-baseline\
    --baseline-file "${LFBFL_temp_phpmd_baseline}"\
    . text "${LFBFL_phpmd_rulesets}"
  echo "---PHP end---"

  echo "---JS---"
  LFBFL_npm_lint_directories=""
  grep_variable "${LFBFL_data_file_name}" npm_lint_directories\
    --result-variable-prefix="LFBFL_"
  if [[ -n "${LFBFL_npm_lint_directories}" ]]; then
    echo "Running ESLint"
    local LFBFL_JS_directory
    echo "${LFBFL_npm_lint_directories}"\
      | sed -e 's/\\n/\n/g'\
      | while read -r LFBFL_JS_directory;
    do
      (cd "${LFBFL_JS_directory}" && npm run lint)
    done
  fi
  echo "---JS end---"

  echo "Analyzing too long lines"
  # shellcheck disable=SC2248
  too_long_code_lines ${LFBFL_max_line_length} "$@"

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
  local upgrade_vnu_jar_time_interval_in_seconds=""
  grep_variable "${LFBFL_data_file_name}"\
    upgrade_vnu_jar_time_interval_in_seconds
  if [[ "${upgrade_vnu_jar_time_interval_in_seconds}" == "wat" ]];
  then
    upgrade_vnu_jar_time_interval_in_seconds=${RANDOM}
  fi

  declare -i LFBFL_vnu_jar_ts
  local LFBFL_vnu_jar_path=""
  grep_variable "${LFBFL_data_file_name}" vnu_jar_path\
    --result-variable-prefix="LFBFL_"\
    --replace-line-returns-by=""
  if [[ -f "${LFBFL_vnu_jar_path}" ]]; then
    LFBFL_vnu_jar_ts=$(stat -c %Y "${LFBFL_vnu_jar_path}")
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
    java -Xss128M -jar "${LFBFL_vnu_jar_path}" --exit-zero-always\
      --verbose "${LFBFL_files_for_Nu2[@]}"
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
