<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
    <xsl:output method="html" indent="yes"/>

    <xsl:template match="/">
       <html>
          <head>
             <link rel = "stylesheet" type="text/css" href="Default.css" />
          </head>
          <body>
             <h1>Complexity Metrics</h1>

             <xsl:call-template name="TargetTOC" />
             
             <xsl:apply-templates select="//Targets/Target" />
          </body>
       </html>
    </xsl:template>

   <!-- 
   Create the table of contents for all the Targets found
   in the xml file
   -->
   <xsl:template name="TargetTOC">
      <div class="TOCEntry">
         <h2>Modules</h2>
         <xsl:for-each select="//Target">
            <a class="TOCEntry">
               <xsl:attribute name="href">
                  #<xsl:value-of select="./Modules/Module/@Name"/>
               </xsl:attribute>
               <xsl:value-of select="./Modules/Module/@Name"/>
            </a>
         </xsl:for-each>
      </div>
   </xsl:template>

   <!--
   Create the table of contents for all the namespaces found
   in the module / target
   -->
   <xsl:template name="NamespaceTOC">
      <div class="TOCEntry">
         <h2>Namespaces</h2>
         <xsl:for-each select=".//Namespace">
            <xsl:call-template name="TOCEntryByName" />
         </xsl:for-each>
      </div>
   </xsl:template>

   <!--
   Create the table of contents for all the types in 
   the namespace
   -->
   <xsl:template name="TypeTOC">
      <div class="TOCEntry">
         <h2>Types</h2>
         <xsl:for-each select=".//Type">
            <xsl:call-template name="TOCEntryByName" />
         </xsl:for-each>
      </div>
   </xsl:template>

   <!--
   Create the table of contents for all the members of the
   type
   -->
   <xsl:template name="MemberTOC">
      <div class="TOCEntry">
         <h2>Members</h2>
         <xsl:for-each select=".//Member">
            <xsl:call-template name="TOCEntryByName" />
         </xsl:for-each>
      </div>
   </xsl:template>
   
   <!--
   A helper XSLT function that builds the anchor tag
   of any element with a 'Name' attribute
   -->
   <xsl:template name="TOCEntryByName">
      <a class="TOCEntry">
         <xsl:attribute name="href">
            #<xsl:value-of select="@Name"/>
         </xsl:attribute>
         <xsl:value-of select="@Name"/>
      </a>
   </xsl:template>

   <!-- Template for the Target element. All elements in the metrics
        results file is contained in this element -->
   <xsl:template match="Target">
      <xsl:apply-templates select="./Modules/Module" />
   </xsl:template>

   <xsl:template match="Module">
      <h2>
         <xsl:call-template name="BookMark" />
      </h2>

      <div class="Level1">
         <table class="ModuleDetails">
            <tr>
               <td class="Label">Full Path:</td>
               <td>
                  <xsl:value-of select="../../@Name"/>
               </td>
            </tr>
            <tr>
               <td class="Label">Assembly Verion:</td>
               <td>
                  <xsl:value-of select="@AssemblyVersion"/>
               </td>
            </tr>
            <tr>
               <td class="Label">File Version:</td>
               <td>
                  <xsl:value-of select="@FileVersion"/>
               </td>
            </tr>
         </table>

         <xsl:apply-templates select="Metrics" />
         <xsl:call-template name="NamespaceTOC" />
         <xsl:apply-templates select="./Namespaces/Namespace" />
      </div>
      
   </xsl:template>

   <xsl:template match="Metrics">
      <div>
         <table class="Metrics">
            <xsl:for-each select="./Metric">
               <tr>
                  <td class="Label"><xsl:value-of select="@Name"/>:</td>
                  <td>
                     <xsl:value-of select="@Value"/>
                  </td>
               </tr>
            </xsl:for-each>
         </table>
      </div>
   </xsl:template>

   <xsl:template match="Namespace">
      <div class="Level1">
         <h2>
            Namespace: <xsl:call-template name="BookMark" />
         </h2>
         <xsl:apply-templates select="Metrics" />

         <div class="Level1">
            <xsl:call-template name="TypeTOC" />
            <xsl:apply-templates select="./Types/Type"/>
         </div>
      </div>
   </xsl:template>

   <xsl:template name="BookMark">
      <a>
         <xsl:attribute name="name">
            <xsl:value-of select="@Name"/>
         </xsl:attribute>
         <xsl:value-of select="@Name"/>
      </a>
   </xsl:template>
   
   <xsl:template match="Type">
      <div>
         <h2>
            Type: <xsl:call-template name="BookMark" />
         </h2>
         <xsl:apply-templates select="Metrics" />

         <div class="Level1">
            <xsl:call-template name="MemberTOC"/>
            <xsl:apply-templates select="./Members/Member" />
         </div>
      </div>
   </xsl:template>

   <xsl:template match="Member">
      <div>
         <h4>
            <xsl:call-template name="BookMark" />
         </h4>

         <table class="MemberDetails">
            <tr>
               <td class="Label">File:</td>
               <td>
                  <xsl:value-of select="@File"/>
               </td>
            </tr>
            <tr>
               <td class="Label">Line:</td>
               <td>
                  <xsl:value-of select="@Line"/>
               </td>
            </tr>
         </table>

         <xsl:apply-templates select="Metrics" />
      </div>
   </xsl:template>
</xsl:stylesheet>
