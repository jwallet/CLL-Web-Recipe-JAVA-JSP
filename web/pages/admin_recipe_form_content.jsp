<%@ page language="java" contentType="text/html; charset=ISO-8859-15"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://www.atg.com/taglibs/json" prefix="json" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/dbrecette"
     user="root"  password=""/>

<sql:query dataSource="${snapshot}" var="recettes">SELECT * FROM recettes WHERE id_recette=<%=request.getParameter("id")%>;</sql:query>
<sql:query dataSource="${snapshot}" var="labels">SELECT * FROM p_type_label</sql:query>
<sql:query dataSource="${snapshot}" var="unites">SELECT * FROM p_type_unite</sql:query>
<sql:query dataSource="${snapshot}" var="fractions">SELECT * FROM p_type_fraction</sql:query>

<div class="carree_blanc">

<c:choose>    
    <c:when test="${recettes.rowCount == 0}">
        <%-- ajout recette--%>
 <div class="gros_titre">Ajout d'une recette</div>
 <form  method="post" action="">
        <sql:query dataSource="${snapshot}" var="sommaire">SELECT  * FROM p_type_sommaire;</sql:query>  

     
        <div class="explication">
            <div class="float">
                    <label for="recette_label">Catégorie</label>
                    <select>
                    <c:forEach var="lbls" items="${labels.rows}" varStatus="status">
                        <option name="recette_label" value="${lbls.label}">${lbls.label}</option>                            
                    </c:forEach>
                    </select>
                    </div>
            
                    <label for="recette_titre">Titre</label><input type="text" name="recette_titre"
                            id="recette_titre" value="" />
                    
                    
        </div>

        <div class="explication">
                    <div>Description</div>
        
                    <textarea name="recette_description" id="recette_description" rows="4"></textarea>
            
        </div>
            <fieldset class="som">
                <legend>Sommaire</legend>
            
                <c:forEach var="som" items="${sommaire.rows}" varStatus="loopsom">
                        <c:choose>    
                            <c:when test="${som.id_type_sommaire != 4}">
                                <div class="sommaire">
                                    <label for="recette_${som.type}">Temps de ${som.type}</label> 
                                    <input name="recette_${som.type}" id="recette_${som.type}" value="" />
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="sommaire">
                                    <label for="recette_${som.type}">Nombre de ${som.type}</label> 
                                    <input name="recette_${som.type}" id="recette_${som.type}" value="" />
                                </div>
                            </c:otherwise>
                        </c:choose>
                </c:forEach>
            </fieldset>

            <fieldset class="ing" id="formnewing">
                <legend>Ingrédients &#8212; <input type="button" class="addingfields" id="addingfields" value ="Ajouter un ingrédient"/></legend>
           
                <div class="lesingredients" id="ings0"><label>Quantité</label>
                        <input name="recette_ing_quantite" id="recette_ing_quantite" size="1" value="1" />
                        <select style="margin-left:-15px;">
                        <c:forEach var="f" items="${fractions.rows}">
                            <option name="recette_ing_type_fraction_${loop.index}" value="${f.id_type_fraction}">${f.fraction_nohtml}</option>
                        </c:forEach>
                        </select>

                        
                        Mesure
                        <select>
                        <c:forEach var="unite" items="${unites.rows}">
                            <option name="recette_ing_type_unite_${loop.index}" value="${unite.id_type_unite}">${unite.type_unite}</option>
                        </c:forEach>
                        </select>
                        Ingrédient
                        <input style="width:45%;" name="recette_ing_ingredient" id="ingredient" value="" />
                        
                      </div>
            </fieldset>
        

            <div class="explication">
                <label for="recette_notes_ingredients">Notes additionnelles sur les ingrédients</label>
                <textarea name="recette_instructions" id="recette_instructions" rows="5" cols="100">${rec.instructions}</textarea>
            </div>
            <div class="explication">
                <label for="recette_instructions">Instructions</label> 

                    <div>
                            <textarea name="recette_instructions" id="recette_instructions" rows="20" cols="100"></textarea>
                    </div>
            </div>
            <div class="liens_bouton">
                    <div>
                            <a href="${pageContext.request.contextPath}">Annuler</a> ou <input type="submit" name="recette_save" value="Enregistrer" />
                    </div>
            </div>
             
