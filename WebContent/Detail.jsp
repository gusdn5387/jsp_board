<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%@ page import = "dao.boardDAO" %>
    <%@ page import = "bean.boardBean" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 연습</title>
</head>
<%
	boardDAO bd = new boardDAO();
	int num = Integer.parseInt(request.getParameter("num"));
	boardBean boardbean = bd.selectDetail(num);
	String title = boardbean.getTitle();
	String userid = boardbean.getUserid();
	String bdate = boardbean.getBdate();
	String content = boardbean.getContent().replace("\r\n", "<br>");
	String password = boardbean.getPassword();
%>
<script>
	function chk1() {
		var pass = prompt('비밀번호를 입력하세요');
		if(pass == '<%=password%>') {
			location.href='UpdateBoard.jsp?num=<%=num%>';
		} else if (pass != '<%=password%>') {
			alert("비밀번호가 틀렸습니다!");
		}
	} 
	
	function chk2() {
		var pass = prompt('비밀번호를 입력하세요');
		if(pass == '<%=password%>') {
			location.href='DeleteBoard.jsp?num=<%=num%>';
		} else if (pass != '<%=password%>') {
			alert("비밀번호가 틀렸습니다!");
		}
	} 
</script>
<body>
	<form>
		<table border = "1" style="text-align:center; width:700px; margin:0 auto;">
			<tr>
				<th style="width:10%;">제목</th>
				<td style = "width: 90%;"><%=title %></td>
			</tr>
			<tr>
				<th style="width:10%;">작성자</th>
				<td style = "width: 90%;"><%=userid %></td>
			</tr>
			<tr>
				<th style="width:10%;">작성일</th>
				<td style = "width: 90%;"><%=bdate %></td>
			</tr>
			<tr>
				<th style="width:10%;">글내용</th>
				<td style = "width: 90%; text-align:left;"><%=content %></td>
			</tr>
			<tr>
				<td colspan= "2">
					<input type="button" value="목록" onClick = "location.href='index.jsp?tpage=1'"/>
					<input type="button" value="수정" onClick = "chk1();"/>
					<input type="button" value="삭제" onClick = "chk2();"/>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>