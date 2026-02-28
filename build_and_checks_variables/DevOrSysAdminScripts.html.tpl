<!DOCTYPE html>
<html lang="en">
<!--
This file is part of DevOrSysAdminScripts library.

DevOrSysAdminScripts is free software:
you can redistribute it and/or modify it under the terms
of the GNU Lesser General Public License
as published by the Free Software Foundation,
either version 3 of the License,
or (at your option) any later version.

DevOrSysAdminScripts is distributed in the hope
that it will be useful,
but WITHOUT ANY WARRANTY;
without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU Lesser General Public License for more details.

You should have received a copy of
the GNU Lesser General Public License
along with DevOrSysAdminScripts.
If not, see <https://www.gnu.org/licenses/>.

©Copyright 2023-2026 Laurent Frédéric Bernard François Lyaudet
-->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="generator" content="DevOrSysAdminScripts">
<style>
.title{
  margin: 2ex auto;
  text-align: center;
}
.titlemain{
  margin: 1ex 2ex 2ex 1ex;
}
.titlerest{
  font-size: 1.17em;
  margin: 0ex 2ex;
}
table{
  border-collapse: collapse;
}
td{
  padding: 0;
}
pre{
  text-align: left;
  margin-left: 0ex;
  margin-right: auto;
}
pre.numbered_lines:before{
  background: snow;
  border-right: 1px black solid;
  color: #010101;
  content: attr(line-numbers);
  float: left;
  padding: 0 1ch;
  text-align: right;
}
blockquote{
  margin-left: 4ex;
  margin-right: 4ex;
  text-align: left;
}
ol.level1, ol.level2{
  list-style-type: none;
  /*
  list-style-type: decimal;
  Previous rule is shorter and more efficient if you need only level1.
  But you don't have accessible counter if you use decimal.
  */
}
ol.level1{
  counter-reset: level1;
}
ol.level2{
  counter-reset: level2;
}
ol.level1 li:before{
  content: counter(level1) ". ";
  counter-increment: level1;
}
ol.level2 li:before{
  content: counter(level1) "." counter(level2) " ";
  counter-increment: level2;
}
</style>
<title>@repository_name@</title>
</head>
<body >
<table class="title">
  <tr>
    <td style="padding:1ex">
      <h1 class="titlemain">@repository_name@</h1>
      <h2 class="titlerest">
        @author_full_name@
        <br>
        <a href="@author_website@">
          <span style="font-family:monospace">
          @author_website@
          </span>
        </a>
        <br>
        <a href="mailto:@author_email@">
          <span style="font-family:monospace">
          @author_email@
          </span>
        </a>
      </h2>
    </td>
  </tr>
</table>

<blockquote class="abstract">
  <span style="font-weight:bold">Abstract:</span>
  @abstract@
</blockquote>
<p>Current version: @current_date@</p>
<p>Current number of commits: @number_of_commits@</p>
<p>Current git SHA1: @current_git_SHA1@</p>
<p>
Code lines: @number_of_lines@
</p>


<h2>Contents</h2>

<ol class="level1">
  <li><a href="#section1">Files Tree</a></li>
  <li><a href="#section2">Listing of files</a><br>
    <ol class="level2">
      @files_lis@
    </ol>
  </li>
</ol>


<h2 id="section1">1 Files tree</h2>
<pre class="verbatim">
@current_tree_light@
</pre>
<pre class="verbatim">
@current_tree@
</pre>


<h2 id="section2">2 Listing of files</h2>

<p>
This repository is dual licensed.
All the Bash scripts source code is covered by GPLv3+.
All the PHP scripts source code is covered by LGPLv3+.
All the Python scripts source code is covered by LGPLv3+.
</p>

<p>
The text of the licenses is available at:
<a href="https://www.gnu.org/licenses/"><span
  style="font-family:monospace"
>https://www.gnu.org/licenses/</span></a>.
The git repository of this source code is also available at:
<a href="@repository_web_url@"><span
 style="font-family:monospace"
>@repository_web_url@</span></a>.
Clone it with this URL:
<span style="font-family:monospace"
>@repository_git_url@</span>.
</p>

