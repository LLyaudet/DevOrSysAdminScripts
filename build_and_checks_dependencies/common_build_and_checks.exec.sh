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
  LFBFL_correct_sha512='239c41539d866e50bfbe32e91b4ebaf80e751e2621e86'
  LFBFL_correct_sha512+='4c70c01b918f1d563eba5cca49bca8967c292edc9c29'
  LFBFL_correct_sha512+='1fd372c53cad764b9bfb742b5dbdc0d4832db5c'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="check_shell_scripts_indentation.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='4afb238c86c2f4ea796364a2c4462f113396d6f60ace1'
  LFBFL_correct_sha512+='b8602fa56ddae83645f541bbf6be0d200264c36b8cab'
  LFBFL_correct_sha512+='6c74a75807cb09d5c1712f3d810dc0e8c49dc0b'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="check_URLs.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='15711c549b2fb76f9f4fb1fd883055eccdf778f6caf34'
  LFBFL_correct_sha512+='efca0c37273b34ba486b50a9f82fdfcd8be6d332c23f'
  LFBFL_correct_sha512+='618b024338a811ca1cef1f8b8fb95b0fa08ae43'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="common_options.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='68fbf223873c4ec67874f511a7e1176ff3b688c170e88'
  LFBFL_correct_sha512+='60275f7ef285d4ec9fd32ed6980ec177ca9270ed183f'
  LFBFL_correct_sha512+='1b6e9434361504a8ce66474a9d5e438eea5deb3'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="comparisons.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='2c9754d6517c0e07036a913552495fcda18ba09e0e04c'
  LFBFL_correct_sha512+='61ca262bfec4f3213d2b07f0ee8006a85c6806fecf16'
  LFBFL_correct_sha512+='52a72de4d3c9487dd825d0a643586306fb0f0d5'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="create_PDF.exec.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='9007d73a728c6f4a76a2bfe6030430aef2e7abbe17f4d'
  LFBFL_correct_sha512+='83278bf28ae9f134606d5a2762acdc36753fcb816428'
  LFBFL_correct_sha512+='f54890d666f5dbc8953f1e5ec7687473e449cd7'
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
  LFBFL_correct_sha512='b8d4cb07fca28c3904b75e0d24debe2ad2b3b1b1c8bd9'
  LFBFL_correct_sha512+='6436c2236ee385ba5d8fa8462f4b71cb5f756b15719c'
  LFBFL_correct_sha512+='e1ea5defed2d1b01d236d8bc3f6535eb48ed804'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  # /licenses_templates/ ---------------------------------------------
  declare -r LFBFL_subdir2="${LFBFL_subdir}/licenses_templates"
  declare -r LFBFL_start_URL2="${LFBFL_start_URL}/licenses_templates"
  LFBFL_file_name="build_licenses_templates.exec.sh"
  LFBFL_URL="${LFBFL_start_URL2}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir2}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='7f0b8d7516256e59b819e49c8b76f334b595ae2a89382'
  LFBFL_correct_sha512+='10225200793a4843d7ef93d60d9a5dd73a9d55d4c90d'
  LFBFL_correct_sha512+='d1f882be7949cfea86ba2e59d24ef8cb4c0118e'
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
  LFBFL_correct_sha512='750d45b2a31cc73b62b861f1007bb132d44407b517619'
  LFBFL_correct_sha512+='d77333cfb531c6445ba47ab4349f84a29b6455f88817'
  LFBFL_correct_sha512+='00b9d3be2ae1542cb6fe2ced2f713a9417d76b7'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="lines_filters.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='36d0289f83bbf7e59a076253d37ebfa851857f50dc3f4'
  LFBFL_correct_sha512+='128930035f2502bb9dace99fafd425c0a0a29b8be959'
  LFBFL_correct_sha512+='c73599312f549b9d4a3027e5ff92d163526cb51'
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
  LFBFL_correct_sha512='38058e326270c15885c5b01112c984fbef97bcf82c7b7'
  LFBFL_correct_sha512+='a8023a496edb38c187808360170861e27c8e6a770d44'
  LFBFL_correct_sha512+='a4f265732ac969c2dd875fcf383d081a35c029f'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="python_isort_complement.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='ed1e7e260bf99543c60c17f3290226e11c19a90b190b6'
  LFBFL_correct_sha512+='8e264b1db0ce1daead4271c29b14ac1b75470def6138'
  LFBFL_correct_sha512+='267cf8e3144f95916b278668e8f9c23486e1455'
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
  LFBFL_correct_sha512='f0829a4ca7ad785d053705e780bf407f5b546beaa81d9'
  LFBFL_correct_sha512+='e06b83d0e6ec624b9887ce2e77fb3bc4c46026cc818f'
  LFBFL_correct_sha512+='fcc8942024c66507374f0c479bb5acedc27c2c1'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="too_long_code_lines.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='4c69a505fed012c034c0c2b29256e01855572f98f599f'
  LFBFL_correct_sha512+='166a9fdd9e3dbeb1a5c4aff47456fa213a33de4f0050'
  LFBFL_correct_sha512+='72da451e0a54699bf440997234c438cfba53448'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="update_or_check_files_names_listing.exec.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='89c3e1b4fd52d0b5abf71e1c60f1f41bcb22bff9f31df'
  LFBFL_correct_sha512+='823efe29b05ac0e3a2f89405fb240be1a2da20e2d389'
  LFBFL_correct_sha512+='1e0e9e5e8c0eb6327600a078ab263a9c10ddf46'
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

  enhanced_set_pipefail && trap 'enhanced_unset_pipefail' RETURN

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

  local LFBFL_upgrade_venvs_time_interval_in_seconds=""
  grep_variable "${LFBFL_data_file_name}"\
    upgrade_venvs_time_interval_in_seconds\
    --result-variable-prefix="LFBFL_"
  case ${LFBFL_upgrade_venvs_time_interval_in_seconds} in
    wat) LFBFL_upgrade_venvs_time_interval_in_seconds=${RANDOM};;
    watyouwant?) LFBFL_upgrade_venvs_time_interval_in_seconds=${SRANDOM};;
    *) echo "No wat for you?";; #TempsDeCerveauDisponible XD SC2249 ;)
  esac

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

  echo "Building license headers"
  "./${LFBFL_subdir2}/build_licenses_templates.exec.sh" "$@"

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

  pushd_to_work_directory\
    && trap 'popd_from_work_directory' RETURN
  can_continue_after_enhanced_pushd || return

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
  python_isort_complement "$@"

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
  echo "Running python_black_complement"
  python_black_complement "$@"

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
  too_long_code_lines "${LFBFL_verbose}"\
    --max-line-length=${LFBFL_max_line_length}

  echo "Analyzing shell scripts beginnings"
  check_shell_scripts_beginnings "${LFBFL_verbose}"\
    | relevant_grep

  echo "Analyzing shell scripts indentation"
  check_shell_scripts_indentation "${LFBFL_verbose}"\
    | relevant_grep

  echo "Analyzing URLs"
  check_URLs "$@" \
    | relevant_grep

  echo "Analyzing strange characters: hover over in doubt"
  # shellcheck disable=SC1111
  LFBFL_usual_characters="\x00-\x7Fàâéèêëîïôûç©“”└─├│«»"
  grep --exclude-dir .git --binary-files=without-match --color=always\
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
