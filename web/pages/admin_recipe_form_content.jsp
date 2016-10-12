<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>
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

<div class="carree_blanc">
<c:choose>    
    <c:when test="${recettes.rowCount == 0}">
        <%-- ajout recette--%>
 <div class="gros_titre">Ajout d'une recette</div>
<form action="admin_recipe_uploadfile.jsp" method="post" enctype="multipart/form-data" accept-charset="utf-8">
<!--<form  action="admin_recipe_savechanges2.jsp" method="get">-->
        <sql:query dataSource="${snapshot}" var="sommaire">SELECT  * FROM p_type_sommaire;</sql:query>  
     
        <div class="explication">
            <div class="float">
                <label for="recette_label">Catégorie</label>
                <c:forEach var="lbls" items="${labels.rows}">
                    <input style="width: 20px; height: 20px; margin-left:15px;margin-right:5px;" type="checkbox" name="recette_label" id="recette_label" value="${lbls.id_type_label}">${lbls.label}                          
                </c:forEach>
            </div>
            
            <label for="recette_titre">Titre</label><input type="text" name="recette_titre"
                            id="recette_titre" value="" required/>                   
                    
        </div>

        <div class="explication">
                    <label>Description</label>
        
                    <textarea name="recette_description" id="recette_description" rows="3"></textarea>
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
        
        <div class="recette_upload">
            <fieldset class="img">
                <legend>Téléversement d'images</legend>
                 <div class="warning">Maintenir la touche CTRL pour sélectionner plusieurs images.</div>
                <input type="file" id="recette_upload" name="recette_upload" accept="image/*" style="visibility:hidden; width:0px; height:0px;" multiple/>
                <div style="float:right;text-align:right;font-variant:all-small-caps;"><input type="button" id="uploadfile" name="uploadfile" style="padding-left:20px;padding-right:20px;" value ="Parcourir" onclick="document.getElementById('recette_upload').click(); return false"/><div>Taille maximum: 5 mo</div><div name="fileCount" id="fileCount"></div></div> 
                <label name="filename" id="filename" class="filename">aucune image choisie</label> 
                  
                </fieldset>
        </div>
      
            <fieldset class="ing" id="formnewing">
                <legend>Ingrédients</legend>
                <input type="button" style="margin-left:10px;margin-bottom:20px;padding-left:20px;padding-right:20px;" class="addingfields" id="addingfields" value ="Ajouter un ingrédient"/>                   
            </fieldset>  
        
            <div class="explication">
                <label for="recette_instructions">Étapes de préparation</label> 
                    <div>
                            <textarea name="recette_instructions" id="recette_instructions" rows="25" cols="100"></textarea>
                    </div>
            </div>
        
            <div class="explication">
                <label for="recette_notes">Avertissement et notes additionnelles sur les ingrédients ou la recette</label>
                <textarea name="recette_notes" id="recette_notes" rows="3" cols="100"></textarea>
            </div>
        
            <div class="liens_bouton">
                    <div>
                            <a href="admin_recipe_tolist.jsp">Annuler</a> ou <input style="padding-left:20px;padding-right:20px;" type="submit" class="save" id="save" name="save" value="Enregistrer" />
                    </div>
            </div>
             
</form>        

    </c:when>
  
    <c:otherwise>
<sql:query dataSource="${snapshot}" var="label_recette">SELECT * FROM label lbl JOIN p_type_label ptl ON lbl.id_type_label=ptl.id_type_label WHERE lbl.id_recette=<%=request.getParameter("id")%>;</sql:query>
<sql:query dataSource="${snapshot}" var="ingredients_recette">SELECT * FROM ingredients ing JOIN p_type_unite ptu ON ing.id_type_unite=ptu.id_type_unite JOIN p_type_fraction ptf ON ptf.id_type_fraction=ing.id_type_fraction WHERE ing.id_recette=<%=request.getParameter("id")%>;</sql:query>
<sql:query dataSource="${snapshot}" var="sommaire">SELECT * FROM sommaire som JOIN p_type_sommaire pts ON som.id_type_sommaire=pts.id_type_sommaire WHERE id_recette=<%=request.getParameter("id")%>;</sql:query>
<sql:query dataSource="${snapshot}" var="images">SELECT * FROM images WHERE id_recette=<%=request.getParameter("id")%> ORDER BY principale DESC;</sql:query>
<sql:query dataSource="${snapshot}" var="unites">SELECT * FROM p_type_unite;</sql:query>
<sql:query dataSource="${snapshot}" var="fractions">SELECT * FROM p_type_fraction;</sql:query>
    
