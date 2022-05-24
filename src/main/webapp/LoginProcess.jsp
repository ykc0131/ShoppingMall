<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<% request.setCharacterEncoding("utf-8");%>
<% response.setContentType("text/html;charset=UTF-8"); %>
<jsp:useBean id="confirm" class ="com.bean.LoginBean" scope="page"/>
<jsp:setProperty name="confirm" property="login_id" param="login_id"/>
<jsp:setProperty name="confirm" property="pwd" param="pwd"/>
<%
	String login_id = confirm.getLogin_id();
	String pwd = confirm.getPwd();
%>


<%
	if(login_id!=null){
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/yookibee?characterEncoding=utf-8", "root", "root");
			Statement stmt = conn.createStatement();
			
			String sqlStr = "SELECT pw,name,id FROM client WHERE login_id=?";
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);
			pstmt.setString(1,login_id);
			
			ResultSet rset = pstmt.executeQuery();
			String name="";
			
			if (rset.next()) {
		        String pw = rset.getString("pw");
		        if(pw.equals(pwd)){
		        	session.setAttribute("id", rset.getString("id"));
		        	session.setAttribute("login_id", login_id);
					session.setAttribute("name",rset.getString("name"));
					%>
					<script>location.href='HomePage.jsp';</script>
					<%
		        }
		        else{
		        	%>
		        	<script>alert('비밀번호가 일치하지 않습니다.');</script>
					<script>location.href='Login.jsp';</script>
		        	<%
		        	
		        }
		      }
			else{
				%>
				<script>alert('회원정보가 존재하지 않습니다');</script>
				<script>location.href='Login.jsp';</script>
				<%
			}
			rset.close();
			pstmt.close();
			
		}catch(SQLException e){
			out.println(e.toString());
			%>
			로그인 실패
			<%
		}
	}
%>

</body>
</html>