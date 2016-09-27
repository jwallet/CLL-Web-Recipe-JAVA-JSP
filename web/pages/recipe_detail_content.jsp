<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/dbrecette"
     user="root"  password=""/>

<sql:query dataSource="${snapshot}" var="result2">SELECT * from recettes WHERE brouillon=0;</sql:query>

        <table class="listing" border="1" width="100%">
            <tr>
                <th>Titre de la recette<th>
                <th></th>
                <th></th>
                <th></th>
            </tr>
            <c:forEach var="row" items="${result2.rows}" varStatus="status">
                <tr class="${status.index%2==0 ? 'alt' : ''}">
                    <td>${row.titre}</td>
                    <td><a href="admin_recipe_form.jsp?id=${row.id_recette}">Modifier</a></td>
                    <td><a href="${pageContext.request.contextPath}/?id=${row.id_recette}">Supprimer</a></td>
                    <td><a href="${pageContext.request.contextPath}/?id=${row.id_recette}">Retour en brouillon</a></td>
                    <td><a href="${pageContext.request.contextPath}/?id=${row.id_recette}">Apercu</a></td>
                </tr>
            </c:forEach>
        </table>