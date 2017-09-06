<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:template match="/">
        <html>
            <head>
                <title>HSL to HTML XSLT Transform</title>
            </head>
            <body>
                <h1>HSL to HTML XSLT Transform</h1>
                <!--Songs-->
                <h2>Songs</h2>
                <table>
                    <tr>
                        <th>Title</th>
                        <th>Artist</th>
                        <th>Source</th>
                    </tr>
                    <xsl:for-each select="hsl/songs/entry">
                        <xsl:sort select="title"/>
                        <tr>
                            <td>
                                <a>
                                    <xsl:attribute name="name">
                                        <xsl:value-of select="@id"/>
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
                                    <xsl:value-of select="source"/>
                                </a>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
                <!--Artists-->
                <h2>Artists</h2>
                <table>
                    <xsl:for-each select="hsl/artists/entry">
                        <xsl:sort select="name"/>
                        <xsl:variable name="artistId" select="@id"/>
                        <a>
                            <xsl:attribute name="name">
                                <xsl:value-of select="$artistId"/>
                            </xsl:attribute>
                        </a>
                        <xsl:choose>
                            <xsl:when test="name = ''">
                                <h3>[EMPTY]</h3>
                            </xsl:when>
                            <xsl:otherwise>
                                <h3>
                                    <xsl:value-of select="name"/>
                                </h3>
                            </xsl:otherwise>
                        </xsl:choose>
                        <h4>Songs</h4>
                        <ul>
                            <xsl:for-each select="/hsl/songs/entry">
                                <xsl:variable name="songId" select="@id"/>
                                <xsl:if test="$artistId = artist/@id">
                                    <li>
                                        <a>
                                            <xsl:attribute name="href">#<xsl:value-of select="$songId"/>
                                            </xsl:attribute>
                                            <xsl:value-of
                                                    select="title"/>
                                        </a>
                                    </li>
                                </xsl:if>
                            </xsl:for-each>
                        </ul>
                    </xsl:for-each>
                </table>
                <!--Sources-->
                <h2>Sources</h2>
                <table>
                    <xsl:for-each select="hsl/sources/entry">
                        <xsl:sort select="name"/>
                        <xsl:variable name="sourceId" select="@id"/>
                        <xsl:variable name="seriesId" select="series/@id"/>
                        <a>
                            <xsl:attribute name="name">
                                <xsl:value-of select="$sourceId"/>
                            </xsl:attribute>
                        </a>
                        <xsl:choose>
                            <xsl:when test="name = ''">
                                <h3>[EMPTY]</h3>
                            </xsl:when>
                            <xsl:otherwise>
                                <h3>
                                    <xsl:value-of select="name"/>
                                </h3>
                            </xsl:otherwise>
                        </xsl:choose>

                        <h4>Series</h4>
                        <ul>
                            <xsl:for-each select="/hsl/series/entry">
                                <xsl:if test="@id = $seriesId">
                                    <li>
                                        <a>
                                            <xsl:attribute name="href">#<xsl:value-of select="$seriesId"/>
                                            </xsl:attribute>
                                            <xsl:value-of
                                                    select="name"/>
                                        </a>
                                    </li>
                                </xsl:if>
                            </xsl:for-each>
                        </ul>
                        <h4>Songs</h4>
                        <ul>
                            <xsl:for-each select="/hsl/songs/entry">
                                <xsl:variable name="songId" select="@id"/>
                                <xsl:if test="$sourceId = source/@id">
                                    <li>
                                        <a>
                                            <xsl:attribute name="href">#<xsl:value-of select="$songId"/>
                                            </xsl:attribute>
                                            <xsl:value-of
                                                    select="title"/>
                                        </a>
                                    </li>
                                </xsl:if>
                            </xsl:for-each>
                        </ul>
                    </xsl:for-each>
                </table>
                <!--Series-->
                <h2>Series</h2>
                <table>
                    <xsl:for-each select="hsl/series/entry">
                        <xsl:sort select="name"/>
                        <xsl:variable name="seriesId" select="@id"/>
                        <a>
                            <xsl:attribute name="name">
                                <xsl:value-of select="$seriesId"/>
                            </xsl:attribute>
                        </a>
                        <xsl:choose>
                            <xsl:when test="name = ''">
                                <h3>[EMPTY]</h3>
                            </xsl:when>
                            <xsl:otherwise>
                                <h3>
                                    <xsl:value-of select="name"/>
                                </h3>
                            </xsl:otherwise>
                        </xsl:choose>
                        <ul>
                            <xsl:for-each select="/hsl/sources/entry">
                                <xsl:variable name="sourceId" select="@id"/>
                                <xsl:if test="$seriesId = series/@id">
                                    <li>
                                        <a>
                                            <xsl:attribute name="href">#<xsl:value-of select="$sourceId"/>
                                            </xsl:attribute>
                                            <xsl:value-of
                                                    select="name"/>
                                        </a>
                                    </li>
                                </xsl:if>
                            </xsl:for-each>
                        </ul>
                    </xsl:for-each>
                </table>

            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>