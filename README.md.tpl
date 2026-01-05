# DevOrSysAdminScripts

[![CodeFactor-badge]][CodeFactor-package-page]
[![Codacy-badge]][Codacy-package-page]
![GitHub-top-language-badge]
![GitHub-code-size-in-bytes-badge]
[![Security:bandit:badge]][Bandit-GitHub.com]
[![Code-style:black:badge]][Black-GitHub.com]
[![Imports:isort:badge]][Isort-GitHub.io]
[![Typecheck:mypy:badge]][Typecheck-mypy-lang.org]
[![Linting:pylint:badge]][Pylint-GitHub.com]

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

[Security:bandit:badge]: https://img.shields.io/badge/\
security-bandit-yellow.svg

[Bandit-GitHub.com]: https://github.com/PyCQA/bandit

[Code-style:black:badge]: https://img.shields.io/badge/\
code%20style-black-000000.svg

[Black-GitHub.com]: https://github.com/psf/black

[Imports:isort:badge]: https://img.shields.io/badge/\
%20imports-isort-%231674b1?style=flat&labelColor=ef8336

[Isort-GitHub.io]: https://pycqa.github.io/isort/

[Typecheck:mypy:badge]: https://www.mypy-lang.org/static/\
mypy_badge.svg

[Typecheck-mypy-lang.org]: https://mypy-lang.org/

[Linting:pylint:badge]: https://img.shields.io/badge/\
linting-pylint-yellowgreen

[Pylint-GitHub.com]: https://github.com/pylint-dev/pylint
