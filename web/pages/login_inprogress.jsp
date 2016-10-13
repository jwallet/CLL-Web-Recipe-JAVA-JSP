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
            String mypass = request.getParameter("password");
            if(!mypass.isEmpty())
            {
                String mynewpass = new String();
                byte[] bHash = "0:?0$É0u3!l3t4T0û7f41tCeprÔJ%7".getBytes();
                while(mypass.getBytes().length<30 && !mypass.isEmpty())
                    mypass+=mypass;
                byte[] bMyPass = mypass.getBytes();
                byte[] bBuffer = "000000000000000000000000000000".getBytes();
                for(int i=0;i<bBuffer.length;i++)
                {            
                    mynewpass += (int)(Math.abs((bMyPass[i])+(bHash[i])));
                }
                if(sPass.equals(mynewpass))
                {
                    pageContext.setAttribute("pass", mynewpass);
                    pageContext.setAttribute("ressemblance", true);
                }
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
