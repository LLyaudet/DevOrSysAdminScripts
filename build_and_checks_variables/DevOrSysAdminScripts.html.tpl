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

©Copyright 2023-2025 Laurent Frédéric Bernard François Lyaudet
-->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="generator" content="DevOrSysAdminScripts">
<style type="text/css">
.title{
  margin: 2ex auto;
  text-align: center;
}
.titlemain{
  margin: 1ex 2ex 2ex 1ex;
}
.titlerest{
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
</style>
<title>@repository_name@</title>
</head>
<body >
<table class="title">
  <tr>
    <td style="padding:1ex">
      <h1 class="titlemain">@repository_name@</h1>
      <h3 class="titlerest">
        @author_full_name@
        <br>
        <a href="@author_website@">
          <span style="font-family:monospace">@author_website@</span>
        </a>
        <br>
        <a href="mailto:@author_email@">
          <span style="font-family:monospace">@author_email@</span>
        </a>
      </h3>
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
<p>Code lines: @number_of_lines@</p>


<h2 id="section1">1 Files tree</h2>
<pre class="verbatim">@current_tree_light@</pre>
<pre class="verbatim">@current_tree@</pre>


<h2 id="section2">2 Listing of files</h2>
<p>The following source code is covered by LGPLv3+.
The text of the license is available at:
<a href="https://www.gnu.org/licenses/"><span
  style="font-family:monospace"
>https://www.gnu.org/licenses/</span></a>.
The git repository of this source code is also available at:
<a href="https://github.com/LLyaudet/@repository_name@/"><span
  style="font-family:monospace"
>https://github.com/LLyaudet/@repository_name@/</span></a>.</p>

@files_listing_HTMLPreInput@

<p>@acknowledgments@</p>

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
