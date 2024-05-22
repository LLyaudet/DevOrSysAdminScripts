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
  LFBFL_correct_sha512='e9804f54e4ee8cca4d74258591b0bebd78a35e07f5c2c'
  LFBFL_correct_sha512+='0b16649ee4f99811092a8daacd8575f07135f12b444c'
  LFBFL_correct_sha512+='921e6b8be4d001f1304ba0a9f5709b6a684d4ee'
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
  LFBFL_correct_sha512='614e94c3f7297e6cda3d7ba7876684ff7acb1862f27dd'
  LFBFL_correct_sha512+='1183275cc7e40de3d1ee87f4abf9a795243355e3450d'
  LFBFL_correct_sha512+='13824a2831402d10b74a0c5a60be4df42f3ff5c'
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
  LFBFL_correct_sha512='d20ff26d45e1ce261ec33ce97487dfbb17d25e3030a62'
  LFBFL_correct_sha512+='f5f0011a1e7337b601264f75e1defed007f9fb3b31dc'
  LFBFL_correct_sha512+='91f44204501bf1d2134a7969602017bbcf678b8'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"
  chmod +x "./${LFBFL_file_path}"

  LFBFL_file_name="generate_from_template.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='abc8f204939305c785c233d5bf16efbf5229984df4c98'
  LFBFL_correct_sha512+='b0520a586c5f6d57beceb00d0ddea4d6aab38f752a82'
  LFBFL_correct_sha512+='9214ddc886bffdf5c5be5f0b11d5585f0d236ba'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="get_common_text_glob_patterns.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='e194ad25846845679aad127a1eb301df840c6726b28ac'
  LFBFL_correct_sha512+='1bfe991aed5d64767b3f3795119842c943bf3c8a1e6f'
  LFBFL_correct_sha512+='991568df1bcfc5d3f5542c68267c0a639750f42'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="grammar_and_spell_check.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='2d24fbc3a0addfe2620024ba939abd5c5afbbf1cf9a71'
  LFBFL_correct_sha512+='8d607fa72e770fc241d4b125ddaf4a56303ad0504504'
  LFBFL_correct_sha512+='591816045eb508ad40afef6d792d13e7b37d005'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  # /licenses_templates/ ---------------------------------------------
  declare -r LFBFL_subdir2="${LFBFL_subdir}/licenses_templates"
  declare -r LFBFL_start_URL2="${LFBFL_start_URL}/licenses_templates"
  LFBFL_file_name="build_licenses_templates.exec.sh"
  LFBFL_URL="${LFBFL_start_URL2}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir2}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='1220a0014c08c94491dce626e04d3044023a09cbd8c3d'
  LFBFL_correct_sha512+='cd98fcbbe5fd7d2ff5e017d93f5c2c4b6bc8c7f4da82'
  LFBFL_correct_sha512+='4a6aaca667f63a5eb43fb55e6fa6f70a1d31646'
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
  LFBFL_correct_sha512='8c270d2773320e1ec408f9fc855bed809bccd78b26ef0'
  LFBFL_correct_sha512+='8160c1c3027670ceac436197b3460b855d9f10b0267b'
  LFBFL_correct_sha512+='1d464ae42ad7d93398b962e48b3e869585c6381'
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
  LFBFL_correct_sha512='b779c96fca4e48f5aa7eaa15ac8e7049f0d76edf8f1dd'
  LFBFL_correct_sha512+='a2d7ae96a0cf94560e60397b706b224cec61e0c509a0'
  LFBFL_correct_sha512+='88140bde50a861717c2481b35ba29717056756a'
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
  LFBFL_correct_sha512='7de6e8c6a20d6982a6e0f814ea1ffba3509a054c9832e'
  LFBFL_correct_sha512+='e3ec989daf0a8e218e412813be6ac8a0a1cbdd69867b'
  LFBFL_correct_sha512+='1e4503bf2d32e25cb4acdca2470bf6dc208c6cb'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

  LFBFL_file_name="too_long_code_lines.libr.sh"
  LFBFL_URL="${LFBFL_start_URL}/${LFBFL_file_name}"
  LFBFL_file_path="./${LFBFL_subdir}/${LFBFL_file_name}"
  local LFBFL_correct_sha512
  LFBFL_correct_sha512='2276b7d65bb8f5ad70389a3ca5ba7088b91b97e4c05b2'
  LFBFL_correct_sha512+='b63b35441b84161be664effcfe10454653a52cb4d7fc'
  LFBFL_correct_sha512+='0c9ae7c7165b82ee12f02cee1642e12292d9ed5'
  wget_sha512 "${LFBFL_file_path}" "${LFBFL_URL}"\
    "${LFBFL_correct_sha512}" "${LFBFL_verbose}"

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
