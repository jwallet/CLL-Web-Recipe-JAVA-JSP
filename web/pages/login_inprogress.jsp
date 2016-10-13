<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/dbrecette"
     user="root"  password=""/>
<c:set var="ressemblance" value="false"/>
<c:set var="pass" value=""/>
<%
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
        String sPass = rs.getString(4);
        if(sUser.equals(request.getParameter("user")))
        {
            byte[] bytes = "0:?0$è0u3!l3t4T0û7f41tCepr#Jè7".getBytes();
            String mypass = request.getParameter("password");
            String mynewpass = new String();
            byte[] b = mypass.getBytes();
            for(int i=0;i<b.length;i++)
            {
                b[i] += bytes[i];
                mynewpass += (char)(b[i]-20)/5;
                mynewpass += (char)(b[i]*2-17)/2;
                mynewpass += (char)((b[i]*5))/3;
            }
            if(sPass.equals(mynewpass))
            {
                pageContext.setAttribute("pass", mynewpass);
                pageContext.setAttribute("ressemblance", true);
            }
        }
    }
%>

<c:choose>    
    <c:when test="${ressemblance==true}">
            <%
                // Create cookies for first and last names.      
                Cookie usager = new Cookie("usager",
                                       request.getParameter("user"));
                Cookie motdepasse = new Cookie("motdepasse",
                                       (String)pageContext.getAttribute("pass"));

                // Set expiry date after 24 Hrs for both the cookies.
                usager.setMaxAge(60*60*24); 
                motdepasse.setMaxAge(60*60*24); 

                // Add both the cookies in the response header.
                response.addCookie( usager );
                response.addCookie( motdepasse );
             %>
            <c:redirect url="admin_recipe_tolist.jsp"/>
    </c:when>
    <c:otherwise>
         <c:redirect url="login.jsp?failed=true"/>
    </c:otherwise>
</c:choose>
