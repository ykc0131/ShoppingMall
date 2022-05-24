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
<jsp:useBean id="board" class ="com.bean.BoardCreateBean" scope="page"/>
<jsp:setProperty name="board" property="title" param="title"/>
<jsp:setProperty name="board" property="post" param="post"/>

<%
String idString = (String)session.getAttribute("id");
Integer id = Integer.parseInt(idString);
String title = board.getTitle();
String post = board.getPost();
%>
id : <%=id %>
<%
	if(title!=null&&post!=null){
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/yookibee?characterEncoding=utf-8", "root", "root");
			
			String sqlStr = "Insert into board(id,title,post) values(?,?,?)";
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);
			
			pstmt.setInt(1,id);
			pstmt.setString(2,title);
			pstmt.setString(3,post);
			
			pstmt.execute();
			pstmt.close();

			%>
			<script>location.href='QuestionPage.jsp';</script>
			<%
			
		}catch(SQLException e){
			out.println(e.toString());
		}
	}
	else{
		%>
		<script>alert('공백 없이 입력해주세요');</script>
		<script>location.href='boardCreate.jsp';</script>
		<%
	}
%>

</body>
</html>