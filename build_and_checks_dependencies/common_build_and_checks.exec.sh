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
  # $1 LFBFL_work_directory
  # $2 LFBFL_dependencies_URL
  # $3 optional --verbose
  local LFBFL_work_directory="${1:-.}"
  LFBFL_work_directory=$(realpath "${LFBFL_work_directory}")
  local LFBFL_work_directory_option="--work-directory="
  LFBFL_work_directory_option+="${LFBFL_work_directory}"
  # declare -r LFBFL_dependencies_URL="$2" too long
  declare -r LFBFL_start_URL="$2"
  local LFBFL_verbose=""
  declare -i LFBFL_i_verbose=0
  if [[ "$*" == *--verbose* ]]; then
    echo "$0 $*"
    LFBFL_verbose="--verbose"
    LFBFL_i_verbose=1
  fi
  readonly LFBFL_verbose
  readonly LFBFL_i_verbose
  declare -ar LFBFL_some_common_options=(
    "${LFBFL_verbose}"
    # "$--work-directory={LFBFL_work_directory}" doesn't work
    "${LFBFL_work_directory_option}"
  )

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
  LFBFL_correct_sha512='debb2bdda6f77ef82be5c17a547077d5c3db2bea62f92'
  LFBFL_correct_sha512+='6b092815c4d7a2dbd9b8461923bff8e38199d776a71b'
  LFBFL_correct_sha512+='c8d417fa396a556898c3d783681afb8c235922f'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"
  chmod +x "./${LFBFL_file_path}"

  LFBFL_file_name="check_shell_scripts_beginnings.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='13346ffc2efcff3d0628b2a28855d1cd752f2ad3882fe'
  LFBFL_correct_sha512+='9aa3dca9c50c96e0b2780b5107d9bb7cf90eb885a80b'
  LFBFL_correct_sha512+='6ed84ea329f6d7c06ba0e8c368e78ed9ecfe2ac'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="check_shell_scripts_indentation.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='2ddb8563896f04c04d033965915082526b22ddf367356'
  LFBFL_correct_sha512+='dd10505286f459876e639cbd5f5a328ee0e39939f010'
  LFBFL_correct_sha512+='fac0833224c786d18abffd1f20c9ae84c8e7f9f'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="check_URLs.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='32ff1c210a5d6e6589ec7a3a692eca090759bf9692756'
  LFBFL_correct_sha512+='09dda93607349432d233674c1c79945ed92b79287c5e'
  LFBFL_correct_sha512+='d044ce240b872e35462edebb60cc9f27f218ba3'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="common_options.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='1c5b17cbbeb7d3018f4d1bf1ce2d4c7452ce3fa8557c2'
  LFBFL_correct_sha512+='a2391c448181b51e336c03fafdb1c51b9d7168837773'
  LFBFL_correct_sha512+='fe15a1235ada2337efae17e54e71e99ec313760'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="comparisons.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='445d448b0077ac8ff660bcdb8b5e3fb391a08dec1832d'
  LFBFL_correct_sha512+='1f6633807806d5b145aa6fda4c7835a6510988ce3c37'
  LFBFL_correct_sha512+='439b1fca19b27cb4757659cd1c204ed8aeb071f'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="create_PDF.exec.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='983acc9185fce5c064b475a234d0008c8c286fa4e9d6f'
  LFBFL_correct_sha512+='c8be96f49bb73f5e3a0d901f2487f2a704f4f481417a'
  LFBFL_correct_sha512+='bcc413088301404b50131964668978e2799a78b'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"
  chmod +x "./${LFBFL_file_path}"

  LFBFL_file_name="generate_from_template.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='7d90727e83305c1269ed80ab59a138bb70fd36833bbb2'
  LFBFL_correct_sha512+='3713a9fcf8910fb1578c6f089c107f351a4c0fdad048'
  LFBFL_correct_sha512+='73c7d5870c45d4d5f1364af543d33eaecadd4f3'
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
  LFBFL_correct_sha512='6deeaae24bc1f67bfe93acbf477d8ce15311edbb6b664'
  LFBFL_correct_sha512+='68052a4e29e326c33977272f4f8a6ede39cd1065f012'
  LFBFL_correct_sha512+='c3171f253c230c59fc01c95f8a288eb90cb78ca'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  # /licenses_templates/ ---------------------------------------------
  declare -r LFBFL_subdir2="${LFBFL_subdir}/licenses_templates"
  declare -r LFBFL_start_URL2="${LFBFL_start_URL}/licenses_templates"
  LFBFL_file_name="build_licenses_templates.exec.sh"
  LFBFL_URL="${LFBFL_start_URL2}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir2}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='34c02434a90f63330b150ac55693b9a82baa9208a539c'
  LFBFL_correct_sha512+='c6eec4cd48db32b28b32d42d6b089d148781dbaf4d49'
  LFBFL_correct_sha512+='52b7b1ffd0efc8d1badbd90478d968725388cc0'
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
  LFBFL_correct_sha512='809597a887cfd33d0556c3353ebd3d7cfac175cbd1d63'
  LFBFL_correct_sha512+='c4181554009d81bf35b85ab068405b009f04c0a37107'
  LFBFL_correct_sha512+='24db5af77178dbdbdfa18586cd5a61849f22821'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="lines_filters.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='739357424121ecb80696cc5620ce4b51ec6e2b2d7c31e'
  LFBFL_correct_sha512+='968b6f8b45da6546042d405a2a725e7fe7e7f8467e1f'
  LFBFL_correct_sha512+='4904156d3e9d5b6947f739313fa9571599054fe'
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
  LFBFL_correct_sha512='ce29513479932cc7c2f8d79fc10ef2f3803b578c18106'
  LFBFL_correct_sha512+='9d5ba6462734acfe9907240f1c0b0fa1fecae672e722'
  LFBFL_correct_sha512+='e72c1bdf94077693cb86af1bbc34f18fb4400fa'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="python_isort_complement.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='c913be48fdd63c3c518ce342860adfeb2698866548905'
  LFBFL_correct_sha512+='6aa3e3299fc81f0c418e30d5d6ead46804e9b426a39f'
  LFBFL_correct_sha512+='22fffcb1c89f7c2a380915b66acaa54dba6af1d'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="repository_data.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='236fe88b20c3e900e840651e489f84534036262ae048b'
  LFBFL_correct_sha512+='fcfdd494c98cbdba17d634e4c842c5b37866bc0332ae'
  LFBFL_correct_sha512+='e322e8fc140e7e8e0f1b2209cf839b6d56066a7'
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
  LFBFL_correct_sha512='30db86474889d21a62976c8d69fed289d1f0d5e33dc4d'
  LFBFL_correct_sha512+='57b7bca7098bc48ed06a60a6392b3f1f8e34a0903cc0'
  LFBFL_correct_sha512+='96207fafc18fdfbda28409afc1b10e1d4fe874b'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="too_long_code_lines.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='12172cd22a13672131b8e1fbd2894e3f6be70d23751cc'
  LFBFL_correct_sha512+='7602fff28cc41e94882354e7f1b97bd8a08cd3819b91'
  LFBFL_correct_sha512+='ab00bc7b502542313034c8d966821b8ed707313'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="update_or_check_files_names_listing.exec.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='a93461e1f83560cc9be0e8881173c3eaf7b00d1ee4397'
  LFBFL_correct_sha512+='751c9dbb683327746e7111c382c51f2d52e98d4f7cfd'
  LFBFL_correct_sha512+='6a8e66f2ce32ec5c8382348addc1460cd3ab3d9'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"
  chmod +x "./${LFBFL_file_path}"

  # shellcheck source=check_shell_scripts_beginnings.libr.sh
  source "./${LFBFL_subdir}/check_shell_scripts_beginnings.libr.sh"
  # shellcheck source=check_shell_scripts_indentation.libr.sh
  source "./${LFBFL_subdir}/check_shell_scripts_indentation.libr.sh"
  # shellcheck source=check_URLs.libr.sh
  source "./${LFBFL_subdir}/check_URLs.libr.sh"
  # shellcheck source=common_options.libr.sh
  source "./${LFBFL_subdir}/common_options.libr.sh"
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

  enhanced_set_bash_option extglob
  # shellcheck source=repository_data.libr.sh
  source "./${LFBFL_subdir}/repository_data.libr.sh"
  # shellcheck disable=SC2154,SC2309
  [[ enhanced_set_bash_option_extglob_result -eq 0 ]]\
    && enhanced_unset_bash_option extglob

  enhanced_set_shell_option pipefail\
    && trap 'enhanced_unset_shell_option pipefail' RETURN

  echo "Building license headers"
  "./${LFBFL_subdir2}/build_licenses_templates.exec.sh"\
    "${LFBFL_some_common_options[@]}"

  echo "Building README.md"
  "./${LFBFL_subdir}/build_md_from_printable_md.exec.sh"\
    "--work-directory=${LFBFL_work_directory}"\
    "--base-name=README"\
    "${LFBFL_verbose}"

  echo "Building other MarkDown files"
  local LFBFL_some_directory
  declare -r LFBFL_readme="${LFBFL_work_directory}/README.md.tpl"
  find "${LFBFL_work_directory}" -name "*.md.tpl"\
    | relevant_find\
    | while read -r LFBFL_file_path;
  do
    [[ "${LFBFL_file_path}" == "${LFBFL_readme}" ]] && continue
    echo "Found template ${LFBFL_file_path}"
    LFBFL_some_directory=$(dirname "${LFBFL_file_path}")
    LFBFL_file_name=$(basename "${LFBFL_file_path}")
    LFBFL_file_name=${LFBFL_file_name%.md.tpl}
    "./${LFBFL_subdir}/build_md_from_printable_md.exec.sh"\
      "--work-directory=${LFBFL_some_directory}"\
      "--base-name=${LFBFL_file_name}"\
      "${LFBFL_verbose}"
  done

  declare -i LFBFL_will_popd
  pushd_to_work_directory
  LFBFL_will_popd=$?
  can_continue_after_enhanced_pushd || return

  local LFBFL_data_file_name=\
