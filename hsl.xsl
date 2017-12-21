<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    <xsl:template match="/">
        <html>
            <head>
                <title>HSL to HTML XSLT Transform</title>
                <style>
                    table, tr, td, th { border-style: solid; border-width: 1px; padding: 2px; }
                </style>
            </head>
            <body>
                <h1>HSL to HTML XSLT Transform</h1>

                <h2>Songs</h2>
                <table>
                    <tr>
                        <th>Title</th>
                        <th>Artist</th>
                        <th>Source</th>
                    </tr>
                    <xsl:apply-templates select="/hsl/songs//entry">
                        <xsl:sort select="title"/>
                        <xsl:sort select="artist"/>
                        <xsl:sort select="source"/>
                    </xsl:apply-templates>
                </table>
                <hr/>
                <h2>Artists</h2>
                <xsl:apply-templates select="/hsl/artists//entry">
                    <xsl:sort/>
                </xsl:apply-templates>
                <hr/>
                <h2>Sources</h2>
                <xsl:apply-templates select="/hsl/sources//entry">
                    <xsl:sort/>
                </xsl:apply-templates>
                <h2>Series</h2>
                <xsl:apply-templates select="/hsl/series//entry">
                    <xsl:sort/>
                </xsl:apply-templates>

            </body>
        </html>
    </xsl:template>
    <xsl:template match="songs/entry">
        <tr>
            <td>
                <a>
                    <xsl:attribute name="name">
                        <xsl:value-of select="./@id"/>
                    </xsl:attribute>
                </a>
                <xsl:value-of select="title"/>
            </td>
            <td>
                <a>
                    <xsl:attribute name="href">#<xsl:value-of select="artist/@id"/>
                    </xsl:attribute>
                    <xsl:value-of select="artist"/>
                </a>
            </td>
            <td>
                <a>
                    <xsl:attribute name="href">#<xsl:value-of select="source/@id"/>
                    </xsl:attribute>
                    <xsl:choose>
                        <xsl:when test="./source = ''">
                            [EMPTY]
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of
                                    select="source"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </a>
            </td>
        </tr>
    </xsl:template>
    <xsl:template match="artists/entry">
        <xsl:variable name="artistId" select="./@id"/>
        <a>
            <xsl:attribute name="name">
                <xsl:value-of select="./@id"/>
            </xsl:attribute>
        </a>
        <h3>
            <xsl:choose>
                <xsl:when test="./name = ''">[EMPTY]</xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="name"/>
                </xsl:otherwise>
            </xsl:choose>
        </h3>
        <ul>
            <xsl:for-each select="/hsl/songs/entry">
                <xsl:sort/>
                <xsl:if test="./artist/@id = $artistId">
                    <li>
                        <a>
                            <xsl:attribute name="href">#<xsl:value-of select="./@id"/>
                            </xsl:attribute>
                            <xsl:value-of
                                    select="title"/>
                        </a>
                    </li>
                </xsl:if>
            </xsl:for-each>
        </ul>
    </xsl:template>
    <xsl:template match="sources/entry">
        <xsl:variable name="sourceId" select="./@id"/>
        <a>
            <xsl:attribute name="name">
                <xsl:value-of select="./@id"/>
            </xsl:attribute>
        </a>
        <h3>
            <xsl:choose>
                <xsl:when test="./name = ''">[EMPTY]</xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="name"/>
                </xsl:otherwise>
            </xsl:choose>
        </h3>
        <h4>Series</h4>
        <ul>
            <xsl:call-template name="lookupSeries">
                <xsl:with-param name="source" select="./series/@id"/>
            </xsl:call-template>
            <!--series-->
        </ul>
        <h4>Sources</h4>
        <ul>
            <xsl:for-each select="/hsl/songs/entry">
                <xsl:sort/>
                <xsl:if test="./source/@id = $sourceId">
                    <li>
                        <a>
                            <xsl:attribute name="href">#<xsl:value-of select="./@id"/>
                            </xsl:attribute>
                            <xsl:value-of
                                    select="title"/>
                        </a>
                    </li>
                </xsl:if>
            </xsl:for-each>
        </ul>
    </xsl:template>
    <xsl:template match="series/entry">
        <xsl:variable name="seriesId" select="./@id"/>
        <a>
            <xsl:attribute name="name">
                <xsl:value-of select="./@id"/>
            </xsl:attribute>
        </a>
        <h3>
            <xsl:choose>
                <xsl:when test="./name = ''">[EMPTY]</xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="name"/>
                </xsl:otherwise>
            </xsl:choose>
        </h3>
        <ul>
            <xsl:for-each select="/hsl/sources/entry">
                <xsl:sort/>
                <xsl:if test="./series/@id = $seriesId">
                    <li>
                        <a>
                            <xsl:attribute name="href">#<xsl:value-of select="./@id"/>
                            </xsl:attribute>
                            <xsl:value-of
                                    select="./name"/>
                        </a>
                    </li>
                </xsl:if>
            </xsl:for-each>
        </ul>
    </xsl:template>
    <xsl:template name="lookupSeries">
        <xsl:param name="source"/>
        <xsl:for-each select="/hsl/series/entry">
            <xsl:if test="./@id = $source">
                <li>
                    <a>
                        <xsl:attribute name="href">#<xsl:value-of select="./@id"/>
                        </xsl:attribute>
                        <xsl:value-of
                                select="./name"/>
                    </a>
                </li>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>