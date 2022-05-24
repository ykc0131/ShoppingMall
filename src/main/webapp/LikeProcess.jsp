<%@ page import="java.sql.*" %>
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
<jsp:useBean id="like" class ="com.bean.LikeBean" scope="page"/>

<jsp:setProperty name="like" property="id" param="id"/>
<jsp:setProperty name="like" property="item_id" param="item_id"/>
<jsp:setProperty name="like" property="islike" param="islike"/>
<jsp:setProperty name="like" property="currentUri" param="currentUri"/>

<%
	Integer id = like.getId();
	Integer item_id = like.getItem_id();
	Integer islike = like.getIslike();
	String currentUri = like.getCurrentUri();
	
	if(currentUri.equals("/final/Detail.jsp")){
		currentUri = currentUri+"?item="+item_id;
	}
	
	if(islike==0){
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/yookibee?characterEncoding=utf-8", "root", "root");
			
			String sqlStr = "Insert into likelist(id,item_id) values(?,?)";
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);
			
			pstmt.setInt(1,id);
			pstmt.setInt(2,item_id);
			
			pstmt.execute();
			pstmt.close();

			%>
				<script>location.href="http://localhost:8080"+"<%=currentUri%>";</script>
			<%
			
		}catch(SQLException e){
			out.println(e.toString());
		}
	}
	else if(islike==1){
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/yookibee?characterEncoding=utf-8", "root", "root");
			
			String sqlStr = "DELETE from likelist WHERE id=? and item_id=?";
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);
			
			pstmt.setInt(1,id);
			pstmt.setInt(2,item_id);
			
			pstmt.execute();
			pstmt.close();

			%>
				<script>location.href="http://localhost:8080"+"<%=currentUri%>";</script>
			<%
			
		}catch(SQLException e){
			out.println(e.toString());
		}
	}
%>

</body>
</html>