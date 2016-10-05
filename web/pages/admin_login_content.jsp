<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/dbrecette"
     user="root"  password=""/>

 <sql:query dataSource="${snapshot}" var="user">SELECT * FROM login_admin;</sql:query> 
 <div class="carree_blanc">
     <form class='som' action="admin_login_inprogress.jsp" method="post">
                <div class="gros_titre">Connexion</div>    
                    
               <div><label class="float">Nom d'usager :</label><input type="text" name="txtuser_admin"></div>
                        <div><label class="float">Mot de passe :</label><input type="text" name="txtpass_admin"></div>
               
               <div style="" class="liens_bouton"><a href="recipe_tolist.jsp">Annuler</a> ou <input type="submit" value="connexion"/></div>
               <div class="alert">
                    <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span>
                    Échec de connexion. Le nom d'usager ou le mot de passe est invalide.
               </div>
     </form>
</div>
 