<%@page import="java.net.URLEncoder"%>
<%@page import="java.nio.charset.Charset"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
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

 <sql:query dataSource="${snapshot}" var="recette">SELECT  id_recette FROM recettes ORDER BY id_recette DESC LIMIT 1;</sql:query>  
 
<c:set var="id_recette" value="${recette.rows[0].id_recette + 1}"/>
<%
   File file ;
   int maxFileSize = 5000 * 1024;
   int maxMemSize = 10000 * 1024;
   int x = 0;
   String idRecette;
   String getLink = new String();
   if(request.getParameterMap().containsKey("id")){
       idRecette = request.getParameter("id").toString();
   }
   else{
       idRecette = pageContext.getAttribute("id_recette").toString();
   }
   //idRecette = pageContext.getAttribute("id_recette").toString();
   ServletContext context = pageContext.getServletContext();
   String Path = context.getRealPath("\\images\\");
   String filePath = Path + "\\" +idRecette + "\\";
   File repertoire = new File(filePath);
   if(!repertoire.exists()){repertoire.mkdir();}
   String contentType = request.getContentType();
   if ((contentType.indexOf("multipart/form-data") >= 0)) {
      DiskFileItemFactory factory = new DiskFileItemFactory();
      factory.setSizeThreshold(maxMemSize);
      factory.setRepository(new File(Path+"\\temp"));
      ServletFileUpload upload = new ServletFileUpload(factory);
      upload.setHeaderEncoding("UTF-8");
      upload.setSizeMax( maxFileSize );
      try{ 
         List fileItems = upload.parseRequest(request);
         Iterator i = fileItems.iterator();
         while ( i.hasNext () ) 
         {
            x++;
            FileItem fi = (FileItem)i.next();
            if ( !fi.isFormField () )	
            {
                // Get the uploaded file parameters
                FileItem fiImg = fi;
                String fieldName = fiImg.getFieldName();
                String fileName = fiImg.getName().replaceAll(" ","_").toLowerCase();
                if(fileName!="")
                {
                    boolean isInMemory = fiImg.isInMemory();
                    long sizeInBytes = fiImg.getSize();

                    getLink+= fieldName + '=' + URLEncoder.encode(fileName,"Windows-1252") + '&';
                    // Write the file
                    if( fileName.lastIndexOf("\\") >= 0 ){
                    file = new File( filePath + 
                    fileName.substring( fileName.lastIndexOf("\\"))) ;
                    }else{
                    file = new File( filePath + 
                    fileName.substring(fileName.lastIndexOf("\\")+1)) ;
                    }
                        fiImg.write( file ) ;
                }
            }
            else
            {
                
                //String fName = fi.getFieldName();
                //String fContent = fi.getString("UTF-8");//new String(fi.getString("UTF-8").getBytes("ISO-8859-1"),"UTF-8");
                //fContent = fContent.replaceAll("\r\n","<br />");
//                byte[] bytes = fContent.getBytes("UTF-8");
//                StringBuilder buf = new StringBuilder();
//                for(int compteur = 0;compteur<bytes.length;compteur++)
//                {
//                    buf.append("&#");
//                    buf.append((int)bytes[compteur]);
//                    buf.append(';');
//                }
                
                getLink+= fi.getFieldName() + '=' + URLEncoder.encode(fi.getString("UTF-8"),"Windows-1252") + '&';
            }
         }        
         
      }catch(Exception ex){
         System.out.println(ex);
      }
      getLink = getLink.substring(0, getLink.length()-2);
      
      response.sendRedirect("admin_recipe_savechanges.jsp?"+ getLink);
   }
%>

