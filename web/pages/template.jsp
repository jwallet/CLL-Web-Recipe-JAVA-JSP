<%@ page language="java" contentType="text/html; charset=UTF-8"
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
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/style.css" />
</head>
<body>
	<jsp:include page="/pages/${param.admin}header.jsp"/>

	
	<!--<h2>${param.title}</h2>-->

	<jsp:include page="/pages/${param.content}.jsp">
            <jsp:param name="id" value="<%=request.getParameter("id")%>"/>
        </jsp:include>
	
	<jsp:include page="/pages/${param.admin}footer.jsp"/>
	
	
</body>
</html>