<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:gmd="http://www.isotc211.org/2005/gmd"
                xmlns:gco="http://www.isotc211.org/2005/gco"
                xmlns:gmx="http://www.isotc211.org/2005/gmx"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:gml="http://www.opengis.net/gml"
                xmlns:srv="http://www.isotc211.org/2005/srv"
                xmlns:geonet="http://www.fao.org/geonetwork"
                xmlns:util="java:org.fao.geonet.util.XslUtil"
                xmlns:skos="http://www.w3.org/2004/02/skos/core#"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                exclude-result-prefixes="#all">
  <xsl:import href="../../iso19139/index-fields/language-default.xsl"/>

  <xsl:template match="*" mode="metadata">
    <xsl:param name="langId"/>
    <xsl:param name="isoLangId"/>

  <xsl:for-each select="gmd:contact/*/gmd:organisationName//gmd:LocalisedCharacterString[@locale=$langId]">
        <Field name="metadataPOC" string="{string(.)}" store="true" index="true"/>

        <xsl:variable name="role" select="../../../../gmd:role/*/@codeListValue"/>
        <xsl:variable name="roleTranslation" select="util:getCodelistTranslation('gmd:CI_RoleCode', string($role), string($isoLangId))"/>
        <xsl:variable name="logo" select="../../../..//gmx:FileName/@src"/>
        <xsl:variable name="email" select="../../../../gmd:contactInfo/*/gmd:address/*/gmd:electronicMailAddress/gco:CharacterString"/>
        <xsl:variable name="url" select="../../../../gmd:contactInfo/*/gmd:onlineResource/*/gmd:linkage/gmd:URL/text()"/>
        <xsl:variable name="phone" select="../../../../gmd:contactInfo/*/gmd:phone/*/gmd:voice[normalize-space(.) != '']/*/text()"/>
        <xsl:variable name="individualName" select="../../../../gmd:individualName/gco:CharacterString/text()"/>
        <xsl:variable name="positionName" select="../../../../gmd:positionName/gco:CharacterString/text()"/>
        <xsl:variable name="address" select="string-join(../../../../gmd:contactInfo/*/gmd:address/*/(
                                      gmd:deliveryPoint|gmd:postalCode|gmd:city|
                                      gmd:administrativeArea|gmd:country)/gco:CharacterString/text(), ', ')"/>

        <Field name="responsibleParty"
               string="{concat($roleTranslation, '|metadata|', ., '|', $logo, '|', string-join($email, ','), '|', $url, '|', $individualName, '|', $positionName, '|', $address, '|', string-join($phone, ','))}"
               store="true" index="false"/>
    </xsl:for-each>

    <xsl:for-each select="gmd:pointOfContact/gmd:CI_ResponsibleParty/gmd:organisationName//gmd:LocalisedCharacterString[@locale=$langId]">
          <Field name="orgName" string="{string(.)}" store="true" index="true"/>
          <Field name="_orgName" string="{string(.)}" store="true" index="true"/>

          <xsl:variable name="role"    select="../../../../gmd:role/*/@codeListValue"/>
          <xsl:variable name="roleTranslation" select="util:getCodelistTranslation('gmd:CI_RoleCode', string($role), string($isoLangId))"/>
          <xsl:variable name="logo"    select="../../../..//gmx:FileName/@src"/>
          <xsl:variable name="email"   select="../../../../gmd:contactInfo/*/gmd:address/*/gmd:electronicMailAddress/gco:CharacterString"/>
          <xsl:variable name="url" select="../../../../gmd:contactInfo/*/gmd:onlineResource/*/gmd:linkage/gmd:URL/text()"/>
          <xsl:variable name="phone"   select="../../../../gmd:contactInfo/*/gmd:phone/*/gmd:voice[normalize-space(.) != '']/*/text()"/>
          <xsl:variable name="individualName" select="../../../../gmd:individualName/gco:CharacterString/text()"/>
          <xsl:variable name="positionName"   select="../../../../gmd:positionName/gco:CharacterString/text()"/>
          <xsl:variable name="address" select="string-join(../../../../gmd:contactInfo/*/gmd:address/*/(
                                    gmd:deliveryPoint|gmd:postalCode|gmd:city|
                                    gmd:administrativeArea|gmd:country)/gco:CharacterString/text(), ', ')"/>

          <Field name="responsibleParty"
                 string="{concat($roleTranslation, '|resource|', ., '|', $logo, '|',  string-join($email, ','), '|', $url, '|', $individualName, '|', $positionName, '|', $address, '|', string-join($phone, ','))}"
                 store="true" index="false"/>
      </xsl:for-each>
</xsl:template>
</xsl:stylesheet>
