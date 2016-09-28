<%-- 
    Document   : index
    Created on : Sep 26, 2016, 5:25:28 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1><a href="${pageContext.request.contextPath}/pages/admin_recipe_form.jsp">admin_form (ajout/modif)</a></h1>
        <h1><a href="${pageContext.request.contextPath}/pages/admin_recipe_tolist.jsp">admin_list (to list)</a></h1>
        <h1><a href="${pageContext.request.contextPath}/pages/recipe_tolist.jsp">listing</a></h1>
        <h1><a href="${pageContext.request.contextPath}/pages/recipe_detail.jsp">detail (1)</a></h1>
    </body>
</html>
