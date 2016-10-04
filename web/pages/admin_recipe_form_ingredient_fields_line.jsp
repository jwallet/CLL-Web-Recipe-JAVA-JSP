<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/dbrecette"
     user="root"  password=""/>

<sql:query dataSource="${snapshot}" var="recettes">SELECT * FROM recettes WHERE id_recette=<%=request.getParameter("id")%>;</sql:query>
<sql:query dataSource="${snapshot}" var="labels">SELECT * FROM p_type_label</sql:query>
<sql:query dataSource="${snapshot}" var="unites">SELECT * FROM p_type_unite</sql:query>


Quantité<input name="recette_ing_quantite" id="recette_ing_quantite" size="1" value="1" />
<!--                        <select style="margin-left:-15px;">
<c:forEach var="fraction" items="${fractions.rows}">
    <option name="recette_ing_type_fraction_${loop.index}" value="${unite.id_type_fraction}">${unite.type_fraction}</option>
</c:forEach>
</select>-->
<select style="margin-left:-15px;"><option>1/4</option></select>Mesure<select>
<c:forEach var="unite" items="${unites.rows}">
    <option name="recette_ing_type_unite_${loop.index}" value="${unite.id_type_unite}">${unite.type_unite}</option>
</c:forEach>
</select>Ingrédient<input style="width:45%;" name="recette_ing_ingredient" id="ingredient" value="" />
