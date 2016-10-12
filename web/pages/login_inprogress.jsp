<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/dbrecette"
     user="root"  password=""/>

<sql:query dataSource="${snapshot}" var="user">select * FROM redacteurs WHERE usager like "<%=request.getParameter("user")%>" and motdepasse like "<%=request.getParameter("password")%>" LIMIT 1;</sql:query>
  
    <c:choose>    
        <c:when test="${user.rowCount == 1}">
                <%
                    // Create cookies for first and last names.      
                    Cookie usager = new Cookie("usager",
                                           request.getParameter("user"));
                    Cookie motdepasse = new Cookie("motdepasse",
                                           request.getParameter("password"));

                    // Set expiry date after 24 Hrs for both the cookies.
                    usager.setMaxAge(60*60*24); 
                    motdepasse.setMaxAge(60*60*24); 

                    // Add both the cookies in the response header.
                    response.addCookie( usager );
                    response.addCookie( motdepasse );
                 %>
                <c:redirect url="admin_recipe_tolist.jsp"/>
        </c:when>
        <c:otherwise>
             <c:redirect url="login.jsp?failed=true"/>
        </c:otherwise>
    </c:choose>
