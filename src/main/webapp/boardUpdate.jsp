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
	width:150px;
}
table{
	width:900px;
	font-size:20px;
	color: #3B3838;
}
#inputtext{
	width:800px;
	height:25px;
	border:solid 1px #3B3838;
	border-radius:5px;
	border-collapse:collapse;
}

#inputtextarea{
	overflow:visible;
	resize:none;
	width:100%;
	height:100%;
	border:solid 1px #3B3838;
	border-radius:5px;
	border-collapse:collapse;
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

<jsp:useBean id="update" class ="com.bean.BoardCreateBean" scope="page"/>
<jsp:setProperty name="update" property="title" param="title"/>
<jsp:setProperty name="update" property="post" param="post"/>

<%
	String pageNum= request.getParameter("page");
	Integer board_id = Integer.parseInt(pageNum);
%>

<center id="tableborder">
<table cellpadding="10">
<form action="boardUpdateProcess.jsp" method ="post">
<input type="hidden" name="board_id" value=<%=board_id%>>
<tr>
	<td>제목</td>
	<td><input type="text" name="title" id="inputtext"  value="<jsp:getProperty name="update" property="title"/>"></td>
</tr>
<tr>
	<td ><div id="context">내용</div></td>
	<td><textarea name="post" id="inputtextarea" rows="30" ><jsp:getProperty name="update" property="post"/></textarea></td>
</tr>
<tr>
	<td colspan="2" class="jointd"><input type="image" src="image/update.png" id="updateBtn"></td>
</tr>
</form>
</table>
</center>
</body>
</html>