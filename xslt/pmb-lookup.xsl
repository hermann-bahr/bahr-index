<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output method="xml" indent="yes"/>
    <xsl:param name="pmblistperson" select="document('../../bahr-textverzeichnis-data/pmblistperson.xml')"/>
    <xsl:key name="pmb" match="//*:listPerson[1]/*:person" composite="no"
        use="*:idno[@subtype = 'hermanbahrtextverzeichnis']"/>
    <xsl:template match="tei:person">
        <xsl:element name="person" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="xml:id">
                <xsl:value-of
                    select="key('pmb', concat('https://hermanbahrtextverzeichnis/', @xml:id), $pmblistperson)/@xml:id"
                />
            </xsl:attribute>
            <xsl:copy-of select="*"/>
            <xsl:apply-templates select="tei:idno[@type = 'TSN']"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:idno[@type = 'TSN']">
        <xsl:element name="idno" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="type">
                <xsl:text>bahr-TSN</xsl:text>
            </xsl:attribute>
            <xsl:value-of
                select="concat('https://bahr.univie.ac.at/node/49702?URI=', key('pmb', concat('https://hermanbahrtextverzeichnis/', .), $pmblistperson)/@xml:id)"
            />
        </xsl:element>
    </xsl:template>
    
    
    
    
</xsl:stylesheet>
