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
    xmlns:util="java:org.fao.geonet.util.XslUtil"
    version="2.0" exclude-result-prefixes="#all">

    <xsl:import href="process-utility.xsl"/>


    <xsl:variable name="inspire-gemet"
        select="document(concat('file:///', replace(util:getConfigValue('codeListDir'), '\\', '/'), '/external/thesauri/theme/gemet.rdf'))"/>

    <xsl:template match="gmd:MD_DataIdentification">

        <xsl:variable name="lang" select="if (normalize-space(//gmd:MD_Metadata/gmd:language/gco:CharacterString
            |//gmd:MD_Metadata/gmd:language/gmd:LanguageCode/@codeListValue)='')
            then 'en'
            else
            substring(//gmd:MD_Metadata/gmd:language/gco:CharacterString
            |//gmd:MD_Metadata/gmd:language/gmd:LanguageCode/@codeListValue, 1, 2)
            "/>
        <!--<xsl:variable name="lang" select="'en'" />-->

      <xsl:copy>
        <xsl:copy-of select="@*" />

        <xsl:apply-templates select="gmd:citation" />
        <xsl:apply-templates select=" gmd:abstract" />
        <xsl:apply-templates select="gmd:purpose" />
        <xsl:apply-templates select="gmd:credit" />
        <xsl:apply-templates select="gmd:status" />
        <xsl:apply-templates select="gmd:pointOfContact" />
        <xsl:apply-templates select="gmd:resourceMaintenance" />
        <xsl:apply-templates select="gmd:graphicOverview" />
        <xsl:apply-templates select="gmd:resourceFormat" />

        <!-- Copy all non GEMET keywords -->
        <xsl:apply-templates select="gmd:descriptiveKeywords[not(gmd:MD_Keywords/gmd:thesaurusName)]" />

        <xsl:apply-templates select="gmd:descriptiveKeywords[gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:title/gco:CharacterString != 'GEMET - Concepts, version 2.4']" />

        <!-- Create a list tagging valid/invalid GEMET keywords -->
        <xsl:variable name="allGemetKeywords">
          <xsl:for-each select="gmd:descriptiveKeywords[gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:title/gco:CharacterString = 'GEMET - Concepts, version 2.4']/gmd:MD_Keywords/gmd:keyword">
            <xsl:variable name="value" select="gco:CharacterString"/>

            <xsl:choose>
              <xsl:when test="count($inspire-gemet//skos:Concept[skos:prefLabel[@xml:lang = normalize-space($lang)] = $value]/skos:prefLabel) = 0">
                <invalid><xsl:apply-templates select="." /></invalid>
              </xsl:when>
              <xsl:otherwise>
                <valid><xsl:apply-templates select="." /></valid>
              </xsl:otherwise>
            </xsl:choose>

          </xsl:for-each>
        </xsl:variable>

        <!--<xsl:message>COUNT NON-GEMET:<xsl:value-of select="count($allGemetKeywords/invalid)"/></xsl:message>
        <xsl:message>COUNT GEMET:<xsl:value-of select="count($allGemetKeywords/valid)"/></xsl:message>-->

        <!-- Add GEMET invalid keywords to a new gmd:descriptiveKeywords section -->
        <xsl:if test="count($allGemetKeywords/invalid) > 0">
          <gmd:descriptiveKeywords>
            <gmd:MD_Keywords>
              <xsl:for-each select="$allGemetKeywords/invalid">
                <gmd:keyword>
                  <gco:CharacterString><xsl:value-of select="normalize-space(.)" /></gco:CharacterString>
                </gmd:keyword>
              </xsl:for-each>
              <gmd:type>
                <gmd:MD_KeywordTypeCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#MD_KeywordTypeCode" codeListValue="theme">theme</gmd:MD_KeywordTypeCode>
              </gmd:type>
            </gmd:MD_Keywords>
          </gmd:descriptiveKeywords>
        </xsl:if>

        <!-- Add GEMET valid keywords to gmd:descriptiveKeywords section for GEMET. All GEMET keywords are grouped in the same section -->
        <xsl:if test="count($allGemetKeywords/valid) > 0">
          <gmd:descriptiveKeywords>
            <gmd:MD_Keywords>
              <xsl:for-each select="$allGemetKeywords/valid">
                <gmd:keyword>
                  <gco:CharacterString><xsl:value-of select="normalize-space(.)" /></gco:CharacterString>
                </gmd:keyword>
              </xsl:for-each>

              <xsl:copy-of select="//gmd:descriptiveKeywords[gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:title/gco:CharacterString = 'GEMET - Concepts, version 2.4'][1]/gmd:MD_Keywords/gmd:type"></xsl:copy-of>
              <xsl:copy-of select="//gmd:descriptiveKeywords[gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:title/gco:CharacterString = 'GEMET - Concepts, version 2.4'][1]/gmd:MD_Keywords/gmd:thesaurusName"></xsl:copy-of>
            </gmd:MD_Keywords>
          </gmd:descriptiveKeywords>
        </xsl:if>

        <xsl:apply-templates select="gmd:resourceSpecificUsage" />
        <xsl:apply-templates select="gmd:resourceConstraints" />
        <xsl:apply-templates select="gmd:aggregationInfo" />
        <xsl:apply-templates select="gmd:spatialRepresentationType" />
        <xsl:apply-templates select="gmd:spatialResolution" />
        <xsl:apply-templates select="gmd:language" />
        <xsl:apply-templates select="gmd:characterSet" />
        <xsl:apply-templates select="gmd:topicCategory" />
        <xsl:apply-templates select="gmd:environmentDescription" />
        <xsl:apply-templates select="gmd:extent" />
        <xsl:apply-templates select="gmd:supplementalInformation" />
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
