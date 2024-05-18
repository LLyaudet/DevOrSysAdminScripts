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
% ©Copyright 2023-2024 Laurent Frédéric Bernard François Lyaudet

\documentclass{article}

\usepackage[utf8]{inputenc}
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
  \email{@author_email@}
}
\title{DevOrSysAdminScripts}

\maketitle
\begin{abstract}
Some ``small'' useful scripts
for enhancing development or system-administrators tasks
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

The following source code is covered by LGPLv3+.
The text of the license is available at:
\url{https://www.gnu.org/licenses/}.
The git repository of this source code is also available at:
\url{https://github.com/LLyaudet/DevOrSysAdminScripts/}.


\subsection{
  build\_and\_checks\_dependencies/build\_and\_checks.sh.tpl
}
\label{
  build_and_checks_dependencies:build_and_checksshtpl
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks_dependencies/build_and_checks.sh.tpl
}


\subsection{
  build\_and\_checks\_dependencies/build\_md\_from\_printable\_md.sh
}
\label{
  build_and_checks_dependencies:build_md_from_printable_mdsh
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks_dependencies/build_md_from_printable_md.sh
}


\subsection{
  build\_and\_checks\_dependencies/call\_split\_score\_after\_before\_or\_before\_after.php
}
\label{
  build_and_checks_dependencies:call_split_score_after_before_or_before_afterphp
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks_dependencies/call_split_score_after_before_or_before_after.php
}


\subsection{
  build\_and\_checks\_dependencies/%
check\_shell\_scripts\_beginnings.sh
}
\label{
  build_and_checks_dependencies:check_shell_scripts_beginningssh
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks_dependencies/check_shell_scripts_beginnings.sh
}


\subsection{
  build\_and\_checks\_dependencies/check\_URLs.sh
}
\label{
  build_and_checks_dependencies:check_URLssh
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks_dependencies/check_URLs.sh
}


\subsection{
  build\_and\_checks\_dependencies/common\_build\_and\_checks.sh
}
\label{
  build_and_checks_dependencies:common_build_and_checkssh
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks_dependencies/common_build_and_checks.sh
}


\subsection{
  build\_and\_checks\_dependencies/common\_build\_and\_checks.sh.tpl
}
\label{
  build_and_checks_dependencies:common_build_and_checksshtpl
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks_dependencies/common_build_and_checks.sh.tpl
}


\subsection{
  build\_and\_checks\_dependencies/comparisons.sh
}
\label{
  build_and_checks_dependencies:comparisonssh
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks_dependencies/comparisons.sh
}


\subsection{
  build\_and\_checks\_dependencies/create\_PDF.sh
}
\label{
  build_and_checks_dependencies:create_PDFsh
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks_dependencies/create_PDF.sh
}


\subsection{
  build\_and\_checks\_dependencies/generate\_from\_template.sh
}
\label{
  build_and_checks_dependencies:generate_from_templatesh
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks_dependencies/generate_from_template.sh
}


\subsection{
  build\_and\_checks\_dependencies/get\_common\_text\_glob\_patterns%
.sh
}
\label{
  build_and_checks_dependencies:get_common_text_glob_patternssh
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks_dependencies/get_common_text_glob_patterns.sh
}


\subsection{
  build\_and\_checks\_dependencies/licenses\_templates/%
build\_licenses\_templates.sh
}
\label{
  build_and_checks_dependencies:licenses_templates:%
build_licenses_templatessh
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks_dependencies/licenses_templates/%
build_licenses_templates.sh
}


\subsection{
  build\_and\_checks\_dependencies/licenses\_templates/%
license\_file\_header\_GPLv3+.c.tpl
}
\label{
  build_and_checks_dependencies:licenses_templates:%
license_file_header_GPLv3+ctpl
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks_dependencies/licenses_templates/%
license_file_header_GPLv3+.c.tpl
}


\subsection{
  build\_and\_checks\_dependencies/licenses\_templates/%
license\_file\_header\_GPLv3+.py.tpl
}
\label{
  build_and_checks_dependencies:licenses_templates:%
license_file_header_GPLv3+pytpl
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks_dependencies/licenses_templates/%
license_file_header_GPLv3+.py.tpl
}


\subsection{
  build\_and\_checks\_dependencies/licenses\_templates/%
license\_file\_header\_GPLv3+.sh.tpl
}
\label{
  build_and_checks_dependencies:licenses_templates:%
license_file_header_GPLv3+shtpl
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks_dependencies/licenses_templates/%
license_file_header_GPLv3+.sh.tpl
}


\subsection{
  build\_and\_checks\_dependencies/licenses\_templates/%
license\_file\_header\_GPLv3+.tex.tpl
}
\label{
  build_and_checks_dependencies:licenses_templates:%
license_file_header_GPLv3+textpl
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks_dependencies/licenses_templates/%
license_file_header_GPLv3+.tex.tpl
}


\subsection{
  build\_and\_checks\_dependencies/licenses\_templates/%
license\_file\_header\_GPLv3+.tpl
}
\label{
  build_and_checks_dependencies:licenses_templates:%
license_file_header_GPLv3+tpl
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks_dependencies/licenses_templates/%
license_file_header_GPLv3+.tpl
}


\subsection{
  build\_and\_checks\_dependencies/licenses\_templates/%
license\_file\_header\_LGPLv3+.c
}
\label{
  build_and_checks_dependencies:licenses_templates:%
license_file_header_LGPLv3+c
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks_dependencies/licenses_templates/%
license_file_header_LGPLv3+.c
}


\subsection{
  build\_and\_checks\_dependencies/licenses\_templates/%
license\_file\_header\_LGPLv3+.c.tpl
}
\label{
  build_and_checks_dependencies:licenses_templates:%
license_file_header_LGPLv3+ctpl
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks_dependencies/licenses_templates/%
license_file_header_LGPLv3+.c.tpl
}


\subsection{
  build\_and\_checks\_dependencies/licenses\_templates/%
license\_file\_header\_LGPLv3+.py
}
\label{
  build_and_checks_dependencies:licenses_templates:%
license_file_header_LGPLv3+py
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks_dependencies/licenses_templates/%
license_file_header_LGPLv3+.py
}


\subsection{
  build\_and\_checks\_dependencies/licenses\_templates/%
license\_file\_header\_LGPLv3+.py.tpl
}
\label{
  build_and_checks_dependencies:licenses_templates:%
license_file_header_LGPLv3+pytpl
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks_dependencies/licenses_templates/%
license_file_header_LGPLv3+.py.tpl
}


\subsection{
  build\_and\_checks\_dependencies/licenses\_templates/%
license\_file\_header\_LGPLv3+.sh
}
\label{
  build_and_checks_dependencies:licenses_templates:%
license_file_header_LGPLv3+sh
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks_dependencies/licenses_templates/%
license_file_header_LGPLv3+.sh
}


\subsection{
  build\_and\_checks\_dependencies/licenses\_templates/%
license\_file\_header\_LGPLv3+.sh.tpl
}
\label{
  build_and_checks_dependencies:licenses_templates:%
license_file_header_LGPLv3+shtpl
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks_dependencies/licenses_templates/%
license_file_header_LGPLv3+.sh.tpl
}


\subsection{
  build\_and\_checks\_dependencies/licenses\_templates/%
license\_file\_header\_LGPLv3+.tex
}
\label{
  build_and_checks_dependencies:licenses_templates:%
license_file_header_LGPLv3+tex
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks_dependencies/licenses_templates/%
license_file_header_LGPLv3+.tex
}


\subsection{
  build\_and\_checks\_dependencies/licenses\_templates/%
license\_file\_header\_LGPLv3+.tex.tpl
}
\label{
  build_and_checks_dependencies:licenses_templates:%
license_file_header_LGPLv3+textpl
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks_dependencies/licenses_templates/%
license_file_header_LGPLv3+.tex.tpl
}


\subsection{
  build\_and\_checks\_dependencies/licenses\_templates/%
license\_file\_header\_LGPLv3+.tpl
}
\label{
  build_and_checks_dependencies:licenses_templates:%
license_file_header_LGPLv3+tpl
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks_dependencies/licenses_templates/%
license_file_header_LGPLv3+.tpl
}


\subsection{
  build\_and\_checks\_dependencies/lines\_counts.sh
}
\label{
  build_and_checks_dependencies:lines_countssh
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks_dependencies/lines_counts.sh
}


\subsection{
  build\_and\_checks\_dependencies/lines\_filters.sh
}
\label{
  build_and_checks_dependencies:lines_filterssh
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks_dependencies/lines_filters.sh
}


\subsection{
  build\_and\_checks\_dependencies/lines\_maps.sh
}
\label{
  build_and_checks_dependencies:lines_mapssh
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks_dependencies/lines_maps.sh
}


\subsection{
  build\_and\_checks\_dependencies/listings/files\_names\_listing.txt
}
\label{
  build_and_checks_dependencies:listings:files_names_listingtxt
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks_dependencies/listings/files_names_listing.txt
}


\subsection{
  build\_and\_checks\_dependencies/listings/update\_or\_check\_files\_names\_listing.sh
}
\label{
  build_and_checks_dependencies:listings:update_or_check_files_names_listingsh
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks_dependencies/listings/update_or_check_files_names_listing.sh
}


\subsection{
  build\_and\_checks\_dependencies/overwrite\_if\_not\_equal.sh
}
\label{
  build_and_checks_dependencies:overwrite_if_not_equalsh
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks_dependencies/overwrite_if_not_equal.sh
}


\subsection{
  build\_and\_checks\_dependencies/python\_black\_complement.sh
}
\label{
  build_and_checks_dependencies:python_black_complementsh
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks_dependencies/python_black_complement.sh
}


\subsection{
  build\_and\_checks\_dependencies/python\_isort\_complement.sh
}
\label{
  build_and_checks_dependencies:python_isort_complementsh
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks_dependencies/python_isort_complement.sh
}


\subsection{
  build\_and\_checks\_dependencies/too\_long\_code\_lines.sh
}
\label{
  build_and_checks_dependencies:too_long_code_linessh
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks_dependencies/too_long_code_lines.sh
}


\subsection{
  build\_and\_checks\_dependencies/update\_common\_build\_and\_checks%
.sh
}
\label{
  build_and_checks_dependencies:update_common_build_and_checkssh
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks_dependencies/update_common_build_and_checks.sh
}


\subsection{
  build\_and\_checks.sh
}
\label{
  build_and_checkssh
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks.sh
}


\subsection{
  git\_checks.sh
}
\label{
  git_checkssh
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  git_checks.sh
}


\subsection{
  build\_and\_checks\_dependencies/grammar\_and\_spell\_check.sh
}
\label{
  build_and_checks_dependencies:grammar_and_spell_checksh
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks_dependencies/grammar_and_spell_check.sh
}


\subsection{
  latex/DevOrSysAdminScripts.tex.tpl
}
\label{
  latex:DevOrSysAdminScriptstextpl
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  latex/DevOrSysAdminScripts.tex.tpl
}


\subsection{
  LiensUtiles.txt
}
\label{
  LiensUtilestxt
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  LiensUtiles.txt
}


\subsection{
  pre-commit
}
\label{
  pre-commit
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  pre-commit
}


\subsection{
  README.md.tpl
}
\label{
  READMEmdtpl
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  README.md.tpl
}


\subsection{
  repository\_data.txt
}
\label{
  repository_datatxt
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  repository_data.txt
}


\subsection{
  build\_and\_checks\_dependencies/split\_line\_at\_most.php
}
\label{
  build_and_checks_dependencies:split_line_at_mostphp
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks_dependencies/split_line_at_most.php
}


\subsection{
  build\_and\_checks\_dependencies/string\_functions.sh
}
\label{
  build_and_checks_dependencies:string_functionssh
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  build_and_checks_dependencies/string_functions.sh
}



\subsection{
  unicode.php
}
\label{
  unicodephp
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  unicode.php
}


\subsection{
  wget\_sha512.sh
}
\label{
  wget_sha512sh
}

\VerbatimInput[numbers=left,xleftmargin=-5mm]{
  wget_sha512.sh
}


Merci Dieu ! Merci P\`ere ! Merci Seigneur ! Merci Saint Esprit !

\end{document}
