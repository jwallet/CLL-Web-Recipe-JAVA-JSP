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
<sql:query dataSource="${snapshot}" var="labels">SELECT * FROM p_type_label;</sql:query>
<sql:query dataSource="${snapshot}" var="unites">SELECT * FROM p_type_unite;</sql:query>
<sql:query dataSource="${snapshot}" var="fractions">SELECT * FROM p_type_fraction;</sql:query>

<div class="carree_blanc">
    <%-- <c:if test="${lbls.id_type_label eq label_recette.rows[loop].id_type_label}">--%>
<c:choose>    
    <c:when test="${recettes.rowCount == 0}">
        <%-- ajout recette--%>
 <div class="gros_titre">Ajout d'une recette</div>
 <form  method="get" action="admin_recipe_savechanges.jsp" enctype="multipart/form-data">
     
        <sql:query dataSource="${snapshot}" var="sommaire">SELECT  * FROM p_type_sommaire;</sql:query>  

     
        <div class="explication">
            <div class="float">
                <label for="recette_label">Cat�gorie</label>
                <c:forEach var="lbls" items="${labels.rows}">
                    <input style="width: 20px; height: 20px; margin-left:15px;margin-right:5px;" type="checkbox" name="recette_label" id="recette_label" value="${lbls.id_type_label}">${lbls.label}                          
                </c:forEach>
            </div>
            
            <label for="recette_titre">Titre</label><input type="text" name="recette_titre"
                            id="recette_titre" value="" required/>                   
                    
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
                <legend>T�l�versement d'images</legend>
                <div style="padding-left:20px;font-size:15px;padding-bottom:10px;">Maintenir la touche CTRL pour s�lectionner plusieurs images.</div>
                <input type="file" id="upload" name="upload" accept="image/*" style="visibility:hidden; width:0px; height:0px;" multiple/>
                <div style="float:right;text-align:right;font-variant:all-small-caps;"><input type="button" id="uploadfile" name="uploadfile" style="padding-left:20px;padding-right:20px;" value ="Parcourir" onclick="document.getElementById('upload').click(); return false"/><div>Taille maximum: 5 mo</div><div name="fileCount" id="fileCount"></div></div> 
                <label name="filename" id="filename" class="filename">aucune image choisie</label> 
                  
                </fieldset>
        </div>
      
            <fieldset class="ing" id="formnewing">
                <legend>Ingr�dients</legend>
                <input type="button" style="margin-left:10px;margin-bottom:20px;padding-left:20px;padding-right:20px;" class="addingfields" id="addingfields" value ="Ajouter un ingr�dient"/>                   
               
                <div class="lesingredients" id="ing_0"><label>Quantit�</label>
                        <input style="width: 55px;" type="number" min="0" max="9999" name="recette_ing_quantite" id="recette_ing_quantite" size="0" value="0" required/>
                        <select name="recette_ing_type_fraction" id="recette_ing_type_fraction">
                        <c:forEach var="f" items="${fractions.rows}" varStatus="loop">
                            <option name="recette_ing_type_fraction${loop.index}" id="recette_ing_type_fraction${loop.index}" value="${f.id_type_fraction}">${f.fraction_nohtml}</option>
                        </c:forEach>
                        </select>                        
                        Mesure
                        <select name="recette_ing_type_unite" id="recette_ing_type_unite">
                        <c:forEach var="unite" items="${unites.rows}" varStatus="loop">
                            <option name="recette_ing_type_unite${loop.index}" id="recette_ing_type_unite${loop.index}" value="${unite.id_type_unite}">${unite.type_unite}</option>
                        </c:forEach>
                        </select>
                        Ingr�dient
                        <input type="text" style="width:45%;" maxlength="40" name="recette_ing_ingredient" id="recette_ing_ingredient" value="" />                        
                      </div>
            </fieldset>  
        
            <div class="explication">
                <label for="recette_instructions">�tapes de pr�paration</label> 

                    <div>
                            <textarea name="recette_instructions" id="recette_instructions" rows="20" cols="100"></textarea>
                    </div>
            </div>
        
            <div class="explication">
                <label for="recette_notes">Notes additionnelles sur les ingr�dients ou la recette</label>
                <textarea name="recette_notes" id="recette_notes" rows="5" cols="100"></textarea>
            </div>
        
            <div class="liens_bouton">
                    <div>
                            <a href="admin_recipe_tolist.jsp">Annuler</a> ou <input style="padding-left:20px;padding-right:20px;" type="submit" name="save" value="Enregistrer" />
                    </div>
            </div>
             
</form>        

    </c:when>
  
    <c:otherwise>
