<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:tei="http://www.tei-c.org/ns/1.0" version="3.0" exclude-result-prefixes="tei">
    <xsl:output method="xml" indent="true"/>
    <xsl:mode on-no-match="shallow-skip"/>
<!-- Das angwandt auf die ursprüngliche listPerson holt die Werke raus -->

        <xsl:template match="tei:listPerson">
            <xsl:element name="listBibl" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:for-each select="tei:person[tei:listBibl]">
                    <xsl:variable name="author" select="@xml:id"/>
                    <xsl:for-each select="tei:listBibl/tei:bibl">
                        <xsl:element name="bibl" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:copy-of select="@*|node()"/>
                            <xsl:element name="author">
                                <xsl:attribute name="ref">
                                    <xsl:value-of select="$author"/>
                                </xsl:attribute>
                            </xsl:element>
                        </xsl:element>
                    </xsl:for-each>
                    
                    
                    
                    
                </xsl:for-each>
                
                
                
                
            </xsl:element>
            
            
        </xsl:template>
        
        
</xsl:stylesheet>
