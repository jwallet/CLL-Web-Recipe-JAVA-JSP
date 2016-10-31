<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/dbrecette"
     user="root"  password=""/>
 <sql:query dataSource="${snapshot}" var="user">SELECT * FROM redacteurs;</sql:query> 
 <c:set var="failed" value="<%=request.getParameter("failed")%>"/>

 <div class="carree_blanc">
     <form class='som' action="login_inprogress.jsp" method="post">
                <div class="gros_titre">Connexion</div>    
                
                <div style='padding-left:30px;padding-top:20px;padding-bottom:10px;'><label class="float">Nom d'usager :</label><input type="text" name="user" id='user' maxlength="30"><br />
                    <label class="float">Mot de passe :</label> <input type="password" name="password" id='password' maxlength="30">
                </div>
               
                <div style="" class="liens_bouton"><a href="recipe_tolist.jsp" >Annuler</a> ou <input type="submit" value="connexion"/><%--<button style="float:left" type="submit" formaction="login_hash.jsp">#</button>--%></div>
                
     </form>
</div>
 </a>
 <c:if test="${failed == true}"><div class="failed"><a onclick="this.parentElement.style.visibility='hidden';"><div class="box"><p>Connexion Impossible</p></div></a></div></c:if>
 
 
 