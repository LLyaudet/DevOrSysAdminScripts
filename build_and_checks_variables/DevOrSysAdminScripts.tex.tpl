% This file is part of DevOrSysAdminScripts library.
%
% DevOrSysAdminScripts is free software:
% you can redistribute it and/or modify it under the terms
% of the GNU Lesser General Public License
% as published by the Free Software Foundation,
% either version 3 of the License,
% or (at your option) any later version.
%
% DevOrSysAdminScripts is distributed in the hope
% that it will be useful,
% but WITHOUT ANY WARRANTY;
% without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
% See the GNU Lesser General Public License for more details.
%
% You should have received a copy of
% the GNU Lesser General Public License
% along with DevOrSysAdminScripts.
% If not, see <https://www.gnu.org/licenses/>.
%
% ©Copyright 2023-2026 Laurent Frédéric Bernard François Lyaudet

% 2025-12-29T17:08+01:00: This file was moved from
% "./latex"
% to
% "./build_and_checks_variables".

\documentclass{article}

\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage{subfigure}
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{amsthm}
\usepackage[pdftex]{hyperref}
\usepackage{tikz}
\usepackage{caption}
\usepackage[round]{natbib}
\usepackage{fancyhdr}
\usepackage{amsfonts}
\usepackage{times}
\usepackage{ifpdf}
\usepackage{latexsym}
\usepackage{graphicx}
\usepackage{enumerate}
\usepackage{pmboxdraw}
\usepackage{fancyvrb}
\usepackage[french,english]{babel}

% *** les environnements ***
%\theoremstyle{break}
\newtheorem{definition}{Definition}[section]
\newtheorem{proposition}[definition]{Proposition}
\newtheorem{theorem}[definition]{Theorem}
\newtheorem{lemma}[definition]{Lemma}
\newtheorem{corollary}[definition]{Corollary}
\newtheorem{remark}[definition]{Remark}
\newtheorem{openproblem}[definition]{Open problem}

\begin{document}

\author{
  @author_full_name@\\
  \url{@author_website@}\\
  \href{mailto:@author_email@}{@author_email@}
}
\title{@repository_name@}

\maketitle
\begin{abstract}
@abstract@
\end{abstract}

Current version: @current_date@

Current number of commits: @number_of_commits@

Current git SHA1: @current_git_SHA1@

Code lines: @number_of_lines@

\tableofcontents
\newpage

\section{Files tree}
\label{section:tree}

\begin{verbatim}
@current_tree_light@
\end{verbatim}

\begin{verbatim}
@current_tree@
\end{verbatim}

\section{Listing of files}
\label{section:listing}

This repository is dual licensed.
All the Bash scripts source code is covered by GPLv3+.
All the PHP scripts source code is covered by LGPLv3+.
All the Python scripts source code is covered by LGPLv3+.

