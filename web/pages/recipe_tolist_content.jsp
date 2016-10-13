<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>--%>
<%--<% pageContext.setAttribute("newLineChar", "\n"); %>--%>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/dbrecette"
     user="root"  password=""/>
<c:set var="lbl" value="<%=request.getParameter("lbl")%>"/>
<c:choose>
    <c:when test="${lbl eq null}">
        <sql:query dataSource="${snapshot}" var="recettes">SELECT * FROM recettes WHERE brouillon=0;</sql:query>
    </c:when>
    <c:otherwise>        
        <sql:query dataSource="${snapshot}" var="recettes">SELECT * FROM recettes r JOIN label l ON r.id_recette=l.id_recette JOIN p_type_label ptl ON l.id_type_label=ptl.id_type_label WHERE r.brouillon=0 AND ptl.label like '<%=request.getParameter("lbl")%>' AND l.actif=true;</sql:query>
    </c:otherwise>
</c:choose>
        
<c:forEach var="rec" items="${recettes.rows}" varStatus="status">
    <sql:query dataSource="${snapshot}" var="image">SELECT * FROM images WHERE id_recette=${rec.id_recette} ORDER BY principale DESC;</sql:query>
    <!--<div style="background-image: url(${pageContext.request.contextPath}${image.rows[0].url_local});background-position: center;background-size:100%;">-->
    <div class="post">
          
        <c:choose>
            <c:when test="${image.rowCount==0}">
                <div class="image">
                    <img class='thumbnail' alt="Aucune image reliée" src="${pageContext.request.contextPath}/resources/images/aucune.jpg"/>
                </div>                    
            </c:when>
            <c:otherwise>
                <c:forEach var="img" items="${image.rows}" varStatus="loopimg">
                    <div class="image">                
                        <c:choose>
                            <c:when test="${loopimg.index eq 0}"> 
                                <a href="${pageContext.request.contextPath}${img.url_local}" data-lightbox="${rec.titre}">
                                    <img class="zoom"src="../resources/images/zoom.png"/><img class='thumbnail' alt="${rec.titre}" src="${pageContext.request.contextPath}${img.url_local}"/>
                                    </a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}${img.url_local}" data-lightbox="${rec.titre}">
                                    <img class='hidden_thumbnail'width="0px" height="0px" alt="${rec.titre}" src="${pageContext.request.contextPath}${img.url_local}" />
                                    </a>
                            </c:otherwise>
                        </c:choose>                
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
        <div class="titre"><a href="recipe_detail.jsp?id=${rec.id_recette}">${rec.titre}</a></div>
        <div class="description">${rec.description}<%--${fn:replace(rec.description, newLineChar, "<br />")}--%></div>
        <sql:query dataSource="${snapshot}" var="sommaire">SELECT * FROM sommaire som JOIN p_type_sommaire pts ON som.id_type_sommaire=pts.id_type_sommaire WHERE id_recette=${rec.id_recette};</sql:query>
        <div class="sommaire">
            <c:forEach var="som" items="${sommaire.rows}" varStatus="somloop">
                <c:choose>    
                    <c:when test="${som.id_type_sommaire != 0}">
                        <c:choose>                     
                            <c:when test="${somloop.index%2 eq 0}">                       
                                <div class="droit"><b>Temps de ${som.type}:</b> ${som.nbre_unite}</div>
                            </c:when>
                            <c:otherwise>
                                <div class="gauche"><b>Temps de ${som.type}:</b> ${som.nbre_unite}</div>
                            </c:otherwise>
                         </c:choose>
                    </c:when>
                    <c:otherwise>
                        <div class="gauche"><b>Nombre de ${som.type}:</b> ${som.nbre_unite}</div> 
                    </c:otherwise>
                </c:choose>                 
            </c:forEach>
        </div>   
        <!--<div class="readmore"><a href="recipe_detail.jsp?id=${rec.id_recette}">Lire la recette</a></div>-->
    </div>
</c:forEach>   