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
	String idString = request.getParameter("id");
	Integer id = Integer.parseInt(idString);
%>

<%
	String sqlStr="";
	try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/yookibee?characterEncoding=utf-8", "root", "root");
		
		sqlStr ="Select * from client where id=?";
		PreparedStatement pstmt1 = conn.prepareStatement(sqlStr);
		pstmt1.setInt(1,id);
		
		ResultSet rset = pstmt1.executeQuery();
		if(rset.next()){
			sqlStr = "Insert into expireclient(id,login_id,pw,name,gender) values(?,?,?,?,?)";
			PreparedStatement pstmt2 = conn.prepareStatement(sqlStr);
			pstmt2.setInt(1,rset.getInt("id"));
			pstmt2.setString(2,rset.getString("login_id"));
			pstmt2.setString(3,rset.getString("pw"));
			pstmt2.setString(4,rset.getString("name"));
			pstmt2.setString(5,rset.getString("gender"));
			
			pstmt2.execute();
			
			sqlStr = "DELETE from client WHERE id=?";
			PreparedStatement pstmt3 = conn.prepareStatement(sqlStr);
			
			pstmt3.setInt(1,id);
			
			pstmt3.execute();
			
			%>
			<script>location.href='AdminUser.jsp';</script>
			<%
			pstmt2.close();
			pstmt3.close();
		}
		pstmt1.close();
		
		
	}catch(SQLException e){
		out.println(e.toString());
	}
%>
<script>location.href='AdminUser.jsp';</script>

</body>
</html>