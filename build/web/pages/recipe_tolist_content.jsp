<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>--%>
<%--<% pageContext.setAttribute("newLineChar", "\n"); %>--%>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/dbrecette"
     user="root"  password=""/>
<c:set var="lbl" value='<%=request.getParameter("lbl")%>'/>
<c:choose>
    <c:when test="${lbl eq null}">
        <sql:query dataSource="${snapshot}" var="recettes">SELECT * FROM recettes WHERE brouillon=0;</sql:query>
    </c:when>
    <c:otherwise>        
        <sql:query dataSource="${snapshot}" var="recettes">SELECT * FROM recettes r JOIN label l ON r.id_recette=l.id_recette JOIN p_type_label ptl ON l.id_type_label=ptl.id_type_label WHERE r.brouillon=0 AND ptl.label like '<%=request.getParameter("lbl")%>' AND l.actif=true;</sql:query>
    </c:otherwise>
</c:choose>

        <div class="poster">     
<c:forEach var="rec" items="${recettes.rows}" varStatus="status">
    <sql:query dataSource="${snapshot}" var="image">SELECT * FROM images WHERE id_recette=${rec.id_recette} ORDER BY principale DESC;</sql:query>
    <!--<div style="background-image: url(${pageContext.request.contextPath}${image.rows[0].url_local});background-position: center;background-size:100%;">-->
    

            <div class="wrap"><a href="recipe_detail.jsp?id=${rec.id_recette}">
                <c:choose>
                    <c:when test="${image.rowCount==0}">                           
                            <img class='thumbnail' alt="Aucune image reliée" src="${pageContext.request.contextPath}/resources/images/aucune.png"/>                                            
                    </c:when>
                    <c:otherwise>
                                <img class='thumbnail' alt="${rec.titre}" src="${pageContext.request.contextPath}${image.rows[0].url_local}"/>                                          
                    </c:otherwise>
                </c:choose>
            <div class="titre"><span>${rec.titre}</span></div>
                                
                </a>
            </div>
    
</c:forEach>  </div> 