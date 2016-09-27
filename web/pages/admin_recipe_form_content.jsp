<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/dbrecette"
     user="root"  password=""/>

<sql:query dataSource="${snapshot}" var="result">SELECT * from recettes where id_recette=<%=request.getParameter("id")%>;</sql:query>


<form class="semantic" method="post"
	action="adding.jsp">
	
    <div>
            <label for="title">Titre</label> <input type="text" name="title"
                    id="title" value="${row.titre}" />
            <label for="label">Catégorie</label> <input type="text" name="label"
                    id="label" value="${row.label}" />
    </div>
    
    <div>
            <label for="description">Description</label>
            <textarea name="description" id="description" rows="2" cols="60">${row.description}</textarea>
    </div>

    <fieldset>
		<legend>
			Sommaire
		</legend>
        <div>
            <label for="preparation">Temps de préparation</label> <input name="preparation" id="preparation"
                    value="${row.preparation}" />

            <label for="cuisson">Temps de cuisson</label> <input name="cuisson" id="cuisson"
                    value="${row.cuisson}" />
        </div>
        <div>
            <label for="refroidissement">Temps de refroidissement</label> <input name="refroidissement" id="refroidissement"
                    value="${row.refroidissement}" />

            <label for="portions">Nombre de portions</label> <input name="portions" id="portions"
                    value="${row.portions}" />
        </div>
    </fieldset>
            

    

 <div>
            <label for="ingredients">Ingrédients</label> 
            <textarea name="ingredients" id="ingredients" rows="10" cols="60">${row.ingredients}</textarea>
    </div>

    <div>
            <label for="instructions">Instructions</label> 
            <textarea name="instructions" id="instructions" rows="10" cols="60">${row.instructions}</textarea>
    </div>

    <c:if test="${not empty book.id}">
            <input type="hidden" name="id" value="${book.id}" />
    </c:if>

	</fieldset>

	<div class="button-row">
		<a href="${pageContext.request.contextPath}">Annuler</a> ou <input type="submit" value="Enregistrer" />
	</div>
</form>        

