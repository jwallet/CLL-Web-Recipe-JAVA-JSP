<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/dbrecette"
     user="root"  password=""/>

<sql:query dataSource="${snapshot}" var="result">SELECT * from recettes;</sql:query>                                  
<c:set var="current" value="<%=request.getRequestURI().substring(request.getRequestURI().lastIndexOf('/')+1, request.getRequestURI().length()) %>"/>
<c:set var="id" value="<%=request.getParameter("id")%>"/> 
<div id='header'>
    <div class="icon"><a href="javascript:void(0);" onclick="burgerpourmobile()">&#9776;</a></div>
    <div class="banniere"></div>    
    <div class='menu' id='menu'>
        <ul>
            <li <c:if test="${current == 'admin_recipe_tolist.jsp'}">class='active'</c:if>><a href="admin_recipe_tolist.jsp">Liste des recettes</a></li>

            <%--<c:if test="${id eq null}">--%>
                <li <c:if test="${current == 'admin_recipe_form.jsp' && id eq null}">class='active'</c:if>><a href="admin_recipe_form.jsp">Ajout d'une recette</a></li>
            <%--</c:if>--%>

                <li><a class="active" href='logout.jsp'>Déconnexion (<c:out value="${param.cUser}"/>)</a></li>
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