<%@ page language="java" contentType="text/html; charset=ISO-8859-15"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/dbrecette"
     user="root"  password=""/>

 <sql:query dataSource="${snapshot}" var="recette">SELECT  * FROM recettes WHERE id_recette=<%=request.getParameter("id")%>;</sql:query>  
 <c:forEach var="r" items="${recette.rows}" varStatus="status">
     <form action="admin_recipe_todelete.jsp" method="post">
         <input type='hidden' name='id' value='<%=request.getParameter("id")%>'/>
            <div class="carree_blanc">
                <div class="gros_titre">Supprimer une recette</div>    
                <div class="explication">Êtes-vous certain de vouloir supprimer la recette:</label> <div class="recette">${r.titre}</div></div>
                   <div class="liens_bouton"><a href="admin_recipe_tolist.jsp">Annuler</a> ou
                       <input style="padding-left:20px;padding-right:20px;" type="submit" value="Supprimer"/></div>

            </div>     
     </form>

</c:forEach>
