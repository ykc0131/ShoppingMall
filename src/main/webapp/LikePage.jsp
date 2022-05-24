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
	color:#3B3838;
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
#product-list{
	position: relative;
	width: 1400px;
}
.product-image{
	width:300px;
	height:400px;
}
.product-info{
	width:150px;
}
#clickTable{
width:300px;
}
.detaillist{
 text-decoration : none;
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
<h2>좋아요</h2>
<hr style="width:15%;">
<br><br>


<%
try{	
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/yookibee?characterEncoding=utf-8", "root", "root");
	String sqlLikeStr = "SELECT * FROM likelist left join item on likelist.item_id = item.item_id WHERE id=?";
    PreparedStatement pstmt = conn.prepareStatement(sqlLikeStr);
    pstmt.setString(1,(String)session.getAttribute("id"));
    
    int count=0;
	%>
	<center>
	<div id="product-list">
	<table cellpadding="20">
	<tr><%
	ResultSet result = pstmt.executeQuery();
	String currentUri = request.getRequestURI();
	 while(result.next()) {
		 
		 if(count%4==0){
	        	%></tr><tr><%
	        }
		 %>
		 <td id="<%=result.getInt("item_id")%>">
	        		<a class="detaillink" href="Detail.jsp?item=<%=result.getInt("item_id")%>">
	        		<div class="product-image"><img src="<%=result.getString("imgurl")%>"></div></a>
	        		<table id="clickTable">
	        			<tr>
	        				<td><div class="product-info" class="product-name" ><%=result.getString("name")%></div></td>
	        				<td rowspan="2">
	        					<form action="LikeProcess.jsp" method="post">
	        						<input type="hidden" name="currentUri" value="<%=currentUri %>">
		        					<input type="hidden" name="id" value="<%=(String)session.getAttribute("id") %>">
		        					<input type="hidden" name="item_id" value="<%=result.getInt("item_id")%>">
		        					<input type="hidden" name="islike" value="1">
		        					<input type="image" src="image/like.png" style="width:40px;float:right;">
		        				</form>
	        				<td rowspan="2">
	        					<form action="CartProcess.jsp" method="post" onsubmit="if(!confirm('장바구니에 담으시겠습니까?')){return false;}">
		        					<input type="hidden" name="id" value="<%=(String)session.getAttribute("id") %>">
		        					<input type="hidden" name="item_id" value="<%=result.getInt("item_id")%>">
		        					<input type="image" src="image/cart.png" style="width:60px;float:right;">
	        					</form>
	        			</tr>
	        			<tr>
	        				<td><div class="product-info" class="product-price"><%=result.getInt("price")%></div></td>
	        			</tr>
	        		</table>
	        	</td>
	        <%
	        count++;
	      }
		 if(count<4){
				for(; count<4;count++){
					%>
					<td style="width:300px;"></td>
					<%
				}
		 }
		%></tr></table></div></center><%
		result.close();
		pstmt.close();
}catch(SQLException e){
	out.println(e.toString());
	//
}
%>



</body>
</html>