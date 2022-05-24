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
<jsp:useBean id="update" class ="com.bean.JoinBean" scope="page"/>
<jsp:setProperty name="update" property="login_id" param="login_id"/>
<jsp:setProperty name="update" property="pwd" param="pwd"/>
<jsp:setProperty name="update" property="name" param="name"/>
<jsp:setProperty name="update" property="gender" param="sex"/>

<%
String name = update.getName();
String login_id = update.getLogin_id();
String pwd = update.getPwd();
String gender = update.getGender();
%>
<%=name %>
<%=login_id %>
<%=pwd %>
<%=gender %>
<%
	if(name!=null&&login_id!=null&&pwd!=null&&gender!=null){
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/yookibee?characterEncoding=utf-8", "root", "root");
			
			String sqlStr = "UPDATE client SET login_id=?,pw=?,name=?,gender=? WHERE id=?";
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);
			
			pstmt.setString(1,login_id);
			pstmt.setString(2,pwd);
			pstmt.setString(3,name);
			pstmt.setString(4,gender);
			pstmt.setString(5,(String)session.getAttribute("id"));
			
			pstmt.execute();
			pstmt.close();

        	session.setAttribute("login_id", login_id);
			session.setAttribute("name",name);
			%>
			<script>location.href="MyPageConfirm.jsp";</script>
			<%
			
		}catch(SQLException e){
			out.println(e.toString());
		}
	}
	else{
		%>
			<script>alert('공백 없이 입력해주세요');</script>
			<script>location.href='MyPageUpdate.jsp';</script>
		<%
	}
%>

</body>
</html>