<sql:query dataSource="${snapshot}" var="label_recette">SELECT * FROM label lbl JOIN p_type_label ptl ON lbl.id_type_label=ptl.id_type_label WHERE lbl.id_recette=<%=request.getParameter("id")%>;</sql:query>
<sql:query dataSource="${snapshot}" var="ingredients_recette">SELECT * FROM ingredients ing JOIN p_type_unite ptu ON ing.id_type_unite=ptu.id_type_unite JOIN p_type_fraction ptf ON ptf.id_type_fraction=ing.id_type_fraction WHERE ing.id_recette=<%=request.getParameter("id")%>;</sql:query>
<sql:query dataSource="${snapshot}" var="sommaire">SELECT * FROM sommaire som JOIN p_type_sommaire pts ON som.id_type_sommaire=pts.id_type_sommaire WHERE id_recette=<%=request.getParameter("id")%>;</sql:query>
<sql:query dataSource="${snapshot}" var="images">SELECT * FROM images WHERE id_recette=<%=request.getParameter("id")%>;</sql:query>
    
<c:forEach var="rec" items="${recettes.rows}" varStatus="status">
    <div class="gros_titre">Modification d'une recette</div>
 <form  method="get" action="admin_recipe_savechanges2.jsp" enctype="multipart/form-data"> 
     
        <div class="explication">
            <div class="float">
                <input type="hidden" name="recette_id" id="recette_id" value="${rec.id_recette}" />
                    <label for="recette_label">Cat�gorie</label>
                                           
                    <c:forEach var="lbls" items="${labels.rows}">
                        <input style="width: 20px; height: 20px; margin-left:15px;margin-right:5px;" id="recette_label" type="checkbox" name="recette_label"
                               <c:forEach var="mylbl" items="${label_recette.rows}" varStatus="mylblcount">
                                   <c:if test="${lbls.id_type_label eq mylbl.id_type_label}">
                                       checked="checked"
                                   </c:if>                               
                               </c:forEach>value="${lbls.id_label}">${lbls.label}                 
                    </c:forEach> 
                           
             </div>         
                    

            <label for="recette_titre">Titre</label><input type="text" name="recette_titre"
                    id="recette_titre" value="${rec.titre}" required />                   
                    
        </div>

        <div class="explication">
                    <label>Description</label>
        
                    <textarea name="recette_description" id="recette_description" rows="4">${rec.description}</textarea>
        </div>
        
        <div class="uploaded">
            <fieldset class="img">
                <legend>Images associ�es � la recette</legend>
                
                <c:choose>
                    <c:when test="${images.rowCount eq 0}">
                        <div class="warning">Aucune image n'est associ�e � cette recette</div>
                    </c:when>
                    <c:otherwise>
                        <div class="warning"><p>Les images poss�dant un encadr� bleu seront supprim�es � l'enregistrement.</p>
                        <c:forEach var="img" items="${images.rows}" varStatus="status">
                            <input class="checkbox" style="background-image: url(${pageContext.request.contextPath}${img.url_local});" id="recette_images_+${labelcount}" type="checkbox" name="recette_images" value="${img.id_image}">
                        </c:forEach>
                            </div>
                    </c:otherwise>
                </c:choose>
                            
            </fieldset>
        </div>

            <div class="sommaire">
                <fieldset class="som">
                <legend>Temps et portions</legend>
            
                <c:forEach var="som" items="${sommaire.rows}" varStatus="loopsom">
                        <c:choose>    
                            <c:when test="${som.id_type_sommaire != 4}">
                                <div class="sommaire">
                                    <label for="recette_${som.type}">Temps de ${som.type}</label> 
                                    <input name="recette_${som.type}" id="recette_${som.type}" value="${som.nbre_unite}" />
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="sommaire">
                                    <label for="recette_${som.type}">Nombre de ${som.type}</label> 
                                    <input name="recette_${som.type}" id="recette_${som.type}" value="${som.nbre_unite}" />
                                </div>
                            </c:otherwise>
                        </c:choose>
                </c:forEach>
                </fieldset>
            </div>
        
        <div class="upload">
            <fieldset class="img">
                <legend>T�l�versement d'images</legend>
                <div style="padding-left:20px;font-size:15px;padding-bottom:10px;">Maintenir la touche CTRL pour s�lectionner plusieurs images.</div>
                <input type="file" id="upload" name="upload" accept="image/*" style="visibility:hidden; width:0px; height:0px;" multiple/>
                <div style="float:right;text-align:right;font-variant:all-small-caps;"><input type="button" id="uploadfile" name="uploadfile" style="padding-left:20px;padding-right:20px;" value ="Parcourir" onclick="document.getElementById('upload').click(); return false"/><div>Taille maximum: 5 mo</div><div name="fileCount" id="fileCount"></div></div> 
                <label name="filename" id="filename" class="filename">aucune image choisie</label> 
                  
                </fieldset>
        </div>
      
            <fieldset class="ing" id="formnewing">
                <legend>Ingr�dients</legend>
                <input type="button" style="margin-left:10px;margin-bottom:20px;padding-left:20px;padding-right:20px;" class="addingfields" id="addingfields" value ="Ajouter un ingr�dient"/>
                <c:forEach var="ing" items="${ingredients_recette.rows}" varStatus="bigloop">
                    
                    <div class="lesingredients" name="ing_${bigloop.index}" id="ing_${bigloop.index}">
                        <label>Quantit�</label>
                        <input style="width: 55px;" type="number" min="0" max="9999" name="recette_ing_quantite" id="recette_ing_quantite" size="1" value="${ing.quantite}" />
                        <select name="recette_ing_type_fraction" id="recette_ing_type_fraction">
                            <c:forEach var="f" items="${fractions.rows}" varStatus="loop">
                                <c:choose>
                                    <c:when test="${f.id_type_fraction eq ing.id_type_fraction}">
                                        <option name="recette_ing_type_fraction${loop.index}" id="recette_ing_type_fraction${loop.index}" value="${f.id_type_fraction}" selected>${f.fraction_nohtml}</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option name="recette_ing_type_fraction${loop.index}" id="recette_ing_type_fraction${loop.index}" value="${f.id_type_fraction}">${f.fraction_nohtml}</option>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </select>                        
                        Mesure
                        <select name="recette_ing_type_unite" id="recette_ing_type_unite">
                            <c:forEach var="unite" items="${unites.rows}" varStatus="loop">
                                <c:choose>
                                    <c:when test="${unite.id_type_unite eq ing.id_type_unite}">
                                        <option name="recette_ing_type_unite${loop.index}" id="recette_ing_type_unite${loop.index}" value="${unite.id_type_unite}" selected>${unite.type_unite}</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option name="recette_ing_type_unite${loop.index}" id="recette_ing_type_unite${loop.index}" value="${unite.id_type_unite}">${unite.type_unite}</option>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </select>
                        Ingr�dient
                        <input type="text" style="width:45%;" maxlength="40" name="recette_ing_ingredient" id="recette_ing_ingredient_${bigloop.index}" value="${ing.ingredient}" required />                        
                      </div>
                </c:forEach>
            </fieldset>    

        
            <div class="explication">
                <label for="recette_instructions">�tapes de pr�paration</label> 

                    <div>
                            <textarea name="recette_instructions" id="recette_instructions" rows="20" cols="100">${rec.instructions}</textarea>
                    </div>
            </div>
        
            <div class="explication">
                <label for="recette_notes">Notes additionnelles sur les ingr�dients ou la recette</label>
                <textarea name="recette_notes" id="recette_notes" rows="5" cols="100">${rec.notes}</textarea>
            </div>
        
            <div class="liens_bouton">
                    <div>
                            <a href="admin_recipe_tolist.jsp">Annuler</a> ou <input style="padding-left:20px;padding-right:20px;" type="submit" name="recette_update" value="Modifier" />
                    </div>
            </div>
             
    </form>     
    </c:forEach>

    </c:otherwise>
