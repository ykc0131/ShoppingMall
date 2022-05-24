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
<jsp:useBean id="update" class ="com.bean.BoardUpdateBean" scope="page"/>
<jsp:setProperty name="update" property="board_id" param="board_id"/>
<jsp:setProperty name="update" property="title" param="title"/>
<jsp:setProperty name="update" property="post" param="post"/>
<%
	Integer board_id = update.getBoard_id();
	String title = update.getTitle();
	String post = update.getPost();
%>
<%
	if(title!=null&&post!=null){
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/yookibee?characterEncoding=utf-8", "root", "root");
			
			String sqlStr = "UPDATE board SET title=?,post=? WHERE board_id=?";
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);
			
			pstmt.setString(1,title);
			pstmt.setString(2,post);
			pstmt.setInt(3,board_id);
			
			pstmt.execute();
			pstmt.close();

			%>
			response.write("<script>location.href='QuestionPost.jsp?page=<%=update.getBoard_id()%>';</script>")
			<%
			
		}catch(SQLException e){
			out.println(e.toString());
		}
	}
	else{
		%>
		<script>alert('공백 없이 입력해주세요');</script>
		<script>location.href='.jsp';</script>
		<%
	}
%>

</body>
</html>