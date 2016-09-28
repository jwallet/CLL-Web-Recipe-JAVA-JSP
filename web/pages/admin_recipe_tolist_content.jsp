<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/dbrecette"
     user="root"  password=""/>

<sql:query dataSource="${snapshot}" var="result">SELECT * from recettes WHERE brouillon=1;</sql:query>

<div class="title">Recettes Brouillons</div>
        <table class="listing" border="1" width="100%">
            <c:forEach var="row" items="${result.rows}" varStatus="status">
                <tr class="${status.index%2==0 ? 'alt' : ''}">
                    <td class="titre">${row.titre}</a</td>
                    <td><a href="admin_recipe_view.jsp?id=${row.id_recette}" target='_blank'>Aperçu</a></td>
                    <td><a href="admin_recipe_form.jsp?id=${row.id_recette}">Modifier</a></td>
                    <td><a href="admin_recipe_delete.jsp?id=${row.id_recette}">Supprimer</a></td>
                    <td><a href="admin_recipe_publish.jsp?id=${row.id_recette}">Publier</a></td>
                </tr>
            </c:forEach>
        </table>

<sql:query dataSource="${snapshot}" var="result2">SELECT * from recettes WHERE brouillon=0;</sql:query>

<div class="title">Recettes publiées</div>
        <table class="listing" border="1" width="100%">
            <c:forEach var="row" items="${result2.rows}" varStatus="status">
                <tr class="${status.index%2==0 ? 'alt' : ''}">
                    <td class="titre">${row.titre}</a</td>
                    <td><a href="admin_recipe_view.jsp?id=${row.id_recette}"target='_blank'>Aperçu</a></td>
                    <td><a href="admin_recipe_form.jsp?id=${row.id_recette}">Modifier</a></td>
                    <td><a href="?id=${row.id_recette}">Supprimer</a></td>
                    <td><a href="admin_recipe_draft.jsp?id=${row.id_recette}">Retour en brouillon</a></td>
                </tr>
            </c:forEach>
        </table>
