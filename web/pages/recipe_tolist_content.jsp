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


<c:forEach var="rec" items="${recettes.rows}" varStatus="status">
    <div id="encadrement">
    <div class="post">
        <div class="titre"><a href="recipe_detail.jsp?id=${rec.id_recette}">${rec.titre}</a></div>
        <!-- IMAGE URL HERE -->
        <sql:query dataSource="${snapshot}" var="image">SELECT * FROM images WHERE id_recette=${rec.id_recette};</sql:query>
        <c:forEach var="img" items="${image.rows}" varStatus="loopimg">
                <c:choose>
                    <c:when test="${loopimg.index eq 0}">
                        <div class="image">
                            <img width="200px" height="133px" alt="${rec.titre}" src="${pageContext.request.contextPath}${img.url_local}"/>
                            <div class="msg">Cliquez sur l'image pour agrandir</div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="image">
                            <img width="0px" height="0px" alt="${rec.titre}" src="${pageContext.request.contextPath}${img.url_local}"/>
                        </div>
                    </c:otherwise>
                </c:choose>
        </c:forEach>
        <div class="description">${rec.description}</div>
        <div class="sommaire">
            <sql:query dataSource="${snapshot}" var="sommaire">SELECT * FROM sommaire som JOIN p_type_sommaire pts ON som.id_type_sommaire=pts.id_type_sommaire WHERE id_recette=${rec.id_recette};</sql:query>
            <c:forEach var="som" items="${sommaire.rows}" varStatus="status">
                <div class="${som.type}"><b>Temps de ${som.type}:</b> ${som.nbre_unite}</div>                
            </c:forEach>
        </div>   
        <div class="readmore"><a href="recipe_detail.jsp?id=${rec.id_recette}">Lire la recette</a></div>
    </div>
    </div>
</c:forEach>   