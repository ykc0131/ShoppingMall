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
<jsp:useBean id="comment" class ="com.bean.CommentCreateBean" scope="page"/>
<jsp:setProperty name="comment" property="board_id" param="board_id"/>
<jsp:setProperty name="comment" property="comment" param="comment"/>
<jsp:setProperty name="comment" property="currentUri" param="currentUri"/>

<%
Integer board_id = comment.getBoard_id();
String context= comment.getComment();
String currentUri = comment.getCurrentUri();
if(currentUri.equals("/final/QuestionPost.jsp")){
	currentUri = currentUri+"?page="+board_id;
}
%>

<%	
	if(board_id!=null&&context!=null){
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/yookibee?characterEncoding=utf-8", "root", "root");
			String sqlStr = "Insert into comment(board_id,comment) values(?,?)";
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);
			
			pstmt.setInt(1,board_id);
			pstmt.setString(2,context);
			
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