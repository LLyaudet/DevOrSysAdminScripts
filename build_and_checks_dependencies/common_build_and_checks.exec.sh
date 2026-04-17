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
  LFBFL_correct_sha512='624368d161351d7a261fbe3165d51907f46394c1b0e79'
  LFBFL_correct_sha512+='b980ec11173c324b2c5531cf2a2b60b2dc62edcaa9c8'
  LFBFL_correct_sha512+='71dca55065f8802df4275420836252786f9606b'
  wrapped_wget_sha512
  chmod +x "./${LFBFL_file_path}"

  LFBFL_file_name="build_dependencies_notes.libr.php"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='49e9469e44e3a18db98810ab734b89ff1268e7a9c7788'
  LFBFL_correct_sha512+='12e8fb853aff5a26aaf00845975c73fd7cf6ef5011aa'
  LFBFL_correct_sha512+='462629ca4c6d8db119668f429c956c040b07894'
  wrapped_wget_sha512

  LFBFL_file_name="build_md_from_printable_md.exec.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='4ed727f21bfdb99d3c3a37d631d27816da10be357a200'
  LFBFL_correct_sha512+='b03516cc642cc720735bd1363e47e1b38d5a4667a4ef'
  LFBFL_correct_sha512+='75c573e92f09261df6c2c55ee9c0852ab2d1ee8'
  wrapped_wget_sha512
  chmod +x "./${LFBFL_file_path}"

  LFBFL_file_name="check_shell_scripts_beginnings.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='beb8e11e2ac7fa636a0ac586f2378d8c8f72b16320a72'
  LFBFL_correct_sha512+='99533bd4fbcdbd8794281d78a8882dee54eb53d639a9'
  LFBFL_correct_sha512+='0accdf8f557ac6f64bd9b9d6fe3eae9d4789f54'
  wrapped_wget_sha512

  LFBFL_file_name="check_shell_scripts_indentation.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='9ebc5cfab69e6beab5e77495b2585ce9bc3ad84af4e9c'
  LFBFL_correct_sha512+='20f5a8ed390730fbeb0bf13ff4cfef635dbdbfff8872'
  LFBFL_correct_sha512+='8b1fe95595ef4d47a7f535cd4644c0ccbfa384c'
  wrapped_wget_sha512

  LFBFL_file_name="check_URLs.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='9e42d111550432b63d63f9faa35c92c45a9e4ef308a65'
  LFBFL_correct_sha512+='1ecf094a0838ac36fbe36109b3dc9b4d48a24887d155'
  LFBFL_correct_sha512+='dae7b546ea64551493d0dc4e772e1b09248fa4e'
  wrapped_wget_sha512

  LFBFL_file_name="common_options.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='937a76a0ff1b67be3f33c0397c1d6df267b239bf6b62e'
  LFBFL_correct_sha512+='326196e9b80d53d2bf73dfac94139c81280977c8d45f'
  LFBFL_correct_sha512+='1bcac0b0cb1dd3bd4ce6b53e8d9dfa53703d328'
  wrapped_wget_sha512

  LFBFL_file_name="comparisons.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='27a77b03184fa1497ad0448206a85cfc85071d96364b9'
  LFBFL_correct_sha512+='c7ea6bedcd956eecf14115f5f001d6d859e22caa690b'
  LFBFL_correct_sha512+='3eebe5805afaa94e530ef8de01d54da408956c3'
  wrapped_wget_sha512

  LFBFL_file_name="create_PDF.exec.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='2f91e02375a94dfdafb832e41976c0180516b5bee8ac6'
  LFBFL_correct_sha512+='d83b0efd6f096bf72f9d92daad0b10b57fb2f290e9c4'
  LFBFL_correct_sha512+='67ae311455c1dadf1e5af126f996cc9d933ca6d'
  wrapped_wget_sha512
  chmod +x "./${LFBFL_file_path}"

  LFBFL_file_name="generate_from_template.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='2a14fde1756a2a55f357a94f696aa4dc78f5f3f7be484'
  LFBFL_correct_sha512+='9c83b76b8b97a31770b20d1ab46ac9e5b0afeb7b63fc'
  LFBFL_correct_sha512+='72aa1fbbbad15ac3e1c41b11244f59a2a2143d0'
  wrapped_wget_sha512

  LFBFL_file_name="get_common_text_glob_patterns.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='d38b894f63ac0db1eab4447a765b723642e12e3443aee'
  LFBFL_correct_sha512+='01bd08e44bd2971bf11d3f0b98d2932bcaaeab4f30b7'
  LFBFL_correct_sha512+='9f7da666e02a0fb1dada8a348ad866a104e4d53'
  wrapped_wget_sha512

  LFBFL_file_name="grammar_and_spelling_check.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='5722273402a4e8afbae4bc10e7a50f3d74d942404df18'
  LFBFL_correct_sha512+='bc59f1bb12cea917f6292ee3dd13a7533d16fd03af99'
  LFBFL_correct_sha512+='c4941df14027cce33afae1c0db169f15e503f2c'
  wrapped_wget_sha512

  # /licenses_templates/ ---------------------------------------------
  local LFBFL_dependencies_URL2
  LFBFL_dependencies_URL2="${LFBFL_dependencies_URL}/licenses_templates"
  readonly LFBFL_dependencies_URL2
  LFBFL_file_name="build_licenses_templates.exec.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL2}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir2}/${LFBFL_file_name}"
  LFBFL_correct_sha512='35c70daa9c5fc7fd7bdc127162a41dce0c80fa5cb08cc'
  LFBFL_correct_sha512+='309deb204660f0f84ac8d87f96096f0cca1afbecb03b'
  LFBFL_correct_sha512+='0783a2772e2161b9486449d506cd7ff9bff0376'
  wrapped_wget_sha512
  chmod +x "./${LFBFL_file_path}"

  LFBFL_file_name="license_file_header_AGPLv3+.tpl"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL2}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir2}/${LFBFL_file_name}"
  LFBFL_correct_sha512='9f9aa56d9b90d5003a12c5ec3370ac31aab74fc4a2524'
  LFBFL_correct_sha512+='2c5fbcb0197b0abbb8242f62dafc76eaf60faa5da173'
  LFBFL_correct_sha512+='05924b31b64b037083532fced9f98445000e2d0'
  wrapped_wget_sha512

  LFBFL_file_name="license_file_header_GPLv3+.tpl"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL2}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir2}/${LFBFL_file_name}"
  LFBFL_correct_sha512='2bdef9a729a5a9ca5ed87ef8a518877c5ee6b31b45336'
  LFBFL_correct_sha512+='08660316a4e595fb31465a4847f4d53a2f7264118bd4'
  LFBFL_correct_sha512+='eab7c1d1892e00bc1861455ed02898f194db067'
  wrapped_wget_sha512

  LFBFL_file_name="license_file_header_LGPLv3+.tpl"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL2}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir2}/${LFBFL_file_name}"
  LFBFL_correct_sha512='265fd0d086b48ab798f35a072335a4976e4eda8c256fe'
  LFBFL_correct_sha512+='bba6c77c98ca86cdd844c6ac150c3445c80debbb3fc2'
  LFBFL_correct_sha512+='574b5fceeeaf79ec734a759bdef5fe798067c62'
  wrapped_wget_sha512
  # ------------------------------------------------------------------

  LFBFL_file_name="lines_counts.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='97e50d1fd31841c8e5b747503a55999d5bd3d394808c3'
  LFBFL_correct_sha512+='037b321ab54057518a861e4bb97fa7659aee061a31cf'
  LFBFL_correct_sha512+='e30ac8af22f268f19aa51accf334cbc38aa9091'
  wrapped_wget_sha512

  LFBFL_file_name="lines_filters.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='822a6aac727f833ec30d1958d7e0e1cf1e0527cb21085'
  LFBFL_correct_sha512+='28717daee70af33186ad381677d848ea9b4ae8882355'
  LFBFL_correct_sha512+='a739b8be459c1974b3b659186acf769a63b7b62'
  wrapped_wget_sha512

  LFBFL_file_name="lines_maps.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='45df460ebb31fd5f2f2a62a70f03d6ab9fd3bfd8d6e6f'
  LFBFL_correct_sha512+='e45650e339f5b6bad5557a8c8d3a830d8539ba5442df'
  LFBFL_correct_sha512+='68945da69270219159ceea45b14b395793fc025'
  wrapped_wget_sha512

  LFBFL_file_name="overwrite_if_not_equal.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='f75d5232cba494dd9c1a53111dc10b78414ec180bf293'
  LFBFL_correct_sha512+='6114bdc8c415b41d0c3dd05b31ad9cf66affa1080922'
  LFBFL_correct_sha512+='cc2d9fce18a4cdcef8feee8816ee100196fc190'
  wrapped_wget_sha512

  LFBFL_file_name="python_black_complement.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='1511766231f7463236f9eb31da045b7cf261f356de956'
  LFBFL_correct_sha512+='01431a015d8fbac9fd823a1ac5c2ffd16baedc2228c8'
  LFBFL_correct_sha512+='6c78bbec73d934ef2a119ae5e1416963cbdb1f9'
  wrapped_wget_sha512

  LFBFL_file_name="python_isort_complement.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='d87ffe51863994e0c0a17d0ac4cca82e814697ff8f2d8'
  LFBFL_correct_sha512+='039aa491198471ee4a19873ef3e0aecba578efc584ab'
  LFBFL_correct_sha512+='2d95d39d73a2753bc552d4ab86edc728a699823'
  wrapped_wget_sha512

  LFBFL_file_name="repository_data.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='b69cffe97c11ae5d98532f65e61c94139d781dab2c859'
  LFBFL_correct_sha512+='985b4bf641a1f846337ecd7b02fbf823551934e80b46'
  LFBFL_correct_sha512+='0c9dc4ca6fa9b4ca07facfe3b1a8b239ea29501'
  wrapped_wget_sha512

  LFBFL_file_name="shell_checks_complement.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='937c47a475c82bd02c9ed1e5cdc96d863946c0d978fd2'
  LFBFL_correct_sha512+='caa976bcec4b19465fda3664c6ef6104aad6f2747307'
  LFBFL_correct_sha512+='68ed3de3947b8f36ef1a5bda957aa2c8bab2342'
  wrapped_wget_sha512

  LFBFL_file_name="split_score.exec.php"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='0eaca0166e71a1992f897c7f87e77da3babd297cd85c6'
  LFBFL_correct_sha512+='e4251ae920f15b4cbd9c3d4a7e2ae21eaf74b366a0e7'
  LFBFL_correct_sha512+='681977dff58901c6d40b3e46f38e0cbec86be54'
  wrapped_wget_sha512

  LFBFL_file_name="split_score.libr.php"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='47b667d83125fa17babd46201ae8a8b7f7abeef123276'
  LFBFL_correct_sha512+='40e7ed87faeacac997455207c4ab4df2734649676960'
  LFBFL_correct_sha512+='1efcadaf35338ba2bec2410e01065ff7ed871f7'
  wrapped_wget_sha512

  LFBFL_file_name="strings_functions.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='7284775b28e67d9db3f9cedf01414ba5fa1374aba8b56'
  LFBFL_correct_sha512+='b9b662b61765697567d91d7373f3051e7410a173f204'
  LFBFL_correct_sha512+='59ae04a1fa479ea9bb878060d12244693996233'
  wrapped_wget_sha512

  LFBFL_file_name="too_long_code_lines.libr.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='b91821c48458347aaad5eec9af568ed0f5c6afece67bf'
  LFBFL_correct_sha512+='70046b3d2c9f88e8539dd0f8a59aa64fd7e12ccf62c7'
  LFBFL_correct_sha512+='43d2a2a782675324d37276842fbb454e5f020a9'
  wrapped_wget_sha512

  LFBFL_file_name="update_or_check_files_names_listing.exec.sh"
  LFBFL_script_download_URL="${LFBFL_dependencies_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  LFBFL_correct_sha512='54ae6410092ef9775f046ac14316eb39e6de58995bb17'
  LFBFL_correct_sha512+='7566cfec85b46accba334c3afe1e54e303d81afd2b76'
  LFBFL_correct_sha512+='8f9c04e3367d26d7c3ce1d008e786af36d38fc3'
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
  diff "${LFBFL_phpmd_baseline}" "${LFBFL_temp_phpmd_baseline}"

  printf "Running phpDocumentor\n"
  # shellcheck disable=SC2312
  docker run --rm --volume="$(pwd):/data" phpdoc/phpdoc
  printf -- "---PHP end---\n"

  printf -- "---JS---\n"
  LFBFL_npm_lint_directories=""
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
    declare -r LFBFL_files_for_Nu=$(
      find . -type f -iregex "${LFBFL_find_regexp}"\
      | relevant_find
    )
    if [[ -n "${LFBFL_files_for_Nu}" ]]; then
      declare -a LFBFL_files_for_Nu2
      mapfile -t LFBFL_files_for_Nu2 <<< "${LFBFL_files_for_Nu}"
      readonly LFBFL_files_for_Nu2
      java -Xss128M -jar "${LFBFL_vnu_jar_path}" --exit-zero-always\
        --verbose -- "${LFBFL_files_for_Nu2[@]}"
    fi
  fi
  # ------------------------------------------------------------------

  if [[ LFBFL_i_upgrade_venvs -eq 1 ]]; then
    touch -- "${LFBFL_upgrade_venvs_ts_file}"
  fi
}

common_build_and_checks "$@"
