<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	text-decoration : none;
	text-size:10px; 
}

#clickTable{
width:300px;
}

#post-detail-table{
background-color:#F9F9F9;
padding:30px;
	position: relative;
	width: 700px;
}
#comment-detail-table{
background-color:#F5F5F5;
padding:30px;
	position: relative;
	width: 700px;
}

.post-detail-design,.comment-detail-design{
	text-align:left;
	color: #3B3838;
}


#post-detail-title{
	width:645px;
font-size:25px;
padding:10px;
}

#post-detail-content{
	width:600px;
font-size:15px;
padding:20px;
}

#comment-detail-content{
width:600px;
font-size:12px;
padding-top:20px;
padding-bottom:30px;
padding-left:20px;
padding-right:20px;
}
#updateform,#deleteform,#commentform{
	display:inline;
}

#updateinput,#deleteinput{
	border-style:none;
	background-color:white;
	border: 1px solid #3B3838;
	font-size:12px;
}

#commentinput{
	border-style:none;
	background-color:white;
	border: 2px solid #3B3838;
	font-size:20px;
}
#commentsection{
	position:relative;
	width:600px;
}
.btndesign{
	color: #3B3838;
	font-size:13px;
	text-decoration : none;
}
#btnsection{
	text-align : right;
	top:55px;
	right :80px;
	position: absolute;
	padding:4px;
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

<jsp:useBean id="postContext" class ="com.bean.BoardPostBean" scope="page"/>

<%
	String pageNum= request.getParameter("page");
	Integer board_id = Integer.parseInt(pageNum);
%>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/yookibee?characterEncoding=utf-8", "root", "root");
	try{
		String sqlStr = "SELECT board_id,title,post,board.id as id,login_id FROM board left join client on board.id=client.id WHERE board_id=?";
		PreparedStatement pstmt = conn.prepareStatement(sqlStr);
		pstmt.setInt(1,board_id);
		
		ResultSet rset = pstmt.executeQuery();
		
		if (rset.next()) {
			postContext.setBoard_id(rset.getInt("board_id"));
			postContext.setId(rset.getInt("id"));
			postContext.setWriter(rset.getString("login_id"));
			postContext.setTitle(rset.getString("title"));
			postContext.setPost(rset.getString("post"));
		
			rset.close();
		}
	}catch(SQLException e){
		out.println(e.toString());
	}

%>

<br><br>

<center>
	<div id="post-detail-table">
		<div>
			<center><div class="post-detail-design" id="post-detail-title"><jsp:getProperty name="postContext" property="title"/></div></center>
			<div id="btnsection">
				<form action="boardUpdate.jsp?page=<%=pageNum%>" method="post" class="btndesign" id="updateform" onsubmit="if(!confirm('수정하시겠습니까?')){return false;}">
					<input type="hidden" name="title" value="<jsp:getProperty name="postContext" property="title"/>">
					<input type="hidden" name="post" value="<jsp:getProperty name="postContext" property="post"/>">
					<input type="submit" id="updateinput" value="수정">
				</form>
				<form action="boardDelete.jsp" method="post" class="btndesign" id="deleteform" onsubmit="if(!confirm('삭제하시겠습니까?')){return false;}">
					<input type="hidden" name="board_id" value="<jsp:getProperty name="postContext" property="board_id"/>">
					<input type="submit" id="deleteinput" value="삭제">
				</form>
			</div>
			<hr style="width:90%;">
		</div>
		<div>
		 <center><div class="post-detail-design" id="post-detail-content"><jsp:getProperty name="postContext" property="post"/></div></center>
		</div>
	</div>
</center>
<br>
<%
	try{
		String sqlStr = "SELECT board_id,comment FROM comment WHERE board_id=?";
		PreparedStatement pstmt = conn.prepareStatement(sqlStr);
		pstmt.setInt(1,board_id);
		
		ResultSet rset = pstmt.executeQuery();

		String modecheck = (String)session.getAttribute("id");
		Integer modecheck_id = Integer.parseInt(modecheck);
		if (rset.next()) {
			String currentUri = request.getRequestURI();
			%>
			
			  <center>
				<div id="comment-detail-table">
					<div> <center><div class="comment-detail-design" id="comment-detail-content"><%=rset.getString("comment")%></div></center></div>
				</div>
			</center>
			<%
			rset.close();
		}
		else{
			String currentUri = request.getRequestURI();
			if(modecheck_id==1){
				%>
				<center>
					<div id="comment-detail-table">
						<br>
						<div id="commentsection">
							<form action="CommentCreateProcess.jsp" method="post" class="btndesign" id="commentform">
								<input type="hidden" name="currentUri" value="<%=currentUri %>">
								<input type="hidden" name="board_id" value="<jsp:getProperty name="postContext" property="board_id"/>">
								<textarea name="comment" placeholder="내용입력" id="inputtextarea" rows="30"></textarea>
								<input type="submit" value="답변하기" id="commentinput">
							</form>
						</div>
					</div>
				</center>
				<%
			}
		}
	}catch(SQLException e){
		out.println(e.toString());
	}
 
  %>
</body>
</html>