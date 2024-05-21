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

verbose=""
if [[ "$2" == "--verbose" ]]; then
  echo "$0 $*"
  verbose="--verbose"
fi

source ./wget_sha512.libr.sh

subdir="build_and_checks_dependencies"

personal_github="https://raw.githubusercontent.com/LLyaudet/"
dependencies="DevOrSysAdminScripts/main/${subdir}"
URL_beginning="${personal_github}${dependencies}"

script="${URL_beginning}/build_md_from_printable_md.exec.sh"
correct_sha512='a00087bab7fc225ec6ec30148ecef437c2f1314611846febeadab'
correct_sha512+='f0e0c09e8843600ef4d93ebf267e056e239a3cafc46ffbc8c262'
correct_sha512+='32d57980b277e9d0bf11aae'
wget_sha512 "./${subdir}/build_md_from_printable_md.exec.sh"\
  "${script}" "${correct_sha512}" "${verbose}"
chmod +x "./${subdir}/build_md_from_printable_md.exec.sh"

script="${URL_beginning}/check_shell_scripts_beginnings.libr.sh"
correct_sha512='2fa675a7a226f31f0e16cd092364481c7f84102935f066b31db11'
correct_sha512+='a52115b7678acda071eb329243a0f705c878013d37e53d3fae29'
correct_sha512+='7a70eda7d9b45224c98132f'
wget_sha512 "./${subdir}/check_shell_scripts_beginnings.libr.sh"\
  "${script}" "${correct_sha512}" "${verbose}"

script="${URL_beginning}/check_URLs.libr.sh"
correct_sha512='b1afcdc1d7a39219c664f9e2d1122cb8d295f752282ad52c7cee3'
correct_sha512+='bc3436bf12199f76bc679199de08890ebecf9003002a3156772f'
correct_sha512+='c74bf8e3bbed21f224ac408'
wget_sha512 "./${subdir}/check_URLs.libr.sh" "${script}"\
  "${correct_sha512}" "${verbose}"

script="${URL_beginning}/comparisons.libr.sh"
correct_sha512='b80b4a9d405c86780255cdd34af33d25bd22d8cb9de2250b7f90e'
correct_sha512+='0a8c96bf566a0bff717ef190dceb2b247aa9832ca6e8be8e6bf1'
correct_sha512+='5dcbb8d8cd5725911c1fa80'
wget_sha512 "./${subdir}/comparisons.libr.sh" "${script}"\
  "${correct_sha512}" "${verbose}"

script="${URL_beginning}/create_PDF.exec.sh"
correct_sha512='3c82b2c518a9076ffdb42c6dd2c644913a9d1f261ce01601d5030'
correct_sha512+='6ccf4ad7e789a8dafce5ff9ff8a87974a548f3f32cab36dded5c'
correct_sha512+='2292baf86d6280219eed4bd'
wget_sha512 "./${subdir}/create_PDF.exec.sh" "${script}"\
  "${correct_sha512}" "${verbose}"
chmod +x "./${subdir}/create_PDF.exec.sh"

script="${URL_beginning}/generate_from_template.libr.sh"
correct_sha512='c1ed914248fd577ecf87ffe46ce64fdad204640ca96f50e6225cb'
correct_sha512+='4d6efb5ee60f78c1cf1731d80680a3ce6426d1be70cd716ac0b1'
correct_sha512+='bb90ef26507069e5b907e0e'
wget_sha512 "./${subdir}/generate_from_template.libr.sh" "${script}"\
  "${correct_sha512}" "${verbose}"

script="${URL_beginning}/get_common_text_glob_patterns.libr.sh"
correct_sha512='a55d996d9dad302cc094fb6edc7ac8e160bb44920b3b1b3de8d7c'
correct_sha512+='28ff472598242e77072eec612c188ac83afb34448bf00be0178e'
correct_sha512+='a67f36f90581e96a9b34710'
wget_sha512 "./${subdir}/get_common_text_glob_patterns.libr.sh"\
  "${script}" "${correct_sha512}" "${verbose}"

script="${URL_beginning}/grammar_and_spell_check.libr.sh"
correct_sha512='bc66fc04ceef4d0d9f3db359354f852a4f80298b0b2853416d5a8'
correct_sha512+='6955f8e27cb868d83c6164fa543eeb0cc3c06248079b4ae25a91'
correct_sha512+='428914b5234e6aa4fec5c31'
wget_sha512 "./${subdir}/grammar_and_spell_check.libr.sh" "${script}"\
  "${correct_sha512}" "${verbose}"

