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
	color:#3B3838;;
	text-decoration : none;
	text-size:10px; 
}

#clickTable{
width:300px;
}

#product-detail{
	position: relative;
	width: 1000px;
}

#product-image{
width: 450px;
}

#product-name{
	background-color:#FFF8E5;
	position: relative;
	font-size:40px;
}

#product-price{
	background-color:#FFF8E5;
	position: relative;
	font-size:30px;
}

#prodcut-detail-content{
	padding:30px;
	text-align:center;
	font-size:20px;
	
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

<jsp:useBean id="detail" class ="com.bean.DetailBean" scope="page"/>

<%
	String item= request.getParameter("item");
	Integer item_id = Integer.parseInt(item);
%>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/yookibee?characterEncoding=utf-8", "root", "root");
	try{
		String sqlStr = "SELECT item.item_id as item_id,name,price,detail,imgurl FROM item left join item_detail on item.item_id = item_detail.item_id WHERE item.item_id=?";
		PreparedStatement pstmt = conn.prepareStatement(sqlStr);
		pstmt.setInt(1,item_id);
		
		ResultSet rset = pstmt.executeQuery();
		
		if (rset.next()) {
			if(item_id.equals(rset.getInt("item_id"))){
				detail.setItem_id(rset.getInt("item_id"));
				detail.setName(rset.getString("name"));
				detail.setPrice(rset.getInt("price"));
				detail.setImgurl(rset.getString("imgurl"));
		        detail.setDetail(rset.getString("detail"));
	     	}

			rset.close();
		}
		else{
			%>
			response.write("<script>alert('회원정보가 존재하지 않습니다');</script>");
			response.write("<script>location.href='Login.html';</script>")
			<%
		}
	}catch(SQLException e){
		out.println(e.toString());
	}

%>

<%
		String likeImgUrl="image/unlike.png";
        Integer islike = 0;
        String currentUri = request.getRequestURI();
       	if(session.getAttribute("name") != null){
       		try{
       			String sqlLikeStr = "SELECT * FROM likeList WHERE id=? and item_id=?";
		        PreparedStatement pstmt = conn.prepareStatement(sqlLikeStr);
		        pstmt.setString(1,(String)session.getAttribute("id"));
				pstmt.setInt(2,item_id);
				
				ResultSet result = pstmt.executeQuery();
				if (result.next()) {
			       	likeImgUrl = "image/like.png";
			       	islike=1;
			    }
		      	pstmt.close();
       		}catch(SQLException e){
       			out.println(e.toString());
       			//
    		}
       	}
%>

<center>
	<table id="product-detail">
		<tr>
			<td id="product-image" rowspan="5"><img src="<jsp:getProperty name="detail" property="imgurl"/>" style="width:370px;"></td>
			<td colspan="2"  style="height:55px;"><div id="product-name"><jsp:getProperty name="detail" property="name"/></div></td>
		</tr>
		<tr>
			<td colspan="2"  style="height:50px;"><div id="product-price"><jsp:getProperty name="detail" property="price"/> 원</div></td>
		</tr>
		<tr>
			<td colspan="2"  style="height:50px;"><br></td>
		</tr>
		<tr>
       		<td style="height:50px;width:450px;">
       			<%if(session.getAttribute("name") == null) {
       			%>
       			<img src="image/unlike.png" style="width:60px;float:right;" onclick="alert('로그인이 필요합니다.');">
       			<%
       			}else{
       			%>
       				<form action="LikeProcess.jsp" method="post">
      					<input type="hidden" name="currentUri" value="<%=currentUri %>">
       					<input type="hidden" name="id" value="<%=(String)session.getAttribute("id") %>">
       					<input type="hidden" name="item_id" value="<%=item_id%>">
       					<input type="hidden" name="islike" value="<%=islike%>">
       					<input type="image" src="<%=likeImgUrl %>" style="width:60px;float:right;">
        			</form>
     			<%
     			}
     			%>
     		</td>
     		<td style="height:50px;">
        		<%if(session.getAttribute("name") == null) {
       			%>
       			<img src="image/cart.png" style="width:80px;float:right;" onclick="alert('로그인이 필요합니다.');">
       			<%
       			}else{
       			%>
       				<form action="CartProcess.jsp" method="post" onsubmit="if(!confirm('장바구니에 담으시겠습니까?')){return false;}">
       					<input type="hidden" name="currentUri" value="<%=currentUri %>">
        				<input type="hidden" name="id" value="<%=(String)session.getAttribute("id") %>">
        				<input type="hidden" name="item_id" value="<%=item_id%>">
        				<input type="image" src="image/cart.png" style="width:80px;float:right;">
       				</form>
       			<%
       			}
       			%>
       		</td>
	    </tr>
		<tr>
			<td colspan="2"  style="height:200px;background-color:#FFF8E5;" ><center><div id="prodcut-detail-content"><jsp:getProperty name="detail" property="detail"/></div></center></td>
		</tr>
		
	</table>
</center>
<%
      
  %>
</body>
</html>