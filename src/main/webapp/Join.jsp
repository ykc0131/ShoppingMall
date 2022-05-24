<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Join</title>
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
#mypagelist li{
    border: 1px solid red;
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


.jointd{
	text-align: center;
}
#joinBtn{
	width:150px;
}
table{
	width:300px;
	font-size:20px;
	color: #3B3838;
}
.inputdesgin{
	width:230px;
	height:25px;
	border-style:none;
	border-bottom:solid 1px #3B3838;
	border-collapse:collapse;
}
h2{
	color: #3B3838;
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
<div id="logo"><a href="HomePage.jsp"><img src="image/logo.png"  style="width:300px;"></a></div>
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


<center id="tableborder">
<h2>회원가입</h2>
<table cellpadding="10">
<form action="JoinProcess.jsp" method ="post">
<tr>
	<td>ID</td>
	<td><input type="text" name="login_id" class="inputdesgin"></td>
</tr>
<tr>
	<td>PW</td>
	<td><input type="password" name="pwd" class="inputdesgin"></td>
</tr>
<tr>
	<td>PW확인</td>
	<td><input type="password" name="confirm" class="inputdesgin"></td>
</tr>
<tr>
	<td>NAME</td>
	<td><input type="text" name="name" class="inputdesgin"></td>
</tr>
<tr>
	<td>GENDER</td>
	<td class="jointd">남자<input type='radio' name="sex" value="M" style="width:50px;">
	   여자 <input type='radio' name ="sex" value="F" style="width:50px;"></td>
</tr>
<tr>
	<td colspan="2" class="jointd"><input type="image" src="image/join.png" id="joinBtn"></td>
</tr>
</form>
</table>
</center>
</body>
</html>