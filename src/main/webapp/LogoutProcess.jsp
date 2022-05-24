<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Logout</title>
</head>
<body>
<% 
session.setAttribute("login_id", null);
session.setAttribute("id",null);
session.setAttribute("name",null);
%>
<script>location.href='HomePage.jsp';</script>

</body>
</html>