<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://www.atg.com/taglibs/json" prefix="json" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/dbrecette"
     user="root"  password=""/>

<sql:query dataSource="${snapshot}" var="fractions">SELECT * FROM p_type_fraction</sql:query>

  <json:array name="fraction" var="fr" items="${fractions.rows}">
    <json:object>
      <json:property name="id_type_fraction" value="${fr.id_type_fraction}"/>
      <json:property name="fraction" value="${fr.fraction}"/>
    </json:object>
  </json:array>