<div>
<p>
Here is a listing of the dependencies of the code in this repository:
</p>
<ul>
<li> The following dependencies are GPLv3+ licensed:<br>
basename, bash (and its builtins), cat, chmod, cp, cut, date, diff,
dirname, env, find, grep, head, mkdir, mv, realpath, rm, sed,
sha512sum, shellcheck, sort, tail, touch, wc, wget, xargs;
<li> The following dependencies are GPLv2+ licensed:<br>
more, pandoc, pdftex, pdflatex, tree;
<li> The following dependencies are GPLv2 licensed:<br>
git, pylint;
<li> The following dependencies are LGPLv2.1+ licensed:<br>
notify-send;
<li> The following dependencies are MIT licensed:<br>
black, isort, mypy, ruff;
<li> The following dependencies are Apache-2.0 licensed:<br>
bandit;
<li> The following dependencies are BSD-3-Clause licensed:<br>
phpmd;
<li> php is licensed under PHP License v3.01;
<li> tex is licensed under Knuth license;
<li> pcregrep, pcre2grep has a custom license from Cambridge
University, but PCRE2 has BSD-3-Clause WITH PCRE2-exception.
</ul>
</div>

<p>
Remark: Some commands listed under GPLv3+ are POSIX
and can have different implementations under another license;
for example, uutils coreutils is MIT licensed,
whilst GNU coreutils is GPLv3+ licensed.
</p>

<p>
Bash can be found at the following URLs:
<a href="https://www.gnu.org/software/bash/"><span
  style="font-family:monospace"
>https://www.gnu.org/software/bash/</span></a>,
<a href="https://tiswww.case.edu/php/chet/bash/bashtop.html"><span
  style="font-family:monospace"
>https://tiswww.case.edu/php/chet/bash/bashtop.html</span></a>,
<a href="https://savannah.gnu.org/projects/bash/"><span
  style="font-family:monospace"
>https://savannah.gnu.org/projects/bash/</span></a>.
</p>

<p>
GNU coreutils can be found at the following URLs:
<a href="https://www.gnu.org/software/coreutils/"><span
  style="font-family:monospace"
>https://www.gnu.org/software/coreutils/</span></a>,
<a href="https://savannah.gnu.org/projects/coreutils/"><span
  style="font-family:monospace"
>https://savannah.gnu.org/projects/coreutils/</span></a>.
</p>

<p>
uutils coreutils can be found at the following URLs:
<a href="https://uutils.github.io/coreutils/"><span
  style="font-family:monospace"
>https://uutils.github.io/coreutils/</span></a>,
<a href="https://github.com/uutils/coreutils"><span
  style="font-family:monospace"
>https://github.com/uutils/coreutils</span></a>.
</p>

<p>
diff (GNU diffutils) can be found at the following URLs:
<a href="https://www.gnu.org/software/diffutils/"><span
  style="font-family:monospace"
>https://www.gnu.org/software/diffutils/</span></a>,
<a href="https://savannah.gnu.org/projects/diffutils/"><span
  style="font-family:monospace"
>https://savannah.gnu.org/projects/diffutils/</span></a>.
</p>

<p>
find, xargs (GNU findutils) can be found at the following URLs:
<a href="https://www.gnu.org/software/findutils/"><span
  style="font-family:monospace"
>https://www.gnu.org/software/findutils/</span></a>,
<a href="https://savannah.gnu.org/projects/findutils/"><span
  style="font-family:monospace"
>https://savannah.gnu.org/projects/findutils/</span></a>.
</p>

<p>
grep (GNU grep) can be found at the following URLs:
<a href="https://www.gnu.org/software/grep/"><span
  style="font-family:monospace"
>https://www.gnu.org/software/grep/</span></a>,
<a href="https://savannah.gnu.org/projects/grep/"><span
  style="font-family:monospace"
>https://savannah.gnu.org/projects/grep/</span></a>.
</p>

<p>
sed (GNU sed) can be found at the following URLs:
<a href="https://www.gnu.org/software/sed/"><span
  style="font-family:monospace"
>https://www.gnu.org/software/sed/</span></a>,
<a href="https://savannah.gnu.org/projects/sed/"><span
  style="font-family:monospace"
>https://savannah.gnu.org/projects/sed/</span></a>.
</p>

<p>
ShellCheck can be found at the following URLs:
<a href="https://www.shellcheck.net/"><span
  style="font-family:monospace"
>https://www.shellcheck.net/</span></a>,
<a href="https://github.com/koalaman/shellcheck"><span
  style="font-family:monospace"
