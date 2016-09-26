<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:query dataSource="${snapshot}" var="result">
SELECT * from Employees;
</sql:query>

<%-- exemple de table avec un foreach
        
        <table class="listing" border="1" width="100%">
            <tr>
                <th>Emp ID</th>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Age</th>
            </tr>
            <c:forEach var="row" items="${result.rows}" varStatus="status">
                <tr class="${status.index%2==0 ? 'alt' : ''}">
                    <td><a href="${pageContext.request.contextPath}/book?id=${book.id}">${book.title}</a></td>
                    <td><c:out value="${row.id}"/></td>
                    <td><c:out value="${row.first}"/></td>
                    <td><c:out value="${row.last}"/></td>
                    <td><c:out value="${row.age}"/></td>
                    <td><fmt:formatDate value="${book.pubDate}" type="both" dateStyle ="short" timeStyle ="short"/></td>
                </tr>
            </c:forEach>
        </table>
        --%>