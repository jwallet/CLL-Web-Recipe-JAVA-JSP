<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
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
<c:set var="current" value="<%=request.getRequestURI().substring(request.getRequestURI().lastIndexOf('/')+1, request.getRequestURI().length()) %>"/>
<div id='header'>
    <div class="icon"><a href="javascript:void(0);" onclick="burgerpourmobile()">&#9776;</a></div>
    <div class="banniere"></div>    
    <div class='menu' id="menu">
    <ul>        
        <li <c:if test="${empty lblActuel && empty id && !(current=='login.jsp')}">class='active'</c:if>><a href="recipe_tolist.jsp">Toutes</a></li>
        <c:forEach var="lbl" items="${labels.rows}">
            <li <c:if test="${lblActuel==lbl.label}">class='active'</c:if>><a href="recipe_tolist.jsp?lbl=${lbl.label}">${lbl.label}</a></li>
        </c:forEach>
            <li <c:if test="${current == 'login.jsp'}">class='active'</c:if>><a class="active" href="admin_recipe_tolist.jsp">Administration</a></li>
    </ul>        
    </div>
</div>
<script>
function burgerpourmobile() {
    var x = document.getElementById("menu");
    if (x.className === "menu") {
        x.className = "mobile";
    } else {
        x.className = "menu";
    }
}
</script>
    