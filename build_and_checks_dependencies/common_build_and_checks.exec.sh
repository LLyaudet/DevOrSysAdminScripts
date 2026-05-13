#!/usr/bin/env bash
# This file is part of DevOrSysAdminScripts.
#
# DevOrSysAdminScripts is free software:
# you can redistribute it and/or modify it
# under the terms of the GNU General Public License
# as published by the Free Software Foundation,
# either version 3 of the License,
# or (at your option) any later version.
#
# DevOrSysAdminScripts is distributed
# in the hope that it will be useful,
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
  # Options:
  #   --check-download=y|keep (=keep to keep the downloaded files)
  #   --verbose
  local LFBFL_work_directory="${1:-.}"
  LFBFL_work_directory=$(realpath -- "${LFBFL_work_directory}")
  declare -r LFBFL_dependencies_URL="$2"
  local LFBFL_verbose=""
  declare -i LFBFL_i_verbose=0
  if [[ "$*" == *--verbose* ]]; then
    printf "%s %s\n" "$0" "$*"
    LFBFL_verbose="--verbose"
    LFBFL_i_verbose=1
  fi
  readonly LFBFL_verbose
  readonly LFBFL_i_verbose
  local LFBFL_check_download=""
  if [[ "$*" == *--check-download=keep* ]]; then
    LFBFL_check_download="--check-download=keep"
  elif [[ "$*" == *--check-download=y* ]]; then
    LFBFL_check_download="--check-download=y"
  fi
  readonly LFBFL_check_download

  declare -a LFBFL_some_common_options=(
    "${LFBFL_verbose}"
    "--work-directory=${LFBFL_work_directory}"
  )

  source ./wget_sha512.libr.sh

  local LFBFL_subdir="build_and_checks_dependencies"
  declare -r LFBFL_subdir2="${LFBFL_subdir}/licenses_templates"
  declare -r LFBFL_subdir3="build_and_checks_variables"
  local LFBFL_file_name
  local LFBFL_script_download_URL
  local LFBFL_file_path
  local LFBFL_correct_sha512

  wrapped_wget_sha512(){
    wget_sha512 "${LFBFL_file_path}"\
      "${LFBFL_script_download_URL}"\
      "${LFBFL_correct_sha512}"\
      "${LFBFL_verbose}"\
      "${LFBFL_check_download}"
  }

  LFBFL_file_name="build_dependencies_notes.exec.php"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='7fa2566b939e765b70bc48b8b15e0dab50823b50bae40'
  LFBFL_correct_sha512+='97eeaac9f573139f60427f1d2c02fcf6a1bb4f89e21f'
  LFBFL_correct_sha512+='ca39fd98859a5f4714b6359588e10ef96ec623d'
  wrapped_wget_sha512
  chmod +x "./${LFBFL_file_path}"

  LFBFL_file_name="build_dependencies_notes.libr.php"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='3136857d20aafaabbdcd2468012a55991518430a39a07'
  LFBFL_correct_sha512+='e2f80572c39e51bda8599ac830cdb9ce83cbb606d034'
  LFBFL_correct_sha512+='f971f8734b103feae78d48867a29d4d566f2201'
  wrapped_wget_sha512

  LFBFL_file_name="build_md_from_printable_md.exec.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='500e10ac1b95a41b4d8c045bc7347a7473e7392168d3d'
  LFBFL_correct_sha512+='7f40f3d8a08e8fcb1f5229e548729684e33687afa759'
  LFBFL_correct_sha512+='34330727bf8b1884d45fda03a5407c9a6d798ef'
  wrapped_wget_sha512
  chmod +x "./${LFBFL_file_path}"

  LFBFL_file_name="check_shell_scripts_beginnings.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='0b3e861820e09148a141142c8bb5549e7fa29d906dda9'
  LFBFL_correct_sha512+='5e0fe44132610910687e6f767f1050646abe1ea262b8'
  LFBFL_correct_sha512+='37b3a5d5e79497d0cdc42e43d3c74967f266abb'
  wrapped_wget_sha512

  LFBFL_file_name="check_shell_scripts_indentation.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='3596fddc4b20ce353facac3e355e38fadb5593caee3c8'
  LFBFL_correct_sha512+='05464aedd513d34860a79b296efa648dae18717ae4c0'
  LFBFL_correct_sha512+='24a6df11eb0549c4797643427c49c4f80947840'
  wrapped_wget_sha512

  LFBFL_file_name="check_URLs.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='57113f2f2f0de5bb1e1c080232b8529ac347920b545fa'
  LFBFL_correct_sha512+='d919c69fb4ab19898239e70384d586beb0f1d5f7f274'
  LFBFL_correct_sha512+='f900bf0f8fc0ac7368aac6ec5b28ec4cef8fddf'
  wrapped_wget_sha512

  LFBFL_file_name="common_options.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='3cfaf6cea99f67ade931cf21e9f49658c421e182dc4ac'
  LFBFL_correct_sha512+='211be526f9d99b2e57a09844991cf0d2e6d5e49c19e2'
  LFBFL_correct_sha512+='a63bf9e8f1e3fe999542e9a4e45e5196b375fa9'
  wrapped_wget_sha512

  LFBFL_file_name="comparisons.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='f146beca0d7b4046c140f3b2292cec4c31515cf8c7dbe'
  LFBFL_correct_sha512+='7e9b07fc6dae32513aff6692c6286fa31055caff1a20'
  LFBFL_correct_sha512+='9a6a7384568fea0b50b3cbb2608a3ed9e6e5125'
  wrapped_wget_sha512

  LFBFL_file_name="create_PDF.exec.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='af85eaa0bedae5519bf02e44cf31d825d18f4c6248b9f'
  LFBFL_correct_sha512+='b256832edacbee60deff90b74ea5935104b246e526de'
  LFBFL_correct_sha512+='8fd5628649e464dd730b5923d35b53008d16487'
  wrapped_wget_sha512
  chmod +x "./${LFBFL_file_path}"

  LFBFL_file_name="generate_from_template.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='5f322f27bd20d7042c729f4cb5d8f14f587b5b415c77e'
  LFBFL_correct_sha512+='4a224902d8d4cdeb1483639ae85d81873c9f20c175bb'
  LFBFL_correct_sha512+='4de76a6eaa3dbcbf8a300368e65bbd5303afd3d'
  wrapped_wget_sha512

  LFBFL_file_name="get_common_text_glob_patterns.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='6c2f4b4ddc270c3d2ce9c88327efcb17510f10cac9b0f'
  LFBFL_correct_sha512+='88ca3b585dcba2d7997bed299a97102bff194fccae8c'
  LFBFL_correct_sha512+='771db6e735412ec6d0f9b3ccbe8416f95e79dfa'
  wrapped_wget_sha512

  LFBFL_file_name="grammar_and_spelling_check.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='88cc4f031c05d576a74ea7b14e79077f06c53b3b8a294'
  LFBFL_correct_sha512+='e9b8ddcfe884db5e2cb5cebde09a8d9aea7980fb595c'
  LFBFL_correct_sha512+='85c562462fb67e10503a471ee46da89c8f73b47'
  wrapped_wget_sha512

  # /licenses_templates/ ---------------------------------------------
  local LFBFL_dependencies_URL2
  LFBFL_dependencies_URL2="${LFBFL_dependencies_URL}/licenses_templates"
  readonly LFBFL_dependencies_URL2
  LFBFL_file_name="build_licenses_templates.exec.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL2}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir2}/${LFBFL_file_name}"
  LFBFL_correct_sha512='81b6dadd88516f4e560e00efc40e7dfa50a15e4ecade7'
  LFBFL_correct_sha512+='adfff2504771cd49fa5cc68c1f91e6d63a125465c997'
  LFBFL_correct_sha512+='5749f50cbd1017dc822bc546aed2d0d52413f52'
  wrapped_wget_sha512
  chmod +x "./${LFBFL_file_path}"

  LFBFL_file_name="license_file_header_AGPLv3+.tpl"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL2}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir2}/${LFBFL_file_name}"
  LFBFL_correct_sha512='5dc0dc20914c57feee2e26c2d329f020f221357b11b0d'
  LFBFL_correct_sha512+='0ff6add69941ad953f8356b68be32cd60df8c56e91a2'
  LFBFL_correct_sha512+='716c9cbf70ab8698e74e6aacc9c5439a93cc2bc'
  wrapped_wget_sha512

  LFBFL_file_name="license_file_header_GPLv3+.tpl"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL2}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir2}/${LFBFL_file_name}"
  LFBFL_correct_sha512='2d4b31697e78ba36ee0e3bd2b5393a57e15b5f5e62b2e'
  LFBFL_correct_sha512+='802b812dcb087588f63cb92a851b21180be24bf5dee4'
  LFBFL_correct_sha512+='eff7927244cde817e964512eaa1fb51d9064c01'
  wrapped_wget_sha512

  LFBFL_file_name="license_file_header_LGPLv3+.tpl"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL2}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir2}/${LFBFL_file_name}"
  LFBFL_correct_sha512='43976b6dc9a54fcea0440cfaf87530dade73efe22b5ae'
  LFBFL_correct_sha512+='a968453c9c5ac1fdc4d3798fdd445fb38a53f997da82'
  LFBFL_correct_sha512+='7c30be6b7ad42d5e56ae90aac5095b9526b203d'
  wrapped_wget_sha512
  # ------------------------------------------------------------------

  LFBFL_file_name="lines_counts.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='d131e24ad596988a6953b9362b13e5d17330f3bd8013b'
  LFBFL_correct_sha512+='03fc2acf74a6b931660a619149cce59d1fa3b075c11c'
  LFBFL_correct_sha512+='0a5e9c85e847b437d7bc3b58f034c00df3c5702'
  wrapped_wget_sha512

  LFBFL_file_name="lines_filters.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='d7b9d7456d18965b7910516cf80f96b5a89b76c59f315'
  LFBFL_correct_sha512+='f7558487f5f37afc8d0af13d4f11928f7c2bec8a03a1'
  LFBFL_correct_sha512+='7b49a9a5f71945d2a6fff955ce98518f5305234'
  wrapped_wget_sha512

  LFBFL_file_name="lines_maps.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='ccb9115be582a5b39790725dc96a628beb21b0c9951e7'
  LFBFL_correct_sha512+='03a7a7bc8ab2736e3940ed3df6a2fcb04e75350c10d7'
  LFBFL_correct_sha512+='3e92bcfada424b4049cc6141d41bf7901c0525b'
  wrapped_wget_sha512

  LFBFL_file_name="overwrite_if_not_equal.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='378f03b8ba77430e05db4ef5d5926803b466a87e1a2ec'
  LFBFL_correct_sha512+='eef0b51036f25460a93a018bd86d3f90146b4dfec9ab'
  LFBFL_correct_sha512+='15c5d1d57a526296bbdc4a0c03650088f3e9653'
  wrapped_wget_sha512

  LFBFL_file_name="python_black_complement.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='4f08461329f1b78b58e54f675fb433aec363de2c96a91'
  LFBFL_correct_sha512+='34ba5e96f3c77b93c9d7d6e28771a0b886501c286457'
  LFBFL_correct_sha512+='a4a410389556f180f2dc8f66d7956bf5dd5acf2'
  wrapped_wget_sha512

  LFBFL_file_name="python_isort_complement.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='f91f3236ff9720412b31ec9fec2a5a5b3ef2424931815'
  LFBFL_correct_sha512+='c0e6d1bd9821e86ef80a13a27a3f6d831327dc4b9698'
  LFBFL_correct_sha512+='5935a75793c87bdf735c4ae2a94327289d1c2ed'
  wrapped_wget_sha512

  LFBFL_file_name="repository_data.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='8148fae16b5853b5ed6ca141b73b32f6d8695d8d34a54'
  LFBFL_correct_sha512+='73ad8e8cc0dab61d92e87fd925b6f25c0632f70b2fee'
  LFBFL_correct_sha512+='78ee53b0e3af6aa25b3cc58d8769292c3e4defd'
  wrapped_wget_sha512

  LFBFL_file_name="shell_checks_complement.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='143575d86b5fc0fd78e575b6e46054b0c8facaf2c6df6'
  LFBFL_correct_sha512+='07dc596b6db0494c2b88211d5e0e011dee9abe70a2fc'
  LFBFL_correct_sha512+='b8f2bc04eb5cd50b248b0afe423103ee1cd568b'
  wrapped_wget_sha512

  LFBFL_file_name="split_score.exec.php"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='53830be68f0ef9f1a0b9b16a1d98d0a744a38b8fd0ee6'
  LFBFL_correct_sha512+='68f592aba2df7ec6c856eb1ced9ced7f3d21251699f8'
  LFBFL_correct_sha512+='7a352c8624d03ce5d5503692488c9e14a9ffb62'
  wrapped_wget_sha512
  chmod +x "./${LFBFL_file_path}"

  LFBFL_file_name="split_score.libr.php"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='e8333a215a02dd7250b01a5a8e8ec862b735735a52a95'
  LFBFL_correct_sha512+='2c9339cba94ffc9c1605fa4d84487be100fdff644c2e'
  LFBFL_correct_sha512+='e68cae3569fbc2b0a5525817b33e21425cd2e2f'
  wrapped_wget_sha512

  LFBFL_file_name="strings_functions.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='526bdaeca9ce0732ad429c16410909f9f8014eef9e031'
  LFBFL_correct_sha512+='837c428786b19bc31fea3eff6c8d93eea260b9076b67'
  LFBFL_correct_sha512+='71d21220528e70aa08a1a2fb7579926db662ff2'
  wrapped_wget_sha512

  LFBFL_file_name="too_long_code_lines.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='4d7ca9bd78576a15d16a922d05a27cbea465773625e04'
  LFBFL_correct_sha512+='7eb7aad23374e104a5c2dfcc25bee4bfa4452b55672e'
  LFBFL_correct_sha512+='2f99319cec2ca95cf06503b78add0b1408febef'
  wrapped_wget_sha512

  LFBFL_file_name="update_or_check_files_names_listing.exec.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='188fa5dbcab63be8e0f5b3c8997e099c7259f7c804433'
  LFBFL_correct_sha512+='581c2c05a7d9c7bd3d82bc424e2021afa90cb9e9d6a5'
  LFBFL_correct_sha512+='f84f549ed692c18b6351983c31b875846d7e1af'
  wrapped_wget_sha512
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
  # shellcheck source=grammar_and_spelling_check.libr.sh
  source "./${LFBFL_subdir}/grammar_and_spelling_check.libr.sh"
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
  [[ i_enhanced_set_bash_option_extglob_result -eq 0 ]]\
    && enhanced_unset_bash_option extglob

  declare -a LFBFL_return_traps_stack
  init_return_trap

  enhanced_set_shell_option pipefail --trap-unset

  declare -a LFBFL_some_common_options2=("${LFBFL_some_common_options[@]}")
  keep_options LFBFL_some_common_options2 --verbose

  printf "Building license headers\n"
  "./${LFBFL_subdir2}/build_licenses_templates.exec.sh"\
    "${LFBFL_some_common_options[@]}"

  printf "Building README.md\n"
  "./${LFBFL_subdir}/build_md_from_printable_md.exec.sh"\
    --work-directory="${LFBFL_work_directory}"\
    --base-name=README\
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
      LFBFL_some_directory=$(dirname -- "${LFBFL_file_path}")
      LFBFL_file_name=$(basename -- "${LFBFL_file_path}")
      LFBFL_file_name=${LFBFL_file_name%.md.tpl}
      "./${LFBFL_subdir}/build_md_from_printable_md.exec.sh"\
        --work-directory="${LFBFL_some_directory}"\
        --base-name="${LFBFL_file_name}"\
        "${LFBFL_verbose}"
    done
  fi

  printf "Building dependencies_notes\n"
  # https://github.com/php/php-src/issues/21538
  local LFBFL_annoying_warning
  LFBFL_annoying_warning="PHP Warning:  declare(encoding=...) ignored"
  LFBFL_annoying_warning=" because Zend multibyte feature is turned off"
  LFBFL_annoying_warning=" by settings in"
  readonly LFBFL_annoying_warning
  php -f="./${LFBFL_subdir}/build_dependencies_notes.exec.php"\
    -- "${LFBFL_work_directory}"\
    2>&1\
    | grep --invert-match "${LFBFL_annoying_warning}"

  declare -i LFBFL_i_directory_changed
  pushd_to_work_directory
  LFBFL_i_directory_changed=$?
  can_continue_after_enhanced_pushd || return 1

  local LFBFL_data_file_path="${LFBFL_subdir3}/repository_data.txt"

  declare -i LFBFL_i_max_line_length
  grep_variable "${LFBFL_data_file_path}" max_line_length\
    --result-variable-prefix=LFBFL_i_

  LFBFL_some_common_options+=(
    "--max-line-length=${LFBFL_i_max_line_length}"
  )
  LFBFL_some_common_options2+=(
    "--max-line-length=${LFBFL_i_max_line_length}"
  )

  declare -i LFBFL_i_upgrade_venvs=0
  local LFBFL_upgrade_venvs_ts_file="${LFBFL_subdir3}/upgrade_venvs_ts"
  readonly LFBFL_upgrade_venvs_ts_file
  declare -i LFBFL_i_upgrade_venvs_ts
  declare -i LFBFL_i_current_ts
  local LFBFL_upgrade_venvs_answer

  local LFBFL_upgrade_venvs_time_interval_in_seconds=""
  get_upgrade_venvs_time_interval_in_seconds "${LFBFL_data_file_path}"\
    "${LFBFL_some_common_options2[@]}"

  if [[ -f "${LFBFL_upgrade_venvs_ts_file}" ]]; then
    LFBFL_i_upgrade_venvs_ts=$(
      stat --format %Y -- "${LFBFL_upgrade_venvs_ts_file}"
    )
    LFBFL_i_current_ts=$(date +%s)
    ((LFBFL_i_current_ts -= LFBFL_i_upgrade_venvs_ts))
    ((LFBFL_i_current_ts -= LFBFL_upgrade_venvs_time_interval_in_seconds))
    if [[ LFBFL_i_current_ts -gt 0 ]]; then
      LFBFL_i_upgrade_venvs=1
    fi
  else
    LFBFL_i_upgrade_venvs=1
  fi
  if [[ LFBFL_i_upgrade_venvs -eq 1 ]]; then
    local LFBFL_upgrade_venvs=""
    grep_variable "${LFBFL_data_file_path}" upgrade_venvs\
      --result-variable-prefix=LFBFL_
    if [[ "${LFBFL_upgrade_venvs}" != "auto" ]]; then
      read -r -n 1 -t 10\
        -p "Upgrade venvs and composer global? [Y/n]"\
        LFBFL_upgrade_venvs_answer
      if [[ "${LFBFL_upgrade_venvs_answer}" == "n" ]]; then
        LFBFL_i_upgrade_venvs=0
      fi
    fi
  fi

  printf "Analyzing too long lines\n"
  too_long_code_lines "${LFBFL_some_common_options2[@]}"

  printf "Analyzing URLs\n"
  check_URLs "${LFBFL_some_common_options2[@]}" \
    | relevant_grep

  printf "Analyzing strange characters: hover over in doubt\n"
  # shellcheck disable=SC1111
  LFBFL_usual_characters="\x00-\x7Fàâéèêëîïôûç©“”└─├│«»…"
  grep --binary-files=without-match --color=always --exclude-dir .git\
    --line-number --perl-regexp --recursive --\
    "[^${LFBFL_usual_characters}]" .\
    | relevant_grep

  printf "Grammar and spelling check\n"
  grammar_and_spelling_check "${LFBFL_data_file_path}"\
    "${LFBFL_some_common_options2[@]}"

  printf "Running shellcheck\n"
  LFBFL_s_files_paths=$(
    find . -type f -name "*.sh"\
    | relevant_find
  )
  if [[ -n "${LFBFL_s_files_paths}" ]]; then
    mapfile -t LFBFL_arr_files_paths <<< "${LFBFL_s_files_paths}"
    for LFBFL_file_path in "${LFBFL_arr_files_paths[@]}"; do
      shellcheck --rcfile="${LFBFL_subdir3}/shellcheck.ini"\
        -- "${LFBFL_file_path}"
    done
  fi
  printf "Running shell_checks_complement\n"
  shell_checks_complement "${LFBFL_some_common_options2[@]}"

  printf "Analyzing shell scripts beginnings\n"
  check_shell_scripts_beginnings "${LFBFL_some_common_options2[@]}" \
    | relevant_grep

  printf "Analyzing shell scripts indentation\n"
  check_shell_scripts_indentation "${LFBFL_some_common_options2[@]}" \
    | relevant_grep

  printf -- "---Python---\n"

  maybe_deactivate(){
    if command -v deactivate
    then
      deactivate
    fi
  }

  source_without_return_trap(){
    declare -i LFBFL_i_no_return_traps=1
    # shellcheck disable=SC1090,SC1091
    source -- "$1"
  }

  printf "Running isort\n"
  local LFBFL_isort_venv=""
  grep_variable "${LFBFL_data_file_path}" isort_venv\
    --result-variable-prefix=LFBFL_\
    --replace-line-returns-by=""
  if [[ -n "${LFBFL_isort_venv}" ]]; then
    maybe_deactivate
    source_without_return_trap "${LFBFL_isort_venv}/bin/activate"
  fi
  if [[ LFBFL_i_upgrade_venvs -eq 1 ]]; then
    pip install --upgrade isort
  fi
  isort --profile=black .
  if [[ -n "${LFBFL_isort_venv}" ]]; then
    deactivate
  fi
  printf "Running python_isort_complement\n"
  python_isort_complement "${LFBFL_some_common_options2[@]}"

  printf "Running black\n"
  # First, we update the configuration file with max_line_length.
  local LFBFL_update_max_length="s/^line-length = [0-9]*$"
  LFBFL_update_max_length+="/line-length = ${LFBFL_i_max_line_length}/"
  sed --regexp-extended --expression="${LFBFL_update_max_length}"\
    "${LFBFL_subdir3}/black.toml"\
    > "${LFBFL_subdir3}/black.toml.temp"
  overwrite_if_not_equal "${LFBFL_subdir3}/black.toml"\
    "${LFBFL_subdir3}/black.toml.temp"

  local LFBFL_black_venv=""
  grep_variable "${LFBFL_data_file_path}" black_venv\
    --result-variable-prefix=LFBFL_\
    --replace-line-returns-by=""
  if [[ -n "${LFBFL_black_venv}" ]]; then
    maybe_deactivate
    source_without_return_trap "${LFBFL_black_venv}/bin/activate"
  fi
  if [[ LFBFL_i_upgrade_venvs -eq 1 ]]; then
    pip install --upgrade black
  fi
  black --config="${LFBFL_subdir3}/black.toml" .
  if [[ -n "${LFBFL_black_venv}" ]]; then
    deactivate
  fi
  printf "Running python_black_complement\n"
  python_black_complement "${LFBFL_some_common_options2[@]}"

  printf "Probing if mypy should be runned\n"
  local LFBFL_mypy_venv=""
  grep_variable "${LFBFL_data_file_path}" mypy_venv\
    --result-variable-prefix=LFBFL_\
    --replace-line-returns-by=""
  if [[ -n "${LFBFL_mypy_venv}" ]]; then
    maybe_deactivate
    source_without_return_trap "${LFBFL_mypy_venv}/bin/activate"
  fi
  if [[ LFBFL_i_upgrade_venvs -eq 1 ]]; then
    pip install --upgrade mypy
  fi
  local LFBFL_directory_path
  declare -i LFBFL_i_no_toml=1
  LFBFL_s_files_paths=$(
    find . -type f -name "pyproject.toml"\
    | relevant_find
  )
  if [[ -n "${LFBFL_s_files_paths}" ]]; then
    mapfile -t LFBFL_arr_files_paths <<< "${LFBFL_s_files_paths}"
    for LFBFL_file_path in "${LFBFL_arr_files_paths[@]}"; do
      if grep --quiet "Typing :: Typed" -- "${LFBFL_file_path}"; then
        printf "Running mypy\n"
        LFBFL_directory_path=$(dirname -- "${LFBFL_file_path}")
        mypy -- "${LFBFL_directory_path}"
      fi
      LFBFL_i_no_toml=0
    done
  fi
  if [[ LFBFL_i_no_toml -eq 1 ]]; then
    printf "Running mypy\n"
    mypy .
  fi
  if [[ -n "${LFBFL_mypy_venv}" ]]; then
    deactivate
  fi

  printf "Running bandit\n"
  LFBFL_bandit_venv=""
  grep_variable "${LFBFL_data_file_path}" bandit_venv\
    --result-variable-prefix=LFBFL_\
    --replace-line-returns-by=""
  if [[ -n "${LFBFL_bandit_venv}" ]]; then
    maybe_deactivate
    source_without_return_trap "${LFBFL_bandit_venv}/bin/activate"
  fi
  if [[ LFBFL_i_upgrade_venvs -eq 1 ]]; then
    pip install --upgrade bandit
  fi
  bandit --ini="${LFBFL_subdir3}/bandit.ini"\
    --baseline="${LFBFL_subdir3}/bandit_baseline.json"\
    --recursive .
  # Saving new baseline in temp if necessary.
  bandit --ini="${LFBFL_subdir3}/bandit.ini"\
    --format=json\
    --output="${LFBFL_subdir3}/temp/bandit_baseline.json"\
    --recursive .
  if [[ -n "${LFBFL_bandit_venv}" ]]; then
    deactivate
  fi

  printf "Running pylint\n"
  LFBFL_pylint_venv=""
  grep_variable "${LFBFL_data_file_path}" pylint_venv\
    --result-variable-prefix=LFBFL_\
    --replace-line-returns-by=""
  if [[ -n "${LFBFL_pylint_venv}" ]]; then
    maybe_deactivate
    source_without_return_trap "${LFBFL_pylint_venv}/bin/activate"
  fi
  if [[ LFBFL_i_upgrade_venvs -eq 1 ]]; then
    pip install --upgrade pylint
  fi
  pylint --rcfile="${LFBFL_subdir3}/pylintrc.toml" --recursive=y .
  if [[ -n "${LFBFL_pylint_venv}" ]]; then
    deactivate
  fi

  printf "Running ruff\n"
  LFBFL_ruff_venv=""
  grep_variable "${LFBFL_data_file_path}" ruff_venv\
    --result-variable-prefix=LFBFL_\
    --replace-line-returns-by=""
  if [[ -n "${LFBFL_ruff_venv}" ]]; then
    maybe_deactivate
    source_without_return_trap "${LFBFL_ruff_venv}/bin/activate"
  fi
  if [[ LFBFL_i_upgrade_venvs -eq 1 ]]; then
    pip install --upgrade ruff
  fi
  ruff check --config="${LFBFL_subdir3}/ruff.toml"
  if [[ -n "${LFBFL_ruff_venv}" ]]; then
    deactivate
  fi
  printf -- "---Python end---\n"

  printf -- "---PHP---\n"
  printf "Running PHP native linter\n"
  LFBFL_s_files_paths=$(
    find . -type f -name "*.php"\
    | relevant_find
  )
  if [[ -n "${LFBFL_s_files_paths}" ]]; then
    mapfile -t LFBFL_arr_files_paths <<< "${LFBFL_s_files_paths}"
    for LFBFL_file_path in "${LFBFL_arr_files_paths[@]}"; do
      php --syntax-check -f="${LFBFL_file_path}"
    done
  fi

  printf "Running PHP_CodeSniffer\n"
  if [[ LFBFL_i_upgrade_venvs -eq 1 ]]; then
    composer global require squizlabs/php_codesniffer
  fi
  phpcs --report=code\
    --standard=build_and_checks_variables/phpcs_ruleset.xml

  printf "Running PHPMD\n"
  if [[ LFBFL_i_upgrade_venvs -eq 1 ]]; then
    composer global require phpmd/phpmd
  fi

  declare -r LFBFL_phpmd_baseline="${LFBFL_subdir3}/phpmd_baseline.xml"
  local LFBFL_temp_phpmd_baseline="${LFBFL_subdir3}/temp/"
  LFBFL_temp_phpmd_baseline+="phpmd_baseline.xml"
  readonly LFBFL_temp_phpmd_baseline

  local LFBFL_phpmd_rulesets="cleancode,codesize,controversial,"
  LFBFL_phpmd_rulesets+="design,naming,unusedcode"
  readonly LFBFL_phpmd_rulesets

  phpmd --color --baseline-file="${LFBFL_phpmd_baseline}"\
    . text "${LFBFL_phpmd_rulesets}"
  # Saving new baseline in temp if necessary.
  rm "${LFBFL_temp_phpmd_baseline}"
  phpmd --color --generate-baseline\
    --baseline-file="${LFBFL_temp_phpmd_baseline}"\
    . text "${LFBFL_phpmd_rulesets}"
  sed --in-place --expression='s/" file="/"\n    file="/g'\
    "${LFBFL_temp_phpmd_baseline}"
  sed --in-place --regexp-extended\
    --expression='s~(file=".*)/>~\1\n  />~g'\
    "${LFBFL_temp_phpmd_baseline}"
  diff --suppress-common-lines\
    "${LFBFL_phpmd_baseline}" "${LFBFL_temp_phpmd_baseline}"\
    | grep --invert-match --regexp='<!-- ' --regexp='^[0-9]\+d[0-9]\+$'

  printf "Running phpDocumentor\n"
  # shellcheck disable=SC2312
  docker run --rm --volume="$(pwd):/data" phpdoc/phpdoc
  printf -- "---PHP end---\n"

  printf -- "---JS---\n"
  local LFBFL_npm_lint_directories=""
  grep_variable "${LFBFL_data_file_path}" npm_lint_directories\
    --result-variable-prefix=LFBFL_
  if [[ -n "${LFBFL_npm_lint_directories}" ]]; then
    printf "Running ESLint\n"
    local LFBFL_JS_directory
    declare -a LFBFL_arr_paths
    mapfile -t LFBFL_arr_paths <<< "${LFBFL_npm_lint_directories}"
    for LFBFL_JS_directory in "${LFBFL_arr_paths[@]}"; do
      (cd -- "${LFBFL_JS_directory}" && npm run lint)
    done
  fi
  printf -- "---JS end---\n"

  [[ LFBFL_i_directory_changed -eq 0 ]] && popd_from_work_directory

  printf "Checking listed files\n"
  "./${LFBFL_subdir}/update_or_check_files_names_listing.exec.sh"\
    "${LFBFL_some_common_options[@]}"

  printf "Creating the PDF file of the listing of the source code\n"
  "./${LFBFL_subdir}/create_PDF.exec.sh" "${LFBFL_some_common_options[@]}"

  pushd_to_work_directory --trap-popd
  can_continue_after_enhanced_pushd || return 1

  if [[ -f "${LFBFL_subdir3}/post_build.sh" ]]; then
    "./${LFBFL_subdir3}/post_build.sh" "${LFBFL_verbose}"
  fi

  printf "Running xmllint\n"
  # In some cases, we need to handle a cache of common DTDs by hand.
  # XHTML DTDs validation can yield errors:
  # see https://gitlab.gnome.org/GNOME/libxml2/-/work_items/1119
  # If you use Ubuntu/Debian, install w3c-sgml-lib instead.
  LFBFL_file_name="xhtml1-strict.dtd"
  LFBFL_a="https://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
  LFBFL_script_download_URL="${LFBFL_a}"
  LFBFL_file_path="./${LFBFL_subdir3}/temp/${LFBFL_file_name}"
  LFBFL_correct_sha512='fe11db06c0e1741a9c460fe4f9cf167bca57f4dbe9746'
  LFBFL_correct_sha512+='d8352bf19947168c9bcf1ae212eca035824293abb1f9'
  LFBFL_correct_sha512+='7a0ac02d67a82d098c34905c8cf1b213c891cc0'
  wrapped_wget_sha512

  LFBFL_file_name="xhtml1-transitional.dtd"
  LFBFL_a="https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
  LFBFL_script_download_URL="${LFBFL_a}"
  LFBFL_file_path="./${LFBFL_subdir3}/temp/${LFBFL_file_name}"
  LFBFL_correct_sha512='4bece71fbf75d4a68a900ed29b8ba4efae1a9dfa447a5'
  LFBFL_correct_sha512+='6fc8583da2531f9eadb0fb57bc4cf4990a82ac1da3b3'
  LFBFL_correct_sha512+='c2892e38c88d70a80f8464b21f0bdef79a04843'
  wrapped_wget_sha512

  LFBFL_file_name="xhtml1-frameset.dtd"
  LFBFL_a="https://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd"
  LFBFL_script_download_URL="${LFBFL_a}"
  LFBFL_file_path="./${LFBFL_subdir3}/temp/${LFBFL_file_name}"
  LFBFL_correct_sha512='f969c36d5ba7f6de42261c223f1a8958c8205cb938127'
  LFBFL_correct_sha512+='ea5b7fce6bb2e03a529259e41aa3a429c64177893614'
  LFBFL_correct_sha512+='f05e3f22bd9c46c61b37a83eb702a6d72ce2872'
  wrapped_wget_sha512

  LFBFL_file_name="xhtml11.dtd"
  LFBFL_a="https://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"
  LFBFL_script_download_URL="${LFBFL_a}"
  LFBFL_file_path="./${LFBFL_subdir3}/temp/${LFBFL_file_name}"
  LFBFL_correct_sha512='aa08bb274fd8c4d33bbcaf8993b2357c4e6c03fbdc34b'
  LFBFL_correct_sha512+='1c46bb98332e21db824a11de43da9c6388032149a148'
  LFBFL_correct_sha512+='42992c6d92e728e275817b656d1c333ca7f5d04'
  wrapped_wget_sha512

  LFBFL_file_name="xhtml-lat1.ent"
  LFBFL_a="https://www.w3.org/MarkUp/DTD/xhtml-lat1.ent"
  LFBFL_script_download_URL="${LFBFL_a}"
  LFBFL_file_path="./${LFBFL_subdir3}/temp/${LFBFL_file_name}"
  LFBFL_correct_sha512='3243f33c056e71ae995d51cd2418979a505875d53ec9b'
  LFBFL_correct_sha512+='17310268232dfbda19f5a52794973db47e51058cbcb4'
  LFBFL_correct_sha512+='4a86838fed4937e6adc29636e12741bdc93af04'
  wrapped_wget_sha512

  LFBFL_file_name="xhtml-special.ent"
  LFBFL_a="https://www.w3.org/MarkUp/DTD/xhtml-special.ent"
  LFBFL_script_download_URL="${LFBFL_a}"
  LFBFL_file_path="./${LFBFL_subdir3}/temp/${LFBFL_file_name}"
  LFBFL_correct_sha512='ec8e78745673044993b2d57242f834c94f1615a0df653'
  LFBFL_correct_sha512+='5882b84c1df223f652ce536cc6b17eece23ab6dae518'
  LFBFL_correct_sha512+='60a6e562b20f7ef5440004d56f9dbe4ea58913f'
  wrapped_wget_sha512

  LFBFL_file_name="xhtml-symbol.ent"
  LFBFL_a="https://www.w3.org/MarkUp/DTD/xhtml-symbol.ent"
  LFBFL_script_download_URL="${LFBFL_a}"
  LFBFL_file_path="./${LFBFL_subdir3}/temp/${LFBFL_file_name}"
  LFBFL_correct_sha512='47ca9edba10776c5ea8bba5c0e3ea8dc1a94b2830eada'
  LFBFL_correct_sha512+='2ebf2bec1101ca05066ce09c0e06ecef1af7785c1179'
  LFBFL_correct_sha512+='0a61c2efdc959d89610b7b4b084bb60af89cf72'
  wrapped_wget_sha512

  declare -r LFBFL_s_files_for_xmllint=$(
    find . -type f -iregex ".*\.\(xml\|xhtml\)"\
    | relevant_find\
    | sort
  )
  if [[ -n "${LFBFL_s_files_for_xmllint}" ]]; then
    LFBFL_xmllint_use_downloaded_DTDs=""
    grep_variable "${LFBFL_data_file_path}" xmllint_use_downloaded_DTDs\
      --result-variable-prefix=LFBFL_

    declare -a LFBFL_arr_files_for_xmllint
    mapfile -t LFBFL_arr_files_for_xmllint\
      <<< "${LFBFL_s_files_for_xmllint}"
    readonly LFBFL_arr_files_for_xmllint
    local LFBFL_xmllint_files_without_DTD=""
    grep_variable_with_multiple_files "${LFBFL_data_file_path}"\
      xmllint_files_without_DTD\
      --result-variable-prefix=LFBFL_
    declare -a LFBFL_arr_xmllint_files_without_DTD
    if [[ -n "${LFBFL_xmllint_files_without_DTD}" ]]; then
      mapfile -t LFBFL_arr_xmllint_files_without_DTD\
        <<< "${LFBFL_xmllint_files_without_DTD}"
    fi
    for LFBFL_file_path in "${LFBFL_arr_xmllint_files_without_DTD[@]}"; do
      [[ LFBFL_i_verbose -eq 1 ]]\
        && printf "xmllint on %s\n" "${LFBFL_file_path}"
      # see https://gitlab.gnome.org/GNOME/libxml2/-/issues/1100
      # https://gitlab.gnome.org/GNOME/libxml2/-/work_items/1100
      # xmllint --pedantic --noout -- "${LFBFL_file_path}"
      xmllint --pedantic --noout "${LFBFL_file_path}"
    done

    local LFBFL_file_path2
    for LFBFL_file_path in "${LFBFL_arr_files_for_xmllint[@]}"; do
      for LFBFL_file_path2 in "${LFBFL_arr_xmllint_files_without_DTD[@]}";
      do
        if [[ "${LFBFL_file_path}" == "${LFBFL_file_path2}" ]]; then
          LFBFL_file_path=""
        fi
      done
      if [[ "${LFBFL_file_path}" == "" ]]; then
        continue
      fi
      [[ LFBFL_i_verbose -eq 1 ]]\
        && printf "xmllint on %s\n" "${LFBFL_file_path}"
      if [[
        "${LFBFL_file_path}" == *.xhtml
        && "${LFBFL_xmllint_use_downloaded_DTDs}" == "true"
      ]]; then
        if grep --fixed-strings\
          "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"\
          "${LFBFL_file_path}"
        then
          xmllint --pedantic --noout\
            --dtdvalid "./${LFBFL_subdir3}/temp/xhtml1-strict.dtd"\
            "${LFBFL_file_path}"
        elif grep --fixed-strings\
          "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"\
          "${LFBFL_file_path}"
        then
          xmllint --pedantic --noout\
            --dtdvalid "./${LFBFL_subdir3}/temp/xhtml1-transitional.dtd"\
            "${LFBFL_file_path}"
        elif grep --fixed-strings\
          "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd"\
          "${LFBFL_file_path}"
        then
          xmllint --pedantic --noout\
            --dtdvalid "./${LFBFL_subdir3}/temp/xhtml1-frameset.dtd"\
            "${LFBFL_file_path}"
        elif grep --fixed-strings\
          "http://www.w3.org/TR/xhtml1/DTD/xhtml11.dtd"\
          "${LFBFL_file_path}"
        then
          xmllint --pedantic --noout\
            --dtdvalid "./${LFBFL_subdir3}/temp/xhtml11.dtd"\
            "${LFBFL_file_path}"
        else
          printf "Unknown XHTML DTD.\n"
        fi
      else
        xmllint --pedantic --noout --valid "${LFBFL_file_path}"
      fi
    done
  fi
  # ------------------------------------------------------------------

  # ------------------------------------------------------------------
  # It is at the end that all the HTML files are generated and that
  # we can check there are no mistakes.
  printf "Running Nu W3C HTML CSS and SVG validator\n"
  local LFBFL_upgrade_vnu_jar_time_interval_in_seconds=""
  grep_variable "${LFBFL_data_file_path}"\
    upgrade_vnu_jar_time_interval_in_seconds\
    --result-variable-prefix=LFBFL_

  if [[ "${LFBFL_upgrade_vnu_jar_time_interval_in_seconds}" == "wat" ]];
  then
    LFBFL_upgrade_vnu_jar_time_interval_in_seconds=${RANDOM}
  fi

  declare -i LFBFL_i_vnu_jar_ts
  local LFBFL_vnu_jar_path=""
  grep_variable "${LFBFL_data_file_path}" vnu_jar_path\
    --result-variable-prefix=LFBFL_\
    --replace-line-returns-by=""
  if [[ -f "${LFBFL_vnu_jar_path}" ]]; then
    LFBFL_i_vnu_jar_ts=$(stat --format %Y -- "${LFBFL_vnu_jar_path}")
    LFBFL_i_current_ts=$(date +%s)
    ((LFBFL_i_current_ts -= LFBFL_i_vnu_jar_ts))
    ((
      LFBFL_i_current_ts -= LFBFL_upgrade_vnu_jar_time_interval_in_seconds
    ))
    if [[ LFBFL_i_current_ts -gt 0 ]]; then
      printf $'/!\\ATTENTION: Nu W3C validator is too old./!\\\n'
      printf "Go get the latest version here:\n"
      printf "https://github.com/validator/validator/releases\n"
    fi
    # vnu has false positives for xhtml.
    local LFBFL_use_vnu_for_xhtml=""
    grep_variable "${LFBFL_data_file_path}" use_vnu_for_xhtml\
      --result-variable-prefix=LFBFL_
    local LFBFL_find_regexp
    if [[ "${LFBFL_use_vnu_for_xhtml}" == "true" ]]; then
      LFBFL_find_regexp=".*\.\(css\|html\|svg\|xhtml\)"
    else
      LFBFL_find_regexp=".*\.\(css\|html\|svg\)"
    fi
    declare -r LFBFL_s_files_for_Nu=$(
      find . -type f -iregex "${LFBFL_find_regexp}"\
      | relevant_find
    )
    if [[ -n "${LFBFL_s_files_for_Nu}" ]]; then
      declare -a LFBFL_arr_files_for_Nu
      mapfile -t LFBFL_arr_files_for_Nu <<< "${LFBFL_s_files_for_Nu}"
      readonly LFBFL_arr_files_for_Nu
      java -Xss128M -jar "${LFBFL_vnu_jar_path}" --exit-zero-always\
        --verbose -- "${LFBFL_arr_files_for_Nu[@]}"
    fi
  fi
  # ------------------------------------------------------------------

  if [[ LFBFL_i_upgrade_venvs -eq 1 ]]; then
    touch -- "${LFBFL_upgrade_venvs_ts_file}"
  fi
}

common_build_and_checks "$@"
