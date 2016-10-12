<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://www.atg.com/taglibs/json" prefix="json" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/dbrecette"
     user="root"  password=""/>

<sql:query dataSource="${snapshot}" var="labels">SELECT * FROM p_type_label</sql:query>
<c:set var="lblActuel" value="<%=request.getParameter("lbl")%>"/>
<c:set var="id" value="<%=request.getParameter("id")%>"/>
<div id=header>
    <div class="banniere">
        <a href="${pageContext.request.contextPath}">BANNIERE DU SITE QUI RETOURNE A LA PAGE PRINCIPALE
        <!--<img src="${pageContext.request.contextPath}/resources/logo.png"/>-->
        </a>
    </div>
        
    <div class='menu'>
    <ul>
        <li <c:if test="${empty lblActuel && empty id}">class='active'</c:if>><a href="recipe_tolist.jsp">Toutes les recettes</a></li>
        <c:forEach var="lbl" items="${labels.rows}">
            <li <c:if test="${lblActuel==lbl.label}">class='active'</c:if>><a href="recipe_tolist.jsp?lbl=${lbl.label}">${lbl.label}</a></li>
        </c:forEach>
        <li style="float:right"><a class="active" href="${pageContext.request.contextPath}">Commentaires</a></li>
    </ul>        
    </div>
</div>