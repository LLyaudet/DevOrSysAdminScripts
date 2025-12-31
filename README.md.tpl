# DevOrSysAdminScripts

[![CodeFactor-badge]][CodeFactor-package-page]
[![Codacy-badge]][Codacy-package-page]
![GitHub-top-language-badge]
![GitHub-code-size-in-bytes-badge]

|                **Some "small" useful scripts**               |
|:------------------------------------------------------------:|
| **for enhancing development or system-administrators tasks** |

Currently, the biggest part of this repository is in
a suite of shell scripts about build and checks that
I use in some of my other repositories.

I tried to follow some conventions for my bash code:

- I tried to encapsulate most of the code in functions.
- Unless used as return values, variables in functions are defined
  as local variables (`local` keyword or `declare`)
  with prefix "LFBFL_".
- When used as return values, variables in functions are defined
  as global variables (`declare -g`) with prefix
  "@function_name@_result_".
- Whenever a variable is no more modified after some point,
  add the keyword `readonly` or use `declare -r`.
- Whenever a variable will only contain integer values (or boolean
  values as 0 or 1), use `declare -i`.
- I named bash files with suffixes ".exec.sh" when the script can
  be runned
  (executable, abbreviation stops before a vowel).
- I named bash files with suffixes ".libr.sh" when the script contains
  only functions definitions
  (library, abbreviation stops before a vowel).
- When some ".exec.sh" code is encapsulated into functions,
  either these functions can be reused and go in some ".libr.sh" file,
  either they are truly specific to this script and they are kept
  in ".exec.sh" file.

But the files "pre-commit" and "post-commit" were not renamed,
since it is not possible to give them other names to use them as
pre-commit/post-commit hooks in `git`.

[CodeFactor-badge]: https://www.codefactor.io/repository/github/\
llyaudet/DevOrSysAdminScripts/badge

[CodeFactor-package-page]: https://www.codefactor.io/repository/\
github/llyaudet/DevOrSysAdminScripts

[Codacy-badge]: https://app.codacy.com/project/badge/Grade/\
3dd6ef85e8db4460991d1ebc404b68dd

[Codacy-package-page]: https://app.codacy.com/gh/LLyaudet/\
DevOrSysAdminScripts/dashboard?utm_source=gh&utm_medium=referral\
&utm_content=&utm_campaign=Badge_grade

[GitHub-top-language-badge]: https://img.shields.io/github/\
languages/top/llyaudet/DevOrSysAdminScripts

[GitHub-code-size-in-bytes-badge]: https://img.shields.io/github/\
languages/code-size/llyaudet/DevOrSysAdminScripts
