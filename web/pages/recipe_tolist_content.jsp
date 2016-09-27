<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/dbrecette"
     user="root"  password=""/>

<sql:query dataSource="${snapshot}" var="result">SELECT * from recettes WHERE brouillon=0;</sql:query>

        <table class="listing" border="1" width="100%">
            <c:forEach var="row" items="${result2.rows}" varStatus="status">
                <tr class="${status.index%2==0 ? 'alt' : ''}">
                    <div class="titre">${row.titre}</div>
                    <div class="description">${row.description}</div>
                    <div class="sommaire"
                    <td><a href="${pageContext.request.contextPath}/?id=${row.id_recette}">Supprimer</a></td>
                    <td><a href="${pageContext.request.contextPath}/?id=${row.id_recette}">Retour en brouillon</a></td>
                    <td><a href="${pageContext.request.contextPath}/?id=${row.id_recette}">Apercu</a></td>
                </tr>
            </c:forEach>
        </table>