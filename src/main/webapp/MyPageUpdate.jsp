<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 작성</title>
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
#updateBtn{
	width:100px;
}
table{
	width:300px;
	font-size:20px;
	color: #3B3838;
}
#inputtext{
border: 1px solid red;
	width:800px;
	height:25px;
	border:solid 1px #3B3838;
	border-radius:5px;
	border-collapse:collapse;
}

#inputtextarea{
	overflow:visible;
	border: 1px solid red;
	resize:none;
	width:100%;
	height:100%;
	border:solid 1px #3B3838;
	border-radius:5px;
	border-collapse:collapse;
}
#context{
border: 1px solid red;
}
</style>
</head>
<body>
<% request.setCharacterEncoding("utf-8");%>
<% response.setContentType("text/html;charset=UTF-8"); %>
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

<jsp:useBean id="update" class ="com.bean.JoinBean" scope="page"/>
<jsp:setProperty name="update" property="login_id" param="login_id"/>
<jsp:setProperty name="update" property="pwd" param="pwd"/>
<jsp:setProperty name="update" property="name" param="name"/>
<jsp:setProperty name="update" property="gender" param="gender"/>


<center id="tableborder">
<table cellpadding="10">
<form action="MyPageUpdateProcess.jsp" method ="post">
<tr>
	<td>ID</td>
	<td><input type="text" name="login_id" class="inputdesgin" value="<jsp:getProperty name="update" property="login_id"/>"></td>
</tr>
<tr>
	<td>PW</td>
	<td><input type="password" name="pwd" class="inputdesgin" value="<jsp:getProperty name="update" property="pwd"/>"></td>
</tr>
<tr>
	<td>NAME</td>
	<td><input type="text" name="name" class="inputdesgin" value="<jsp:getProperty name="update" property="name"/>"></td>
</tr>
<tr>
	<td>GENDER</td>
	<td class="jointd">남자<input type='radio' name="sex" value="M" style="width:30px;">
	   여자 <input type='radio' name ="sex" value="F" style="width:30px;"></td>
</tr>
<tr>
	<td colspan="2" class="jointd"><input type="image" src="image/update.png" id="updateBtn"></td>
</tr>
</form>
</table>
</center>
</body>
</html>