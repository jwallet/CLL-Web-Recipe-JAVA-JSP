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


<form class="semantic" method="post"
	action="adding.jsp">   
<c:choose>
    
    <c:when test="${recettes.rowCount == 0}">
        <%-- ajout recette--%>
 <sql:query dataSource="${snapshot}" var="sommaire">SELECT  * FROM p_type_sommaire;</sql:query>       
        <div>
                    <label for="recette_titre">Titre</label> <input type="text" name="recette_titre"
                            id="recette_titre" value="" />
                    <label for="recette_label">Catégorie</label>
                    <select>
                    <c:forEach var="lbls" items="${labels.rows}" varStatus="status">
                        <option name="recette_label" value="${lbls.label}">${lbls.label}</option>                            
                    </c:forEach>
                    </select>
            </div>

            <div>
                    <label for="recette_description">Description</label>
            </div>
        
            <div>
                    <textarea name="recette_description" id="recette_description" rows="2" cols="100"></textarea>
            </div>

            <fieldset>
                <legend>
                    Sommaire
                </legend>
                <c:forEach var="som" items="${sommaire.rows}" varStatus="status">

                <div>
                    <label for="recette_${som.type}">Temps de ${som.type}</label> 
                    <input name="recette_${som.type}" id="recette_${som.type}" value="" />
                </div>

                </c:forEach>
            </fieldset>

            
            <div>
                <label for="recette_ingredients">Ingrédients</label>
            </div>
           
                      <div>   
                        <input name="recette_ing_quantite" id="recette_ing_quantite" value="0.0" />
                        
                        <select>
                        <c:forEach var="unite" items="${unites.rows}">
                            <option name="recette_ing_type_unite_${loop.index}" value="${unite.id_type_unite}">${unite.type_unite}</option>
                        </c:forEach>
                        </select>
                        
                        <input name="recette_ing_ingredient" id="ingredient" value="" />
                        
                      </div>
            
            <div>
                    <label for="recette_instructions">Instructions</label> 
            </div>
            <div>
                    <textarea name="recette_instructions" id="recette_instructions" rows="20" cols="100"></textarea>
            </div>
        
        <div class="button-row">
		<a href="${pageContext.request.contextPath}">Annuler</a> ou <input type="submit" name="recette_save" value="Enregistrer" />
	</div>
        
    </c:when>
    
    
    

    <c:otherwise>
                <%-- modifier de recette --%>   
<sql:query dataSource="${snapshot}" var="label_recette">SELECT * FROM label lbl JOIN p_type_label ptl ON lbl.id_type_label=ptl.id_type_label WHERE lbl.id_recette=<%=request.getParameter("id")%>;</sql:query>
<sql:query dataSource="${snapshot}" var="ingredients_recette">SELECT * FROM ingredients ing JOIN p_type_unite ptu ON ing.id_type_unite=ptu.id_type_unite WHERE ing.id_recette=<%=request.getParameter("id")%>;</sql:query>
<sql:query dataSource="${snapshot}" var="sommaire">SELECT * FROM sommaire som JOIN p_type_sommaire pts ON som.id_type_sommaire=pts.id_type_sommaire WHERE id_recette=<%=request.getParameter("id")%>;</sql:query>

        <c:forEach var="rec" items="${recettes.rows}" varStatus="status">
            <div>
                    <label for="recette_titre">Titre</label> <input type="text" name="recette_titre"
                            id="recette_titre" value="${rec.titre}" />
                    <label for="recette_label">Catégorie</label>
                    <select>
                    <c:forEach var="lbls" items="${labels.rows}" varStatus="status">
                    <c:forEach var="mylbl" items="${label_recette.rows}" varStatus="status">
                        <c:choose>
                            
                                <c:when test="${lbls.id_type_label eq mylbl.id_type_label}">
                                    <option name="recette_label" value="${lbls.label}" selected>${lbls.label}</option>
                                </c:when>
                                <c:otherwise>
                                    <option name="recette_label" value="${lbls.label}">${lbls.label}</option>
                                </c:otherwise>
                            
                        </c:choose>
                    </c:forEach>
                    </c:forEach>
                    </select>
            </div>

            <div>
                    <label for="recette_description">Description</label>
            </div>
            <div>
                    <textarea name="recette_description" id="recette_description" rows="2" cols="100">${rec.description}</textarea>
            </div>

            <fieldset>
                <legend>
                    Sommaire
                </legend>
                <c:forEach var="som" items="${sommaire.rows}" varStatus="status">

                <div>
                    <label for="recette_${som.type}">Temps de ${som.type}</label> 
                    <input name="recette_${som.type}" id="recette_${som.type}" value="${som.nbre_unite}" />
                </div>

                </c:forEach>
            </fieldset>

            
            <div>
                <label for="recette_ingredients">Ingrédients</label>
            </div>
           
                    <c:forEach var="ing" items="${ingredients_recette.rows}" varStatus="loop">
                      <div>   
                        <input name="recette_ing_quantite" id="recette_ing_quantite" value="${ing.quantite}" />
                        
                        <select>
                        <c:forEach var="unite" items="${unites.rows}">
                            <c:choose>

                                    <c:when test="${unite.id_type_unite eq ing.id_type_unite}">
                                        <option name="recette_ing_type_unite_${loop.index}" value="${unite.id_type_unite}" selected>${unite.type_unite}</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option name="recette_ing_type_unite_${loop.index}" value="${unite.id_type_unite}">${unite.type_unite}</option>
                                    </c:otherwise>

                            </c:choose>
                        </c:forEach>
                        </select>
                        
                        <input name="recette_ing_ingredient" id="ingredient" value="${ing.ingredient}" />
                        
                      </div>  
                    </c:forEach>
            
            

            <div>
                    <label for="recette_instructions">Instructions</label> 
            </div>
            <div>
                    <textarea name="recette_instructions" id="recette_instructions" rows="20" cols="100">${rec.instructions}</textarea>
            </div>

        </c:forEach>   

        
	<div class="button-row">
		<a href="${pageContext.request.contextPath}">Annuler</a> ou <input type="submit" name="recette_update" value="Modifier" />
	</div>
        
    </c:otherwise>
</c:choose> 
</form>        

