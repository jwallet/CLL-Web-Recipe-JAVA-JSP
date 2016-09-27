<jsp:include page="/pages/template.jsp">
	<jsp:param name="content" value="admin_recipe_form_content"/>
	<jsp:param name="title" value="Recette"/>
        <jsp:param name="admin" value="admin_"/>
        <jsp:param name="id" value="<%=request.getParameter("id")%>"/>
</jsp:include>