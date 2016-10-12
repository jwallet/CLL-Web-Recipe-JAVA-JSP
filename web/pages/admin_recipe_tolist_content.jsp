<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/dbrecette"
     user="root"  password=""/>

<sql:query dataSource="${snapshot}" var="brouillons">SELECT * from recettes WHERE brouillon=1;</sql:query>
    <div class="titre_grille">Recettes en ébauche</div>
        <table class="listing" border="1" width="100%">
            
                <c:choose>
                    <c:when test="${brouillons.rowCount == 0}">
                        <tr class="${status.index%2==0 ? 'alt' : ''}">
                            <td class="titre">Aucune recette n'est en ébauche.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="br" items="${brouillons.rows}" varStatus="status">
                            <tr class="${status.index%2==0 ? 'alt' : ''}">
                                <td class="titre">${br.titre}</td>
                                <td><a href="admin_recipe_view.jsp?id=${br.id_recette}"target='_blank'>Aperçu</a></td>
                                <td><a href="admin_recipe_form.jsp?id=${br.id_recette}">Modifier</a></td>
                                <td><a href="admin_recipe_delete.jsp?id=${br.id_recette}">Supprimer</a></td>
                                <td><a href="admin_recipe_publish.jsp?id=${br.id_recette}">Publier</a></td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>         

        </table>

<sql:query dataSource="${snapshot}" var="publie">SELECT * from recettes WHERE brouillon=0;</sql:query>
    <div class="titre_grille">Recettes publiées</div>
        <table class="listing" border="1" width="100%">
            
                <c:choose>
                    <c:when test="${publie.rowCount == 0}">
                        <tr class="${status.index%2==0 ? 'alt' : ''}">
                            <td class="titre">Aucune recette n'a été publié.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="pub" items="${publie.rows}" varStatus="status">
                            <tr class="${status.index%2==0 ? 'alt' : ''}">
                                <td class="titre">${pub.titre}</td>
                                <td><a href="admin_recipe_view.jsp?id=${pub.id_recette}"target='_blank'>Aperçu</a></td>
                                <td><a href="admin_recipe_form.jsp?id=${pub.id_recette}">Modifier</a></td>
                                <td><a href="admin_recipe_delete.jsp?id=${pub.id_recette}">Supprimer</a></td>
                                <td><a href="admin_recipe_draft.jsp?id=${pub.id_recette}">Ébaucher</a></td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>         
            </tr>
        </table>
