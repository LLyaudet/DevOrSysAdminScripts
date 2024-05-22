#!/usr/bin/env bash
# This file is part of DevOrSysAdminScripts library.
#
# DevOrSysAdminScripts is free software:
# you can redistribute it and/or modify it under the terms
# of the GNU Lesser General Public License
# as published by the Free Software Foundation,
# either version 3 of the License,
# or (at your option) any later version.
#
# DevOrSysAdminScripts is distributed in the hope
# that it will be useful,
# but WITHOUT ANY WARRANTY;
# without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU Lesser General Public License for more details.
#
# You should have received a copy of
# the GNU Lesser General Public License
# along with DevOrSysAdminScripts.
# If not, see <https://www.gnu.org/licenses/>.
#
# ©Copyright 2023-2024 Laurent Frédéric Bernard François Lyaudet
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

  source ./wget_sha512.libr.sh

  declare -r LFBFL_subdir="build_and_checks_dependencies"

  local LFBFL_file_name
  local LFBFL_URL
  local LFBFL_file_path

  LFBFL_file_name="build_md_from_printable_md.exec.sh"
  # LFBFL_script_download_URL
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='a00087bab7fc225ec6ec30148ecef437c2f1314611846'
  LFBFL_correct_sha512+='febeadabf0e0c09e8843600ef4d93ebf267e056e239a'
  LFBFL_correct_sha512+='3cafc46ffbc8c26232d57980b277e9d0bf11aae'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"
  chmod +x "./${LFBFL_file_path}"

  LFBFL_file_name="check_shell_scripts_beginnings.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='2fa675a7a226f31f0e16cd092364481c7f84102935f06'
  LFBFL_correct_sha512+='6b31db11a52115b7678acda071eb329243a0f705c878'
  LFBFL_correct_sha512+='013d37e53d3fae297a70eda7d9b45224c98132f'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="check_URLs.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='b1afcdc1d7a39219c664f9e2d1122cb8d295f752282ad'
  LFBFL_correct_sha512+='52c7cee3bc3436bf12199f76bc679199de08890ebecf'
  LFBFL_correct_sha512+='9003002a3156772fc74bf8e3bbed21f224ac408'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="comparisons.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='b80b4a9d405c86780255cdd34af33d25bd22d8cb9de22'
  LFBFL_correct_sha512+='50b7f90e0a8c96bf566a0bff717ef190dceb2b247aa9'
  LFBFL_correct_sha512+='832ca6e8be8e6bf15dcbb8d8cd5725911c1fa80'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="create_PDF.exec.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='3c82b2c518a9076ffdb42c6dd2c644913a9d1f261ce01'
  LFBFL_correct_sha512+='601d50306ccf4ad7e789a8dafce5ff9ff8a87974a548'
  LFBFL_correct_sha512+='f3f32cab36dded5c2292baf86d6280219eed4bd'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"
  chmod +x "./${LFBFL_file_path}"

  LFBFL_file_name="generate_from_template.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='c1ed914248fd577ecf87ffe46ce64fdad204640ca96f5'
  LFBFL_correct_sha512+='0e6225cb4d6efb5ee60f78c1cf1731d80680a3ce6426'
  LFBFL_correct_sha512+='d1be70cd716ac0b1bb90ef26507069e5b907e0e'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="get_common_text_glob_patterns.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='a55d996d9dad302cc094fb6edc7ac8e160bb44920b3b1'
  LFBFL_correct_sha512+='b3de8d7c28ff472598242e77072eec612c188ac83afb'
  LFBFL_correct_sha512+='34448bf00be0178ea67f36f90581e96a9b34710'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="grammar_and_spell_check.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='bc66fc04ceef4d0d9f3db359354f852a4f80298b0b285'
  LFBFL_correct_sha512+='3416d5a86955f8e27cb868d83c6164fa543eeb0cc3c0'
  LFBFL_correct_sha512+='6248079b4ae25a91428914b5234e6aa4fec5c31'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  # /licenses_templates/ ---------------------------------------------
  declare -r LFBFL_subdir2="${LFBFL_subdir}/licenses_templates"
  declare -r LFBFL_start_URL2="${LFBFL_start_URL}/licenses_templates"
  LFBFL_file_name="build_licenses_templates.exec.sh"
  LFBFL_URL="${LFBFL_start_URL2}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir2}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='3f1c4a56e4d62ec3a311b6ff3de3ba68082b8c82b5387'
  LFBFL_correct_sha512+='77b6f318cb3e7b16c504b8d91c97091de7de20014c7b'
  LFBFL_correct_sha512+='491a3d77152863a5d4fd4f2e782c76b97762510'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"
  chmod +x "./${LFBFL_file_path}"

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
  LFBFL_correct_sha512='8eaf9fc75050715671bd2ed5950cce5e1b7991903a05e'
  LFBFL_correct_sha512+='b513c0989eaaf2a1445bcb72a681c0ea488be975b221'
  LFBFL_correct_sha512+='5c48a81539401bf38719c3efd52882137b1d2af'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="lines_filters.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='56e40e98c07d404a31e8b55dad1b41292ab55133811ae'
  LFBFL_correct_sha512+='22561eacea0b512f2520aa50e6b914d9ea58b0b9b763'
  LFBFL_correct_sha512+='1e75d0bc162f6bdcfd7eb94ae6ad0a4c437cc63'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="lines_maps.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='b75600e6217f08e0a4ae8858feee50cd193909c1c3080'
  LFBFL_correct_sha512+='3b95f6b67943e0950249a5b4bd77ac6990a1a91e96ec'
  LFBFL_correct_sha512+='d66da5fbe7c6d6ec611c1aa5bd4924743b55049'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  # /listings/ -------------------------------------------------------
  declare -r LFBFL_subdir3="${LFBFL_subdir}/listings"
  declare -r LFBFL_start_URL3="${LFBFL_start_URL}/listings"
  LFBFL_file_name="update_or_check_files_names_listing.exec.sh"
  LFBFL_URL="${LFBFL_start_URL3}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir3}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='71465e0ccfe520117cce16ea613471271f752802256c8'
  LFBFL_correct_sha512+='bf3ba95e65ab358804ea3bd1719097bd27b2e1a419db'
  LFBFL_correct_sha512+='69c7a7bdca4efbd3c6260322d5bda2ef8ec86cc'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"
  chmod +x "./${LFBFL_file_path}"
  # ------------------------------------------------------------------

  LFBFL_file_name="overwrite_if_not_equal.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='86ce430b916b13d55a81cb48e59d2aac65974a3bfa194'
  LFBFL_correct_sha512+='cc0295eba854347727db351c0aab56a292dd753e473c'
  LFBFL_correct_sha512+='c95292937e380f275ddd27a614d9360a4a3e1ff'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="python_black_complement.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='6346483fe09caa8ecfd46d1c1118d0eefcff5d041ee11'
  LFBFL_correct_sha512+='64f450a6bc035dce8b9dfead8a113e4051e9c7fadfa5'
  LFBFL_correct_sha512+='188f972af09a364657a8f7d50516ff33e48150c'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="python_isort_complement.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='515b282c6d26c8b91a02d193aaa5958a0d5cf271f8e21'
  LFBFL_correct_sha512+='876826351442d19185406cc3e40375e3352921907378'
  LFBFL_correct_sha512+='bb146da5d12b477ed584cd7b286a5180de48b88'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="split_line_at_most.exec.php"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='1326f7167f39825ce7d31c3b0af3b3ce25a4a0c0a6534'
  LFBFL_correct_sha512+='91feb798d36099b63b5613141cd4524aa2b877927a19'
  LFBFL_correct_sha512+='42449603c4eb9d32ee31dd519bf2625ca109c24'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="split_line_at_most.libr.php"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='1a427b35f1c0830c00e44b857507efde741590a420edd'
  LFBFL_correct_sha512+='625d6c25f901edda0dfb6bd7270a29b3f12f4fee8ffc'
  LFBFL_correct_sha512+='0eb25dbb6c0c5ab20e116ed130f5fc68d5cfcb4'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="strings_functions.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='6cd0c78dd979f690e210437ea76604a61468718c95434'
  LFBFL_correct_sha512+='583f9cd1b466368261c393f0992be7fb154fc9393b49'
  LFBFL_correct_sha512+='8fef3fef7f59798b4ffa94b185c3a49dd389f28'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="too_long_code_lines.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='1d7da042db55a9eaa4b3f37ecdd68411e66f428f7a703'
  LFBFL_correct_sha512+='bc5e05f48554c6d217fa0e1903439e4e02c1e7d44abf'
  LFBFL_correct_sha512+='2b6733732191d3e7a0b68d8147f1c27f2feaa93'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  shopt -s globstar
  source "./${LFBFL_subdir}/check_shell_scripts_beginnings.libr.sh"
  source "./${LFBFL_subdir}/check_URLs.libr.sh"
  source "./${LFBFL_subdir}/comparisons.libr.sh"
  source "./${LFBFL_subdir}/generate_from_template.libr.sh"
  source "./${LFBFL_subdir}/get_common_text_glob_patterns.libr.sh"
  source "./${LFBFL_subdir}/grammar_and_spell_check.libr.sh"
  source "./${LFBFL_subdir}/lines_counts.libr.sh"
  source "./${LFBFL_subdir}/lines_filters.libr.sh"
  source "./${LFBFL_subdir}/lines_maps.libr.sh"
  source "./${LFBFL_subdir}/overwrite_if_not_equal.libr.sh"
  source "./${LFBFL_subdir}/python_black_complement.libr.sh"
  source "./${LFBFL_subdir}/python_isort_complement.libr.sh"
  source "./${LFBFL_subdir}/strings_functions.libr.sh"
  source "./${LFBFL_subdir}/too_long_code_lines.libr.sh"

  echo "Building license headers"
  "./${LFBFL_subdir2}/build_licenses_templates.exec.sh"\
    "${LFBFL_verbose}"

  echo "Building README.md"
  "./${LFBFL_subdir}/build_md_from_printable_md.exec.sh"\
    "${LFBFL_working_directory}" "README" "${LFBFL_verbose}"

  pushd .
  cd "${LFBFL_working_directory}"

  echo "Running shellcheck"
  shellcheck --check-sourced --enable=all --external-sources **/*.sh

  echo "Running isort"
  isort .
  python_isort_complement

  echo "Running black"
  black .
  python_black_complement

  find . -name "pyproject.toml" | relevant_find\
    | while read -r LFBFL_file_name;
  do
    if grep -q "Typing :: Typed" "${LFBFL_file_name}"; then
      echo "Running mypy"
      mypy $(dirname "${LFBFL_file_name}")
    fi
  done

  echo "Analyzing too long lines"
  too_long_code_lines | relevant_grep | not_license_grep

  echo "Analyzing shell scripts beginnings"
  check_shell_scripts_beginnings | relevant_grep

  echo "Analyzing URLs"
  check_URLs | relevant_grep

  echo "Analyzing strange characters: hover over in doubt"
  LFBFL_usual_characters="\x00-\x7Fàâéèêëîïôç©“”└─├│«»"
  grep --exclude-dir '.git' -nPrv "^[${LFBFL_usual_characters}]*$" .\
    | grep --color='auto' -nP "[^${LFBFL_usual_characters}]"

  echo "Creating the PDF file of the listing of the source code"
  "./${LFBFL_subdir}/create_PDF.exec.sh" "${LFBFL_verbose}"

  popd
}

common_build_and_checks "$@"
