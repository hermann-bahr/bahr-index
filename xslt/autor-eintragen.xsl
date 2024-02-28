<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions" version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:param name="listperson" select="document('../TSN/listPerson_TSN_1.xml')"></xsl:param>
    <xsl:key name="person-nachschlagen" match="//tei:body/tei:listPerson/tei:person" use="tei:idno[@type='TSN']"/>
    
    <xsl:template match="tei:author[@ref]">
        <xsl:element name="author" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:variable name="autor-ref" select="key('person-nachschlagen', @ref, $listperson)[1]" as="node()"/>
            <xsl:attribute name="ref">
                
                <xsl:choose>
                    <xsl:when test="$autor-ref/@xml:id">
                        <xsl:value-of select="concat('#', $autor-ref/@xml:id)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat('SEX', @ref)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:copy-of select="$autor-ref/tei:persName[1]"/>
        </xsl:element>
        
        
    </xsl:template>
    
</xsl:stylesheet>