</c:choose> 
 </div>    

<script>     
     var selectmesure = "";
     var selectfraction = "";
     var x = 0;

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
                var j = i+1;
                if(i !== total && i !== 0) 
                {
                   selectmesure += "<option name='recette_ing_type_unite"+i+"' id=\"recette_ing_type_unite"+i+"\" value='"+j+"'>"+mesure+"</option>";  
                }
                else if(i===0)
                {
                    selectmesure+="<select  name='recette_ing_type_unite' id=\"recette_ing_type_unite\"><option name='recette_ing_type_unite"+i+"' id=\"recette_ing_type_unite"+i+"\" value='"+j+"'>"+mesure+"</option>";
                }
                else
                {
                    selectmesure+="<option name='recette_ing_type_unite"+i+"' id=\"recette_ing_type_unite"+i+"\" value='"+j+"'>"+mesure+"</option></select>";//dernier element
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
                var j = i+1;
                if(i !== total && i !== 0) 
                {
                   selectfraction += "<option name='recette_ing_type_fraction"+i+"' id=\"recette_ing_type_fraction"+i+"\" value='"+j+"'>"+fraction+"</option>";  
                }
                else if(i===0)
                {
                    selectfraction+="<select name='recette_ing_type_fraction' id=\"recette_ing_type_fraction\"><option name='recette_ing_type_fraction"+i+"' id=\"recette_ing_type_fraction"+i+"\" value='"+j+"'>"+fraction+"</option>";
                }
                else
                {
                    selectfraction+="<option name='recette_ing_type_fraction"+i+"' id=\"recette_ing_type_fraction"+i+"\" value='"+j+"'>"+fraction+"</option></select>";//dernier element
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
        x=0; //x++;
        var fieldWrapper = $("<div class=\"lesingredients\" id=\"ing_" + x + "\"/>");
        var fQuantite = $("<label>Quantit�</label><input name=\"recette_ing_quantite\" style=\"width: 55px;\" type=\"number\" min=\"0\" max=\"9999\"  id=\"recette_ing_quantite\" size=\"1\" value=\"0\" required/>");
        var fMesure = $("<label>Mesure</label>");
        fieldWrapper.append(fQuantite);        
        fieldWrapper.append(selectfraction);
        
        fieldWrapper.append(fMesure);
        fieldWrapper.append(selectmesure);
        
        var fType = $("<label>Ingr�dient</label><input style=\"width:45%;\" maxlength=\"40\" name=\"recette_ing_ingredient\" type=\"text\" id=\"recette_ing_ingredient\"/>");
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