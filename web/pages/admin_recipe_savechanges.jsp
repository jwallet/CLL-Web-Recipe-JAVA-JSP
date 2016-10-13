<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/dbrecette"
     user="root"  password=""/>

<c:set var="id" value="${param.recette_id}"/>

<sql:transaction dataSource="${snapshot}">
    <c:choose>
    <%--si c'est une nouvelle recette AJOUT--%>
        <c:when test="${empty id}" >        
            <%--Ajout Titre, Description, Etapes preparation, notes additionnelles, brouillon=actif--%>
            <sql:update  var="count">INSERT INTO recettes (titre, description, instructions, notes, brouillon) VALUES ("${param.recette_titre}", "${param.recette_description}", "${param.recette_instructions}", "${param.recette_notes}", 1)</sql:update>

            <%--Trouve ID dans BD et l'associer a la nouvelle recette--%>
            <sql:query  var="id_recettes">SELECT id_recette FROM recettes ORDER BY id_recette DESC LIMIT 1;</sql:query>
            <c:set var="id_recette" value="${id_recettes.rows[0].id_recette}"/>

            <%--Ajout categorie (x4)--%>
            <sql:update>INSERT INTO label (id_recette, id_type_label, actif) VALUES (${id_recette},1,0),(${id_recette},2,0),(${id_recette},3,0),(${id_recette},4,0);</sql:update>
            <c:if test="${!empty param.recette_label}">
                <c:forEach var="lbl" items="${paramValues.recette_label}" varStatus="j">
                    <c:choose>
                        <c:when test="${j.count != fn:length(paramValues.recette_label)}">
                            <c:set var="sqllbl" value="${j.first ? '' : sqllbl}(${id_recette},${lbl},1),"/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="sqllbl" value="${sqllbl}(${id_recette},${lbl},1)"/>
                        </c:otherwise>
                    </c:choose>                    
                </c:forEach>
                <sql:update var="count">INSERT INTO label (id_recette, id_type_label,actif) VALUES ${sqllbl};</sql:update>
            </c:if>

            <%--Ajout sommaire (x4)--%>
            <sql:update var="count">INSERT INTO sommaire (id_recette, id_type_sommaire, nbre_unite) VALUES (${id_recette},1,"${param.recette_preparation}"),(${id_recette},2,"${param.recette_cuisson}"),(${id_recette},3,"${param.recette_refroidissement}"),(${id_recette},4,"${param.recette_portions}");</sql:update>

            <%--Ajout ingredients (tous)--%>
            <c:if test="${!empty param.recette_ing_ingredient}">
                <c:forEach var="ingredient" items="${paramValues.recette_ing_ingredient}" varStatus="i">
                    <c:set var="ingQuantite" value="${paramValues.recette_ing_quantite[i.index]}"/>
                    <c:if test="${ingQuantite==0}"><c:set var="ingQuantite" value='NULL'/></c:if>
                    <c:choose>
                        <c:when test="${i.count != fn:length(paramValues.recette_ing_ingredient)}">
                            <c:set var="sqling" value="${i.first ? '' : sqling}(${id_recette},${i.count},${ingQuantite},${paramValues.recette_ing_type_fraction[i.index]},${paramValues.recette_ing_type_unite[i.index]},\"${ingredient}\"),"/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="sqling" value="${sqling}(${id_recette},${i.count},${ingQuantite},${paramValues.recette_ing_type_fraction[i.index]},${paramValues.recette_ing_type_unite[i.index]},\"${ingredient}\")"/>
                        </c:otherwise>
                    </c:choose>                    
                </c:forEach>
                <sql:update var="count">INSERT INTO ingredients (id_recette, num_ligne, quantite, id_type_fraction, id_type_unite, ingredient) VALUES ${sqling};</sql:update>
            </c:if>

            <%--Ajout des images--%>
            <c:if test="${!empty param.recette_upload}">
                <c:forEach var="image" items="${paramValues.recette_upload}" varStatus="k">
                    <c:choose>
                        <c:when test="${k.index==0}">"(${id},\"/images/${id}/${image}\",1),"
                            <c:set var="sqlimg" value="(${id_recette},\"/images/${id_recette}/${image}\",1),"/>
                        </c:when>
                        <c:when test="${k.count != fn:length(paramValues.recette_upload)}">
                            <c:set var="sqlimg" value="${sqlimg}(${id_recette},\"/images/${id_recette}/${image}\",0),"/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="sqlimg" value="${sqlimg}(${id_recette},\"/images/${id_recette}/${image}\",0),"/>
                        </c:otherwise>
                    </c:choose>                    
                    <%--<c:set var="sqlimg" value="${k.first ? '' : sqlimg}(${id_recette},"/images/${id_recette}/${image}"),"/>--%>
                </c:forEach> 
                <c:set var="sqlimg" value="${fn:substring(sqlimg,0,fn:length(sqlimg)-1)}"/>
            <sql:update var="count">INSERT INTO images (id_recette, url_local, principale) VALUES ${sqlimg};</sql:update>
            </c:if>
        </c:when>

        <%--si c'est une modification d'une recette MODIF, on update tout pareille--%>
        <c:otherwise>        
            <%--Modifier Titre, Description, Etapes preparation, notes additionnelles, brouillon=actif--%>
            <sql:update var="count">UPDATE recettes SET titre="${param.recette_titre}", description="${param.recette_description}", instructions="${param.recette_instructions}", notes="${param.recette_notes}" WHERE id_recette=${id};</sql:update>

            <%--Modifier categorie (x4)--%>
            <sql:update var="count">UPDATE label SET actif=0 WHERE id_recette=${id};</sql:update>
            <c:if test="${!empty param.recette_label}">
                <c:forEach var="lbl" items="${paramValues.recette_label}" varStatus="j">
                    <c:choose>
                        <c:when test="${j.count != fn:length(paramValues.recette_label)}">
                            <c:set var="sqllbl" value="${j.first ? '' : sqllbl}id_type_label=${lbl} OR "/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="sqllbl" value="${sqllbl}id_type_label=${lbl}"/>
                        </c:otherwise>
                    </c:choose>                    
                </c:forEach>
                <sql:update var="count">UPDATE label SET actif=1 WHERE id_recette=${id} AND (${sqllbl});</sql:update>
            </c:if>

            <%--Modifier sommaire (x4)--%>recette_preparation
            <sql:update var="count">UPDATE sommaire SET nbre_unite="${param.recette_preparation}" WHERE id_recette=${id} AND id_type_sommaire=1;</sql:update>
            <sql:update var="count">UPDATE sommaire SET nbre_unite="${param.recette_cuisson}" WHERE id_recette=${id} AND id_type_sommaire=2;</sql:update>
            <sql:update var="count">UPDATE sommaire SET nbre_unite="${param.recette_refroidissement}" WHERE id_recette=${id} AND id_type_sommaire=3;</sql:update>
            <sql:update var="count">UPDATE sommaire SET nbre_unite="${param.recette_portions}" WHERE id_recette=${id} AND id_type_sommaire=4;</sql:update>

            <%--Modifier ingredients si y'en a moins maintenant qu'avant, on supprime les entrees de trop--%>
            <sql:query var="sIngredients">SELECT * FROM ingredients WHERE id_recette=${id};</sql:query>
            <c:if test="${sIngredients.rowCount > fn:length(paramValues.recette_ing_ingredient)}">
                <%--<c:forEach begin="${sIngredients.rowCount+1}" end="${fn:length(paramValues.recette_ing_ingredient)}" varStatus="l">--%>
                    <sql:update var="count">DELETE FROM ingredients WHERE id_recette=${id} AND num_ligne>${fn:length(paramValues.recette_ing_ingredient)};</sql:update>
                <%--</c:forEach>--%>
            </c:if>            
            
            <%--Modifier ingredients (tous) (si recu en param) et les reordonnes selon le numero de ligne--%>
            <c:if test="${!empty param.recette_ing_ingredient}">                
                <c:forEach var="ingredient" items="${paramValues.recette_ing_ingredient}" varStatus="i">
                    <c:set var="ingQuantite" value="${paramValues.recette_ing_quantite[i.index]}"/>
                    <c:if test="${ingQuantite==0 || empty ingQuantite}"><c:set var="ingQuantite" value='NULL'/></c:if>
                    <c:choose>
                        <c:when test="${i.count <= sIngredients.rowCount}">//update
                            <sql:update var="count">UPDATE ingredients SET quantite=${ingQuantite}, id_type_fraction=${paramValues.recette_ing_type_fraction[i.index]}, id_type_unite=${paramValues.recette_ing_type_unite[i.index]}, ingredient="${ingredient}" WHERE id_recette=${id} AND num_ligne=${i.count};</sql:update>
                        </c:when>
                        <c:otherwise>//insert
                            <sql:update var="count">INSERT INTO ingredients (id_recette, num_ligne, quantite, id_type_fraction, id_type_unite, ingredient) VALUES (${id},${i.count},${ingQuantite},${paramValues.recette_ing_type_fraction[i.index]},${paramValues.recette_ing_type_unite[i.index]},"${ingredient}");</sql:update>
                        </c:otherwise>
                    </c:choose>                 
                    <%--<c:set var="sqling" value="UPDATE ingredients SET quantite=${ingQuantite}, id_type_fraction=${paramValues.recette_ing_type_fraction[i.index]}, id_type_unite=${paramValues.recette_ing_type_unite[i.index]}, ingredient="${ingredient}" WHERE id_recette=${id} AND num_ligne=${i.count};"/>--%>
                </c:forEach>
                <%--<sql:update var="count">${sqling}</sql:update>--%>
            </c:if>

            <%--Modif de l'image principale selon si elle ne l'est pas deja--%>
            <sql:query var="sImgMain">SELECT id_image FROM images WHERE id_recette=${id} AND principale=1;</sql:query>
            <c:if test="${sImgMain.rows[0].id_image != param.recette_imgMain}">
                <sql:update var="count">UPDATE images SET principale=0 WHERE id_recette=${id}</sql:update>
                <sql:update var="count">UPDATE images SET principale=1 WHERE id_recette=${id} AND id_image=${param.recette_imgMain}</sql:update>
            </c:if>
                
            <%--Retrait des images selectionnees en bleu--%>
            <c:if test="${!empty param.recette_images}">
                <c:forEach var="byeImg" items="${paramValues.recette_images}" varStatus="m">
                    <c:choose>
                        <c:when test="${m.count != fn:length(paramValues.recette_images)}">
                            <c:set var="sqlByeImg" value="${m.first ? '' : sqlByeImg}id_image=${byeImg} OR "/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="sqlByeImg" value="${sqlByeImg}id_image=${byeImg}"/>
                        </c:otherwise>
                    </c:choose>                    
                </c:forEach>
                <sql:update var="count">DELETE FROM images WHERE id_recette=${id} AND (${sqlByeImg});</sql:update>
            </c:if>
            
            <%--Ajout des images--%>
            <sql:query var="sImg">SELECT id_image FROM images WHERE id_recette=${id};</sql:query>
            <c:choose>
            <%--Si y'a plus qu'une image reliee a la recette on verifie si elle nest pas la principale--%>
            <%--sinon on set la premiere uploader en principale et on upload les autres--%>
                <c:when test="${sImg.rowCount>0}">
                    <sql:query var="sImgMain2">SELECT id_image FROM images WHERE id_recette=${id} AND principale=1;</sql:query> 
                    <c:if test="${!empty param.recette_upload}">
                        <c:forEach var="image" items="${paramValues.recette_upload}" varStatus="n">
                            <c:choose>
                                <c:when test="${n.index==0 && sImgMain2.rowCount==0}">
                                    <c:set var="sqlimg" value="(${id},\"/images/${id}/${image}\",1),"/>
                                </c:when>
                                <c:otherwise>
                                    <c:set var="sqlimg" value="${n.first ? '' : sqlimg}(${id},\"/images/${id}/${image}\",0),"/>
                                </c:otherwise>
                            </c:choose>                    
                            <%--<c:set var="sqlimg" value="${n.first ? '' : sqlimg}(${id},"/images/${id}/${image}"),"/>--%>
                        </c:forEach> 
                        <c:set var="sqlimg" value="${fn:substring(sqlimg,0,fn:length(sqlimg)-1)}"/>
                        <sql:update var="count">INSERT INTO images (id_recette, url_local, principale) VALUES ${sqlimg};</sql:update>
                    </c:if>
                </c:when>
            <%--si ya aucune image reliee a la recette la premiere uploader sera defnie en tant que principale, et on upload les autres--%>
                <c:otherwise>
                    <c:if test="${!empty param.recette_upload}">
                        <c:forEach var="image" items="${paramValues.recette_upload}" varStatus="k">
                            <c:choose>
                                <c:when test="${k.index==0}">
                                    <c:set var="sqlimg" value="(${id},\"/images/${id}/${image}\",1),"/>
                                </c:when>
                                <c:otherwise>
                                    <c:set var="sqlimg" value="${sqlimg}(${id},\"/images/${id}/${image}\",0),"/>
                                </c:otherwise>
                            </c:choose>                    
                            <%--<c:set var="sqlimg" value="${k.first ? '' : sqlimg}(${id},"/images/${id}/${image}"),"/>--%>
                        </c:forEach> 
                        <c:set var="sqlimg" value="${fn:substring(sqlimg,0,fn:length(sqlimg)-1)}"/>
                        <sql:update var="count">INSERT INTO images (id_recette, url_local, principale) VALUES ${sqlimg};</sql:update>
                    </c:if>  
                </c:otherwise>
            </c:choose>          
        </c:otherwise>
    </c:choose>
</sql:transaction>
 
<script>
    document.location.href="admin_recipe_tolist.jsp";
</script>