The text of the licenses is available at:
\url{https://www.gnu.org/licenses/}.
The git repository of this source code is also available at:
\url{@repository_web_url@}.
Clone it with this URL:
\url{@repository_git_url@}.

Here is a listing of the dependencies of the code in this repository:
\begin{itemize}
\item The following dependencies are GPLv3+ licensed:\newline
basename, bash (and its builtins), cat, chmod, cp, cut, date, diff,
dirname, env, find, grep, head, mkdir, mv, realpath, rm, sed,
sha512sum, shellcheck, sort, tail, touch, wc, wget, xargs;
\item The following dependencies are GPLv2+ licensed:\newline
more, pandoc, pdftex, pdflatex, tree;
\item The following dependencies are GPLv2 licensed:\newline
git, pylint;
\item The following dependencies are LGPLv2.1+ licensed:\newline
notify-send;
\item The following dependencies are MIT licensed:\newline
black, isort, mypy, ruff;
\item The following dependencies are Apache-2.0 licensed:\newline
bandit;
\item The following dependencies are BSD-3-Clause licensed:\newline
phpmd;
\item php is licensed under PHP License v3.01;
\item tex is licensed under Knuth license;
\item pcregrep, pcre2grep has a custom license from Cambridge
University, but PCRE2 has BSD-3-Clause WITH PCRE2-exception.
\end{itemize}

Remark: Some commands listed under GPLv3+ are POSIX
and can have different implementations under another license;
for example, uutils coreutils is MIT licensed,
whilst GNU coreutils is GPLv3+ licensed.

Bash can be found at the following URLs:\newline
\url{https://www.gnu.org/software/bash/},\newline
\url{https://tiswww.case.edu/php/chet/bash/bashtop.html},\newline
\url{https://savannah.gnu.org/projects/bash/}.

GNU coreutils can be found at the following URLs:\newline
\url{https://www.gnu.org/software/coreutils/},\newline
\url{https://savannah.gnu.org/projects/coreutils/}.

uutils coreutils can be found at the following URLs:\newline
\url{https://uutils.github.io/coreutils/},\newline
\url{https://github.com/uutils/coreutils}.

diff (GNU diffutils) can be found at the following URLs:\newline
\url{https://www.gnu.org/software/diffutils/},\newline
\url{https://savannah.gnu.org/projects/diffutils/}.

find, xargs (GNU findutils) can be found at the following URLs:\newline
\url{https://www.gnu.org/software/findutils/},\newline
\url{https://savannah.gnu.org/projects/findutils/}.

grep (GNU grep) can be found at the following URLs:\newline
\url{https://www.gnu.org/software/grep/},\newline
\url{https://savannah.gnu.org/projects/grep/}.

sed (GNU sed) can be found at the following URLs:\newline
\url{https://www.gnu.org/software/sed/},\newline
\url{https://savannah.gnu.org/projects/sed/}.

ShellCheck can be found at the following URLs:\newline
\url{https://www.shellcheck.net/},\newline
\url{https://github.com/koalaman/shellcheck}.

GNU Wget can be found at the following URLs:\newline
\url{https://www.gnu.org/software/wget/},\newline
\url{https://savannah.gnu.org/projects/wget/}.

more of util-linux can be found at the following URLs:\newline
\url{https://www.kernel.org/pub/linux/utils/util-linux/},\newline
\url{https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/},
\newline
\url{https://github.com/util-linux/util-linux} official?

pandoc can be found at the following URLs:\newline
\url{https://pandoc.org/},\newline
\url{https://github.com/jgm/pandoc}.

pdftex/pdflatex can be found at the following URLs:\newline
\url{https://www.tug.org/applications/pdftex/},\newline
\url{https://tug.org/texlive/svn/}.

tree can be found at the following URLs:\newline
\url{https://oldmanprogrammer.net/source.php?dir=projects/tree},\newline
\url{https://gitlab.com/OldManProgrammer/unix-tree},\newline
\url{https://github.com/Old-Man-Programmer/tree}.

git can be found at the following URLs:\newline
\url{https://git-scm.com/about},\newline
\url{https://github.com/git/git}.

pylint can be found at the following URLs:\newline
\url{https://www.pylint.org/},\newline
\url{https://pylint.readthedocs.io/en/stable/},\newline
\url{https://github.com/pylint-dev/pylint},\newline
\url{https://pypi.org/project/pylint/}.

notify-send can be found at the following URLs:\newline
\url{https://gitlab.gnome.org/GNOME/libnotify/},\newline
\url{https://gnome.pages.gitlab.gnome.org/libnotify/}.

black can be found at the following URLs:\newline
\url{https://github.com/psf/black},\newline
\url{https://black.readthedocs.io/en/stable/},\newline
\url{https://pypi.org/project/black/}.

isort can be found at the following URLs:\newline
\url{https://pycqa.github.io/isort/},\newline
\url{https://github.com/pycqa/isort/},\newline
\url{https://pypi.org/project/isort/}.

mypy can be found at the following URLs:\newline
\url{https://mypy-lang.org/},\newline
\url{https://mypy.readthedocs.io/en/stable/},\newline
\url{https://github.com/python/mypy},\newline
\url{https://pypi.org/project/mypy/}.

ruff can be found at the following URLs:\newline
\url{https://docs.astral.sh/ruff/},\newline
\url{https://github.com/astral-sh/ruff},\newline
\url{https://pypi.org/project/ruff/}.

bandit can be found at the following URLs:\newline
\url{https://bandit.readthedocs.io/en/latest/},\newline
\url{https://github.com/PyCQA/bandit},\newline
\url{https://pypi.org/project/bandit/}.

phpmd can be found at the following URLs:\newline
\url{https://phpmd.org/},\newline
\url{https://github.com/phpmd/phpmd},\newline
\url{https://packagist.org/packages/phpmd/phpmd}.

php can be found at the following URLs:\newline
\url{https://www.php.net/},\newline
\url{https://github.com/php/php-src}.

tex can be found at the following URL:\newline
\url{https://ctan.org/tex-archive/systems/knuth/dist/tex}.

pcregrep, pcre2grep can be found at the following URLs:\newline
\url{https://www.pcre.org/},\newline
\url{https://pcre2project.github.io/pcre2/},\newline
\url{https://github.com/PCRE2Project/pcre1},\newline
\url{https://github.com/PCRE2Project/pcre2},\newline
\url{https://github.com/PCRE2Project/pcre2/blob/main/src/pcre2grep.c}.

If you see something that I missed regarding my dependencies,
please tell me/email me :).

@files_listing_VerbatimInput@

@acknowledgments@

\end{document}
