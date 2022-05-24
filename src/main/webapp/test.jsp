<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% request.setCharacterEncoding("utf-8");%>
<% response.setContentType("text/html;charset=UTF-8"); %>
<jsp:useBean id="test" class="com.bean.DetailBean" scope="page"/>

<jsp:setProperty name="test" property="detail" param="detail"/>
<jsp:setProperty name="test" property="color" param="color"/>


<jsp:getProperty name="test" property="detail"/>
<jsp:getProperty name="test" property="color"/>



</body>
</html>