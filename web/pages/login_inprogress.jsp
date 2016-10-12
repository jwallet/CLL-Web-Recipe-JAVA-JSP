<%@ page language="java" contentType="text/html; charset=ISO-8859-15"
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
            <div class="sommaire">
                <c:redirect url="admin_recipe_tolist.jsp"/>
            </div>
        </c:when>
        <c:otherwise>
             <c:redirect url="login.jsp?failed=true"/>
        </c:otherwise>
    </c:choose>
