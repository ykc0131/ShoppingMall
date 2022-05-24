<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete</title>
</head>
<body>
<% request.setCharacterEncoding("utf-8");%>
<% response.setContentType("text/html;charset=UTF-8"); %>
<jsp:useBean id="cart" class ="com.bean.CartBean" scope="page"/>

<jsp:setProperty name="cart" property="id" param="id"/>
<jsp:setProperty name="cart" property="item_id" param="item_id"/>
<% 
	Integer id = cart.getId();
	Integer item_id = cart.getItem_id();
%>

<%
	try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/yookibee?characterEncoding=utf-8", "root", "root");
		
		String sqlStr = "DELETE from cart WHERE id=? and item_id=?";
		PreparedStatement pstmt = conn.prepareStatement(sqlStr);
		
		pstmt.setInt(1,id);
		pstmt.setInt(2,item_id);
		
		pstmt.execute();
		pstmt.close();
	
		%>
			<script>location.href='Cart.jsp';</script>
		<%
		
	}catch(SQLException e){
		out.println(e.toString());
	}
%>
</body>
</html>