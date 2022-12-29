<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:tei="http://www.tei-c.org/ns/1.0" version="3.0" exclude-result-prefixes="tei">
    <xsl:output method="xml" indent="true"/>
    <xsl:mode on-no-match="shallow-copy"/>
    
   
   <xsl:template match="tei:person/tei:persName[tei:forename[contains(., ', Tochter von ')]]">
       <xsl:element name="persName" namespace="http://www.tei-c.org/ns/1.0">
           <xsl:copy-of select="@*"/>
           <xsl:copy-of select="tei:surname"/>
           <xsl:element name="forename" namespace="http://www.tei-c.org/ns/1.0">
               <xsl:value-of select="substring-before(tei:forename, ', Tochter von ')"/>
           </xsl:element>
       </xsl:element>
       <xsl:element name="noti" namespace="http://www.tei-c.org/ns/1.0">
           <xsl:value-of select="normalize-space(concat('Frau von ', substring-after(tei:forename, ', Tochter von ')))"/>
       </xsl:element>
   </xsl:template>
   
    
    
</xsl:stylesheet>