>https://github.com/koalaman/shellcheck</span></a>.
</p>

<p>
GNU Wget can be found at the following URLs:
<a href="https://www.gnu.org/software/wget/"><span
  style="font-family:monospace"
>https://www.gnu.org/software/wget/</span></a>,
<a href="https://savannah.gnu.org/projects/wget/"><span
  style="font-family:monospace"
>https://savannah.gnu.org/projects/wget/</span></a>.
</p>

<p>
more of util-linux can be found at the following URLs:
<a href="https://www.kernel.org/pub/linux/utils/util-linux/"><span
  style="font-family:monospace"
>https://www.kernel.org/pub/linux/utils/util-linux/</span></a>,
<a
href="https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/"
><span
  style="font-family:monospace"
>https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/</span
></a>,
<a href="https://github.com/util-linux/util-linux"><span
  style="font-family:monospace"
>https://github.com/util-linux/util-linux</span></a> official?
</p>

<p>
pandoc can be found at the following URLs:
<a href="https://pandoc.org/"><span
  style="font-family:monospace"
>https://pandoc.org/</span></a>,
<a href="https://github.com/jgm/pandoc"><span
  style="font-family:monospace"
>https://github.com/jgm/pandoc</span></a>.
</p>

<p>
pdftex/pdflatex can be found at the following URLs:
<a href="https://www.tug.org/applications/pdftex/"><span
  style="font-family:monospace"
>https://www.tug.org/applications/pdftex/</span></a>,
<a href="https://tug.org/texlive/svn/"><span
  style="font-family:monospace"
>https://tug.org/texlive/svn/</span></a>.
</p>

<p>
tree can be found at the following URLs:
<a href="https://oldmanprogrammer.net/source.php?dir=projects/tree"
><span style="font-family:monospace"
>https://oldmanprogrammer.net/source.php?dir=projects/tree</span></a>,
<a href="https://gitlab.com/OldManProgrammer/unix-tree"><span
  style="font-family:monospace"
>https://gitlab.com/OldManProgrammer/unix-tree</span></a>,
<a href="https://github.com/Old-Man-Programmer/tree"><span
  style="font-family:monospace"
>https://github.com/Old-Man-Programmer/tree</span></a>.
</p>

<p>
git can be found at the following URLs:
<a href="https://git-scm.com/about"><span
  style="font-family:monospace"
>https://git-scm.com/about</span></a>,
<a href="https://github.com/git/git"><span
  style="font-family:monospace"
>https://github.com/git/git</span></a>.
</p>

<p>
pylint can be found at the following URLs:
<a href="https://www.pylint.org/"><span
  style="font-family:monospace"
>https://www.pylint.org/</span></a>,
<a href="https://pylint.readthedocs.io/en/stable/"><span
  style="font-family:monospace"
>https://pylint.readthedocs.io/en/stable/</span></a>,
<a href="https://github.com/pylint-dev/pylint"><span
  style="font-family:monospace"
>https://github.com/pylint-dev/pylint</span></a>,
<a href="https://pypi.org/project/pylint/"><span
  style="font-family:monospace"
>https://pypi.org/project/pylint/</span></a>.
</p>

<p>
notify-send can be found at the following URLs:
<a href="https://gitlab.gnome.org/GNOME/libnotify/"><span
  style="font-family:monospace"
>https://gitlab.gnome.org/GNOME/libnotify/</span></a>,
<a href="https://gnome.pages.gitlab.gnome.org/libnotify/"><span
  style="font-family:monospace"
>https://gnome.pages.gitlab.gnome.org/libnotify/</span></a>.
</p>

<p>
black can be found at the following URLs:
<a href="https://github.com/psf/black"><span
  style="font-family:monospace"
>https://github.com/psf/black</span></a>,
<a href="https://black.readthedocs.io/en/stable/"><span
  style="font-family:monospace"
>https://black.readthedocs.io/en/stable/</span></a>,
<a href="https://pypi.org/project/black/"><span
  style="font-family:monospace"
>https://pypi.org/project/black/</span></a>.
</p>

<p>
isort can be found at the following URLs:
<a href="https://pycqa.github.io/isort/"><span
  style="font-family:monospace"
>https://pycqa.github.io/isort/</span></a>,
<a href="https://github.com/pycqa/isort/"><span
  style="font-family:monospace"
