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
# ©Copyright 2023-2025 Laurent Frédéric Bernard François Lyaudet
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
  LFBFL_correct_sha512='1f53caeb84d9ea0b597678118dbf028114c9a37fab952'
  LFBFL_correct_sha512+='6d4a6d8e08f4dd5a05d8cc69b52cc405613a325c9bf9'
  LFBFL_correct_sha512+='7e91ef5206efa1a151cc94ade7c3d708c7ed2ef'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"
  chmod +x "./${LFBFL_file_path}"

  LFBFL_file_name="check_shell_scripts_beginnings.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='a17c932546262c82c168e7d4495dd4f2c2409b27c72c0'
  LFBFL_correct_sha512+='99c8ea3bc5277aa11c64b61de0b93a5bdc9b660483d9'
  LFBFL_correct_sha512+='4e61cb79935eb1f4ca04bf4ffe4b713f5e7eccc'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="check_URLs.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='d8ace5d442e87196bec34a3196d419965e435a18fafb2'
  LFBFL_correct_sha512+='9c6a3e334f3dfdca49de686e28447678418c930fe3fa'
  LFBFL_correct_sha512+='b5de8334ef2874aa3785daaf52987836ad3a583'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="comparisons.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='1dac26153e23dc9c4455d18a2b3dd76c8fb8278d3b24f'
  LFBFL_correct_sha512+='86d1c2dfe513e06b16f398f11cc7e52efaafdf360808'
  LFBFL_correct_sha512+='d9b36f4562621203e3da2ed57897a894272202a'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="create_PDF.exec.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='5ba4db9c05bed5ef18ca788f737b5866b601b5ce41aec'
  LFBFL_correct_sha512+='51785ca75ad565172318ced7a8b2841904c9f5847ae0'
  LFBFL_correct_sha512+='237923e196b484a9419f63e5ec48d8cdd616fb8'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"
  chmod +x "./${LFBFL_file_path}"

  LFBFL_file_name="generate_from_template.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='ea1cdb9e9ed3ba468e3398e52c44daca7b6a9c5c21d5b'
  LFBFL_correct_sha512+='3cdf433183aec31286a52b2af5c177650b11d5590e23'
  LFBFL_correct_sha512+='e498ce8e1c3fcad2738fbaec329c6204bc6314d'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="get_common_text_glob_patterns.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='eba2a6665977a84897075fbc3d227d14937cf9c7b2270'
  LFBFL_correct_sha512+='339810caef1a120486979e538a9bc8a9f791564c13c2'
  LFBFL_correct_sha512+='3e699f6fdb88e4bb29a5eab01bdebabedc3bc70'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="grammar_and_spell_check.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='33a477d25e46c49ad000473c1d05a822427d5e769b26e'
  LFBFL_correct_sha512+='d9457ab182f2ad12d20d26d32a46d6016d7d41be0994'
  LFBFL_correct_sha512+='c3ca2f2130f0e62b10763cbda60645e1a49dd0c'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  # /licenses_templates/ ---------------------------------------------
  declare -r LFBFL_subdir2="${LFBFL_subdir}/licenses_templates"
  declare -r LFBFL_start_URL2="${LFBFL_start_URL}/licenses_templates"
  LFBFL_file_name="build_licenses_templates.exec.sh"
  LFBFL_URL="${LFBFL_start_URL2}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir2}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='acfc0dfd02e77d69e6e5b61c4c44cfa3ad76bd3657fa4'
  LFBFL_correct_sha512+='875d19ec249e84db8bc5a8570621cbbf64aa2e9b44de'
  LFBFL_correct_sha512+='932c28674cdf05372f8577c9345fa8ac5398f6c'
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
  LFBFL_correct_sha512='a4784ef043763467486ad53566dadf7b9906fcfacf361'
  LFBFL_correct_sha512+='982e44320bbf21ed341cc5eaf5b2b64420b74c02aaae'
  LFBFL_correct_sha512+='b2d0c5856f3843e99f2b020a70142febe56f490'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="lines_filters.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='d8fb1bb8c5228341d215383a652326b3a3f0eee84c344'
  LFBFL_correct_sha512+='63b55ddd3ebaf564f84f07a10db9c34f007654e23fee'
  LFBFL_correct_sha512+='4748acc9c80feb1c215076d2b88ba4805bd290f'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="lines_maps.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='10c650cddf78dd40bfde665989ae3561b2ae780bc1c8e'
  LFBFL_correct_sha512+='841f5cdbe626cd1a61f01cea57757009c9b1ec3d2a7e'
  LFBFL_correct_sha512+='ef57987dff725cff3e401e86b77a2f29324402d'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="overwrite_if_not_equal.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='dd5da872dedbc21fb6acc385fd9ec9f8f6c7b30b1dc0c'
  LFBFL_correct_sha512+='dd91901a9030939f262303deec044725c12da49b06e8'
  LFBFL_correct_sha512+='f6b41ee7f8b4ce6a3cacf9f7800584598efd859'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="python_black_complement.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='f23f9bbb20902c67f59d24ff46aef99490fa06b467d6c'
  LFBFL_correct_sha512+='bb63de0b010129bf3994aeab307a1dbbcde5e41958e0'
  LFBFL_correct_sha512+='d5872add51d9e09c56e81845db34b9c50350d46'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="python_isort_complement.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='5c27e0496016554cf8783ae0772db2564e56b92a5ed8a'
  LFBFL_correct_sha512+='9b7b73a518c6a931fb431ee12feff001d5c33b6b22a2'
  LFBFL_correct_sha512+='1af5491dd207eef3d810494baed7afc83cbf6cb'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="split_line_at_most.exec.php"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='ecfc21afd7e4ba08c339e62647e3dc2cd3b7e9826364e'
  LFBFL_correct_sha512+='d3d4dd5ce86db4ae6cb60271ed4f262350aa9690e82c'
  LFBFL_correct_sha512+='865785abf3c531e74d196391e361cd599117935'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="split_line_at_most.libr.php"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='3f8a9c760adadda201ca70a3e9523da139d66e821a192'
  LFBFL_correct_sha512+='d4205560850047a22d72528ddc48289755d742312e15'
  LFBFL_correct_sha512+='2134031477a66a48cbc16a03568ca6bfeb8ac32'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="strings_functions.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='e03f9c4e7a2a0a80f6a4d84d4be0c78fa6ab92b391f1e'
  LFBFL_correct_sha512+='6d687fce4e4c0af04d5e4df39981bd9cfd7de4b2c545'
  LFBFL_correct_sha512+='eb295c086141c46d3cf6a0d31f0053c458e7de8'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="too_long_code_lines.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='d6ce6082f1955fec53732c91196ff20c9465ad3b18ba0'
  LFBFL_correct_sha512+='c5a6b9cb8f86e296a6c97dff6282eea8bf8ee4e7df6b'
  LFBFL_correct_sha512+='98a0b8dafcf5e87b85ab364db077090c828a3e7'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="update_or_check_files_names_listing.exec.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='da58ab2f0d0ff526c226212c1dce96f9280befebcb19a'
  LFBFL_correct_sha512+='217617f0df610f563c25d1ed5d8681f07cba9096461b'
  LFBFL_correct_sha512+='9a38c8a39f82e0259cfc21cef87a960f3c76c5d'
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

  echo "Running isort"
  isort .
  python_isort_complement

  echo "Running black"
  black .
  python_black_complement

  local LFBFL_directory_path
  # shellcheck disable=SC2312
  find . -name "pyproject.toml" | relevant_find\
    | while read -r LFBFL_file_path;
  do
    if grep -q "Typing :: Typed" "${LFBFL_file_path}"; then
      echo "Running mypy"
      LFBFL_directory_path=$(dirname "${LFBFL_file_path}")
      mypy "${LFBFL_directory_path}"
    fi
  done

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
  LFBFL_usual_characters="\x00-\x7Fàâéèêëîïôç©“”└─├│«»"
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
