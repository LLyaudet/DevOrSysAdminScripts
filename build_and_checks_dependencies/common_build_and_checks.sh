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

source ./wget_sha512.sh

personal_github="https://raw.githubusercontent.com/LLyaudet/"
dependencies="DevOrSysAdminScripts/main/build_and_checks_dependencies"
URL_beginning="$personal_github$dependencies"

subdir="build_and_checks_dependencies"

script="$URL_beginning/build_md_from_printable_md.sh"
correct_sha512='f443133905731f4d5f8b844b10fdb4eb909ef8127cc11009c8c5e'
correct_sha512+='9dc3e42754f244f3ef829d22d562abdffebb75acc692c3b21874'
correct_sha512+='eb421a375d6a9049406494b'
wget_sha512 "./$subdir/build_md_from_printable_md.sh" "$script"\
  "$correct_sha512"
chmod +x "./$subdir/build_md_from_printable_md.sh"

script="$URL_beginning/check_shell_scripts_beginning.sh"
correct_sha512='312ea7604694b2b0c0e96ecfb8896571f8ddad3bac071e7483d78'
correct_sha512+='6f44ba1781c007819024ece389ef11e7da9a330ca61f222dea19'
correct_sha512+='f5326d9a3b3710056a903b6'
wget_sha512 "./$subdir/check_shell_scripts_beginning.sh" "$script"\
  "$correct_sha512"

script="$URL_beginning/check_URLs.sh"
correct_sha512='91e6297e954bfe6b6bc60c5ed81b1d1dcc5ee9b95b185f83baff9'
correct_sha512+='f16ac2f8059873c8dbfbec17cc1cca029e38595dbcc656bea815'
correct_sha512+='b8994fdb25a8c5beae765cc'
wget_sha512 "./$subdir/check_URLs.sh" "$script" "$correct_sha512"

script="$URL_beginning/comparisons.sh"
correct_sha512='eda1cdad71ef71db542a6bb7f6a0fdc4b3ab5cb4cb90eb44955f3'
correct_sha512+='8fc750d43da63bd25e3ee27f7b1acd4da355d6e8ea133cea75f7'
correct_sha512+='ff9d30b0a8f72cc565696c9'
wget_sha512 "./$subdir/comparisons.sh" "$script" "$correct_sha512"

script="$URL_beginning/create_PDF.sh"
correct_sha512='3640c97ca929cfc50d3d753bd3da29301fe365f9508a449847073'
correct_sha512+='74712c48607e040cc8bd80f41108d31e79b03ee4026c87d48f63'
correct_sha512+='d84462cb205fa905e1b4d83'
wget_sha512 "./$subdir/create_PDF.sh" "$script" "$correct_sha512"
chmod +x "./$subdir/create_PDF.sh"

script="$URL_beginning/generate_from_template.sh"
correct_sha512='cefb11d2446a7ec18badae3ade3008ba2776dc7af35dae0c753b0'
correct_sha512+='e47fd92e81b15fd10a3e56ae58f043f05924085538d181a49b46'
correct_sha512+='fd8ac50bd50a126a264e14a'
wget_sha512 "./$subdir/generate_from_template.sh" "$script"\
  "$correct_sha512"

script="$URL_beginning/get_common_text_glob_patterns.sh"
correct_sha512='cd341e8fd1074d53f6ea88b332fc4375f06af0e4c0b56e1ddb39c'
correct_sha512+='8ab988ea5f0c21ec4088fe1946ae44f3ea7ba394f558c03a446f'
correct_sha512+='0971482a4a7a8d6fe041153'
wget_sha512 "./$subdir/get_common_text_glob_patterns.sh" "$script"\
  "$correct_sha512"

URL_beginning2="$URL_beginning/licenses_templates"
subdir2="$subdir/licenses_templates"
script="$URL_beginning2/build_license_templates.sh"
correct_sha512='5de90f12af0b77ee6771ec4f827f6a1f36883b3ceb5c3b76806de'
correct_sha512+='7d187059e79a8b6fd94b659195abd4b7d91826afbb257a8f6db4'
correct_sha512+='291276a2df0000ab01e6daf'
wget_sha512 "./$subdir2/build_license_templates.sh" "$script"\
  "$correct_sha512"
chmod +x "./$subdir2/build_license_templates.sh"

script="$URL_beginning2/license_file_header_GPLv3+.tpl"
correct_sha512='2bdef9a729a5a9ca5ed87ef8a518877c5ee6b31b4533608660316'
correct_sha512+='a4e595fb31465a4847f4d53a2f7264118bd4eab7c1d1892e00bc'
correct_sha512+='1861455ed02898f194db067'
wget_sha512 "./$subdir2/license_file_header_GPLv3+.tpl" "$script"\
  "$correct_sha512"

