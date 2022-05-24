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
<% 
	String boardstring = request.getParameter("board_id");
	Integer board_id = Integer.parseInt(boardstring);
%>

<%
	try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/yookibee?characterEncoding=utf-8", "root", "root");
		
		String sqlStr = "DELETE from board WHERE board_id=?";
		PreparedStatement pstmt = conn.prepareStatement(sqlStr);
		
		pstmt.setInt(1,board_id);
		
		pstmt.execute();
		pstmt.close();
	
		%>
			response.write("<script>location.href='QuestionPage.jsp';</script>")
		<%
		
	}catch(SQLException e){
		out.println(e.toString());
	}
%>

response.write("<script>location.href='QuestionPage.jsp';</script>")

</body>
</html>