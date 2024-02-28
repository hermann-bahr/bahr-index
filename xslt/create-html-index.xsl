<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:mam="whatever" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0"
    exclude-result-prefixes="xsl tei xs">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes"
        omit-xml-declaration="yes"/>
    <xsl:param name="listwerk" select="document('../TSN/listwork_TSN_1.xml')"></xsl:param>
    <xsl:key name="werke-nachschlagen" match="tei:body/tei:listBibl/tei:bibl" use="tei:author/@ref"></xsl:key>
    
    <xsl:template match="tei:TEI">
        <h2>
            <strong>Hermann Bahr: Tagebücher, Skizzenbücher, Notizhefte. Hg. Moritz Csáky. Wien, Köln, Weimar: Böhlau 1994-2003</strong>
        </h2>
        <ul>
            <li>
                <span class="fett"><strong>I</strong> 1885—1890. Bearbeitet von Lottelis Moser und Helene Zand, 1994.</span>
            </li>
            <li>
                <span class="fett"><strong>II</strong> 1890–1900. Bearbeitet von Helene Zand, Lukas Mayerhofer und Lottelis Moser, 1996.</span>
            </li>
            <li>
                <span class="fett"><strong>III</strong> 1901–1903. Bearbeitet von Helene Zand und Lukas Mayerhofer, 1997.</span>
            </li>
            <li>
                <span class="fett"><strong>IV</strong> 1904–1905. Bearbeitet von Lukas Mayerhofer und Helene Zand, 2000.</span>
            </li>
            <li>
                <span class="fett"><strong>V</strong> 1906–1908. Bearbeitet von Kurt Ifkovits und Lukas Mayerhofer, 2003.</span>
            </li>
        </ul>
        
        <ul>
        <xsl:apply-templates select="descendant::tei:body/tei:listPerson/tei:person"/>
        </ul>
        
        
    </xsl:template>
    
    <xsl:template match="tei:listPerson/tei:person">
        <xsl:variable name="current" as="node()" select="."/>
        <li>
            <xsl:attribute name="id">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
            <xsl:variable name="lemma-name" select="tei:persName[(position() = 1)]" as="node()"/>
            <xsl:variable name="namensformen" as="node()">
                <xsl:element name="listPerson">
                    <xsl:for-each select="descendant::tei:persName[not(position() = 1)]">
                        <xsl:copy-of select="."/>
                    </xsl:for-each>
                </xsl:element>
            </xsl:variable>
            <b><xsl:choose>
                <xsl:when test="$lemma-name/tei:forename and $lemma-name/tei:surname">
                    <xsl:value-of select="concat($lemma-name/tei:surname[1], ', ', $lemma-name/tei:forename[1])"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$lemma-name/tei:forename"/>
                    <xsl:value-of select="$lemma-name/tei:surname"/>
                </xsl:otherwise>
            </xsl:choose></b>
            <xsl:choose>
                <xsl:when test="$namensformen/descendant::tei:persName[1]">
                    <xsl:text>, </xsl:text>
                    <xsl:for-each select="$namensformen/descendant::tei:persName">
                        <xsl:choose>
                            <xsl:when test="descendant::*">
                                <xsl:text> </xsl:text>
                                <!-- den Fall dürfte es eh nicht geben, aber löschen braucht man auch nicht -->
                                <xsl:choose>
                                    <xsl:when test="./tei:forename/text() and ./tei:surname/text()">
                                        <xsl:value-of
                                            select="concat(./tei:forename/text(), ' ', ./tei:surname/text())"
                                        />
                                    </xsl:when>
                                    <xsl:when test="./tei:forename/text()">
                                        <xsl:value-of select="./tei:forename/text()"/>
                                    </xsl:when>
                                    <xsl:when test="./tei:surname/text()">
                                        <xsl:value-of select="./tei:surname/text()"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="."/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text> </xsl:text>
                                <xsl:choose>
                                    <xsl:when
                                        test="@type = 'person_geburtsname_vorname' and $namensformen/descendant::tei:persName[@type = 'person_geburtsname_nachname']">
                                        <xsl:text>geboren </xsl:text>
                                        <xsl:value-of
                                            select="concat(., ' ', $namensformen/descendant::tei:persName[@type = 'person_geburtsname_nachname'][1])"
                                        />
                                    </xsl:when>
                                    <xsl:when
                                        test="@type = 'person_geburtsname_nachname' and $namensformen/descendant::tei:persName[@type = 'person_geburtsname_vorname'][1]"/>
                                    <xsl:when test="@type = 'person_geburtsname_nachname'">
                                        <xsl:text>geboren </xsl:text>
                                        <xsl:value-of select="."/>
                                    </xsl:when>
                                    <xsl:when test="@type = 'person_geburtsname_vorname'">
                                        <xsl:text>geboren </xsl:text>
                                        <xsl:value-of select="concat(., ' ', $lemma-name//tei:surname)"/>
                                    </xsl:when>
                                    <xsl:when test="@type = 'person_adoptierter-nachname'">
                                        <xsl:text>Nachname durch Adoption </xsl:text>
                                        <xsl:value-of select="."/>
                                    </xsl:when>
                                    <xsl:when test="@type = 'person_variante-nachname_vorname'">
                                        <xsl:text>Namensvariante </xsl:text>
                                        <xsl:value-of select="."/>
                                    </xsl:when>
                                    <xsl:when test="@type = 'person_namensvariante'">
                                        <xsl:text>Namensvariante </xsl:text>
                                        <xsl:value-of select="."/>
                                    </xsl:when>
                                    <xsl:when test="@type = 'person_rufname'">
                                        <xsl:text>Rufname </xsl:text>
                                        <xsl:value-of select="."/>
                                    </xsl:when>
                                    <xsl:when test="@type = 'person_pseudonym'">
                                        <xsl:text>Pseudonym </xsl:text>
                                        <xsl:value-of select="."/>
                                    </xsl:when>
                                    <xsl:when test="@type = 'person_ehename'">
                                        <xsl:text>Ehename </xsl:text>
                                        <xsl:value-of select="."/>
                                    </xsl:when>
                                    <xsl:when test="@type = 'person_geschieden'">
                                        <xsl:text>geschieden </xsl:text>
                                        <xsl:value-of select="."/>
                                    </xsl:when>
                                    <xsl:when test="@type = 'person_verwitwet'">
                                        <xsl:text>verwitwet </xsl:text>
                                        <xsl:value-of select="."/>
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
            <xsl:text> </xsl:text>
            <xsl:if test="$current/tei:birth or $current/tei:death">
                <xsl:value-of select="concat('(', mam:lebensdaten($current[1]), ')')"/>
            </xsl:if>
            
            <xsl:if test="$current//tei:occupation">
                <xsl:variable name="entity" select="$current"/>
                <xsl:text>, </xsl:text>
                <xsl:if test="$entity/descendant::tei:occupation">
                    <i>
                        <xsl:for-each select="$entity/descendant::tei:occupation">
                            <xsl:variable name="beruf" as="xs:string">
                                <xsl:choose>
                                    <xsl:when test="contains(., '&gt;&gt;')">
                                        <xsl:value-of select="tokenize(., '&gt;&gt;')[last()]"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="."/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:variable>
                            <xsl:choose>
                                <xsl:when test="$entity/tei:sex/@value = 'male'">
                                    <xsl:value-of select="tokenize($beruf, '/')[1]"/>
                                </xsl:when>
                                <xsl:when test="$entity/tei:sex/@value = 'female'">
                                    <xsl:value-of select="tokenize($beruf, '/')[2]"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="$beruf"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="not(position() = last())">
                                <xsl:text>, </xsl:text>
                            </xsl:if>
                        </xsl:for-each>
                    </i>
                </xsl:if>
            </xsl:if>
            <xsl:variable name="listBibl" select="tei:listBibl" as="node()?"/>
            <xsl:if test="$listBibl/child::*[1]">
                <dl>
            <xsl:for-each select="distinct-values(tei:listBibl/tei:bibl/tei:biblScope[@unit='volume'])">
                <xsl:sort select="."/>
                <xsl:variable name="volume" select="."/>
                <dt><xsl:value-of select="$volume"/></dt>
                <dd>
                <xsl:for-each select="$listBibl/tei:bibl[tei:biblScope[@unit='volume'] = $volume]">
                    <xsl:value-of select="tei:biblScope[@unit='page']"/>
                    <xsl:if test="not(position()=last())">
                        <xsl:text>, </xsl:text>
                    </xsl:if>
                </xsl:for-each>
                </dd>
            </xsl:for-each>
                </dl>
            </xsl:if>
            <xsl:variable name="autor-id" select="tei:idno[@type='TSN']"/>
            <xsl:if test="key('werke-nachschlagen', $autor-id, $listwerk)[1]/child::*">
                <ul>
            <xsl:for-each select="key('werke-nachschlagen', tei:idno[@type='TSN'], $listwerk)">
                <li>
                    <xsl:if test="tei:author[2]">
                        <xsl:text>(mit </xsl:text>
                        <xsl:for-each select="tei:author[not(@ref=$autor-id)]">
                            <xsl:value-of select="."/>
                        </xsl:for-each>
                        <xsl:text>)</xsl:text>
                    </xsl:if>                    
                    <b><i><xsl:value-of select="tei:title"/></i></b>
                    <xsl:variable name="listBibl" select="tei:listBibl" as="node()?"/>
                    <xsl:if test="$listBibl/child::*[1]">
                        <dl>
                            <xsl:for-each select="distinct-values(tei:listBibl/tei:bibl/tei:biblScope[@unit='volume'])">
                                <xsl:sort select="."/>
                                <xsl:variable name="volume" select="."/>
                                <dt><xsl:value-of select="$volume"/></dt>
                                <dd>
                                    <xsl:for-each select="$listBibl/tei:bibl[tei:biblScope[@unit='volume'] = $volume]">
                                        <xsl:value-of select="tei:biblScope[@unit='page']"/>
                                        <xsl:if test="not(position()=last())">
                                            <xsl:text>, </xsl:text>
                                        </xsl:if>
                                    </xsl:for-each>
                                </dd>
                            </xsl:for-each>
                        </dl>
                    </xsl:if>
                </li>
                
            </xsl:for-each>
                </ul>
            </xsl:if>
            
            
            
        </li>
        
        
    </xsl:template>
    <xsl:function name="mam:lebensdaten">
        <xsl:param name="entity" as="node()"/>
        <xsl:variable name="geburtsort" as="xs:string?" select="$entity/tei:birth[1]/tei:settlement[1]/tei:placeName[1]"/>
        <xsl:variable name="geburtsdatum" as="xs:string?" select="mam:normalize-date($entity/tei:birth[1]/tei:date[1]/text())[1]"/>
        <xsl:variable name="todessort" as="xs:string?" select="$entity/tei:death[1]/tei:settlement[1]/tei:placeName[1]"/>
        <xsl:variable name="todesdatum" as="xs:string?" select="mam:normalize-date($entity/tei:death[1]/tei:date[1]/text())[1]"/>
        <xsl:variable name="geburtsstring" as="xs:string?">
            <xsl:choose>
                <xsl:when test="$geburtsort != ''">
                    <xsl:value-of select="concat($geburtsdatum, ' ', $geburtsort)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$geburtsdatum"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="todesstring" as="xs:string?">
            <xsl:choose>
                <xsl:when test="$todessort != ''">
                    <xsl:value-of select="concat($todesdatum, ' ', $todessort)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$todesdatum"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="normalize-space($geburtsstring) != '' and normalize-space($todesstring) != ''">
                <xsl:value-of select="concat($geburtsstring, ' – ', $todesstring)"/>
            </xsl:when>
            <xsl:when test="normalize-space($geburtsstring) != ''">
                <xsl:value-of select="concat('* ', $geburtsstring)"/>
            </xsl:when>
            <xsl:when test="normalize-space($todesstring) !=''">
                <xsl:value-of select="concat('† ', $todesstring)"/>
            </xsl:when>
        </xsl:choose>
    </xsl:function>
    <xsl:function name="mam:normalize-date">
        <xsl:param name="date-string-mit-spitze" as="xs:string?"/>
        <xsl:variable name="date-string" as="xs:string">
            <xsl:choose>
                <xsl:when test="contains($date-string-mit-spitze, '&lt;')">
                    <xsl:value-of select="substring-before($date-string-mit-spitze, '&lt;')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$date-string-mit-spitze"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:analyze-string select="$date-string" regex="^(\d{{4}})-(\d{{2}})-(\d{{2}})$">
            <xsl:matching-substring>
                <xsl:variable name="year" select="xs:integer(regex-group(1))"/>
                <xsl:variable name="month">
                    <xsl:choose>
                        <xsl:when test="starts-with(regex-group(2), '0')">
                            <xsl:value-of select="substring(regex-group(2), 2)"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="regex-group(2)"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="day">
                    <xsl:choose>
                        <xsl:when test="starts-with(regex-group(3), '0')">
                            <xsl:value-of select="substring(regex-group(3), 2)"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="regex-group(3)"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:value-of select="concat($day, '. ', $month, '. ', $year)"/>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:analyze-string select="." regex="^(\d{{2}}).(\d{{2}}).(\d{{4}})$">
                    <xsl:matching-substring>
                        <xsl:variable name="year" select="xs:integer(regex-group(3))"/>
                        <xsl:variable name="month">
                            <xsl:choose>
                                <xsl:when test="starts-with(regex-group(2), '0')">
                                    <xsl:value-of select="substring(regex-group(2), 2)"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="regex-group(2)"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:variable name="day">
                            <xsl:choose>
                                <xsl:when test="starts-with(regex-group(1), '0')">
                                    <xsl:value-of select="substring(regex-group(1), 2)"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="regex-group(1)"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:value-of select="concat($day, '. ', $month, '. ', $year)"/>
                    </xsl:matching-substring>
                    <xsl:non-matching-substring>
                        <xsl:value-of select="."/>
                    </xsl:non-matching-substring>
                </xsl:analyze-string>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:function>
    
</xsl:stylesheet>