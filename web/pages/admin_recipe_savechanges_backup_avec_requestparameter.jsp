<%@ page language="java" contentType="text/html; charset=ISO-8859-15"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/dbrecette"
     user="root"  password=""/>
<c:set var="id" value="<%=request.getParameter("recette_id")%>"/>
<c:choose>
<%--si c'est une nouvelle recette AJOUT--%>
<c:when test="${empty id}" >        
        <%--Ajout Titre, Description, Etapes preparation, notes additionnelles, brouillon=actif--%>
        <sql:update dataSource="${snapshot}" var="count">INSERT INTO recettes (titre, description, instructions, notes, brouillon) VALUES (<%=request.getParameter("recette_titre")%>, <%=request.getParameter("recette_description")%>, <%=request.getParameter("recette_instructions")%>, <%=request.getParameter("recette_notes")%>, 1);</sql:update>
        <%--Trouve ID dans BD--%>
        <sql:query dataSource="${snapshot}" var="id_recette">SELECT id_recette FROM recettes ORDER BY id_recette DESC LIMIT 1;</sql:query>
        <%--Ajout categorie--%>
        <c:forEach var="lbl" items="<%=request.getParameter("recette_label")%>">
            <sql:update dataSource="${snapshot}" var="count">INSERT INTO label (id_recette, id_type_label) VALUES (${id_recette},'${lbl}')</sql:update>
        </c:forEach>
        <%--Ajout sommaire (x4)--%>
        <sql:update dataSource="${snapshot}" var="count">INSERT INTO sommaire (id_recette, id_type_sommaire, nbre_unite) VALUES (${id_recette},1,<%=request.getParameter("recette_préparation")%>)</sql:update>
        <sql:update dataSource="${snapshot}" var="count">INSERT INTO sommaire (id_recette, id_type_sommaire, nbre_unite) VALUES (${id_recette},2,<%=request.getParameter("recette_cuisson")%>)</sql:update>
        <sql:update dataSource="${snapshot}" var="count">INSERT INTO sommaire (id_recette, id_type_sommaire, nbre_unite) VALUES (${id_recette},3,<%=request.getParameter("recette_refroidissement")%>)</sql:update>
        <sql:update dataSource="${snapshot}" var="count">INSERT INTO sommaire (id_recette, id_type_sommaire, nbre_unite) VALUES (${id_recette},4,<%=request.getParameter("recette_portions")%>)</sql:update>
        <%--Ajout ingredients (tous)--%>
        <c:forEach var="ingredient" items="<%=request.getParameter("recette_ingredient")%>" varStatus="i">
            <sql:update dataSource="${snapshot}" var="count">INSERT INTO label (id_recette, quantite, id_type_fraction, id_type_unite, ingredient) VALUES (${id_recette},
                    ${paramValues.recette_ing_quantite[i.index].value},
                    ${paramValues.recette_ing_type_fraction[i.index].value},
                    ${paramValues.recette_ing_type_type_unite[i.index].value},
                    ${ingredient});
            </sql:update>
        </c:forEach>
        <%--Ajout des images--%>
        <c:forEach var="image" items="<%=request.getParameter("recette_upload")%>" varStatus="i">
            <sql:update dataSource="${snapshot}" var="count">INSERT INTO label (id_recette, url_local) VALUES (${id_recette},${image});</sql:update>
        </c:forEach>        
    </c:when>
<%--si c'est une modification d'une recette MODIF--%>
    <c:otherwise>        
        <sql:update dataSource="${snapshot}" var="count">UPDATE 'recettes' SET 'titre'='<%=request.getParameter("recette_titre")%>', 'description'='<%=request.getParameter("recette_description")%>', 'instructions'='<%=request.getParameter("recette_instructions")%>', 'notes'='<%=request.getParameter("recette_notes")%>' WHERE id_recette'=<%=request.getParameter("recette_id")%>;</sql:update>
    </c:otherwise>
        
</c:choose>

        <%
   File file ;
   int maxFileSize = 5000 * 1024;
   int maxMemSize = 5000 * 1024;
   String idRecette;
   if(request.getParameterMap().containsKey("recette_id"))
   {
       idRecette = request.getParameter("recette_id");
   }
   else
   {
       idRecette = (String)pageContext.getAttribute("id_recette");;
   }
   ServletContext context = pageContext.getServletContext();
   String Path = context.getRealPath("\\images\\");
   String filePath = Path + idRecette + "\\";
   File repertoire = new File(filePath);
   if(!repertoire.exists())
   {
       repertoire.mkdir();
   }
   String contentType = request.getContentType();
   if ((contentType.indexOf("multipart/form-data") >= 0)) {

      DiskFileItemFactory factory = new DiskFileItemFactory();
      // maximum size that will be stored in memory
      factory.setSizeThreshold(maxMemSize);
      // Location to save data that is larger than maxMemSize.
      factory.setRepository(new File(Path+"\\temp"));

      // Create a new file upload handler
      ServletFileUpload upload = new ServletFileUpload(factory);
      // maximum file size to be uploaded.
      upload.setSizeMax( maxFileSize );
      try{ 
         // Parse the request to get file items.
         List fileItems = upload.parseRequest(request);

         // Process the uploaded file items
         Iterator i = fileItems.iterator();

//         out.println("<html>");
//         out.println("<head>");
//         out.println("<title>JSP File upload</title>");  
//         out.println("</head>");
//         out.println("<body>");
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
            //out.println("Uploaded Filename: " + filePath + 
            //fileName + "<br>");
            }
         }
//         out.println("</body>");
//         out.println("</html>");
      }catch(Exception ex) {
         System.out.println(ex);
      }
   }else{
//      out.println("<html>");
//      out.println("<head>");
//      out.println("<title>Servlet upload</title>");  
//      out.println("</head>");
//      out.println("<body>");
//      out.println("<p>No file uploaded</p>"); 
//      out.println("</body>");
//      out.println("</html>");
   }
%>
<%--<c:redirect url="admin_recipe_tolist.jsp"/>--%>

