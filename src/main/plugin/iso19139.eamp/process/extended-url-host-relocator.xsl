<?xml version="1.0" encoding="UTF-8"?>
<!--
    This processing allows changing the url prefix of any
    gmd:URL, gco:CharacterString and xlink:href elements 
    in iso19139 based metadata records.
    
    Parameters:
    * process=url-host-relocator (fixed value)
    * urlPrefix=http://localhost : url prefix to replace
    * newUrlPrefix=http://newhost.org : prefix to be replaced by.
    * newProtocol=http : protocol to be replaced by
    * newName=Foo : name to be replaced by
    * newDescription= Website : description to be replaced by
    
    Calling the process using:
    http://localhost:8082/geonetwork/srv/eng/metadata.batch.processing?process=url-host-relocator&urlPrefix=http://localhost&newUrlPrefix=http://newhost.org&newProtocol=http&newName=Foo&newDescription=Website
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:geonet="http://www.fao.org/geonetwork" 
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:gco="http://www.isotc211.org/2005/gco"
    xmlns:gmd="http://www.isotc211.org/2005/gmd" version="1.0">

    <xsl:param name="urlPrefix">http://localhost:8080/</xsl:param>
    <xsl:param name="newUrlPrefix">http://newhost.org/</xsl:param>
    <xsl:param name="newProtocol">http</xsl:param>
    <xsl:param name="newName">Foo</xsl:param>
    <xsl:param name="newDescription">New Website</xsl:param>

    <!-- Do a copy of every nodes and attributes -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

    <!-- Remove geonet:* elements. -->
    <xsl:template match="geonet:*" priority="2"/>

   <!-- update url, name, protocol, description in transfer options -->
   <xsl:template match="*/gmd:transferOptions">
        <gmd:transferOptions>
            <gmd:MD_DigitalTransferOptions>
                <xsl:for-each select="./gmd:MD_DigitalTransferOptions/gmd:onLine">
                    <xsl:variable name="URL"><xsl:value-of select="./gmd:CI_OnlineResource/gmd:linkage/gmd:URL"/></xsl:variable>
                    <xsl:variable name="protocol"><xsl:value-of select="./gmd:CI_OnlineResource/gmd:protocol/gco:CharacterString"/></xsl:variable>
                    <xsl:variable name="description"><xsl:value-of select="./gmd:CI_OnlineResource/gmd:description/gco:CharacterString"/></xsl:variable>
                    <xsl:variable name="name"><xsl:value-of select="./gmd:CI_OnlineResource/gmd:name/gco:CharacterString"/></xsl:variable>
                    <xsl:choose>
                    <xsl:when test="$URL=$urlPrefix">
                            <gmd:onLine>
                                <gmd:CI_OnlineResource>
                                    <gmd:linkage>
                                        <gmd:URL><xsl:value-of select="$newUrlPrefix"/></gmd:URL>
                                    </gmd:linkage>
                                    <gmd:protocol>
                                        <gco:CharacterString><xsl:value-of select="$newProtocol"/></gco:CharacterString>
                                    </gmd:protocol> 
                                    <gmd:name>
                                        <gco:CharacterString><xsl:value-of select="$newName"/></gco:CharacterString>
                                    </gmd:name> 
                                    <gmd:description>
                                        <gco:CharacterString><xsl:value-of select="$newDescription"/></gco:CharacterString>
                                    </gmd:description>    
                                </gmd:CI_OnlineResource>
                            </gmd:onLine> 
                    </xsl:when>
                    <xsl:otherwise>
                            <gmd:onLine>
                                <gmd:CI_OnlineResource>
                                    <gmd:linkage>
                                        <gmd:URL><xsl:value-of select="$URL"/></gmd:URL>
                                    </gmd:linkage>
                                    <gmd:protocol>
                                        <gco:CharacterString><xsl:value-of select="$protocol"/></gco:CharacterString>
                                    </gmd:protocol> 
                                    <gmd:name>
                                        <gco:CharacterString><xsl:value-of select="$name"/></gco:CharacterString>
                                    </gmd:name> 
                                    <gmd:description>
                                        <gco:CharacterString><xsl:value-of select="$description"/></gco:CharacterString>
                                    </gmd:description>    
                                </gmd:CI_OnlineResource>
                            </gmd:onLine> 
                    </xsl:otherwise>
                </xsl:choose>
                </xsl:for-each> 
            </gmd:MD_DigitalTransferOptions>
        </gmd:transferOptions>
    </xsl:template>
    
    <!-- Replace in XLinks. -->
    <xsl:template match="@xlink:href[starts-with(., $urlPrefix)]" priority="2">
        <xsl:attribute name="href" namespace="http://www.w3.org/1999/xlink">
            <xsl:value-of select="concat($newUrlPrefix, substring-after(., $urlPrefix))"/>
        </xsl:attribute>
    </xsl:template>
</xsl:stylesheet>
