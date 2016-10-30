<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<c:set var="cookieUser" value=""/>
<c:set var="redirectNow" value="false"/>
<%
    String admin = request.getParameter("admin");
    if(admin.equals("admin_"))
    {
        Cookie cookie = null;
        Cookie[] cookies = null;
        String usager="";
        String pass="";
        
        // Get an array of Cookies associated with this domain
        cookies = request.getCookies();
        
        if( cookies != null)
        {
            int i;
            for ( i=0; i < cookies.length; i++)
            {
                cookie = cookies[i]; 
                if(cookie.getName().equals("usager")||cookie.getName().equals("motdepasse"))
                {
                    if(cookie.getName().equals("usager"))
                    {
                        usager=cookie.getValue();
                    }
                    else if(cookie.getName().equals("motdepasse"))
                    {
                        pass=cookie.getValue();
                    }
                    if(usager!="" && pass!="")
                    {
                        java.sql.Statement stmt;
                        java.sql.Connection conn;
                        java.sql.ResultSet rs;
                        String sQuery = "SELECT * FROM redacteurs";
                        Class.forName("com.mysql.jdbc.Driver").newInstance();
                        conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost/dbrecette", "root", "");
                        stmt = conn.createStatement();
                        rs = stmt.executeQuery(sQuery);
                        while(rs.next())
                        {
                            String sUser = rs.getString(2);
                            String sName = rs.getString(3);
                            String sPass = rs.getString(4);
                            if(sUser.equals(usager) && sPass.equals(pass))
                            {
                                if(sName==null){sName=usager;}
                                pageContext.setAttribute("cookieUser", sName);
                            }
                        }
                        if(pageContext.getAttribute("cookieUser").equals(""))
                        {
                            pageContext.setAttribute("redirectNow", true);
                        }
                    }
                }
                if(usager==""&&pass==""&&i==cookies.length-1)
                {
                    pageContext.setAttribute("redirectNow", true);                
                }
            }
        }
        else
        {
           pageContext.setAttribute("redirectNow", true);
        }
    }
%>
<c:if test="${redirectNow==true}">
    <script>document.location.href="login.jsp";</script>
</c:if>


<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/dbrecette"
     user="root"  password=""/>

<!DOCTYPE HTML>
<html>
<head>
    <title>${param.title}</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width">
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.1.1.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/style.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/lightbox.css"/>
    <link href="https://fonts.googleapis.com/css?family=Shadows+Into+Light+Two" rel="stylesheet" type="text/css">
</head>
<body>    
    <jsp:include page="/pages/${param.admin}header.jsp">
        <jsp:param name="cUser" value="${cookieUser}"/>
    </jsp:include>	
    <jsp:include page="/pages/${param.content}.jsp"/>
    <jsp:include page="/pages/${param.admin}footer.jsp"/>  
    <script src="${pageContext.request.contextPath}/resources/js/lightbox.js"></script>    
</body>
</html>

