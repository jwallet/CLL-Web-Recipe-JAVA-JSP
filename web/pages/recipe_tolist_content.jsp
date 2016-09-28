<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/dbrecette"
     user="root"  password=""/>

<sql:query dataSource="${snapshot}" var="recettes">SELECT * FROM recettes WHERE brouillon=0;</sql:query>
<%--<sql:query dataSource="${snapshot}" var="labels">SELECT * FROM p_type_label</sql:query>
<sql:query dataSource="${snapshot}" var="unites">SELECT * FROM p_type_unite</sql:query>
  
<sql:query dataSource="${snapshot}" var="label_recette">SELECT * FROM label lbl JOIN p_type_label ptl ON lbl.id_type_label=ptl.id_type_label WHERE lbl.id_recette=<%=request.getParameter("id")%>;</sql:query>
<sql:query dataSource="${snapshot}" var="ingredients_recette">SELECT * FROM ingredients ing JOIN p_type_unite ptu ON ing.id_type_unite=ptu.id_type_unite WHERE ing.id_recette=<%=request.getParameter("id")%>;</sql:query>
--%>


<c:forEach var="rec" items="${recettes.rows}" varStatus="status">
    <div id="encadrement">
    <div class="post">
        <div class="titre"><a href="recipe_detail.jsp?id=${rec.id_recette}">${rec.titre}</a></div>
        <div class="description">${rec.description}</div>
        <div class="sommaire">
            <sql:query dataSource="${snapshot}" var="sommaire">SELECT * FROM sommaire som JOIN p_type_sommaire pts ON som.id_type_sommaire=pts.id_type_sommaire WHERE id_recette=${rec.id_recette};</sql:query>
            <c:forEach var="som" items="${sommaire.rows}" varStatus="status">
                <div class="${som.type}"><b>Temps de ${som.type}:</b> ${som.nbre_unite}</div>                
            </c:forEach>
        </div>   
<!-- IMAGE URL HERE -->
        <div class="image"></div>
        <div class="readmore"><a href="recipe_detail.jsp?id=${rec.id_recette}">Lire la recette</a></div>
    </div>
    </div>
</c:forEach>   