<c:forEach var="rec" items="${recettes.rows}" varStatus="status">
    <div class="gros_titre">Modification d'une recette</div>
    <form  action="admin_recipe_uploadfile.jsp?id=<%=request.getParameter("id")%>" method="post" enctype="multipart/form-data" accept-charset="utf-8"> 
    <!--<form  action="admin_recipe_savechanges2.jsp" method="get">-->
        <div class="explication">
            <input type="hidden" name="recette_id" value=<%=request.getParameter("id")%>>
            <div class="float">
                    <label for="recette_label">Catégorie</label>
                                           
                    <c:forEach var="lbls" items="${labels.rows}">
                        <input style="width: 20px; height: 20px; margin-left:15px;margin-right:5px;" id="recette_label" type="checkbox" name="recette_label"
                               <c:forEach var="mylbl" items="${label_recette.rows}" varStatus="mylblcount">
                                   <c:if test="${(lbls.id_type_label eq mylbl.id_type_label) and mylbl.actif==true}">
                                       checked="checked"
                                   </c:if>                               
                               </c:forEach>value="${lbls.id_type_label}">${lbls.label}                 
                    </c:forEach> 
                           
             </div>         
                    

            <label for="recette_titre">Titre</label><input type="text" name="recette_titre"
                    id="recette_titre" value="${rec.titre}" required />                   
                    
        </div>

        <div class="explication">
                    <label>Description</label>
        
                    <textarea name="recette_description" id="recette_description" rows="3">${rec.description}</textarea>
        </div>
        
        <div class="uploaded">
            <fieldset class="img">
                <legend>Images associées à la recette</legend>
                <c:choose>
                    <c:when test="${images.rowCount eq 0}">
                        <div class="warning">Aucune image n'est associée à cette recette</div>
                    </c:when>
                    <c:otherwise>
                        <div class="uploadedMain">Sélection de l'image principale: <select name='recette_imgMain' id='recette_imgMain'>
                            <c:forEach begin="0" end="${images.rowCount-1}" varStatus='j'>
                                <option value=${images.rows[j.index].id_image}>${j.count}</option>
                            </c:forEach>
                            </select></div>
                        <div class="warning">Les images possédant un encadré bleu seront supprimées à l'enregistrement.<br/>
                        <c:forEach var="img" items="${images.rows}" varStatus="i">
                            <div class='cadre'><div class='insideNum'>${i.count}</div><input class="checkbox" style="background-image: url(${pageContext.request.contextPath}${img.url_local});" id="recette_images" type="checkbox" name="recette_images" value="${img.id_image}"></div>
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
        
        <div class="recette_upload">
            <fieldset class="img">
                <legend>Téléversement d'images</legend>
                <div class='warning'>Maintenir la touche CTRL pour sélectionner plusieurs images.</div>
                <input type="file" id="recette_upload" name="recette_upload" accept="image/*" style="visibility:hidden; width:0px; height:0px;" multiple/>
                <div style="float:right;text-align:right;font-variant:all-small-caps;"><input type="button" id="uploadfile" name="uploadfile" style="padding-left:20px;padding-right:20px;" value ="Parcourir" onclick="document.getElementById('recette_upload').click(); return false"/><div>Taille maximum: 5 mo</div><div name="fileCount" id="fileCount"></div></div> 
                <label name="filename" id="filename" class="filename">aucune image choisie</label> 
                  
                </fieldset>
        </div>
      
            <fieldset class="ing" id="formnewing">
                <legend>Ingrédients</legend>
                <input type="button" style="margin-left:10px;margin-bottom:20px;padding-left:20px;padding-right:20px;" class="addingfields" id="addingfields" value ="Ajouter un ingrédient"/>
                <c:forEach var="ing" items="${ingredients_recette.rows}" varStatus="bigloop">   
                    <c:set var="nbreIngredients" value="${bigloop.index}"/>
                    <div class="lesingredients" name="ing_${bigloop.index}" id="ing_${bigloop.index}"><label>Quantité</label><input style="width: 55px;" type="number" min="0" max="9999" name="recette_ing_quantite" id="recette_ing_quantite" size="1" value="${ing.quantite}"/><select name="recette_ing_type_fraction" id="recette_ing_type_fraction">
                            <c:forEach var="f" items="${fractions.rows}" varStatus="loop">
                                <c:choose>
                                    <c:when test="${f.id_type_fraction eq ing.id_type_fraction}">
                                        <option name="recette_ing_type_fraction${loop.index}" id="recette_ing_type_fraction${loop.index}" value="${f.id_type_fraction}" selected>${f.fraction_nohtml}</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option name="recette_ing_type_fraction${loop.index}" id="recette_ing_type_fraction${loop.index}" value="${f.id_type_fraction}">${f.fraction_nohtml}</option>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach></select><label>Mesure</label><select name="recette_ing_type_unite" id="recette_ing_type_unite">
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
                        </select><label>Ingrédient</label><input type="text" style="width:45%;" maxlength="40" name="recette_ing_ingredient" id="recette_ing_ingredient_${bigloop.index}" value="${ing.ingredient}" required/><a class='remove'><img style='margin-bottom:-5px;' src='../resources/images/x.png'/></a></div>
                </c:forEach>
            </fieldset>    

        
            <div class="explication">
                <label for="recette_instructions">Étapes de préparation</label> 

                    <div>
                            <textarea name="recette_instructions" id="recette_instructions" rows="25" cols="100">${rec.instructions}</textarea>
                    </div>
            </div>
        
            <div class="explication">
                <label for="recette_notes">Avertissement et notes additionnelles sur les ingrédients ou la recette</label>
                <textarea name="recette_notes" id="recette_notes" rows="3" cols="100">${rec.notes}</textarea>
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
    var loaded = 0;
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
            loaded++;
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
            loaded++;
        });
        
        if(<%=!request.getParameterMap().containsKey("id")%>)
        {
            loop();
            function loop (){
                setTimeout(function (){
                    if(loaded!==2){
                        loop();
                    }
                    else{
                        $("#addingfields").trigger('click');
                    }
                },10);
            }
        }
        else
        {
            x = <%=pageContext.getAttribute("nbreIngredients")%>;
        }
    });
    
    
    $("#recette_upload").on('change',function(){
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
        var fieldWrapper = $("<div class=\"lesingredients\" name=\"ing_"+x+"\" id=\"ing_"+x+"\">");
        var fQuantite = $("<label>Quantité</label><input name=\"recette_ing_quantite\" style=\"width: 55px;\" type=\"number\" min=\"0\" max=\"9999\"  id=\"recette_ing_quantite\" size=\"1\" value=\"0\"/>");
        var fMesure = $("<label>Mesure</label>");
        fieldWrapper.append(fQuantite);        
        fieldWrapper.append(selectfraction);
        
        fieldWrapper.append(fMesure);
        fieldWrapper.append(selectmesure);
        
        var fType = $("<label>Ingrédient</label><input style=\"width:45%;\" maxlength=\"40\" name=\"recette_ing_ingredient\" type=\"text\" id=\"recette_ing_ingredient\" required/>");
        fieldWrapper.append(fType);
        
        var retirer = $("<a class='remove'><img style='margin-bottom:-5px;' src='../resources/images/x.png'/></a></div>");
        retirer.click(function() {
            $(this).parent("div").remove();x--;
        });
        fieldWrapper.append(retirer);    
        
        $("#formnewing").append(fieldWrapper);
    });
    $(".remove").click(function() {
            $(this).parent("div").remove();x--;
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