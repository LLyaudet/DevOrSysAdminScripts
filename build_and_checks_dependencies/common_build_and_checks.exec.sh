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

verbose=""
if [[ "$2" == "--verbose" ]]; then
  echo "$0 $*"
  verbose="--verbose"
fi

source ./wget_sha512.sh

personal_github="https://raw.githubusercontent.com/LLyaudet/"
dependencies="DevOrSysAdminScripts/main/build_and_checks_dependencies"
URL_beginning="$personal_github$dependencies"

subdir="build_and_checks_dependencies"

script="$URL_beginning/build_md_from_printable_md.sh"
correct_sha512='89051d59005571ebaedfa1519bd463f3a215fdd1cd19a857cfbd8'
correct_sha512+='fb81b3431fa9569d641be09eaf8eee8084b567682f9751e59f0f'
correct_sha512+='5081b6285245227b7ed4a2e'
wget_sha512 "./$subdir/build_md_from_printable_md.sh" "$script"\
  "$correct_sha512" "$verbose"
chmod +x "./$subdir/build_md_from_printable_md.sh"

script="$URL_beginning/check_shell_scripts_beginnings.sh"
correct_sha512='d94931d4b20b7987aed4dd02663ad5feba3389c8fdea2fdbfb91d'
correct_sha512+='0b71eed4ef80c8d4a8eef5c147837183b2c9ed6d577cda3ad67f'
correct_sha512+='6d6485a015eac56fa0daa3b'
wget_sha512 "./$subdir/check_shell_scripts_beginnings.sh" "$script"\
  "$correct_sha512" "$verbose"

script="$URL_beginning/check_URLs.sh"
correct_sha512='d83cac890cc02fabaed5612ff59dd581e4e42e4f9de5710ad80bb'
correct_sha512+='41db46f9e2ec6f5bddb6006e209e81d45432a908717d10188ebc'
correct_sha512+='a623b1493e4098dd78cd80b'
wget_sha512 "./$subdir/check_URLs.sh" "$script" "$correct_sha512"\
  "$verbose"

script="$URL_beginning/comparisons.sh"
correct_sha512='0ee812694f1cb1666f02351e96642445c18b9b288bebfa88a6ddd'
correct_sha512+='dbe465d8bc2413f08cce766c4f02ff66c95bdd3d6e448069520f'
correct_sha512+='17ee0c04c19a5c52c3c7380'
wget_sha512 "./$subdir/comparisons.sh" "$script" "$correct_sha512"\
  "$verbose"

script="$URL_beginning/create_PDF.sh"
correct_sha512='c7ebeb850040c2d6da0d1e27718fcf7092fd046e2b8fd15a8f9b3'
correct_sha512+='f55685459e85b8733837cbf39206cbe4d476859eb2993e1709c8'
correct_sha512+='8755192cb225b8d4bdab8af'
wget_sha512 "./$subdir/create_PDF.sh" "$script" "$correct_sha512"\
  "$verbose"
chmod +x "./$subdir/create_PDF.sh"

script="$URL_beginning/generate_from_template.sh"
correct_sha512='36c92a15b93f199d28476bfa83612e3e9dd5153b9cc8ed2013bf6'
correct_sha512+='e8e87a041e5f07935357d1e9dce76b3901ecf9d25eee8d99e47c'
correct_sha512+='19cc6a1384a0fc2feb76b49'
wget_sha512 "./$subdir/generate_from_template.sh" "$script"\
  "$correct_sha512" "$verbose"

script="$URL_beginning/get_common_text_glob_patterns.sh"
correct_sha512='cd341e8fd1074d53f6ea88b332fc4375f06af0e4c0b56e1ddb39c'
correct_sha512+='8ab988ea5f0c21ec4088fe1946ae44f3ea7ba394f558c03a446f'
correct_sha512+='0971482a4a7a8d6fe041153'
wget_sha512 "./$subdir/get_common_text_glob_patterns.sh" "$script"\
  "$correct_sha512" "$verbose"

script="$URL_beginning/grammar_and_spell_check.sh"
correct_sha512='69dcb77061f2e560d6268622ae72ef11d412b996520b7321b1f20'
correct_sha512+='427fb4eda6d2fb5909938da6c0af4099921190298d372466dea3'
correct_sha512+='b45805f0c271da852578075'
wget_sha512 "./$subdir/grammar_and_spell_check.sh" "$script"\
  "$correct_sha512" "$verbose"

URL_beginning2="$URL_beginning/licenses_templates"
subdir2="$subdir/licenses_templates"
script="$URL_beginning2/build_licenses_templates.sh"
correct_sha512='e1b5e13be2cb0625e620958744c9aa7aa811e56cd4359f2ab6831'
correct_sha512+='8e42afc75bfb8b638fb15ed180de336379c4d5fb72b253ab3db8'
correct_sha512+='4515391606476d0172295bc'
wget_sha512 "./$subdir2/build_licenses_templates.sh" "$script"\
  "$correct_sha512" "$verbose"
chmod +x "./$subdir2/build_licenses_templates.sh"

script="$URL_beginning2/license_file_header_GPLv3+.tpl"
correct_sha512='2bdef9a729a5a9ca5ed87ef8a518877c5ee6b31b4533608660316'
correct_sha512+='a4e595fb31465a4847f4d53a2f7264118bd4eab7c1d1892e00bc'
correct_sha512+='1861455ed02898f194db067'
wget_sha512 "./$subdir2/license_file_header_GPLv3+.tpl" "$script"\
  "$correct_sha512" "$verbose"

