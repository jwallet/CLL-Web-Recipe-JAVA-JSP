<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/dbrecette"
     user="root"  password=""/>

<sql:query dataSource="${snapshot}" var="result">SELECT * from recettes;</sql:query>

<c:set var="id" value="<%=request.getParameter("id")%>"/>                                   
<div class='menu'>
    <ul>
        <li ><a href="admin_recipe_tolist.jsp">Liste des recettes</a></li>

        <c:if test="${id eq null}">
            <li><a href="admin_recipe_form.jsp">Ajout d'une recette</a></li>
        </c:if>
            
        <!--<li style="float:right"><a class="active" href='#logout'>Déconnexion</a></li>-->
    </ul>        
</div>
