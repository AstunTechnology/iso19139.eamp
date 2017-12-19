<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:gmd="http://www.isotc211.org/2005/gmd"
                xmlns:gco="http://www.isotc211.org/2005/gco"
                xmlns:gml="http://www.opengis.net/gml"
                xmlns:srv="http://www.isotc211.org/2005/srv"
                xmlns:geonet="http://www.fao.org/geonetwork"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:gmx="http://www.isotc211.org/2005/gmx"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:util="java:org.fao.geonet.util.XslUtil"
                xmlns:skos="http://www.w3.org/2004/02/skos/core#"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:eamp="http://environment.data.gov.uk/eamp"
                version="2.0"
                exclude-result-prefixes="#all">
	<xsl:import href="../../iso19139/index-fields/default.xsl" />

	<!-- ========================================================================================= -->
 	<xsl:template match="/" priority="10">
		<Document locale="{$isoLangId}">
			<Field name="_locale" string="{$isoLangId}" store="true" index="true" />

			<Field name="_docLocale" string="{$isoLangId}" store="true"
				index="true" />

			<xsl:variable name="_defaultTitle">
				<xsl:call-template name="defaultTitle">
					<xsl:with-param name="isoDocLangId" select="$isoLangId" />
				</xsl:call-template>
			</xsl:variable>

			<Field name="_defaultTitle" string="{string($_defaultTitle)}"
				store="true" index="true" />

			<xsl:if test="geonet:info/isTemplate != 's'">
				<Field name="_title" string="{string($_defaultTitle)}" store="true"
					index="true" />
			</xsl:if>

			<xsl:apply-templates
				select="*[name(.)='gmd:MD_Metadata' or @gco:isoType='gmd:MD_Metadata']"
				mode="metadata" />

			<xsl:apply-templates mode="index" select="*" />


			<xsl:for-each select="//eamp:EA_Constraints">
				<xsl:variable name="fieldPrefix">MD_LegalConstraints</xsl:variable>

				<xsl:for-each
					select="gmd:accessConstraints/gmd:MD_RestrictionCode/@codeListValue[string(.) != 'otherRestrictions']">
					<Field name="{$fieldPrefix}AccessConstraints" string="{string(.)}"
						store="true" index="true" />
				</xsl:for-each>

				<xsl:for-each select="gmd:otherConstraints/gco:CharacterString">
					<Field name="{$fieldPrefix}OtherConstraints" string="{string(.)}"
						store="true" index="true" />
				</xsl:for-each>

				<xsl:for-each select="gmd:useLimitation/gco:CharacterString">
					<Field name="{$fieldPrefix}UseLimitation" string="{string(.)}"
						store="true" index="true" />
				</xsl:for-each>

				<xsl:for-each
					select="gmd:useLimitation/gmx:Anchor[not(string(@xlink:href))]">
					<Field name="{$fieldPrefix}UseLimitation" string="{string(.)}"
						store="true" index="true" />
				</xsl:for-each>

				<xsl:for-each select="gmd:useLimitation/gmx:Anchor[string(@xlink:href)]">
					<Field name="{$fieldPrefix}UseLimitation"
						string="{concat('link|',string(@xlink:href), '|', string(.))}"
						store="true" index="true" />
				</xsl:for-each>
			</xsl:for-each>
		</Document>
	</xsl:template>
</xsl:stylesheet>