"build_and_checks_variables/repository_data.txt"

  declare -i LFBFL_max_line_length
  grep_variable "${LFBFL_data_file_name}" max_line_length\
    --result-variable-prefix="LFBFL_"

  declare -i LFBFL_upgrade_venvs=0
  declare -r LFBFL_upgrade_venvs_ts_file=\
"build_and_checks_variables/upgrade_venvs_ts"
  declare -i LFBFL_upgrade_venvs_ts
  declare -i LFBFL_current_ts
  local LFBFL_upgrade_venvs_answer

  local LFBFL_upgrade_venvs_time_interval_in_seconds=""
  get_upgrade_venvs_time_interval_in_seconds "${LFBFL_data_file_name}"\
    "${LFBFL_some_common_options[@]}"

  if [[ -f "${LFBFL_upgrade_venvs_ts_file}" ]]; then
    LFBFL_upgrade_venvs_ts=$(
      stat -c %Y "${LFBFL_upgrade_venvs_ts_file}"
    )
    LFBFL_current_ts=$(date +%s)
    ((LFBFL_current_ts-=LFBFL_upgrade_venvs_ts))
    ((LFBFL_current_ts-=LFBFL_upgrade_venvs_time_interval_in_seconds))
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
  echo "Running python_isort_complement"
  python_isort_complement "${LFBFL_some_common_options[@]}"

  echo "Running black"
  # First, we update the configuration file with max_line_length.
  local LFBFL_update_max_length="s/^line-length = [0-9]*$"
  LFBFL_update_max_length+="/line-length = ${LFBFL_max_line_length}/"
  sed -E -e "${LFBFL_update_max_length}"\
    build_and_checks_variables/black.toml\
    > build_and_checks_variables/black.toml.temp
  overwrite_if_not_equal build_and_checks_variables/black.toml\
    build_and_checks_variables/black.toml.temp

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
  echo "Running python_black_complement"
  python_black_complement "${LFBFL_some_common_options[@]}"

  echo "Probing if mypy should be runned"
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
  too_long_code_lines "${LFBFL_some_common_options[@]}" \
    --max-line-length=${LFBFL_max_line_length}

  echo "Analyzing shell scripts beginnings"
  check_shell_scripts_beginnings "${LFBFL_some_common_options[@]}" \
    | relevant_grep

  echo "Analyzing shell scripts indentation"
  check_shell_scripts_indentation "${LFBFL_some_common_options[@]}" \
    | relevant_grep

  echo "Analyzing URLs"
  check_URLs "${LFBFL_some_common_options[@]}" \
    | relevant_grep

  echo "Analyzing strange characters: hover over in doubt"
  # shellcheck disable=SC1111
  LFBFL_usual_characters="\x00-\x7Fàâéèêëîïôûç©“”└─├│«»"
  grep --exclude-dir .git --binary-files=without-match --color=always\
    -nPr "[^${LFBFL_usual_characters}]" .

  [[ LFBFL_will_popd -eq 0 ]] && popd_from_work_directory

  echo "Checking listed files"
  "./${LFBFL_subdir}/update_or_check_files_names_listing.exec.sh"\
    "${LFBFL_some_common_options[@]}"

  echo "Creating the PDF file of the listing of the source code"
  "./${LFBFL_subdir}/create_PDF.exec.sh" "${LFBFL_some_common_options[@]}"

  pushd_to_work_directory\
    && trap 'popd_from_work_directory' RETURN
  can_continue_after_enhanced_pushd || return

  if [[ -f "build_and_checks_variables/post_build.sh" ]]; then
    ./build_and_checks_variables/post_build.sh "${LFBFL_verbose}"
  fi

  # ------------------------------------------------------------------
  # It is at the end that all the HTML files are generated and that
  # we can check there are no mistakes.
  echo "Running Nu W3C HTML CSS and SVG validator"
  local LFBFL_upgrade_vnu_jar_time_interval_in_seconds=""
  grep_variable "${LFBFL_data_file_name}"\
    upgrade_vnu_jar_time_interval_in_seconds\
    --result-variable-prefix="LFBFL_"

  if [[ "${LFBFL_upgrade_vnu_jar_time_interval_in_seconds}" == "wat" ]];
  then
    LFBFL_upgrade_vnu_jar_time_interval_in_seconds=${RANDOM}
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
    ((LFBFL_current_ts-=LFBFL_upgrade_vnu_jar_time_interval_in_seconds))
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
}

common_build_and_checks "$@"
