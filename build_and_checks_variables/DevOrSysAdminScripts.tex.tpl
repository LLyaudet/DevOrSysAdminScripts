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
% ©Copyright 2023-2025 Laurent Frédéric Bernard François Lyaudet

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

The text of the licenses is available at:
\url{https://www.gnu.org/licenses/}.
The git repository of this source code is also available at:
\url{https://github.com/LLyaudet/@repository_name@/}.

Here is a listing of the dependencies of the code in this repository:
\begin{itemize}
\item The following dependencies are GPLv3+ licensed:\newline
basename, bash (and its builtins), cat, chmod, cp, cut, date, diff,
dirname, find, grep, head, mkdir, mv, realpath, rm, sed, sha512sum,
shellcheck, sort, tail, wc, wget, xargs
\item The following dependencies are GPLv2+ licensed:\newline
more, pandoc, pdftex, pdflatex, tree
\item The following dependencies are GPLv2 licensed:\newline
git
\item The following dependencies are LGPLv2.1+ licensed:\newline
notify-send
\item The following dependencies are MIT licensed:\newline
black, isort, mypy
\item php is licensed under PHP License v3.01
\item tex is licensed under Knuth license
\item pcregrep has a custom license from Cambridge University
\end{itemize}

Remark: Some commands listed under GPLv3+ are POSIX
and can have different implementations under another license;
for example, uutils coreutils is MIT licensed,
whilst GNU coreutils is GPLv3+ licensed.

@files_listing_VerbatimInput@

@acknowledgments@

\end{document}