</form>        
</div>
    </c:when>
    
    

    <c:otherwise>
        
        <div class="carree_blanc">
    <form  method="post" action="">
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
                    <c:choose>    
                        <c:when test="${som.id_type_sommaire != 4}">
                            <div>
                                <label for="recette_${som.type}">Temps de ${som.type}</label> 
                                <input name="recette_${som.type}" id="recette_${som.type}" value="${som.nbre_unite}" />
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div>
                                <label for="recette_${som.type}">Nombre de ${som.type}</label> 
                                <input name="recette_${som.type}" id="recette_${som.type}" value="${som.nbre_unite}" />
                            </div>
                        </c:otherwise>
                    </c:choose> 
                </c:forEach>
            </fieldset>

            
            <div>
                <label for="recette_ingredients">Ingrédients</label>
            </div>
           <div class='ingredients'>
                <button class="add_field_button">Ajouter un ingrédient</button>
                <div id="input_fields_wrap"> 
                    <c:forEach var="ing" items="${ingredients_recette.rows}" varStatus="loop">
                      <div class='liste'>   
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
                
                </div>
           </div>
            
            

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
        </form>        
</div>
    </c:otherwise>
</c:choose> 

<script>
     var x = 0;
     var selectmesure = "";
     var selectfraction = "";
     
    $(document).ready(function() {
        var jsonmesure = [];
        var jsonfraction = [];
     
        $.getJSON("json_sql_ing_type_unites.jsp",function(data){

            $.each( data, function( key, val ) {
              jsonmesure.push(val.type_unite);
            });            
            
            $.each(jsonmesure, function( i, val ) {
                var total = jsonmesure.length-1;
                var mesure = val;
                if(i !== total && i !== 0) 
                {
                   selectmesure += "<option name='recette_new_ing_type_unite_"+x+"' value='"+i+"'>"+mesure+"</option>";  
                }
                else if(i===0)
                {
                    selectmesure+="<select><option name='recette_new_ing_type_unite_"+x+"' value='"+i+"'>"+mesure+"</option>";
                }
                else
                {
                    selectmesure+="<option name='recette_new_ing_type_unite_"+x+"' value='"+i+"'>"+mesure+"</option></select>";//dernier element
                }
            });
        });
        
        $.getJSON("json_sql_ing_type_fractions.jsp",function(data){

            $.each( data, function( key, val ) {
              jsonfraction.push(val.fraction);
            });            
            
            $.each(jsonfraction, function( i, val ) {
                var total = jsonfraction.length-1;
                var fraction = val;            
                if(i !== total && i !== 0) 
                {
                   selectfraction += "<option name='recette_new_ing_type_unite_"+x+"' value='"+i+"'>"+fraction+"</option>";  
                }
                else if(i===0)
                {
                    selectfraction+="<select><option name='recette_new_ing_type_unite_"+x+"' value='"+i+"'>"+fraction+"</option>";
                }
                else
                {
                    selectfraction+="<option name='recette_new_ing_type_unite_"+x+"' value='"+i+"'>"+fraction+"</option></select>";//dernier element
                }
            });
        });
        
    });
    $("#addingfields").click(function() {
        x++;
        var fieldWrapper = $("<div class=\"lesingredients\" id=\"ing_" + x + "\"/>");
        var fQuantite = $("<label>Quantité</label><input type=\"text\" id=\"recette_ing_quantite_"+x+"\" size=\"1\" value=\"1\" />");
        var fMesure = $("<label>Mesure</label>");
        
        fieldWrapper.append(fQuantite);        
        fieldWrapper.append(selectfraction);
        
        fieldWrapper.append(fMesure);
        fieldWrapper.append(selectmesure);
        
        var fType = $("<label>Ingrédient</label><input style=\"width:45%;\" type=\"text\" id=\"recette_ing_ingredient_"+x+"\"/>");
        fieldWrapper.append(fType);
        
        //var removeButton = $("<input type=\"button\" class=\"remove\" value=\"-\" />");
        
        var retirer = $("<a href='#' class='remove'><img style='margin-bottom:-5px;' src='../resources/images/x.png'/></a></div>");
        retirer.click(function() {
            $(this).parent().remove();x--;
        });
        fieldWrapper.append(retirer);    
        
        $("#formnewing").append(fieldWrapper);
    });
    $("#preview").click(function() {
        $("#yourform").remove();
        var fieldSet = $("<fieldset id=\"yourform\"><legend>Your Form</legend></fieldset>");
        $("#formnewing div").each(function() {
            var id = "input" + $(this).attr("id").replace("field","");
            var label = $("<label for=\"" + id + "\">" + $(this).find("input.fieldname").first().val() + "</label>");
            var input;
            switch ($(this).find("select.fieldtype").first().val()) {
                case "checkbox":
                    input = $("<input type=\"checkbox\" id=\"" + id + "\" name=\"" + id + "\" />");
                    break;
                case "textbox":
                    input = $("<input type=\"text\" id=\"" + id + "\" name=\"" + id + "\" />");
                    break;
                case "textarea":
                    input = $("<textarea id=\"" + id + "\" name=\"" + id + "\" ></textarea>");
                    break;    
            }
            fieldSet.append(label);
            fieldSet.append(input);
        });
        $("body").append(fieldSet);
    });
</script>