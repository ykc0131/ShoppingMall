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
<jsp:useBean id="join" class ="com.bean.JoinBean" scope="page"/>
<jsp:setProperty name="join" property="name" param="name"/>
<jsp:setProperty name="join" property="login_id" param="login_id"/>
<jsp:setProperty name="join" property="pwd" param="pwd"/>
<jsp:setProperty name="join" property="confirm" param="confirm"/>
<jsp:setProperty name="join" property="gender" param="sex"/>

<%
String name = join.getName();
String login_id = join.getLogin_id();
String pwd = join.getPwd();
String confirm = join.getConfirm();
String gender = join.getGender();
%>

<%
	if(name!=null&&login_id!=null&&pwd!=null&&gender!=null){
		try{
			//비밀번호 확인
			if(!pwd.equals(confirm)){
				%>
				<script>alert('비밀번호가 일치하지 않습니다.');</script>
				<script>location.href='Join.jsp';</script>
				<%
			}
			else{
				Class.forName("com.mysql.jdbc.Driver");
				Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/yookibee?characterEncoding=utf-8", "root", "root");
				String sql = "SELECT * FROM client WHERE login_id=?";
				PreparedStatement pst = conn.prepareStatement(sql);
				pst.setString(1,login_id);
				
				ResultSet rset = pst.executeQuery();
				
				if(rset.next()){
					%>
					<script>alert('중복된 아이디입니다.');</script>
					<script>location.href='Join.jsp';</script>
					<%
				}
				else{
					String sqlStr = "Insert into client(login_id,pw,name,gender) values(?,?,?,?)";
					PreparedStatement pstmt = conn.prepareStatement(sqlStr);
					
					pstmt.setString(1,login_id);
					pstmt.setString(2,pwd);
					pstmt.setString(3,name);
					pstmt.setString(4,gender);
					
					pstmt.execute();
					pstmt.close();

					%>
					<script>location.href='JoinSuccess.jsp';</script>
					<%
				}
			}
		}catch(SQLException e){
			out.println(e.toString());
			%>
			회원가입 실패
			<%
		}
	}
	else{
		%>
		<script>alert('모든 항목에 기입해주세요');</script>
		<script>location.href='Join.jsp';</script>
		<%
	}
%>

</body>
</html>