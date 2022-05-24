<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Yookibee</title>
<style>
#logo{
	left:620px;
	position:absolute;
	text-align: center;
}
a{
	color:#3B3838;
	text-decoration : none;
}
#loginSection{
	text-align : right;
	width:350px;
	float:right;
	top:10px;
	left :1100px;
	position: absolute;
	font-size:13px;
}
#mode{
	color:#7F7F7F;
	font-size:13px;
	top:90px;
	left :920px;
	position: absolute;
}
#barlist{
top:140px;
left:330px;
position:absolute;
	list-style:none;
	text-align:center;
	
}
#barlist li{
	display:inline;
	padding: 0 30px;
	letter-spacing:8px;
}

#logoutform{
	display:inline;
}

#logoutinput{
	border-style:none;
	background-color:white;
	font-size:13px;
}
.barlink{
color:#3B3838;;
	text-decoration : none;
	text-size:10px; 
}

#mypagelist li{
    display:inline;
	padding: 0 30px;
	letter-spacing:8px;
}

h2{
font-size:30px;
	text-align: center;
	color: #3B3838;
}
#tabledesign{
border-collapse:collapse;
border-bottom:1px solid #3B3838;
}

#tabledesign thead{
	border-top:1px solid #3B3838;
	border-bottom:1px solid #3B3838;
}

#writebtn{
	text-align : right;
	left :1286px;
	position: relative;
	border: 1px solid #3B3838;
	padding:3px;
	padding-right:5px;
	padding-left:5px;
	font-weight : bold;
	font-size : 15px;
	color: #3B3838;
	text-decoration : none;
}
#board-list{
	position: relative;
	width: 1400px;
}
#board-title{
	width:1000px;
}
</style>
</head>
<body>
<%
String loginSection = "";
String mode="";
	if (session.getAttribute("name") == null) {
		loginSection = 
				"<a href='Join.jsp'>회원가입</a>&nbsp&nbsp&nbsp<a href='Login.jsp'>로그인 </a>";
	}
	else{
		String modecheck = (String)session.getAttribute("id");
		Integer modecheck_id = Integer.parseInt(modecheck);
		if(modecheck_id==1){
			mode="관리자페이지";
			loginSection =
					" <a href='Root.jsp' style='font-size:13px;'>관리자설정</a>"
					+ "<form id=\"logoutform\" action = \"LogoutProcess.jsp\" method=\"post\" onsubmit=\"if(!confirm(\'로그아웃하시겠습니까?\')){return false;}\">"
					+ "<input type =\"submit\" value =\"로그아웃\" id=\"logoutinput\">"
					+ "</form>";;
		}
		else{
			loginSection = 
					"<strong>"+(String)session.getAttribute("name")+"</strong> 님"
					+ "&nbsp&nbsp<a href='LikePage.jsp'>좋아요</a>&nbsp&nbsp<a href='Cart.jsp'>장바구니</a>&nbsp&nbsp<a href='MyPage.jsp'>마이페이지</a>&nbsp"
					+ "<form id=\"logoutform\" action = \"LogoutProcess.jsp\" method=\"post\" onsubmit=\"if(!confirm(\'로그아웃하시겠습니까?\')){return false;}\">"
					+ "<input type =\"submit\" value =\"로그아웃\" id=\"logoutinput\">"
					+ "</form>";
		}
	}
	
%>
<br>
<div id="logo"><a href="HomePage.jsp"><img src="image/logo.png" style="width:300px;"></a></div>


<div id="loginSection">
<%=loginSection%>
</div>
<div id="mode"><%=mode%></div>
<br>
<ul id="barlist">
	<li><a href="DessertPage.jsp" class="barlink">DESSERT</a></li>
	<li><a href="BestPage.jsp" class="barlink">BEST10</a></li>
	<li><a href="EventPage.jsp" class="barlink">EVENT</a></li>
	<li><a href="NoticePage.jsp" class="barlink">NOTICE</a></li>
	<li><a href="QuestionPage.jsp" class="barlink">Q&A</a></li>
</ul>

<br><br>
<br><br>
<br><br><hr>
<br><br>
<h2>Q&A</h2>
<hr style="width:15%;">
<br><br>
<%
	try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/yookibee?characterEncoding=utf-8", "root", "root");
		Statement stmt = conn.createStatement();
		
		String sqlStr = "SELECT board_id,title,board.id as id,login_id FROM board left join (select * from client union select * from expireclient) as uniontable on board.id=uniontable.id order by board_id asc";
		ResultSet rset = stmt.executeQuery(sqlStr);
		
		%>
		
		
		<center>
		<div id="board-list">
		<table cellpadding="20" id="tabledesign">
		<thead>
			<tr>
				<th>No.</th>
				<th>제목</th>
				<th>작성자</th>
			</tr>
		</thead>
		<%
		int count=1;
		while (rset.next()) {
	        %>
	        	<tr><td id="board-num"><%=count++ %></td>
	        	<%
	        	
		    		if(session.getAttribute("id")!=null){
		    			String modecheck = (String)session.getAttribute("id");
			    		Integer modecheck_id = Integer.parseInt(modecheck);
			    		
		    			if(modecheck_id == rset.getInt("id") || modecheck_id==1){
		    				%>
		    				<td id="board-title"><a href="QuestionPost.jsp?page=<%=rset.getInt("board_id")%>"><%=rset.getString("title")%></a></td>
		    				<%
		        		}
		    			else{
		    				%>
		    				<td id="board-title"><a href="QuestionPage.jsp" onclick="alert('작성자만 볼 수 있습니다.')"><%=rset.getString("title")%></a>
		    				<%
		    			}
		    		}
		    		else{
		    			%>
	    				<td id="board-title"><a href="QuestionPage.jsp" onclick="alert('로그인이 필요합니다.')"><%=rset.getString("title")%></a>
	    				<%
		    		}
		    		
	        	%>
	        	
	        	<td id="board-writer"><%=rset.getString("login_id")%></td></tr>
	        <%
	      }
		%></table></div></center><br>
		<%
		if(session.getAttribute("id")!=null){
			String modecheck = (String)session.getAttribute("id");
    		Integer modecheck_id = Integer.parseInt(modecheck);
    		%>
    			<a href="boardCreate.jsp" id="writebtn">작성하기</a>
    		<%
		}
		
		rset.close();
		stmt.close();
		
	}catch(SQLException e){
		out.println(e.toString());
	}
%>

</body>
</html>