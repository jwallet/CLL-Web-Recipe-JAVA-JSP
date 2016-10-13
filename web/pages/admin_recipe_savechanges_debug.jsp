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
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/dbrecette"
     user="root"  password=""/>

<c:forEach var="para" items="${paramValues}">
     <c:out value="${para.key}"/><br>
     <c:out value="${para.value[0]}" />....
     <c:out value="${para.value[1]}" />...
     <c:out value="${para.value[2]}" />...
     <c:out value="${para.value[3]}" />...
     <c:out value="${para.value[4]}" />...
     <c:out value="${para.value[5]}" />..<br/>
</c:forEach>
     <br><br><br><br>
     
     <c:set var="titre" value="${param.recette_titre}"/>
    <c:out value="${titre}"/><br/>
    <c:out value="${param.recette_titre}"/><br/>

    <br><br><br><br><br>
    
<c:forEach var="ing" items="${paramValues.recette_ing_ingredient}">
    <c:out value="${ing}"/><br/>
</c:forEach>
    <br><br><br>
    
    <c:forEach var="ing" items="${paramValues.recette_ing_quantite}">
    <c:out value="${ing}"/><br/>
</c:forEach>
    <br><br><br>
    
    <c:forEach var="ing" items="${paramValues.recette_ing_type_fraction}">
    <c:out value="${ing}"/><br/>
</c:forEach>
    <br><br><br>
    
    <c:forEach var="ing" items="${paramValues.recette_label}">
    <c:out value="${ing}"/><br/>
</c:forEach>
    <br><br><br>

    <c:forEach var="ing" items="${paramValues.recette_ing_type_unite}">
    <c:out value="${ing}"/><br/>
</c:forEach>
    <br><br><br>

<c:out value="${param.recette_ing_quantite}"/><br>

<c:out value="${fn:length(paramValues.recette_ing_ingredient)}"/>

<br>
<c:set var="mm" value="3"/>
<c:forEach begin="${mm +1}" end="5" varStatus="l">
                    <c:out value="${l.index}"/>
                </c:forEach>