URL_beginning2="${URL_beginning}/licenses_templates"
subdir2="${subdir}/licenses_templates"
script="${URL_beginning2}/build_licenses_templates.exec.sh"
correct_sha512='3f1c4a56e4d62ec3a311b6ff3de3ba68082b8c82b538777b6f318'
correct_sha512+='cb3e7b16c504b8d91c97091de7de20014c7b491a3d77152863a5'
correct_sha512+='d4fd4f2e782c76b97762510'
wget_sha512 "./${subdir2}/build_licenses_templates.exec.sh"\
  "${script}" "${correct_sha512}" "${verbose}"
chmod +x "./${subdir2}/build_licenses_templates.exec.sh"

script="${URL_beginning2}/license_file_header_GPLv3+.tpl"
correct_sha512='2bdef9a729a5a9ca5ed87ef8a518877c5ee6b31b4533608660316'
correct_sha512+='a4e595fb31465a4847f4d53a2f7264118bd4eab7c1d1892e00bc'
correct_sha512+='1861455ed02898f194db067'
wget_sha512 "./${subdir2}/license_file_header_GPLv3+.tpl" "${script}"\
  "${correct_sha512}" "${verbose}"

script="${URL_beginning2}/license_file_header_LGPLv3+.tpl"
correct_sha512='265fd0d086b48ab798f35a072335a4976e4eda8c256febba6c77c'
correct_sha512+='98ca86cdd844c6ac150c3445c80debbb3fc2574b5fceeeaf79ec'
correct_sha512+='734a759bdef5fe798067c62'
wget_sha512 "./${subdir2}/license_file_header_LGPLv3+.tpl"\
  "${script}" "${correct_sha512}" "${verbose}"

script="${URL_beginning}/lines_counts.libr.sh"
correct_sha512='8eaf9fc75050715671bd2ed5950cce5e1b7991903a05eb513c098'
correct_sha512+='9eaaf2a1445bcb72a681c0ea488be975b2215c48a81539401bf3'
correct_sha512+='8719c3efd52882137b1d2af'
wget_sha512 "./${subdir}/lines_counts.libr.sh" "${script}"\
  "${correct_sha512}" "${verbose}"

script="${URL_beginning}/lines_filters.libr.sh"
correct_sha512='b0f327907198de1d674fe204ca7cb18d4054d0666fe017db2984f'
correct_sha512+='ea094832d9bf2a7d2c98bb86c0fbb4549055e6b47be30ad03a8e'
correct_sha512+='2885bf79361dc081b8bb5ad'
wget_sha512 "./${subdir}/lines_filters.libr.sh" "${script}"\
  "${correct_sha512}" "${verbose}"

script="${URL_beginning}/lines_maps.libr.sh"
correct_sha512='b75600e6217f08e0a4ae8858feee50cd193909c1c30803b95f6b6'
correct_sha512+='7943e0950249a5b4bd77ac6990a1a91e96ecd66da5fbe7c6d6ec'
correct_sha512+='611c1aa5bd4924743b55049'
wget_sha512 "./${subdir}/lines_maps.libr.sh" "${script}"\
  "${correct_sha512}" "${verbose}"

URL_beginning3="${URL_beginning}/listings"
subdir3="${subdir}/listings"
script="${URL_beginning3}/update_or_check_files_names_listing.exec.sh"
correct_sha512='71465e0ccfe520117cce16ea613471271f752802256c8bf3ba95e'
correct_sha512+='65ab358804ea3bd1719097bd27b2e1a419db69c7a7bdca4efbd3'
correct_sha512+='c6260322d5bda2ef8ec86cc'
wget_sha512\
  "./${subdir3}/update_or_check_files_names_listing.exec.sh"\
  "${script}" "${correct_sha512}" "${verbose}"
chmod +x "./${subdir3}/update_or_check_files_names_listing.exec.sh"

script="${URL_beginning3}/files_names_listing.txt"
correct_sha512='09819dcf924a3a5b568b1cfdeec7610b9b0f7cba44cf6e4c9e188'
correct_sha512+='d6de24b88f3deb21705cd81f6c1c121f6dd4562fefc41f74a172'
correct_sha512+='011c3647d4fccf72d7297dd'
wget_sha512 "./${subdir3}/files_names_listing.txt" "${script}"\
  "${correct_sha512}" "${verbose}"

