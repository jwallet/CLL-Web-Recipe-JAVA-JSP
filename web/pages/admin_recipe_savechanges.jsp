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

<%--<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/dbrecette"
     user="root"  password=""/>

<c:set var="count" value="<%=request.getParameter("count_box")%>"/>
<c:set var="indice" value="0"/>

<c:set var="titre" value="<%=request.getParameter("recette_titre")%>"/>
<c:set var="description" value="<%=request.getParameter("recette_description")%>"/>
<c:set var="Preparation" value="<%=request.getParameter("recette_Preparation")%>"/>
<c:set var="Cuisson" value="<%=request.getParameter("recette_Cuisson")%>"/>
<c:set var="Refroidissement" value="<%=request.getParameter("recette_Refroidissement")%>"/>
<c:set var="Portions" value="<%=request.getParameter("recette_Portions")%>"/>

<c:forEach var="0" items="<%=request.getParameter("recette_ing_quantite")%>" varStatus="loop">
    <c:set var="titre" value="<%=request.getParameter("recette_ing_quantite")%>"/>
    <c:set var="titre" value="<%=request.getParameter("recette_ing_ingredient")%>"/>
</c:forEach>--%>

<%
   File file ;
   int maxFileSize = 5000 * 1024;
   int maxMemSize = 5000 * 1024;
   String idRecette= "1";
   //String idRecette = request.getParameter("recette_id");
   ServletContext context = pageContext.getServletContext();
   String Path = context.getInitParameter("file-upload");
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

         out.println("<html>");
         out.println("<head>");
         out.println("<title>JSP File upload</title>");  
         out.println("</head>");
         out.println("<body>");
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
            out.println("Uploaded Filename: " + filePath + 
            fileName + "<br>");
            }
         }
         out.println("</body>");
         out.println("</html>");
      }catch(Exception ex) {
         System.out.println(ex);
      }
   }else{
      out.println("<html>");
      out.println("<head>");
      out.println("<title>Servlet upload</title>");  
      out.println("</head>");
      out.println("<body>");
      out.println("<p>No file uploaded</p>"); 
      out.println("</body>");
      out.println("</html>");
   }
%>



<%--<sql:update dataSource="${snapshot}" var="count">D FROM recettes WHERE id_recette=<%=request.getParameter("id")%>;</sql:update>--%>


        
<%--<c:redirect url="admin_recipe_tolist.jsp"/>--%>