script="$URL_beginning2/license_file_header_LGPLv3+.tpl"
correct_sha512='265fd0d086b48ab798f35a072335a4976e4eda8c256febba6c77c'
correct_sha512+='98ca86cdd844c6ac150c3445c80debbb3fc2574b5fceeeaf79ec'
correct_sha512+='734a759bdef5fe798067c62'
wget_sha512 "./$subdir2/license_file_header_LGPLv3+.tpl" "$script"\
  "$correct_sha512" "$verbose"

script="$URL_beginning/lines_counts.sh"
correct_sha512='4aa984d1a3709d3ed6ad5a4accc5e1d9cee2f174730ef232dbcd6'
correct_sha512+='1d3661191e1904a0072fdb818c96e4aff5e58d5d7b0b024a874f'
correct_sha512+='17acb35d98bbde10fb6dacd'
wget_sha512 "./$subdir/lines_counts.sh" "$script" "$correct_sha512"\
  "$verbose"

script="$URL_beginning/lines_filters.sh"
correct_sha512='a144c6e57df8a6dc4e99aecefcef3e5d1f93ef22a76f0089bb6e1'
correct_sha512+='be6189193a1ea4ac316173a36b83a2c92f75856e6cec97a2bbcf'
correct_sha512+='ba23110239e5a1d10455bf6'
wget_sha512 "./$subdir/lines_filters.sh" "$script" "$correct_sha512"\
  "$verbose"

script="$URL_beginning/lines_maps.sh"
correct_sha512='7412f31e20e625b49579621cdc0cf2deb3226d4a93414ed6dfd18'
correct_sha512+='e7118adf6bc699e8a7c0a59cd4fa1c1e597b14671485ba3ced04'
correct_sha512+='ce8dbb4aa1b5971e6f906f4'
wget_sha512 "./$subdir/lines_maps.sh" "$script" "$correct_sha512"\
  "$verbose"

URL_beginning3="$URL_beginning/listings"
subdir3="$subdir/listings"
script="$URL_beginning3/update_or_check_files_names_listing.sh"
correct_sha512='992da121f4f6a711813243d914d774d947c074c95a025ba579a3f'
correct_sha512+='3e717320e2901b1b8c73583c79d8ddbf9f493fab18a0de422a49'
correct_sha512+='a199d91768bab8920ef797a'
wget_sha512 "./$subdir3/update_or_check_files_names_listing.sh"\
  "$script" "$correct_sha512" "$verbose"
chmod +x "./$subdir3/update_or_check_files_names_listing.sh"

script="$URL_beginning3/files_names_listing.txt"
correct_sha512='19003318a81ac923b3053abb87dcf1d92b825cc0cf88da4285c4a'
correct_sha512+='5c7b73878c0fb0a8ca50a3ab0aa744bd872edfa3a91846189e23'
correct_sha512+='dd3e9a01430f22d8e369012'
wget_sha512 "./$subdir3/files_names_listing.txt" "$script"\
  "$correct_sha512" "$verbose"

script="$URL_beginning/overwrite_if_not_equal.sh"
correct_sha512='afabf6f384e61920dbc575afb1519173ac2654b6180b9a28c5ffc'
correct_sha512+='173a05c6e6d4011d7bc8912da15caee923c9033d8355967920e4'
correct_sha512+='d05e2cd575c3cf065fc8e40'
wget_sha512 "./$subdir/overwrite_if_not_equal.sh" "$script"\
  "$correct_sha512" "$verbose"

script="$URL_beginning/python_black_complement.sh"
correct_sha512='7152e9d01cc3c72371695635cd6866b2e13ce25f4842afb8e4e87'
correct_sha512+='b6447b26abafbdbc850f69946913b5b2c423b265c9066a2b4655'
correct_sha512+='6dea19c04a5416588423a74'
wget_sha512 "./$subdir/python_black_complement.sh" "$script"\
  "$correct_sha512" "$verbose"

script="$URL_beginning/python_isort_complement.sh"
correct_sha512='770e5ed16e4b5f6d61577794033161d361bc2eacea6d08a5c7b9a'
correct_sha512+='1577666cf655d1c947108adb9151d87f937471d30716a6d50d76'
correct_sha512+='f84bbcf1f1620fb9ede4575'
wget_sha512 "./$subdir/python_isort_complement.sh" "$script"\
  "$correct_sha512" "$verbose"

script="$URL_beginning/too_long_code_lines.sh"
correct_sha512='a8716971f22a14160701b6e801c4f66220e2e1dd174f24e43775e'
correct_sha512+='e743aeaa4ee66dadae185e134c3554f8c37d8ee457d051336ed3'
correct_sha512+='430b734bcf80e8d5704064b'
wget_sha512 "./$subdir/too_long_code_lines.sh" "$script"\
  "$correct_sha512" "$verbose"

shopt -s globstar
source "./$subdir/check_shell_scripts_beginnings.sh"
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
./$subdir2/build_licenses_templates.sh "$verbose"

echo "Building README.md"
./$subdir/build_md_from_printable_md.sh "$cwd" "README" "$verbose"

pushd .
cd "$cwd"

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
./build_and_checks_dependencies/create_PDF.sh "$verbose"

popd
