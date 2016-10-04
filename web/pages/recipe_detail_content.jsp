<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/dbrecette"
     user="root"  password=""/>

<sql:query dataSource="${snapshot}" var="recettes">SELECT * FROM recettes WHERE id_recette=<%=request.getParameter("id")%>;</sql:query>
<sql:query dataSource="${snapshot}" var="label_recette">SELECT * FROM label lbl JOIN p_type_label ptl ON lbl.id_type_label=ptl.id_type_label WHERE lbl.id_recette=<%=request.getParameter("id")%>;</sql:query>
<sql:query dataSource="${snapshot}" var="ingredients_recette">SELECT * FROM ingredients ing JOIN p_type_unite ptu ON ing.id_type_unite=ptu.id_type_unite JOIN p_type_fraction ptf ON ing.id_type_fraction=ptf.id_type_fraction WHERE ing.id_recette=<%=request.getParameter("id")%>;</sql:query>
<sql:query dataSource="${snapshot}" var="sommaire">SELECT * FROM sommaire som JOIN p_type_sommaire pts ON som.id_type_sommaire=pts.id_type_sommaire WHERE id_recette=<%=request.getParameter("id")%>;</sql:query>
<sql:query dataSource="${snapshot}" var="image">SELECT * FROM images WHERE id_recette=<%=request.getParameter("id")%>;</sql:query>

<c:forEach var="rec" items="${recettes.rows}" varStatus="status">
    <div class="post">
        <div class="titre"><a href="recipe_detail.jsp?id=${rec.id_recette}">${rec.titre}</a></div>
        <!-- IMAGE URL HERE -->
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
        <div class="description">${rec.description}</div>
        <div class="sommaire">
            <c:forEach var="som" items="${sommaire.rows}" varStatus="status">
                <c:choose>    
                    <c:when test="${som.id_type_sommaire != 4}">
                        <div class="${som.type}"><b>Temps de ${som.type}:</b> ${som.nbre_unite}</div> 
                    </c:when>
                    <c:otherwise>
                        <div class="${som.type}"><b>Nombre de ${som.type}:</b> ${som.nbre_unite}</div> 
                    </c:otherwise>
                </c:choose>                 
            </c:forEach>
        </div>   
        
        <div class="ingredients"><b>Ingrédients</b>:
            <ul>
             <c:forEach var="ing" items="${ingredients_recette.rows}" varStatus="ingloop"> 
                 <c:choose>                     
                     <c:when test="${ingloop.index%2 eq 1}">                         
                         
                            <li class="gauche">${ing.quantite}${ing.fraction} ${ing.type_unite} ${ing.ingredient}</li>
                        
                     </c:when>
                     <c:otherwise>
                            <li class="droit">${ing.quantite}${ing.fraction} ${ing.type_unite} ${ing.ingredient}</li>
                     </c:otherwise>
                 </c:choose>
            </c:forEach>
                            </ul>
        </div>
        <p>TO DO : Zone note sur un ingredient dans un fieldset ou carre blanc</p>
        <div class="instructions"><p><b>Instructions:</b></p>${rec.instructions}</div>
    </div>
</c:forEach>
