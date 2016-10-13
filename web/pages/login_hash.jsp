<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<c:set var="hash" value=""/>
<%
    String mypass = request.getParameter("password");
    if(!mypass.isEmpty())
    {
        String mynewpass = new String();
        byte[] bHash = "0:?0$É0u3!l3t4T0û7f41tCeprÔJ%7".getBytes();    
        while(mypass.getBytes().length<30)
            mypass+=mypass;
        byte[] bMyPass = mypass.getBytes();
        byte[] bBuffer = "000000000000000000000000000000".getBytes();
        for(int i=0;i<bBuffer.length;i++)
        {            
            mynewpass += (int)(Math.abs((bMyPass[i])+(bHash[i])));
        }
        pageContext.setAttribute("hash", mynewpass);
    }
%>

<c:choose>    
    <c:when test="${!empty hash}">
            <c:out value="${hash}"/><br/><a href="login.jsp">Retour</a>
    </c:when>
    <c:otherwise>
         <c:redirect url="login.jsp?failed=true"/>
    </c:otherwise>
</c:choose>
