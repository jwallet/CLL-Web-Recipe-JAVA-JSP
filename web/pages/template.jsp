<%@ page language="java" contentType="text/html; charset=ISO-8859-15"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/dbrecette"
     user="root"  password=""/>

<!DOCTYPE HTML>
<html>
<head>
    <title>${param.title}</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.1.1.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/style.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/lightbox.css"/>
</head>
<body>    
    <jsp:include page="/pages/${param.admin}header.jsp"/>	
    <jsp:include page="/pages/${param.content}.jsp"/>
    <jsp:include page="/pages/${param.admin}footer.jsp"/>  
    <script src="${pageContext.request.contextPath}/resources/js/lightbox.js"></script>    
</body>
</html>