script="${URL_beginning}/overwrite_if_not_equal.libr.sh"
correct_sha512='86ce430b916b13d55a81cb48e59d2aac65974a3bfa194cc0295eb'
correct_sha512+='a854347727db351c0aab56a292dd753e473cc95292937e380f27'
correct_sha512+='5ddd27a614d9360a4a3e1ff'
wget_sha512 "./${subdir}/overwrite_if_not_equal.libr.sh" "${script}"\
  "${correct_sha512}" "${verbose}"

script="${URL_beginning}/python_black_complement.libr.sh"
correct_sha512='6346483fe09caa8ecfd46d1c1118d0eefcff5d041ee1164f450a6'
correct_sha512+='bc035dce8b9dfead8a113e4051e9c7fadfa5188f972af09a3646'
correct_sha512+='57a8f7d50516ff33e48150c'
wget_sha512 "./${subdir}/python_black_complement.libr.sh" "${script}"\
  "${correct_sha512}" "${verbose}"

script="${URL_beginning}/python_isort_complement.libr.sh"
correct_sha512='515b282c6d26c8b91a02d193aaa5958a0d5cf271f8e2187682635'
correct_sha512+='1442d19185406cc3e40375e3352921907378bb146da5d12b477e'
correct_sha512+='d584cd7b286a5180de48b88'
wget_sha512 "./${subdir}/python_isort_complement.libr.sh" "${script}"\
  "${correct_sha512}" "${verbose}"

script="${URL_beginning}/too_long_code_lines.libr.sh"
correct_sha512='1d7da042db55a9eaa4b3f37ecdd68411e66f428f7a703bc5e05f4'
correct_sha512+='8554c6d217fa0e1903439e4e02c1e7d44abf2b6733732191d3e7'
correct_sha512+='a0b68d8147f1c27f2feaa93'
wget_sha512 "./${subdir}/too_long_code_lines.libr.sh" "${script}"\
  "${correct_sha512}" "${verbose}"

shopt -s globstar
source "./${subdir}/check_shell_scripts_beginnings.libr.sh"
source "./${subdir}/check_URLs.libr.sh"
source "./${subdir}/comparisons.libr.sh"
source "./${subdir}/generate_from_template.libr.sh"
source "./${subdir}/get_common_text_glob_patterns.libr.sh"
source "./${subdir}/lines_counts.libr.sh"
source "./${subdir}/lines_filters.libr.sh"
source "./${subdir}/overwrite_if_not_equal.libr.sh"
source "./${subdir}/python_black_complement.libr.sh"
source "./${subdir}/python_isort_complement.libr.sh"
source "./${subdir}/too_long_code_lines.libr.sh"

cwd="."
if [[ -n "$1" ]];
then
  cwd="$1"
fi

echo "Building license headers"
./${subdir2}/build_licenses_templates.exec.sh "${verbose}"

echo "Building README.md"
./${subdir}/build_md_from_printable_md.exec.sh "${cwd}" "README" "${verbose}"

pushd .
cd "${cwd}"

echo "Running shellcheck"
shellcheck --check-sourced --enable=all --external-sources **/*.sh

echo "Running isort"
isort .
python_isort_complement

echo "Running black"
black .
python_black_complement

find . -name "pyproject.toml" | relevant_find\
  | while read -r file_name;
do
  if grep -q "Typing :: Typed" "$file_name"; then
    echo "Running mypy"
    mypy $(dirname "$file_name")
  fi
done

echo "Analyzing too long lines"
too_long_code_lines | relevant_grep | not_license_grep

echo "Analyzing shell scripts beginnings"
check_shell_scripts_beginnings | relevant_grep

echo "Analyzing URLs"
check_URLs | relevant_grep

echo "Analyzing strange characters : hover over in doubt"
usual_characters="\x00-\x7Fàâéèêëîïôç©“”└─├│«»"
grep --exclude-dir '.git' -nPrv "^[$usual_characters]*$" .\
  | grep --color='auto' -nP "[^$usual_characters]"

echo "Creating the PDF file of the listing of the source code"
./${subdir}/create_PDF.exec.sh "${verbose}"

popd
