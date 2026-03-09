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
    printf "%s %s\n" "$0" "$*"
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
  LFBFL_correct_sha512='281f076b7e83ce4dff1f4c30bfa981d755d47c46b439a'
  LFBFL_correct_sha512+='606344fd40d0d9337c6badbc41f6685ae1d543d94dd7'
  LFBFL_correct_sha512+='a66d0c263abbf5bbed6dd1b703ff00350536ba8'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"
  chmod +x "./${LFBFL_file_path}"

  LFBFL_file_name="check_shell_scripts_beginnings.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='e2d6a928cc8056440336e65416f2cb68aca5d67291446'
  LFBFL_correct_sha512+='c134edcba52aca0400ef2f486330e02d40c6d4054042'
  LFBFL_correct_sha512+='ad3c76444b0e261e0ef7bb4facd29dcc0bc7786'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="check_shell_scripts_indentation.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='aec310eadf00f7f5349549d1feee8bebc6736b7a02c68'
  LFBFL_correct_sha512+='e900a71743be58d5bfb8e73662cc7924501464c99e54'
  LFBFL_correct_sha512+='c2f278bd643a6c8c83c2ce62a7f5eb0824880ae'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="check_URLs.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='35465ae8f66feab68ea43cb03372f6d14e152b1198e9f'
  LFBFL_correct_sha512+='b0548f5c1aded656ba309980eaac5bbf4a17ecb3e500'
  LFBFL_correct_sha512+='05ea66d9f464c45f3fd007c23aa4d3e7623e771'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="common_options.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='0f0bbd6f994c92ffb4cfc1748e2650857c88c3dc18b76'
  LFBFL_correct_sha512+='7adb6a9962a6387ed470ddbfb8a6b981219659c1e19f'
  LFBFL_correct_sha512+='2d0bbff7277251e08e8a165f4e98524ca7ba551'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="comparisons.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='eb4f6855e09eec27832af9f375f5ea750f08bd04f7955'
  LFBFL_correct_sha512+='e4a071216ca80772469ada184cfc96821d71f80f1b42'
  LFBFL_correct_sha512+='01ea9e2da4279d07aaecb98739a9c59bbbb5b0a'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="create_PDF.exec.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='80cac6bed474b7db5fd1c8a6b9cdbefeb57258c84b120'
  LFBFL_correct_sha512+='e4f39c6c9544b962d1a67394d7001403cfaf7cde944a'
  LFBFL_correct_sha512+='69f02be45b022aa77ffc85e297730525ac4ba63'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"
  chmod +x "./${LFBFL_file_path}"

  LFBFL_file_name="generate_from_template.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='8846f6cfa5893288e3414e4e339e7881f62a1e13e1173'
  LFBFL_correct_sha512+='1428a1847a3651fde29d71a998560d8109256c78b4c0'
  LFBFL_correct_sha512+='b9e84786034479b53ba3493ca06ded078c683ee'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="get_common_text_glob_patterns.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='fc041abf937df4c7cb1241c73e776e8bd07a5525bc9a9'
  LFBFL_correct_sha512+='29c83d597ddd6aa88a6e61a99d22ca88c11561f1cdbc'
  LFBFL_correct_sha512+='0fbf5df4794a2384f33e7e7dd5b65a53ab46f4a'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="grammar_and_spell_check.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='7238bffa4627414b6efb890950d3cfa125511124dc7a8'
  LFBFL_correct_sha512+='fc4c935c7dfd3da38ebfe8c3a06c65cf5b9275fe651e'
  LFBFL_correct_sha512+='1d98936c5bf9242b58b6679a05ecc37bef174b1'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  # /licenses_templates/ ---------------------------------------------
  declare -r LFBFL_subdir2="${LFBFL_subdir}/licenses_templates"
  declare -r LFBFL_start_URL2="${LFBFL_start_URL}/licenses_templates"
  LFBFL_file_name="build_licenses_templates.exec.sh"
  LFBFL_URL="${LFBFL_start_URL2}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir2}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='1e439c82e0232593038e973793ed01b63ace4d1913903'
  LFBFL_correct_sha512+='ceae9d112734f29d8f7c5b831d61f0ac1bf02be8bee9'
  LFBFL_correct_sha512+='1ee429522a8aca1f2b812c4f3eca66250ba41fe'
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
  LFBFL_correct_sha512='adf26da440c9c258164bbbc157fd9eb327ecf7f449d0b'
  LFBFL_correct_sha512+='4b3d7661f5a36295f47d17f8e3a7294a5e26af6b4f6f'
  LFBFL_correct_sha512+='5302c40a33e584a584c2cb475f279d5d753f149'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="lines_filters.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='7ddf19d2df834ffa2246bc4e95b2b03263fa282c09221'
  LFBFL_correct_sha512+='35f0db8c42461b4ee82cbdae2e76c7cd6328b22cbd33'
  LFBFL_correct_sha512+='b773f34771baeb8212929a830560e33f80186de'
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
  LFBFL_correct_sha512='1f647d6da821c5ebc6e2cc1943d85ce8067eeec571079'
  LFBFL_correct_sha512+='59d37d9ee9d7d6f37be924ad278082b20284926ca5c4'
  LFBFL_correct_sha512+='d31441ca910a048267968e43548c9eb2a2729c2'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="python_black_complement.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='afba2d9bff112d05e22dfbb7b4f50c9d925e4002473ce'
  LFBFL_correct_sha512+='df2f066368cac1dcf3943512cd39f9f07853b935c57f'
  LFBFL_correct_sha512+='acca56342e81700ec71e5076fb08ce65df62d10'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="python_isort_complement.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='88d23cd7b9761c956c1bd33370d0457abf77c58f59c4a'
  LFBFL_correct_sha512+='c7c24f3ce6f2523a24d40e827df8e106cd27870242a6'
  LFBFL_correct_sha512+='327311471df4806231321020d8bb130084cf569'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="repository_data.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='793af27d8e658ed63148e6a3b45ba9b4eda1ddd3ede22'
  LFBFL_correct_sha512+='0b2af3c6a72e46d89b3565cef6e074cf1f9fcaccc7e4'
  LFBFL_correct_sha512+='dca98da471003bebeaabde704412ced55728094'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="shell_checks_complement.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='edf5b8042b6cf5fb0a2391b13aa863700543fd87e7cc7'
  LFBFL_correct_sha512+='2971faf45dc29c75a1f18201c3a8dfcd9b30153a0300'
  LFBFL_correct_sha512+='7a13741c898af552df66499ffddec99a87ee3ac'
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
  LFBFL_correct_sha512='2bcc71452545f83cbde9f528c8c638c8026c79f0cebcb'
  LFBFL_correct_sha512+='959706b17db02b04fb3101349dd15814df130c192f55'
  LFBFL_correct_sha512+='d475aef749bda6905c92da97a0deb1237dc6ae8'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="too_long_code_lines.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='564069418a6f15fc95f08cb087269a480a4b67191523f'
  LFBFL_correct_sha512+='78f74c8e1aabf9fd21a181a31948b9c042259575faf0'
  LFBFL_correct_sha512+='9665a6582c72147a6de9948d8a2540311352840'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="update_or_check_files_names_listing.exec.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='fd286f85e173d2cdc1099423e8e9978971346e237f7c4'
  LFBFL_correct_sha512+='75b076038d532a3a4a748df5e6e9f016ce08a11faadb'
  LFBFL_correct_sha512+='d86ca2653e831de43868d7c9c5818c7cfbca273'
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
  # shellcheck source=shell_checks_complement.libr.sh
  source "./${LFBFL_subdir}/shell_checks_complement.libr.sh"
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

  printf "Building license headers\n"
  "./${LFBFL_subdir2}/build_licenses_templates.exec.sh"\
    "${LFBFL_some_common_options[@]}"

  printf "Building README.md\n"
  "./${LFBFL_subdir}/build_md_from_printable_md.exec.sh"\
    "--work-directory=${LFBFL_work_directory}"\
    "--base-name=README"\
    "${LFBFL_verbose}"

  printf "Building other MarkDown files\n"
  local LFBFL_some_directory
  declare -r LFBFL_readme="${LFBFL_work_directory}/README.md.tpl"
  local LFBFL_s_files_paths
  LFBFL_s_files_paths=$(
    find "${LFBFL_work_directory}" -type f -name "*.md.tpl"\
    | relevant_find
  )
  declare -a LFBFL_arr_files_paths
  if [[ -n "${LFBFL_s_files_paths}" ]]; then
    mapfile -t LFBFL_arr_files_paths <<< "${LFBFL_s_files_paths}"
    for LFBFL_file_path in "${LFBFL_arr_files_paths[@]}"; do
      [[ "${LFBFL_file_path}" == "${LFBFL_readme}" ]] && continue
      printf "Found template %s.\n" "${LFBFL_file_path}"
      LFBFL_some_directory=$(dirname "${LFBFL_file_path}")
      LFBFL_file_name=$(basename "${LFBFL_file_path}")
      LFBFL_file_name=${LFBFL_file_name%.md.tpl}
      "./${LFBFL_subdir}/build_md_from_printable_md.exec.sh"\
        "--work-directory=${LFBFL_some_directory}"\
        "--base-name=${LFBFL_file_name}"\
        "${LFBFL_verbose}"
    done
  fi

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

  printf "Running shellcheck\n"
  LFBFL_s_files_paths=$(
    find . -type f -name "*.sh"\
    | relevant_find
  )
  if [[ -n "${LFBFL_s_files_paths}" ]]; then
    mapfile -t LFBFL_arr_files_paths <<< "${LFBFL_s_files_paths}"
    for LFBFL_file_path in "${LFBFL_arr_files_paths[@]}"; do
      shellcheck --rcfile=build_and_checks_variables/shellcheck.ini\
        "${LFBFL_file_path}"
    done
  fi
  printf "Running shell_checks_complement\n"
  shell_checks_complement "${LFBFL_some_common_options[@]}"

  printf -- "---Python---\n"
  printf "Running isort\n"
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
  printf "Running python_isort_complement\n"
  python_isort_complement "${LFBFL_some_common_options[@]}"

  printf "Running black\n"
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
  printf "Running python_black_complement\n"
  python_black_complement "${LFBFL_some_common_options[@]}"

  printf "Probing if mypy should be runned\n"
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
  LFBFL_s_files_paths=$(
    find . -type f -name "pyproject.toml"\
    | relevant_find
  )
  if [[ -n "${LFBFL_s_files_paths}" ]]; then
    mapfile -t LFBFL_arr_files_paths <<< "${LFBFL_s_files_paths}"
    for LFBFL_file_path in "${LFBFL_arr_files_paths[@]}"; do
      if grep -q "Typing :: Typed" "${LFBFL_file_path}"; then
        printf "Running mypy\n"
        LFBFL_directory_path=$(dirname "${LFBFL_file_path}")
        mypy "${LFBFL_directory_path}"
      fi
      LFBFL_no_toml=0
    done
  fi
  if [[ LFBFL_no_toml -eq 1 ]]; then
    printf "Running mypy\n"
    mypy .
  fi
  if [[ -n "${LFBFL_mypy_venv}" ]]; then
    deactivate
  fi

  printf "Running bandit\n"
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

  printf "Running pylint\n"
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

  printf "Running ruff\n"
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
  printf -- "---Python end---\n"

  printf -- "---PHP---\n"
  printf "Running PHPMD\n"
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
  sed -i -e 's/" file="/"\n    file="/g' "${LFBFL_temp_phpmd_baseline}"
  diff "${LFBFL_phpmd_baseline}" "${LFBFL_temp_phpmd_baseline}"
  printf -- "---PHP end---\n"

  printf -- "---JS---\n"
  LFBFL_npm_lint_directories=""
  grep_variable "${LFBFL_data_file_name}" npm_lint_directories\
    --result-variable-prefix="LFBFL_"
  if [[ -n "${LFBFL_npm_lint_directories}" ]]; then
    printf "Running ESLint\n"
    local LFBFL_JS_directory
    declare -a LFBFL_arr_paths
    mapfile -t LFBFL_arr_paths <<< "${LFBFL_npm_lint_directories}"
    for LFBFL_JS_directory in "${LFBFL_arr_paths[@]}"; do
      (cd "${LFBFL_JS_directory}" && npm run lint)
    done
  fi
  printf -- "---JS end---\n"

  printf "Analyzing too long lines\n"
  # shellcheck disable=SC2248
  too_long_code_lines "${LFBFL_some_common_options[@]}" \
    --max-line-length=${LFBFL_max_line_length}

  printf "Analyzing shell scripts beginnings\n"
  check_shell_scripts_beginnings "${LFBFL_some_common_options[@]}" \
    | relevant_grep

  printf "Analyzing shell scripts indentation\n"
  check_shell_scripts_indentation "${LFBFL_some_common_options[@]}" \
    | relevant_grep

  printf "Analyzing URLs\n"
  check_URLs "${LFBFL_some_common_options[@]}" \
    | relevant_grep

  printf "Analyzing strange characters: hover over in doubt\n"
  # shellcheck disable=SC1111
  LFBFL_usual_characters="\x00-\x7Fàâéèêëîïôûç©“”└─├│«»"
  grep --exclude-dir .git --binary-files=without-match --color=always\
    -nPr "[^${LFBFL_usual_characters}]" .

  [[ LFBFL_will_popd -eq 0 ]] && popd_from_work_directory

  printf "Checking listed files\n"
  "./${LFBFL_subdir}/update_or_check_files_names_listing.exec.sh"\
    "${LFBFL_some_common_options[@]}"

  printf "Creating the PDF file of the listing of the source code\n"
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
  printf "Running Nu W3C HTML CSS and SVG validator\n"
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
      printf $'/!\\ATTENTION: Nu W3C validator is too old./!\\\n'
      printf "Go get the latest version here:\n"
      printf "https://github.com/validator/validator/releases\n"
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
