<?xml version="1.0" encoding="utf-8"?>

<!--
    Force metadata to have EAMP Metadata Standard and Version and fix gml namespaces
-->

<xsl:stylesheet xmlns:geonet="http://www.fao.org/geonetwork"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:eamp="http://environment.data.gov.uk/eamp" xmlns:gmx="http://www.isotc211.org/2005/gmx"
	xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:gco="http://www.isotc211.org/2005/gco"
	xmlns:srv="http://www.isotc211.org/2005/srv" xmlns:gml="http://www.opengis.net/gml/3.2"
	xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	version="2.0"
	exclude-result-prefixes="geonet">
	
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
	
	<!-- fix namespaces -->
	<xsl:template name="add-namespaces">
		<xsl:namespace name="xsi" select="'http://www.w3.org/2001/XMLSchema-instance'"/>
		<xsl:namespace name="gco" select="'http://www.isotc211.org/2005/gco'"/>
		<xsl:namespace name="gmd" select="'http://www.isotc211.org/2005/gmd'"/>
		<xsl:namespace name="srv" select="'http://www.isotc211.org/2005/srv'"/>
		<xsl:namespace name="gmx" select="'http://www.isotc211.org/2005/gmx'"/>
		<xsl:namespace name="gts" select="'http://www.isotc211.org/2005/gts'"/>
		<xsl:namespace name="gsr" select="'http://www.isotc211.org/2005/gsr'"/>
		<xsl:namespace name="gmi" select="'http://www.isotc211.org/2005/gmi'"/>
		<xsl:namespace name="gml" select="'http://www.opengis.net/gml/3.2'"/>
		<xsl:namespace name="xlink" select="'http://www.w3.org/1999/xlink'"/>
		<xsl:namespace name="eamp" select="'http://environment.data.gov.uk/eamp'"/>
	</xsl:template>
	
	<!-- Don't copy these nodes at all- they are covered by later templates -->
	<xsl:template match="gmd:pointOfContact"/>
	
	<!--  Change standard to EAMP  -->
	<xsl:template match="gmd:metadataStandardName">
		<xsl:message>==== Updating Metadata Standard Name ====</xsl:message>
		<gmd:metadataStandardName>
			<gco:CharacterString>Environment Agency Metadata Profile</gco:CharacterString>
		</gmd:metadataStandardName>
	</xsl:template>
	
	<xsl:template match="gmd:metadataStandardVersion">
		<xsl:message>==== Updating Metadata Standard Version ====</xsl:message>
		<gmd:metadataStandardVersion>
			<gco:CharacterString>1.1</gco:CharacterString>
		</gmd:metadataStandardVersion>
	</xsl:template>
	
	
	
	
	<!--  Change schema location to gemini version  -->
	<xsl:template match="gmd:MD_Metadata">
		<!--<xsl:element name="{name()}" namespace="{namespace-uri()}">-->
			<!--<xsl:namespace name="gml" select="'http://www.opengis.net/gml/3.2'" />-->
			<!--<xsl:copy-of select="namespace::*[not(name() = ('gml','xsl'))]"/>-->
			<!--<xsl:copy-of select="namespace::*[not(name() = ('gml') or name()=('xsl'))]"/>-->
			
			<xsl:copy copy-namespaces="no">
				<xsl:call-template name="add-namespaces"/>
				
						
			<xsl:apply-templates select="gmd:fileIdentifier" />
			<xsl:apply-templates select="gmd:language" />  
			<xsl:apply-templates select="gmd:characterSet" />
				<xsl:if test="not(gmd:characterSet)">
					<xsl:message>==== Adding default character set ====</xsl:message>
					<gmd:characterSet>
						<gmd:MD_CharacterSetCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#MD_CharacterSetCode"
							codeListValue="utf8"
							codeSpace="ISOTC211/19115">utf8</gmd:MD_CharacterSetCode>
					</gmd:characterSet>
				</xsl:if>
			<xsl:apply-templates select="gmd:parentIdentifier" />
			<xsl:apply-templates select="gmd:hierarchyLevel" />
			<xsl:apply-templates select="gmd:hierarchyLevelName" />
			<xsl:apply-templates select="gmd:contact" /> 
			<xsl:apply-templates select="gmd:dateStamp" />   
			<xsl:apply-templates select="gmd:metadataStandardName" />
			<xsl:if test="not(gmd:metadataStandardName)">
				<xsl:message>==== Adding Metadata Standard Name ====</xsl:message>
				<gmd:metadataStandardName>
					<gco:CharacterString>Environment Agency Metadata Profile</gco:CharacterString>
				</gmd:metadataStandardName>
			</xsl:if>
			
			<xsl:apply-templates select="gmd:metadataStandardVersion" />
			<xsl:if test="not(gmd:metadataStandardVersion)">
				<xsl:message>==== Adding Metadata Standard Version ====</xsl:message>
				<gmd:metadataStandardVersion>
					<gco:CharacterString>1.1</gco:CharacterString>
				</gmd:metadataStandardVersion>
			</xsl:if>
			

			
			<xsl:apply-templates select="gmd:dataSetURI" /> 
			<xsl:apply-templates select="gmd:locale" />  
			<xsl:apply-templates select="gmd:spatialRepresentationInfo" />    
			<xsl:apply-templates select="gmd:referenceSystemInfo" />    
			<xsl:apply-templates select="gmd:metadataExtensionInfo" />    
			<xsl:apply-templates select="gmd:identificationInfo" />   
			<xsl:apply-templates select="gmd:contentInfo" />    
			<xsl:apply-templates select="gmd:distributionInfo" />    
			<xsl:apply-templates select="gmd:dataQualityInfo" />    
			<xsl:apply-templates select="gmd:portrayalCatalogueInfo" />    
			<xsl:apply-templates select="gmd:metadataConstraints" />    
			<xsl:apply-templates select="gmd:applicationSchemaInfo" />    
			<xsl:apply-templates select="gmd:metadataMaintenance" />    
			<xsl:apply-templates select="gmd:series" />    
			<xsl:apply-templates select="gmd:describes" />    
			<xsl:apply-templates select="gmd:propertyType" />    
			<xsl:apply-templates select="gmd:featureType" />    
			<xsl:apply-templates select="gmd:featureAttribute" /> 
		<!--</xsl:element>-->
			</xsl:copy>
	</xsl:template>
	
	<!-- geographic identifier element -->
	<xsl:template match="*/gmd:extent/gmd:EX_Extent">
		<xsl:copy copy-namespaces="no">
			    <xsl:apply-templates select="gmd:geographicElement"/>
			<xsl:message>==== Adding default Geographic Identifier Element ====</xsl:message>
			<gmd:geographicElement>
				<gmd:EX_GeographicDescription>
					<gmd:extentTypeCode>
						<gco:Boolean>true</gco:Boolean>
					</gmd:extentTypeCode>
					<gmd:geographicIdentifier>
						<gmd:MD_Identifier>
							<gmd:code>
								<gco:CharacterString>GB-ENG</gco:CharacterString>
							</gmd:code>
						</gmd:MD_Identifier>
					</gmd:geographicIdentifier>
				</gmd:EX_GeographicDescription>
			</gmd:geographicElement>
			<xsl:apply-templates select="gmd:temporalElement"/>
		</xsl:copy>
	</xsl:template>
	
	<!-- EA AfA Status and default openData constraints to be inserted as new block, after the last gmd:descriptiveKeyword -->
	<xsl:template match="*/gmd:descriptiveKeywords[not(following-sibling::gmd:descriptiveKeywords)]">
		<xsl:copy copy-namespaces="no">
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
		<gmd:resourceConstraints>
			<xsl:message>==== Adding default constraints ====</xsl:message>
			<eamp:EA_Constraints>
				<eamp:afa>
					<eamp:EA_Afa>
						<eamp:afaNumber>
							<gco:Decimal>0</gco:Decimal>
						</eamp:afaNumber>
						<eamp:afaStatus>
							<eamp:EA_AfaStatus>Open Data Risk Assessment</eamp:EA_AfaStatus>
						</eamp:afaStatus>
					</eamp:EA_Afa>
				</eamp:afa>
			</eamp:EA_Constraints>
		</gmd:resourceConstraints>
		<gmd:resourceConstraints>
			<gmd:MD_Constraints>
				<gmd:useLimitation>
					<gco:CharacterString>
						There are no public access constraints to this data. Use of this data is subject to the licence identified.
					</gco:CharacterString>
				</gmd:useLimitation>
			</gmd:MD_Constraints>
		</gmd:resourceConstraints>
		<gmd:resourceConstraints>
			<gmd:MD_LegalConstraints>
				<gmd:accessConstraints>
					<gmd:MD_RestrictionCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#MD_RestrictionCode" codeListValue="otherRestrictions" codeSpace="ISOTC211/19115">otherRestrictions</gmd:MD_RestrictionCode>
				</gmd:accessConstraints>
				<gmd:accessConstraints>
					<gmd:MD_RestrictionCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#MD_RestrictionCode" codeListValue="license" codeSpace="ISOTC211/19115">license</gmd:MD_RestrictionCode>
				</gmd:accessConstraints>
				<gmd:accessConstraints>
					<gmd:MD_RestrictionCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#MD_RestrictionCode" codeListValue="copyright" codeSpace="ISOTC211/19115">copyright</gmd:MD_RestrictionCode>
				</gmd:accessConstraints>
				<gmd:otherConstraints>
					<!-- use useLimitation from original record in anchor with href form if available-->
					<xsl:variable name="nelicensetext" select="//gmd:MD_Constraints/gmd:useLimitation/(gmx:Anchor|gco:CharacterString)"/>
					<xsl:variable name="nelicensehref" select="//gmd:MD_Constraints/gmd:useLimitation/gmx:Anchor/@xlink:href"/>
					<xsl:choose>
						<xsl:when test="$nelicensehref = ''">
							<gco:CharacterString>
								<xsl:value-of select="$nelicensetext"></xsl:value-of>
							</gco:CharacterString>
						</xsl:when>
						<xsl:otherwise>
							<xsl:element name="gmx:anchor">
								<xsl:attribute name="xlink:href">
									<xsl:value-of select="$nelicensehref"/>
								</xsl:attribute>
								<xsl:value-of select="$nelicensetext"/>
							</xsl:element>
						</xsl:otherwise>
					</xsl:choose>
				</gmd:otherConstraints>
				<gmd:otherConstraints>
					<!-- if Attribution statement is present in abstract, use that for copyright -->
						<xsl:choose>
						<xsl:when test="contains(//gmd:abstract/gco:CharacterString,'Attribution statement')">
							<xsl:variable name="copyrightText" select="substring-after(//gmd:abstract/gco:CharacterString,'Attribution statement: ')"/>
							<gco:CharacterString>
								<xsl:value-of select="$copyrightText"></xsl:value-of>
							</gco:CharacterString>
						</xsl:when>
						<xsl:otherwise>
							<gco:CharacterString>
								<xsl:text>© Natural England [year]</xsl:text>
							</gco:CharacterString>
						</xsl:otherwise>
						</xsl:choose>
							</gmd:otherConstraints>
			</gmd:MD_LegalConstraints>
		</gmd:resourceConstraints>
	</xsl:template>
	
	<!-- wipe existing gmd:resourceConstraints -->
	<xsl:template match="*/gmd:resourceConstraints"/>
	
	

	
	
	<!-- generic contacts in the form required by EAMP after abstract-->
	<xsl:template match="*/gmd:abstract">
		<gmd:abstract>
			<gco:CharacterString><xsl:value-of select="./gco:CharacterString"></xsl:value-of></gco:CharacterString>
		</gmd:abstract>
		<xsl:message>==== Adding default contacts ====</xsl:message>
		<gmd:pointOfContact>
			<gmd:CI_ResponsibleParty>
				<gmd:individualName>
					<gco:CharacterString>Data Services</gco:CharacterString>
				</gmd:individualName>
				<gmd:organisationName>
					<gco:CharacterString>Natural England</gco:CharacterString>
				</gmd:organisationName>
				<gmd:positionName>
					<gco:CharacterString>Enquiries</gco:CharacterString>
				</gmd:positionName>
				<gmd:contactInfo>
					<gmd:CI_Contact>
						<gmd:phone>
							<gmd:CI_Telephone>
								<gmd:voice>
									<gco:CharacterString>0300 060 3900</gco:CharacterString>
								</gmd:voice>
							</gmd:CI_Telephone>
						</gmd:phone>
						<gmd:address>
							<gmd:CI_Address>
								<gmd:deliveryPoint>
									<gco:CharacterString>Foss House, Kings Pool, 1-2 Peasholme
										Green</gco:CharacterString>
								</gmd:deliveryPoint>
								<gmd:city>
									<gco:CharacterString>York</gco:CharacterString>
								</gmd:city>
								<gmd:postalCode>
									<gco:CharacterString>YO1 7PX</gco:CharacterString>
								</gmd:postalCode>
								<gmd:country>
									<gco:CharacterString>United Kingdom</gco:CharacterString>
								</gmd:country>
								<gmd:electronicMailAddress>
									<gco:CharacterString>Data.Services@naturalengland.org.uk</gco:CharacterString>
								</gmd:electronicMailAddress>
							</gmd:CI_Address>
						</gmd:address>
						<gmd:onlineResource>
							<gmd:CI_OnlineResource>
								<gmd:linkage>
									<gmd:URL>https://www.gov.uk/government/organisations/natural-england</gmd:URL>
								</gmd:linkage>
							</gmd:CI_OnlineResource>
						</gmd:onlineResource>
					</gmd:CI_Contact>
				</gmd:contactInfo>
				<gmd:role>
					<gmd:CI_RoleCode
						codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/codelist/gmxCodelists.xml#CI_RoleCode"
						codeListValue="pointOfContact">pointOfContact</gmd:CI_RoleCode>
				</gmd:role>
			</gmd:CI_ResponsibleParty>
		</gmd:pointOfContact>
		<gmd:pointOfContact>
			<gmd:CI_ResponsibleParty>
				<gmd:individualName>
					<gco:CharacterString>Data Services</gco:CharacterString>
				</gmd:individualName>
				<gmd:organisationName>
					<gco:CharacterString>Natural England</gco:CharacterString>
				</gmd:organisationName>
				<gmd:positionName>
					<gco:CharacterString>Enquiries</gco:CharacterString>
				</gmd:positionName>
				<gmd:contactInfo>
					<gmd:CI_Contact>
						<gmd:phone>
							<gmd:CI_Telephone>
								<gmd:voice>
									<gco:CharacterString>0300 060 3900</gco:CharacterString>
								</gmd:voice>
							</gmd:CI_Telephone>
						</gmd:phone>
						<gmd:address>
							<gmd:CI_Address>
								<gmd:deliveryPoint>
									<gco:CharacterString>Foss House, Kings Pool, 1-2 Peasholme
										Green</gco:CharacterString>
								</gmd:deliveryPoint>
								<gmd:city>
									<gco:CharacterString>York</gco:CharacterString>
								</gmd:city>
								<gmd:postalCode>
									<gco:CharacterString>YO1 7PX</gco:CharacterString>
								</gmd:postalCode>
								<gmd:country>
									<gco:CharacterString>United Kingdom</gco:CharacterString>
								</gmd:country>
								<gmd:electronicMailAddress>
									<gco:CharacterString>Data.Services@naturalengland.org.uk</gco:CharacterString>
								</gmd:electronicMailAddress>
							</gmd:CI_Address>
						</gmd:address>
						<gmd:onlineResource>
							<gmd:CI_OnlineResource>
								<gmd:linkage>
									<gmd:URL>https://www.gov.uk/government/organisations/natural-england</gmd:URL>
								</gmd:linkage>
							</gmd:CI_OnlineResource>
						</gmd:onlineResource>
					</gmd:CI_Contact>
				</gmd:contactInfo>
				<gmd:role>
					<gmd:CI_RoleCode
						codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/codelist/gmxCodelists.xml#CI_RoleCode"
						codeListValue="Custodian">Custodian</gmd:CI_RoleCode>
				</gmd:role>
			</gmd:CI_ResponsibleParty>
		</gmd:pointOfContact>
		<gmd:pointOfContact>
			<gmd:CI_ResponsibleParty>
				<gmd:individualName>
					<gco:CharacterString>Data Services</gco:CharacterString>
				</gmd:individualName>
				<gmd:organisationName>
					<gco:CharacterString>Natural England</gco:CharacterString>
				</gmd:organisationName>
				<gmd:positionName>
					<gco:CharacterString>Enquiries</gco:CharacterString>
				</gmd:positionName>
				<gmd:contactInfo>
					<gmd:CI_Contact>
						<gmd:phone>
							<gmd:CI_Telephone>
								<gmd:voice>
									<gco:CharacterString>0300 060 3900</gco:CharacterString>
								</gmd:voice>
							</gmd:CI_Telephone>
						</gmd:phone>
						<gmd:address>
							<gmd:CI_Address>
								<gmd:deliveryPoint>
									<gco:CharacterString>Foss House, Kings Pool, 1-2 Peasholme
										Green</gco:CharacterString>
								</gmd:deliveryPoint>
								<gmd:city>
									<gco:CharacterString>York</gco:CharacterString>
								</gmd:city>
								<gmd:postalCode>
									<gco:CharacterString>YO1 7PX</gco:CharacterString>
								</gmd:postalCode>
								<gmd:country>
									<gco:CharacterString>United Kingdom</gco:CharacterString>
								</gmd:country>
								<gmd:electronicMailAddress>
									<gco:CharacterString>Data.Services@naturalengland.org.uk</gco:CharacterString>
								</gmd:electronicMailAddress>
							</gmd:CI_Address>
						</gmd:address>
						<gmd:onlineResource>
							<gmd:CI_OnlineResource>
								<gmd:linkage>
									<gmd:URL>https://www.gov.uk/government/organisations/natural-england</gmd:URL>
								</gmd:linkage>
							</gmd:CI_OnlineResource>
						</gmd:onlineResource>
					</gmd:CI_Contact>
				</gmd:contactInfo>
				<gmd:role>
					<gmd:CI_RoleCode
						codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/codelist/gmxCodelists.xml#CI_RoleCode"
						codeListValue="Custodian">Custodian</gmd:CI_RoleCode>
				</gmd:role>
			</gmd:CI_ResponsibleParty>
		</gmd:pointOfContact>
		<gmd:pointOfContact>
			<gmd:CI_ResponsibleParty>
				<gmd:individualName>
					<gco:CharacterString>Data Services</gco:CharacterString>
				</gmd:individualName>
				<gmd:organisationName>
					<gco:CharacterString>Natural England</gco:CharacterString>
				</gmd:organisationName>
				<gmd:positionName>
					<gco:CharacterString>Enquiries</gco:CharacterString>
				</gmd:positionName>
				<gmd:contactInfo>
					<gmd:CI_Contact>
						<gmd:phone>
							<gmd:CI_Telephone>
								<gmd:voice>
									<gco:CharacterString>0300 060 3900</gco:CharacterString>
								</gmd:voice>
							</gmd:CI_Telephone>
						</gmd:phone>
						<gmd:address>
							<gmd:CI_Address>
								<gmd:deliveryPoint>
									<gco:CharacterString>Foss House, Kings Pool, 1-2 Peasholme
										Green</gco:CharacterString>
								</gmd:deliveryPoint>
								<gmd:city>
									<gco:CharacterString>York</gco:CharacterString>
								</gmd:city>
								<gmd:postalCode>
									<gco:CharacterString>YO1 7PX</gco:CharacterString>
								</gmd:postalCode>
								<gmd:country>
									<gco:CharacterString>United Kingdom</gco:CharacterString>
								</gmd:country>
								<gmd:electronicMailAddress>
									<gco:CharacterString>Data.Services@naturalengland.org.uk</gco:CharacterString>
								</gmd:electronicMailAddress>
							</gmd:CI_Address>
						</gmd:address>
						<gmd:onlineResource>
							<gmd:CI_OnlineResource>
								<gmd:linkage>
									<gmd:URL>https://www.gov.uk/government/organisations/natural-england</gmd:URL>
								</gmd:linkage>
							</gmd:CI_OnlineResource>
						</gmd:onlineResource>
					</gmd:CI_Contact>
				</gmd:contactInfo>
				<gmd:role>
					<gmd:CI_RoleCode
						codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/codelist/gmxCodelists.xml#CI_RoleCode"
						codeListValue="Owner">Owner</gmd:CI_RoleCode>
				</gmd:role>
			</gmd:CI_ResponsibleParty>
		</gmd:pointOfContact>
	</xsl:template>
	
	
	<xsl:template match="*">
		<xsl:element name="{name()}">
			<xsl:apply-templates select="@* | node()" />
		</xsl:element>
	</xsl:template>
	
	<!-- Match any attribute -->
	<xsl:template match="@*">
		<xsl:attribute name="{name()}">
			<xsl:value-of select="." />
		</xsl:attribute>
	</xsl:template>
	
	
	
	
	
	<!-- Updating schema-location to correct version for EAMP -->
	
	<xsl:template match="@xsi:schemaLocation" priority="2">
		<xsl:attribute name="xsi:schemaLocation">http://environment.data.gov.uk/eamp http://environment.data.gov.uk/eamp/schema.xsd http://www.isotc211.org/2005/gmd http://www.isotc211.org/2005/gmd/gmd.xsd http://www.isotc211.org/2005/gmx http://eden.ign.fr/xsd/isotc211/isofull/20090316/gmx/gmx.xsd http://www.isotc211.org/2005/srv http://eden.ign.fr/xsd/isotc211/isofull/20090316/srv/srv.xsd</xsl:attribute>
		
		<xsl:message>==== Copying schemalocation ====</xsl:message>
	</xsl:template>
	
	
	
	<!--  Remove geonet:* elements.  -->
	<xsl:template match="geonet:*" priority="2"/>
</xsl:stylesheet>
