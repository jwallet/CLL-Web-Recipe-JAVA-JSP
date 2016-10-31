<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>   

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/dbrecette"
     user="root"  password=""/>

<sql:query dataSource="${snapshot}" var="recettes">SELECT * from recettes WHERE id_recette=<%=request.getParameter("id")%>;</sql:query>
<sql:query dataSource="${snapshot}" var="ingredients_recette">SELECT * FROM ingredients ing JOIN p_type_unite ptu ON ing.id_type_unite=ptu.id_type_unite JOIN p_type_fraction ptf ON ing.id_type_fraction=ptf.id_type_fraction WHERE ing.id_recette=<%=request.getParameter("id")%>;</sql:query>
<sql:query dataSource="${snapshot}" var="sommaire">SELECT * FROM sommaire som JOIN p_type_sommaire pts ON som.id_type_sommaire=pts.id_type_sommaire WHERE id_recette=<%=request.getParameter("id")%> ORDER BY pts.type DESC;</sql:query>
<sql:query dataSource="${snapshot}" var="image">SELECT * FROM images WHERE id_recette=<%=request.getParameter("id")%>;</sql:query>
<sql:query dataSource="${snapshot}" var="image">SELECT * FROM images WHERE id_recette=<%=request.getParameter("id")%> ORDER BY principale DESC;</sql:query>    
<c:forEach var="rec" items="${recettes.rows}" varStatus="status">
    <div class="post">
        <div class="haut" style="background-image: url('..${image.rows[0].url_local}')">
            <div class='post-inside'>
                <!-- IMAGE URL HERE -->
                <c:choose>
                    <c:when test="${image.rowCount==0}">
                        <div class="image">
                            <img class='thumbnail' alt="Aucune image reliée" src="${pageContext.request.contextPath}/resources/images/aucune.png"/>
                        </div>                    
                    </c:when>
                    <c:otherwise>
                        <div class="image">                
                            <a href="${pageContext.request.contextPath}${image.rows[0].url_local}" data-lightbox="${rec.titre}">
                                <img class="zoom"src="../resources/images/zoom.png"/><img class='thumbnail' alt="${rec.titre}" src="${pageContext.request.contextPath}${image.rows[0].url_local}"/>
                            </a>              
                        </div>
                    </c:otherwise>
                </c:choose>
                <div class="titre"><mid>${rec.titre}</mid></div>
                <c:if test="${!empty rec.description}"><div class="description">${rec.description}</div></c:if>
                <div class="sommaire"><c:forEach var="som" items="${sommaire.rows}" varStatus="somloop">
                        <c:if test="${!empty som.nbre_unite}">
                            <ligne><strong>${som.type}</strong> ${som.nbre_unite} <c:if test="${somloop.count != 3}">min</c:if></ligne>
                        </c:if>
                </c:forEach></div>
                   
            </div>
        </div>
        <div class="post-inside">
            <c:if test="${!empty rec.notes}"><div class='notes'><p>${fn:replace(rec.notes, newLineChar, "<br />")}</p></c:if>
        </div>
        
           <div class="post-inside"> 
        <div class="ingredients"><b>Ingrédients</b>:
            <ul>
             <c:forEach var="ing" items="${ingredients_recette.rows}" varStatus="ingloop"> 
                 <c:choose>                     
                    <c:when test="${ingloop.index%2 eq 1}">                       
                        <li class="gauche">${ing.quantite}${ing.fraction} ${ing.type_unite}
                        <c:choose>
                                <c:when test="${fn:contains(ing.ingredient, '*')}">
                                    <strong>${fn:replace(ing.ingredient,'*',"</strong><note>")}</note>
                                </c:when>
                                <c:otherwise>
                                    <strong>${ing.ingredient}</strong>
                                </c:otherwise>
                            </c:choose>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="droit">${ing.quantite}${ing.fraction} ${ing.type_unite} 
                            <c:choose>
                                <c:when test="${fn:contains(ing.ingredient, '*')}">
                                    <strong>${fn:replace(ing.ingredient,'*',"</strong><note>")}</note>
                                </c:when>
                                <c:otherwise>
                                    <strong>${ing.ingredient}</strong>
                                </c:otherwise>
                            </c:choose>
                        </li>
                    </c:otherwise>
                 </c:choose>
            </c:forEach>
                            </ul>
        </div><br/> 
        
        <div class="instructions"><p><b>Instructions:</b></p>${fn:replace(rec.instructions, newLineChar, "<br />")}</div>
        </div>
    </div>
</div>
</c:forEach>

