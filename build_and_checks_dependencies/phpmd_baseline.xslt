<?xml version="1.0" encoding="UTF-8"?>
<!--
This file is part of DevOrSysAdminScripts.

DevOrSysAdminScripts is free software:
you can redistribute it and/or modify it
under the terms of the GNU Lesser General Public License
as published by the Free Software Foundation,
either version 3 of the License,
or (at your option) any later version.

DevOrSysAdminScripts is distributed
in the hope that it will be useful,
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
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.1">
  <xsl:output method="xml"/>
  <xsl:template match="phpmd-baseline">
    <xsl:copy>
      <xsl:apply-templates select="node()">
        <xsl:sort select="@file"/>
        <xsl:sort select="@rule"/>
      </xsl:apply-templates>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="violation">
    <xsl:text>  </xsl:text>
    <xsl:copy>
      <xsl:copy-of select="@*"/>
    </xsl:copy>
    <xsl:text>
</xsl:text>
  </xsl:template>
</xsl:stylesheet>
