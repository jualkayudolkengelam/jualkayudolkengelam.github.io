<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:sitemap="http://www.sitemaps.org/schemas/sitemap/0.9"
  xmlns:image="http://www.google.com/schemas/sitemap-image/1.1">
<xsl:output method="html" encoding="UTF-8" indent="yes"/>
<xsl:template match="/">
<html>
<head>
<title>XML Sitemap - Jual Kayu Dolken Gelam</title>
<meta name="robots" content="noindex,follow"/>
<style type="text/css">
body{font-family:-apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,Oxygen-Sans,Ubuntu,Cantarell,"Helvetica Neue",sans-serif;color:#333;margin:0;padding:20px}
h1{color:#2c5530;font-size:24px;margin-bottom:10px}
p{color:#666;margin-bottom:20px}
table{border-collapse:collapse;width:100%;margin:20px 0}
th{background:#2c5530;color:#fff;padding:12px 8px;text-align:left;font-size:13px}
td{padding:10px 8px;border-bottom:1px solid #ddd;font-size:13px}
tr:hover{background:#f5f5f5}
a{color:#2c5530;text-decoration:none}
a:hover{text-decoration:underline}
.url{max-width:400px;word-break:break-all}
.images{color:#666;font-size:12px}
.count{background:#e8f5e9;padding:4px 8px;border-radius:4px;font-size:12px}
</style>
</head>
<body>
<h1>XML Sitemap - Jual Kayu Dolken Gelam</h1>
<p>Sitemap ini berisi <strong><xsl:value-of select="count(sitemap:urlset/sitemap:url)"/></strong> URL dengan <strong><xsl:value-of select="count(sitemap:urlset/sitemap:url/image:image)"/></strong> gambar.</p>
<table>
<tr>
<th>#</th>
<th>URL</th>
<th>Images</th>
<th>Last Modified</th>
</tr>
<xsl:for-each select="sitemap:urlset/sitemap:url">
<tr>
<td><xsl:value-of select="position()"/></td>
<td class="url">
<a href="{sitemap:loc}"><xsl:value-of select="sitemap:loc"/></a>
</td>
<td class="images">
<xsl:if test="count(image:image) > 0">
<span class="count"><xsl:value-of select="count(image:image)"/> gambar</span>
</xsl:if>
</td>
<td><xsl:value-of select="sitemap:lastmod"/></td>
</tr>
</xsl:for-each>
</table>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
