<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<c:set var="hash" value=""/>
<%
    byte[] bytes = "0:?0$è0u3!l3t4T0û7f41tCepr#Jè7".getBytes();
    String mypass = request.getParameter("password");
    String mynewpass = new String();
    byte[] b = mypass.getBytes();
    for(int i=0;i<b.length;i++)
    {
        b[i] += bytes[i];
        mynewpass += (char)(b[i]-20)/5;
        mynewpass += (char)(b[i]*2-17)/2;
        mynewpass += (char)((b[i]*5))/3;
    }
    pageContext.setAttribute("hash", mynewpass);
%>

<c:choose>    
    <c:when test="${!empty hash}">
            <c:out value="${hash}"/><br/><a href="login.jsp">Retour</a>
    </c:when>
    <c:otherwise>
         <c:redirect url="login.jsp?failed=true"/>
    </c:otherwise>
</c:choose>
