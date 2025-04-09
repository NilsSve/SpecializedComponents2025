<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                                           xmlns:custList="http://www.dataaccess.com/Customer">
<xsl:template match="custList:CUSTOMERLIST">
<HTML>
<BODY>
<TABLE BORDER = "1">
<TR>
<TD>NAME</TD>
<TD>SALES REP</TD>
<TD>TELEPHONE</TD>
</TR>
<xsl:for-each select="custList:CUSTOMER">
<TR>
<TD><xsl:value-of select="@NAME"/></TD>
<TD><xsl:value-of select="custList:SALES-REP"/></TD>
<TD><xsl:value-of select="custList:TELEPHONE"/></TD>
</TR>
</xsl:for-each>
</TABLE>
</BODY>
</HTML>
</xsl:template>
</xsl:stylesheet>
