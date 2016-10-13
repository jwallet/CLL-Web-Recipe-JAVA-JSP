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

<sql:update dataSource="${snapshot}" var="count">DELETE FROM recettes WHERE id_recette=<%=request.getParameter("id")%>;</sql:update>

<%
    ServletContext context = pageContext.getServletContext();
    String Path = context.getRealPath("\\images\\");
    String filePath = Path + "\\" +request.getParameter("id") + "\\";
    File repertoire = new File(filePath);
    File[] files = repertoire.listFiles();
    if(files!=null)
    {
        for(File f: files)
        {
            f.delete();
        }
    }
    repertoire.delete();
    File fCache = new File(filePath);
    if(fCache!=null)
    {
        fCache.delete();
    }
%>
        
<c:redirect url="admin_recipe_tolist.jsp"/>

