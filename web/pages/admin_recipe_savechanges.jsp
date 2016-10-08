<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/dbrecette"
     user="root"  password=""/>

<c:set var="id" value="${param.recette_id}"/>

<sql:transaction dataSource="${snapshot}">
<c:choose>
<%--si c'est une nouvelle recette AJOUT--%>
<c:when test="${empty id}" >        
        <%--Ajout Titre, Description, Etapes preparation, notes additionnelles, brouillon=actif--%>
        <sql:update  var="count">INSERT INTO recettes (titre, description, instructions, notes, brouillon) VALUES ('${param.recette_titre}', '${param.recette_description}', '${param.recette_instructions}', '${param.recette_notes}', 1)</sql:update>
        
        <%--Trouve ID dans BD--%>
        <sql:query  var="id_recettes">SELECT id_recette FROM recettes ORDER BY id_recette DESC LIMIT 1;</sql:query>
        <c:set var="id_recette" value="${id_recettes.rows[0].id_recette}"/>
        
        <%--Ajout categorie--%>
        <c:if test="${!empty param.recette_label}">
            <c:forEach var="lbl" items="${paramValues.recette_label}" varStatus="j">
                <c:set var="sqllbl" value="${j.first ? '' : sqllbl}(${id_recette},${lbl}),"/>
            </c:forEach>
            <c:set var="sqllbl" value="${fn:substring(sqllbl,0,fn:length(sqllbl)-1)}" />
            <sql:update var="count">INSERT INTO label (id_recette, id_type_label) VALUES ${sqllbl};</sql:update>
        </c:if>
            
        <%--Ajout sommaire (x4)--%>
        <sql:update var="count">INSERT INTO sommaire (id_recette, id_type_sommaire, nbre_unite) VALUES (${id_recette},1,'${param.recette_préparation}')</sql:update>
        <sql:update var="count">INSERT INTO sommaire (id_recette, id_type_sommaire, nbre_unite) VALUES (${id_recette},2,'${param.recette_cuisson}')</sql:update>
        <sql:update var="count">INSERT INTO sommaire (id_recette, id_type_sommaire, nbre_unite) VALUES (${id_recette},3,'${param.recette_refroidissement}')</sql:update>
        <sql:update var="count">INSERT INTO sommaire (id_recette, id_type_sommaire, nbre_unite) VALUES (${id_recette},4,'${param.recette_portions}')</sql:update>
        
        <%--Ajout ingredients (tous)--%>
        <c:if test="${!empty param.recette_ing_ingredient}">
            <c:forEach var="ingredient" items="${paramValues.recette_ing_ingredient}" varStatus="i">
                <c:set var="sqling" value="${i.first ? '' : sqling}(${id_recette},${paramValues.recette_ing_quantite[i.index]},${paramValues.recette_ing_type_fraction[i.index]},${paramValues.recette_ing_type_unite[i.index]},'${ingredient}'),"/>
            </c:forEach>
            <c:set var="sqling" value="${fn:substring(sqling,0,fn:length(sqling)-1)}"/>
            <sql:update var="count">INSERT INTO ingredients (id_recette, quantite, id_type_fraction, id_type_unite, ingredient) VALUES ${sqling};</sql:update>
        </c:if>
        
        <%--Ajout des images--%>
        <c:if test="${!empty param.recette_upload}">
            <c:forEach var="image" items="${paramValues.recette_upload}" varStatus="k">
                <c:set var="sqlimg" value="${k.first ? '' : sqlimg}(${id_recette},'/images/${id_recette}/${image}'),"/>
            </c:forEach> 
            <c:set var="sqlimg" value="${fn:substring(sqlimg,0,fn:length(sqlimg)-1)}"/>
        <sql:update var="count">INSERT INTO images (id_recette, url_local) VALUES ${sqlimg};</sql:update>
        </c:if>
    </c:when>

            <%--si c'est une modification d'une recette MODIF--%>
    <c:otherwise>        
        <sql:update var="count">UPDATE 'recettes' SET 'titre'='${param.recette_titre}', 'description'='${param.recette_description}', 'instructions'='${param.recette_instructions}', 'notes'='${param.recette_notes}' WHERE id_recette'=${param.recette_id};</sql:update>
    </c:otherwise>
        
</c:choose>
        </sql:transaction>
        
<%
   File file ;
   int maxFileSize = 5000 * 1024;
   int maxMemSize = 10000 * 1024;
   String idRecette;
   if(request.getParameterMap().containsKey("recette_id")){
       idRecette = (String)request.getParameter("recette_id");
   }
   else{
       idRecette = (String)pageContext.getAttribute("id_recette");;
   }
   idRecette= "134";
   ServletContext context = pageContext.getServletContext();
   String Path = context.getRealPath("\\images\\");
   String filePath = Path + idRecette + "\\";
   File repertoire = new File(filePath);
   if(!repertoire.exists()){repertoire.mkdir();}
   String contentType = request.getContentType();
   if ((contentType.indexOf("multipart/form-data") >= 0)) {
      DiskFileItemFactory factory = new DiskFileItemFactory();
      factory.setSizeThreshold(maxMemSize);
      factory.setRepository(new File(Path+"\\temp"));
      ServletFileUpload upload = new ServletFileUpload(factory);
      upload.setSizeMax( maxFileSize );
      try{ 
         List fileItems = upload.parseRequest(request);
         Iterator i = fileItems.iterator();
         while ( i.hasNext () ) 
         {
            FileItem fi = (FileItem)i.next();
            if ( !fi.isFormField () )	
            {
            // Get the uploaded file parameters
            String fieldName = fi.getFieldName();
            String fileName = fi.getName();
            boolean isInMemory = fi.isInMemory();
            long sizeInBytes = fi.getSize();
            // Write the file
            if( fileName.lastIndexOf("\\") >= 0 ){
            file = new File( filePath + 
            fileName.substring( fileName.lastIndexOf("\\"))) ;
            }else{
            file = new File( filePath + 
            fileName.substring(fileName.lastIndexOf("\\")+1)) ;
            }
            fi.write( file ) ;
            }
         }
      }catch(Exception ex){
         System.out.println(ex);
      }
   }
%>

<c:redirect url="admin_recipe_tolist.jsp"/>

