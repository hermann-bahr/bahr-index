<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:tei="http://www.tei-c.org/ns/1.0" version="3.0" exclude-result-prefixes="tei">
    <xsl:output method="xhtml" indent="false"/>
    <xsl:mode on-no-match="shallow-copy"/>
    
    <xsl:template match="tei:header"/>
    <xsl:template match="tei:TEI">
        <xsl:apply-templates select="tei:text/tei:body"></xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="tei:body">
            <!--<style type="text/css">.p {
text-indent:-80px;
margin-left:80px}
.b {
padding-left: 40px;
font-style:italic;
}
.fett {
font-weight:bold;
color:#FF8000;
}
.w {font-style:italic;}
</style>-->
<h4><i>Helene Zand</i></h4>

<p><b>Hermann Bahr: Tagebücher, Skizzenbücher, Notizhefte. Hg. Moritz Csáky. Wien, Köln, Weimar: Böhlau 1994-2003</b></p>
<ul>
<li><span class="fett"><b>I</b> 1885—1890. Bearbeitet von Lottelis Moser und Helene Zand, 1994.</span></li>

<li><span class="fett"><b>II</b> 1890–1900. Bearbeitet von Helene Zand, Lukas Mayerhofer und Lottelis Moser, 1996. </span></li>

<li><span class="fett"><b>III</b> 1901–1903. Bearbeitet von Helene Zand und Lukas Mayerhofer, 1997.</span></li>
    
    <li><span class="fett"><b>IV</b> 1904–1905. Bearbeitet von Lukas Mayerhofer und Helene Zand, 2000.</span></li>

<li><span class="fett"><b>V</b> 1906–1908. Bearbeitet von Kurt Ifkovits und Lukas Mayerhofer, 2003.</span>
        
</li></ul>
    
        <xsl:apply-templates select="tei:listPerson"/>
        
    </xsl:template>
    
    <xsl:template match="tei:listPerson">
        <ul>
            <xsl:apply-templates/>
        </ul>
    </xsl:template>
    
    <xsl:template match="tei:person">
        <dl>
        <dt>
            <xsl:for-each select="tei:persName">
                <xsl:choose>
                    <xsl:when test="@type='alt' or starts-with(@type,'geburtsname')">
                        <xsl:text>geb. </xsl:text>
                    </xsl:when>
                    <xsl:when test="@type='pseudonym'">
                        <xsl:text>Pseudonym </xsl:text>
                    </xsl:when>
                    <xsl:when test="@type='rufname'">
                        <xsl:text>gen. </xsl:text>
                    </xsl:when>
                </xsl:choose>
                <xsl:choose>
                    <xsl:when test="tei:surname and tei:forename">
                        <xsl:value-of select="tei:surname"/><xsl:text>, </xsl:text><xsl:value-of select="tei:forename"/>
                    </xsl:when>
                    <xsl:when test="tei:surname">
                        <xsl:value-of select="tei:surname"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="tei:forename"/>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:if test="not(position()=last())">
                    <xsl:text>, </xsl:text>
                </xsl:if>
            </xsl:for-each>
            <xsl:choose>
                <xsl:when test="tei:birth/tei:date and tei:death/tei:date">
                    <xsl:value-of select="concat(' (', tei:birth/tei:date, '–', tei:death/tei:date, ')')"/>
                </xsl:when>
                <xsl:when test="tei:birth/tei:date">
                    <xsl:value-of select="concat(' (* ', tei:birth/tei:date,')')"/>
                </xsl:when>
                <xsl:when test="tei:death/tei:date">
                    <xsl:value-of select="concat(' († ', tei:death/tei:date,')')"/>
                </xsl:when>
            </xsl:choose>
        </dt>
        <dd>
           <xsl:if test="tei:occupation">
              <p><i><xsl:value-of select="tei:occupation"/></i></p>
           </xsl:if>
            <xsl:if test="tei:note[not(@type)]">
                <p><i><xsl:value-of select="tei:note[not(@type)]"/></i></p>
            </xsl:if>
            <xsl:apply-templates select="tei:idno"/>
            <xsl:apply-templates select="tei:listBibl"/>
        </dd>
        </dl>
    </xsl:template>
    
    <xsl:template match="tei:idno">
        <xsl:variable name="band" select="@subtype"/>
        <xsl:variable name="bandname">
            <xsl:choose>
                
                <xsl:when test="$band='vol1'">
                    <span class="fett"> I: </span>
                </xsl:when>
                <xsl:when test="$band='vol2'">
                    <span class="fett"> II: </span>
                </xsl:when>
                <xsl:when test="$band='vol3'">
                    <span class="fett"> III: </span>
                </xsl:when>
                <xsl:when test="$band='vol4'">
                    <span class="fett"> IV: </span>
                </xsl:when>
                <xsl:when test="$band='vol5'">
                    <span class="fett"> V: </span>
                </xsl:when>
                <xsl:otherwise>
                    <span class="fett"> Band offen: </span>
                </xsl:otherwise>
            </xsl:choose>
            
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="not(preceding-sibling::tei:idno)">
                <xsl:value-of select="concat($bandname, ' ', .)"/>
            </xsl:when>
            <xsl:when test="preceding-sibling::tei:idno[1][@subtype= $band]">
                <xsl:value-of select="concat(', ', .)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat(', ', $bandname, ' ', .)"/>
            </xsl:otherwise>
            
        </xsl:choose>
        
    </xsl:template>
    
    <xsl:template match="tei:listBibl">
        <ul>
            <li>
           <dl>
            <xsl:apply-templates/>
           </dl>
            </li>
        </ul>
    </xsl:template>
    
    <xsl:template match="tei:bibl">
        <dt>
            <xsl:for-each select="tei:title">
                <xsl:choose>
                    <xsl:when test="position()=1">
                        <i><xsl:value-of select="normalize-space(.)"/></i>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text> (</xsl:text><i>
                        <xsl:value-of select="normalize-space(.)"/></i>
                        <xsl:text>)</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </dt>
        <dd>
            <xsl:apply-templates select="tei:idno"/>
            
        </dd>
    </xsl:template>
   
</xsl:stylesheet>
