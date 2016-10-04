<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
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
</c:forEach>
<sql:update dataSource="${snapshot}" var="count">D FROM recettes WHERE id_recette=<%=request.getParameter("id")%>;</sql:update>

        
<c:redirect url="admin_recipe_tolist.jsp"/>

