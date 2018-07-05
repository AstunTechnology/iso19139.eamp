<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:exslt="http://exslt.org/common" xmlns:geonet="http://www.fao.org/geonetwork"
    xmlns:skos="http://www.w3.org/2004/02/skos/core#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:dcterms="http://purl.org/dc/terms/"
    xmlns:gco="http://www.isotc211.org/2005/gco"
    xmlns:gmd="http://www.isotc211.org/2005/gmd"
    xmlns:srv="http://www.isotc211.org/2005/srv"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:gmx="http://www.isotc211.org/2005/gmx"
    xmlns:util="java:org.fao.geonet.util.XslUtil"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    version="2.0" exclude-result-prefixes="#all">

  
  <xsl:template match="gmd:thesaurusName/gmd:CI_Citation/gmd:identifier/gmd:MD_Identifier/gmd:code[contains(gmx:Anchor, 'theme.inspire-theme')]">

      <xsl:copy>
        <xsl:copy-of select="@*" />

        <gmx:Anchor>
          <xsl:attribute name="xlink:href" select="replace(gmx:Anchor/@xlink:href, 'inspire-theme', 'httpinspireeceuropaeutheme-theme')" />
          <xsl:value-of select="replace(gmx:Anchor, 'inspire-theme', 'httpinspireeceuropaeutheme-theme')" />
        </gmx:Anchor>
      </xsl:copy>
    </xsl:template>


    <!-- Do a copy of every nodes and attributes -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

    <!-- Remove geonet:* elements. -->
    <xsl:template match="geonet:*" priority="2"/>

</xsl:stylesheet>
