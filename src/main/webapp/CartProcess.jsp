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
<jsp:useBean id="cart" class ="com.bean.CartBean" scope="page"/>

<jsp:setProperty name="cart" property="id" param="id"/>
<jsp:setProperty name="cart" property="item_id" param="item_id"/>
<jsp:setProperty name="cart" property="currentUri" param="currentUri"/>

<%
	Integer id = cart.getId();
	Integer item_id = cart.getItem_id();
	String currentUri = cart.getCurrentUri();
	
	if(currentUri.equals("/final/Detail.jsp")){
		currentUri = currentUri+"?item="+item_id;
	}
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/yookibee?characterEncoding=utf-8", "root", "root");
	

	try{
		String sql = "SELECT * FROM cart WHERE id=? and item_id=?";
		PreparedStatement pst = conn.prepareStatement(sql);
		pst.setInt(1,id);
		pst.setInt(2,item_id);
		
		ResultSet rset = pst.executeQuery();
		if(rset.next()){
			%>
				<script>alert('이미 장바구니에 담긴 상품입니다.');</script>
				<script>location.href="http://localhost:8080"+"<%=currentUri%>";</script>
			<%
		}
		else{
			String sqlStr = "Insert into cart(id,item_id) values(?,?)";
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);
			
			pstmt.setInt(1,id);
			pstmt.setInt(2,item_id);
			
			pstmt.execute();
			pstmt.close();

			%>
				<script>alert('장바구니에 추가되었습니다.');</script>
				<script>location.href="http://localhost:8080"+"<%=currentUri%>";</script>
			<%
		}
		
	}catch(SQLException e){
		out.println(e.toString());
	}
%>
</body>
</html>