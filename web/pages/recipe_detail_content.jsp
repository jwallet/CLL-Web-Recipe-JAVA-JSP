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

<sql:query dataSource="${snapshot}" var="recettes">SELECT * FROM recettes WHERE id_recette=<%=request.getParameter("id")%>;</sql:query>
<sql:query dataSource="${snapshot}" var="label_recette">SELECT * FROM label lbl JOIN p_type_label ptl ON lbl.id_type_label=ptl.id_type_label WHERE lbl.id_recette=<%=request.getParameter("id")%>;</sql:query>
<sql:query dataSource="${snapshot}" var="ingredients_recette">SELECT * FROM ingredients ing JOIN p_type_unite ptu ON ing.id_type_unite=ptu.id_type_unite JOIN p_type_fraction ptf ON ing.id_type_fraction=ptf.id_type_fraction WHERE ing.id_recette=<%=request.getParameter("id")%>;</sql:query>
<sql:query dataSource="${snapshot}" var="sommaire">SELECT * FROM sommaire som JOIN p_type_sommaire pts ON som.id_type_sommaire=pts.id_type_sommaire WHERE id_recette=<%=request.getParameter("id")%>;</sql:query>
<sql:query dataSource="${snapshot}" var="image">SELECT * FROM images WHERE id_recette=<%=request.getParameter("id")%> ORDER BY principale DESC;</sql:query>
<c:forEach var="rec" items="${recettes.rows}" varStatus="status">
    
    <div class="post">
        <div class="haut" style="background-image: url('..${image.rows[0].url_local}')">
            <div class='post-inside'
                <!-- IMAGE URL HERE -->
                <c:choose>
                    <c:when test="${image.rowCount==0}">
                        <div class="image">
                            <img class='thumbnail' alt="Aucune image reliée" src="${pageContext.request.contextPath}/resources/images/aucune.png"/>
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
                <div class="titre"><mid>${rec.titre}</mid></div>
                <c:if test="${!empty rec.description}"><div class="description">${rec.description}</div></c:if>
                <div class="sommaire"><c:forEach var="som" items="${sommaire.rows}" varStatus="somloop">
                        <ligne><strong>${som.type}</strong> ${som.nbre_unite} <c:if test="${somloop.count != 3}">min</c:if></ligne>
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
                                    <c:out value="${'<strong>'+fn:replace(ing.ingredient,'*','</strong><italic></italic>')+'</strong>'}"/>
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
