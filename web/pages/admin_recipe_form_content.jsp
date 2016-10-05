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
 <form  method="post" action="admin_recipe_savechanges.jsp" enctype="multipart/form-data">
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
                    <label>Description</label>
        
                    <textarea name="recette_description" id="recette_description" rows="4"></textarea>
        </div>

            <div class="sommaire">
                <fieldset class="som">
                <legend>Temps et portions</legend>
            
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
            </div>
        
        <div class="upload">
            <fieldset class="img">
                <legend>Téléversement d'images</legend>
                <div style="padding-left:20px;font-size:15px;padding-bottom:10px;">Maintenir la touche CTRL pour sélectionner plusieurs images.</div>
                <input type="file" id="upload" name="upload" accept="image/*" style="visibility:hidden; width:0px; height:0px;" multiple/>
                <div style="float:right;text-align:right;font-variant:all-small-caps;"><input type="button" id="uploadfile" name="uploadfile" style="padding-left:20px;padding-right:20px;" value ="Parcourir" onclick="document.getElementById('upload').click(); return false"/><div>Taille maximum: 5 mo</div><div name="fileCount" id="fileCount"></div></div> 
                <label name="filename" id="filename" class="filename">aucune image choisie</label> 
                  
                </fieldset>
        </div>
      
            <fieldset class="ing" id="formnewing">
                <legend>Ingrédients</legend>
                <input type="button" style="margin-left:10px;margin-bottom:20px;padding-left:20px;padding-right:20px;" class="addingfields" id="addingfields" value ="Ajouter un ingrédient"/>
        <div class="lesingredients" id="ing_0"><label>Quantité</label>
                        <input type="text" name="recette_ing_quantite" id="recette_ing_quantite_0" size="1" value="1" />
                        <select name="recette_ing_type_fraction0" id="recette_ing_type_fraction0">
                        <c:forEach var="f" items="${fractions.rows}">
                            <option name="recette_ing_type_fraction_${loop.index}" id="recette_ing_type_fraction_${loop.index}" value="${f.id_type_fraction}">${f.fraction_nohtml}</option>
                        </c:forEach>
                        </select>

                        
                        Mesure
                        <select name="recette_ing_type_unite0" id="recette_ing_type_unite0">
                        <c:forEach var="unite" items="${unites.rows}">
                            <option name="recette_ing_type_unite_${loop.index}" id="recette_ing_type_unite_${loop.index}" value="${unite.id_type_unite}">${unite.type_unite}</option>
                        </c:forEach>
                        </select>
                        Ingrédient
                        <input type="text" style="width:45%;" name="recette_ing_ingredient_0" id="recette_ing_ingredient_0" value="" />
                        
                      </div>
            </fieldset>
        

            <div class="explication">
                <label for="recette_notes_ingredients">Notes additionnelles sur les ingrédients</label>
                <textarea name="recette_instructions" id="recette_instructions" rows="5" cols="100">${rec.instructions}</textarea>
            </div>
            <div class="explication">
                <label for="recette_instructions">Étapes de préparation</label> 

                    <div>
                            <textarea name="recette_instructions" id="recette_instructions" rows="20" cols="100"></textarea>
                    </div>
            </div>
            <div class="liens_bouton">
                    <div>
                            <a href="admin_recipe_tolist.jsp">Annuler</a> ou <input type="submit" name="recette_save" value="Enregistrer" />
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
                <button style="padding-left:50px;padding-right:50px;" class="add_field_button">Ajouter un ingrédient</button>
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
                   selectmesure += "<option name='recette_ing_type_unite_"+x+"' id=\"recette_ing_type_unite_"+x+"\" value='"+i+"'>"+mesure+"</option>";  
                }
                else if(i===0)
                {
                    selectmesure+="<select  name='recette_ing_type_unite"+x+"' id=\"recette_ing_type_unite"+x+"\" ><option name='recette_ing_type_unite_"+x+"' id=\"recette_ing_type_unite_"+x+"\" value='"+i+"'>"+mesure+"</option>";
                }
                else
                {
                    selectmesure+="<option name='recette_ing_type_unite_"+x+"' id=\"recette_ing_type_unite_"+x+"\" value='"+i+"'>"+mesure+"</option></select>";//dernier element
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
                   selectfraction += "<option name='recette_ing_type_fraction_"+x+"' id=\"recette_ing_type_fraction_"+x+"\" value='"+i+"'>"+fraction+"</option>";  
                }
                else if(i===0)
                {
                    selectfraction+="<select name='recette_ing_type_fraction"+x+"' id=\"recette_ing_type_fraction"+x+"\"><option name='recette_ing_type_fraction_"+x+"' id=\"recette_ing_type_fraction_"+x+"\" value='"+i+"'>"+fraction+"</option>";
                }
                else
                {
                    selectfraction+="<option name='recette_ing_type_fraction_"+x+"' id=\"recette_ing_type_fraction_"+x+"\" value='"+i+"'>"+fraction+"</option></select>";//dernier element
                }
            });
        });
        
    });
    
    $("#upload").on('change',function(){
        var nbre_files = this.files.length;
        var display = "";
        var one_file_name;
        for(var i = 0; i < nbre_files ; i++)
        {
            var name = this.files.item(i).name;
            var file_name_constructeur;            
            one_file_name = name.replace(/\\/g, '/').replace(/.*\//, '');
            if(one_file_name.length>26)
            {
                file_name_constructeur = one_file_name.substring(0, 26);
                var index_point_ext = one_file_name.indexOf('.');
                file_name_constructeur += "..."+one_file_name.substring(index_point_ext,one_file_name.length);
                one_file_name = file_name_constructeur;
            }
            if(i!==nbre_files-1)
            {
                display+=one_file_name+"</label><br /><label name=\"filename\" id=\"filename\" class=\"filename\">";
            }
            else
            {
                display+=one_file_name+"</label>";
            }
        }
        if(nbre_files===1)
        {
            $('#filename').html(one_file_name);
            $('#fileCount').html("Nombre de fichier: "+nbre_files.toString());
        }
        else if( nbre_files===0)
        {
            $('#filename').html("aucune image choisie");
            $('#fileCount').html("");
        }
        else
        {
            $('#filename').html(display);
            $('#fileCount').html("Nombre de fichiers: "+nbre_files.toString());
        }
            
    });
    
    $("#addingfields").click(function() {
        x++;
        var fieldWrapper = $("<div class=\"lesingredients\" id=\"ing_" + x + "\"/>");
        var fQuantite = $("<label>Quantité</label><input name=\"recette_ing_quantite_"+x+"\" type=\"text\" id=\"recette_ing_quantite_"+x+"\" size=\"1\" value=\"1\" />");
        var fMesure = $("<label>Mesure</label>");
        fieldWrapper.append(fQuantite);        
        fieldWrapper.append(selectfraction);
        
        fieldWrapper.append(fMesure);
        fieldWrapper.append(selectmesure);
        
        var fType = $("<label>Ingrédient</label><input style=\"width:45%;\" name=\"recette_ing_ingredient_"+x+"\" type=\"text\" id=\"recette_ing_ingredient_"+x+"\"/>");
        fieldWrapper.append(fType);
        
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