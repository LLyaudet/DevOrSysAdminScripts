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
sha512sum, shellcheck, sort, tail, touch, wc, wget, xargs
<li> The following dependencies are GPLv2+ licensed:<br>
more, pandoc, pdftex, pdflatex, tree
<li> The following dependencies are GPLv2 licensed:<br>
git, pylint
<li> The following dependencies are LGPLv2.1+ licensed:<br>
notify-send
<li> The following dependencies are MIT licensed:<br>
black, isort, mypy, ruff
<li> The following dependencies are Apache-2.0 licensed:<br>
bandit
<li> The following dependencies are BSD-3-Clause licensed:<br>
phpmd
<li> php is licensed under PHP License v3.01
<li> tex is licensed under Knuth license
<li> pcregrep has a custom license from Cambridge University
</ul>
</div>

<p>
Remark: Some commands listed under GPLv3+ are POSIX
and can have different implementations under another license;
for example, uutils coreutils is MIT licensed,
whilst GNU coreutils is GPLv3+ licensed.
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
