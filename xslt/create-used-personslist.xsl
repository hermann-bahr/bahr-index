<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <xsl:mode on-no-match="shallow-skip"/>
    <xsl:output method="xml" indent="yes"/>
    <!-- Match all descendants of <ptr> elements with type="pmb" -->
    
    <xsl:template match="/">
        <xsl:element name="list">
            <xsl:apply-templates select="descendant::tei:ptr[@type='pmb']"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="//tei:ptr[@type='pmb']">
        
        <!-- For each unique value of the target attribute -->
        <xsl:for-each-group select="@target" group-by=".">
            
            <!-- Output the distinct value -->
            <xsl:element name="item" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:value-of select="current-grouping-key()" />
            </xsl:element>
            
        </xsl:for-each-group>
    </xsl:template>
    
</xsl:stylesheet>