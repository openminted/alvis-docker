<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:a="xalan://org.bibliome.alvisnlp.modules.xml.XMLWriter2"
                xmlns:b="http://bilbiome.jouy.inra.fr/alvisnlp/XMLReader2"
                xmlns:inline="http://bibliome.jouy.inra.fr/alvisnlp/bibliome-module-factory/inline"
		extension-element-prefixes="a b inline"
>

  <xsl:output method="text" omit-xml-declaration="yes" indent="no"/>

<!-- <xsl:variable name="replaced_quote"><xsl:text>'</xsl:text></xsl:variable> -->
<!-- <xsl:variable name="double_quote"><xsl:text>"</xsl:text></xsl:variable> -->

    <xsl:template name="replace-string">
        <xsl:param name="text"/>
        <xsl:param name="replace"/>
        <xsl:param name="with"/>
        <xsl:choose>
            <xsl:when test="contains($text,$replace)">
                <xsl:value-of select="substring-before($text,$replace)"/>
                <xsl:value-of select="$with"/>
                <xsl:call-template name="replace-string">
                    <xsl:with-param name="text"
                        select="substring-after($text,$replace)"/>
                    <xsl:with-param name="replace" select="$replace"/>
                    <xsl:with-param name="with" select="$with"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$text"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

<xsl:template match="child::node()|@*|node()">
    <xsl:copy>
        <xsl:apply-templates select="child::node()|@*|node()"/>
    </xsl:copy>
</xsl:template>

<!-- <xsl:template match="text()"> -->
    <!-- <xsl:value-of select="normalize-space(.)"/> -->
<!-- </xsl:template> -->
<xsl:template match="text()">
<xsl:variable name="escaped-body">
  <xsl:call-template name="replace-string">
    <xsl:with-param name="text" select="concat(substring(' ', 1 + not(substring(.,1,1)=' ')),
					normalize-space(),
					substring(' ', 1 + not(substring(., string-length(.)) = ' '))
					)
					"/>
    <xsl:with-param name="replace" select="'&quot;'" />
    <xsl:with-param name="with" select="'%22'"/>
  </xsl:call-template>
</xsl:variable>
<xsl:value-of select="$escaped-body"/>
  <!-- <xsl:value-of select= -->
  <!-- "concat(substring(' ', 1 + not(substring(.,1,1)=' ')), -->
  <!--         normalize-space(), -->
  <!--         substring(' ', 1 + not(substring(., string-length(.)) = ' ')) -->
  <!--         ) -->
  <!-- "/> -->
</xsl:template>


<xsl:template match="b:element">
  <xsl:choose>
    <xsl:when test="@type='ne'">
<xsl:text>&lt;span class='openminted_</xsl:text><xsl:value-of select="@ne-type"/><xsl:text>'</xsl:text>
      <!-- <xsl:element name="{@ne-type}"> -->
      <!-- <xsl:element name="span"> -->
      <!-- 	<xsl:attribute name="class"> -->
      <!-- 	  <xsl:value-of select="@ne-type"/> -->
      <!-- 	</xsl:attribute> -->
      	<!-- <xsl:choose> -->
      	<!--   <xsl:when test="@ne-type='gene'"> -->
	<!--     <xsl:text> style='background-color: #aac2ff'</xsl:text> -->
      	<!--   </xsl:when> -->
      	<!--   <xsl:when test="@ne-type='phenotype'"> -->
	<!--     <xsl:text> style='background-color: #91ffd4'</xsl:text> -->
      	<!--   </xsl:when> -->
      	<!--   <xsl:when test="@ne-type='marker'"> -->
	<!--     <xsl:text> style='background-color: #ff95a4'</xsl:text> -->
      	<!--   </xsl:when> -->
      	<!--   <xsl:when test="@ne-type='taxon'"> -->
	<!--     <xsl:text> style='background-color: #f8ffc5'</xsl:text> -->
      	<!--   </xsl:when> -->
      	<!--   <xsl:when test="@ne-type='accession'"> -->
	<!--     <xsl:text> style='background-color: #ffc2e3'</xsl:text> -->
      	<!--   </xsl:when> -->
      	<!-- </xsl:choose> -->
	<xsl:text>&gt;</xsl:text>
      	<xsl:apply-templates select="child::node()"/>
	<xsl:text>&lt;/span&gt;</xsl:text>
      <!-- </xsl:element> -->
    </xsl:when>
  </xsl:choose>
</xsl:template>

  <xsl:template match="/">
    <xsl:for-each select="a:elements('documents[@DI]')">
      <xsl:text>Bibliography,</xsl:text>
      <xsl:text>OpenMinTeD,</xsl:text>
      <xsl:value-of select="@DI"/>
      <xsl:text>,</xsl:text>
      <xsl:text>1,&quot;</xsl:text>
      <xsl:for-each select="a:elements('sections:TI|sections:AB')">
	<xsl:for-each select="a:inline('layer:genes|layer:markers|layer:taxa|layer:phenotypes|layer:accessions|layer:varieties')">
	  <xsl:apply-templates select="child::node()"/>
	</xsl:for-each>
	<xsl:text> </xsl:text>
      </xsl:for-each>
      <xsl:value-of select="@entities"/>
      <xsl:text>&quot;,</xsl:text>
      <xsl:text>http://oadoi.org/</xsl:text>
      <xsl:value-of select="@DI"/>
      <xsl:text>,</xsl:text>
      <xsl:text>Triticum,,,,,,,,,,,,,,,,,</xsl:text>
      <xsl:text>&#10;</xsl:text>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
