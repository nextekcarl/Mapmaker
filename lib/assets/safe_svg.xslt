<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:svg="http://www.w3.org/2000/svg">
    <xsl:output indent="yes" />

    <!--The "whitelist" template that will copy matched nodes forward and apply-templates
        for any attributes or child nodes -->
    <xsl:template match="svg:svg
        | svg:defs  | svg:defs/text()
        | svg:g  | svg:g/text()
        | svg:a  | svg:a/text()
        | svg:use   | svg:use/text()
        | svg:rect  | svg:rect/text()
        | svg:circle  | svg:circle/text()
        | svg:ellipse  | svg:ellipse/text()
        | svg:line  | svg:line/text()
        | svg:polyline  | svg:polyline/text()
        | svg:polygon  | svg:polygon/text()
        | svg:path  | svg:path/text()
        | svg:text  | svg:text/text()
        | svg:tspan  | svg:tspan/text()
        | svg:tref  | svg:tref/text()
        | svg:textpath  | svg:textpath/text()
        | svg:linearGradient  | svg:linearGradient/text()
        | svg:radialGradient  | svg:radialGradient/text()
        | svg:clippath  | svg:clippath/text()
        | svg:text | svg:text/text()">
        <xsl:copy>
            <xsl:copy-of select="@*" />
            <xsl:apply-templates select="node()" />
        </xsl:copy>
    </xsl:template>

    <!--The "blacklist" template, which does nothing except apply templates for the
        matched node's attributes and child nodes -->
    <xsl:template match="@* | node()">
        <xsl:apply-templates select="@* | node()" />
    </xsl:template>

</xsl:stylesheet>