script="$URL_beginning2/license_file_header_LGPLv3+.tpl"
correct_sha512='265fd0d086b48ab798f35a072335a4976e4eda8c256febba6c77c'
correct_sha512+='98ca86cdd844c6ac150c3445c80debbb3fc2574b5fceeeaf79ec'
correct_sha512+='734a759bdef5fe798067c62'
wget_sha512 "./$subdir2/license_file_header_LGPLv3+.tpl" "$script"\
  "$correct_sha512"

script="$URL_beginning/lines_counts.sh"
correct_sha512='cc58b84da70ad2c6adfa8c421e58bfc1b410e2508e8b28ece29db'
correct_sha512+='ab13405379aa2e0e586be741f3c785147c1bfc486e2be07ba0f7'
correct_sha512+='e0d63193e14482949cecaed'
wget_sha512 "./$subdir/lines_counts.sh" "$script" "$correct_sha512"

script="$URL_beginning/lines_filters.sh"
correct_sha512='5c9da4e6b8910256dd412effdfc3303e025634d4a650e710741b5'
correct_sha512+='0f43871a3464cdd4935fa52ee756f9848192fb3e95e9a2d17e54'
correct_sha512+='69ae594c96a1597be1044c5'
wget_sha512 "./$subdir/lines_filters.sh" "$script" "$correct_sha512"

script="$URL_beginning/overwrite_if_not_equal.sh"
correct_sha512='66cf1352946f96106206de7b1b71a42c2bf5be4b5636929c64e10'
correct_sha512+='88db7261872aa57057630a92ae51461528f2a2f61fe3da52a549'
correct_sha512+='db8f9febb542fe6b22f51dd'
wget_sha512 "./$subdir/overwrite_if_not_equal.sh" "$script"\
  "$correct_sha512"

script="$URL_beginning/python_black_complement.sh"
correct_sha512='7152e9d01cc3c72371695635cd6866b2e13ce25f4842afb8e4e87'
correct_sha512+='b6447b26abafbdbc850f69946913b5b2c423b265c9066a2b4655'
correct_sha512+='6dea19c04a5416588423a74'
wget_sha512 "./$subdir/python_black_complement.sh" "$script"\
  "$correct_sha512"

script="$URL_beginning/python_isort_complement.sh"
correct_sha512='ca3d5f7547e97c302845d772c4c7079d55ec3f98482cc620ef417'
correct_sha512+='b5b85720067b27252fea8c7ddade226d97ee7bc7f8575c7ff8f0'
correct_sha512+='5dcc20672f0ea9c376a3fd2'
wget_sha512 "./$subdir/python_isort_complement.sh" "$script"\
  "$correct_sha512"

script="$URL_beginning/too_long_code_lines.sh"
correct_sha512='865abda5d73f84bc8f660ac165ce71d69ba96423ffee14399662c'
correct_sha512+='2bc1dd69fafa421327ae9d9a61b1d17c2b8619e0a606db7dc0d6'
correct_sha512+='fad475096828bf339075f09'
wget_sha512 "./$subdir/too_long_code_lines.sh" "$script"\
  "$correct_sha512"

shopt -s globstar
source "./$subdir/check_shell_scripts_beginning.sh"
source "./$subdir/check_URLs.sh"
source "./$subdir/comparisons.sh"
source "./$subdir/generate_from_template.sh"
source "./$subdir/get_common_text_glob_patterns.sh"
source "./$subdir/lines_counts.sh"
source "./$subdir/lines_filters.sh"
source "./$subdir/overwrite_if_not_equal.sh"
source "./$subdir/python_black_complement.sh"
source "./$subdir/python_isort_complement.sh"
source "./$subdir/too_long_code_lines.sh"

cwd="."
if [[ -n "$1" ]];
then
  cwd="$1"
fi

echo "Building license headers"
./$subdir2/build_license_templates.sh "$cwd"

echo "Building README.md"
./$subdir/build_md_from_printable_md.sh "$cwd"

pushd .
cd "$cwd"

echo "Running isort"
isort .
python_isort_complement

echo "Running black"
black .
python_black_complement

find . -name "pyproject.toml" | relevant_find\
  | while read -r filename;
do
  if grep -q "Typing :: Typed" "$filename"; then
    echo "Running mypy"
    mypy $(dirname "$filename")
  fi
done

echo "Analyzing too long lines"
too_long_code_lines | relevant_grep | not_license_grep

echo "Analyzing shell scripts beginning"
check_shell_scripts_beginning | relevant_grep

echo "Analyzing URLs"
check_URLs | relevant_grep

echo "Creating the PDF file of the listing of the source code"
./build_and_checks_dependencies/create_PDF.sh

popd
