<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:tei="http://www.tei-c.org/ns/1.0" version="3.0" exclude-result-prefixes="tei">
    <xsl:output method="xml" indent="true"/>
    <xsl:mode on-no-match="shallow-copy"/>



   <!-- <xsl:template match="//text()[not(normalize-space(.)='') and preceding-sibling::vol[1]]">
        <xsl:for-each select="tokenize(., ',')">
            <xsl:element name="pp">
                <xsl:value-of select="normalize-space(replace(.,',',''))"/>
            </xsl:element>
        </xsl:for-each>
</xsl:template>
-->
    
   <!-- <xsl:template match="//person[following-sibling::*[1][name()='work']]">
        <xsl:element name="person">
            <xsl:copy-of select="@*"/>
            <xsl:value-of select="text()"/>
            <xsl:copy-of select="*"/>
            <xsl:copy-of select="following-sibling::*[1][name()='work']"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="//work[preceding-sibling::*[1][name()='person']]"/>

    -->
  <!--  
    <xsl:template match="text()">
        <xsl:analyze-string select="." regex="(\()(\d{{4}})–(\d{{4}})\)|(\()(\d{{4}})-(\d{{4}})\)">
            <xsl:matching-substring>
                <xsl:element name="date" inherit-namespaces="true">
                    <xsl:attribute name="type">
                        <xsl:text>birth</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="regex-group(2)"/>
                </xsl:element>
                <xsl:element name="date" inherit-namespaces="true">
                    <xsl:attribute name="type">
                        <xsl:text>death</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="regex-group(3)"/>
                </xsl:element>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:analyze-string select="." regex="(\(?–)(\d{{4}})\)|(\(?-)(\d{{4}})\)">
                    <xsl:matching-substring>
                        <xsl:element name="date" inherit-namespaces="true">
                            <xsl:attribute name="type">
                                <xsl:text>death</xsl:text>
                            </xsl:attribute>
                            <xsl:value-of select="regex-group(2)"/>
                        </xsl:element>
                    </xsl:matching-substring>
                    <xsl:non-matching-substring>
                        <xsl:analyze-string select="." regex="(\()(\d{{4}})–?\)|(\()(\d{{4}})-?\)">
                            <xsl:matching-substring>
                                <xsl:element name="date" inherit-namespaces="true">
                                    <xsl:attribute name="type">
                                        <xsl:text>birth</xsl:text>
                                    </xsl:attribute>
                                    <xsl:value-of select="regex-group(2)"/>
                                </xsl:element>
                            </xsl:matching-substring>
                            <xsl:non-matching-substring>
                                <xsl:value-of select="."/>
                            </xsl:non-matching-substring>
                            
                            
                        </xsl:analyze-string>
                    </xsl:non-matching-substring>
                    
                    
                </xsl:analyze-string>
                
                
                
            </xsl:non-matching-substring>
            
            
        </xsl:analyze-string>
        
        
    </xsl:template>-->
    
    <!--<xsl:template match="person/text()">
        <xsl:analyze-string select="." regex="(\()(.*?–.*?)(\))">
            <xsl:matching-substring>
                <xsl:element name="date">
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>-->
    
    <!--<xsl:template match="//person/text()[1][contains(., 'eigtl')]">
        <xsl:analyze-string select="." regex="eigtl(.*)">
            <xsl:matching-substring>
                <xsl:element name="persName">
                    <xsl:attribute name="type">
                        <xsl:text>oilt</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="substring-after(., 'eigtl.')"/>
                </xsl:element>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
        
        
        
    </xsl:template>-->
    
    
    <!--<xsl:template match="//person/text()[1]">
        <xsl:element name="persName">
            <xsl:value-of select="fn:normalize-space(.)"/>
        </xsl:element>
    </xsl:template>-->
    
    <xsl:template match="//work/text()[not(normalize-space(.)='')]">
        <xsl:element name="title">
            <xsl:value-of select="fn:normalize-space(.)"/>
        </xsl:element>
    </xsl:template>
        
</xsl:stylesheet>
