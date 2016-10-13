<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/dbrecette"
     user="root"  password=""/>

<sql:query dataSource="${snapshot}" var="labels">SELECT * FROM p_type_label</sql:query>

<div id=header>
    <div class="banniere_lien">
        <!--<img src="${pageContext.request.contextPath}/resources/logo.png"/>-->
    </div>
        
    <div class='menu'>
    <ul>
        <li class='lien'>Toutes les recettes</a></li>
        <c:forEach var="lbl" items="${labels.rows}">
            <li class='lien'>${lbl.label}</li>
        </c:forEach>
        <li class='lien' style="float:right">Administration</li>
    </ul>        
    </div>
</div>