>https://github.com/pycqa/isort/</span></a>,
<a href="https://pypi.org/project/isort/"><span
  style="font-family:monospace"
>https://pypi.org/project/isort/</span></a>.
</p>

<p>
mypy can be found at the following URLs:
<a href="https://mypy-lang.org/"><span
  style="font-family:monospace"
>https://mypy-lang.org/</span></a>,
<a href="https://mypy.readthedocs.io/en/stable/"><span
  style="font-family:monospace"
>https://mypy.readthedocs.io/en/stable/</span></a>,
<a href="https://github.com/python/mypy"><span
  style="font-family:monospace"
>https://github.com/python/mypy</span></a>,
<a href="https://pypi.org/project/mypy/"><span
  style="font-family:monospace"
>https://pypi.org/project/mypy/</span></a>.
</p>

<p>
ruff can be found at the following URLs:
<a href="https://docs.astral.sh/ruff/"><span
  style="font-family:monospace"
>https://docs.astral.sh/ruff/</span></a>,
<a href="https://github.com/astral-sh/ruff"><span
  style="font-family:monospace"
>https://github.com/astral-sh/ruff</span></a>,
<a href="https://pypi.org/project/ruff/"><span
  style="font-family:monospace"
>https://pypi.org/project/ruff/</span></a>.
</p>

<p>
bandit can be found at the following URLs:
<a href="https://bandit.readthedocs.io/en/latest/"><span
  style="font-family:monospace"
>https://bandit.readthedocs.io/en/latest/</span></a>,
<a href="https://github.com/PyCQA/bandit"><span
  style="font-family:monospace"
>https://github.com/PyCQA/bandit</span></a>,
<a href="https://pypi.org/project/bandit/"><span
  style="font-family:monospace"
>https://pypi.org/project/bandit/</span></a>.
</p>

<p>
phpmd can be found at the following URLs:
<a href="https://phpmd.org/"><span
  style="font-family:monospace"
>https://phpmd.org/</span></a>,
<a href="https://github.com/phpmd/phpmd"><span
  style="font-family:monospace"
>https://github.com/phpmd/phpmd</span></a>,
<a href="https://packagist.org/packages/phpmd/phpmd"><span
  style="font-family:monospace"
>https://packagist.org/packages/phpmd/phpmd</span></a>.
</p>

<p>
php can be found at the following URLs:
<a href="https://www.php.net/"><span
  style="font-family:monospace"
>https://www.php.net/</span></a>,
<a href="https://github.com/php/php-src"><span
  style="font-family:monospace"
>https://github.com/php/php-src</span></a>.
</p>

<p>
tex can be found at the following URL:
<a href="https://ctan.org/tex-archive/systems/knuth/dist/tex"><span
  style="font-family:monospace"
>https://ctan.org/tex-archive/systems/knuth/dist/tex</span></a>.
</p>

<p>
pcregrep, pcre2grep can be found at the following URLs:
<a href="https://www.pcre.org/"><span
  style="font-family:monospace"
>https://www.pcre.org/</span></a>,
<a href="https://pcre2project.github.io/pcre2/"><span
  style="font-family:monospace"
>https://pcre2project.github.io/pcre2/</span></a>,
<a href="https://github.com/PCRE2Project/pcre1"><span
  style="font-family:monospace"
>https://github.com/PCRE2Project/pcre1</span></a>,
<a href="https://github.com/PCRE2Project/pcre2"><span
  style="font-family:monospace"
>https://github.com/PCRE2Project/pcre2</span></a>,
<a
href="https://github.com/PCRE2Project/pcre2/blob/main/src/pcre2grep.c"
><span
  style="font-family:monospace"
>https://github.com/PCRE2Project/pcre2/blob/main/src/pcre2grep.c</span
></a>.
</p>

<p>
If you see something that I missed regarding my dependencies,
please tell me/email me :).
</p>

@files_listing_HTMLPreInput@

<p>
@acknowledgments@
</p>

<script>
"use strict";
const pres = Array.from(
  document.getElementsByClassName('numbered_lines')
);
pres.forEach(
  (pre) => {
    const nb = Array.from(pre.innerText.matchAll("\n")).length + 1;
    let numbers = "";
    for(let i = 1; i <= nb; ++i){
      numbers += i.toString();
      if(i < nb){ numbers += "\n "; }
    }
    pre.setAttribute('line-numbers', numbers);
  }
);
</script>
</html>
