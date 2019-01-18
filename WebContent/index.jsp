<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%@ page import = "java.util.*" %>
    <%@ page import = "dao.boardDAO" %>
    <%@ page import = "bean.boardBean" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
	.page {position:fixed; top: 60%; left: 32%; }
	a {text-decoration:none;}
</style>
<title>게시판 연습</title>
<%
	boardDAO bd = new boardDAO();
	int tpage = Integer.parseInt(request.getParameter("tpage"));
	
	int countpage = 10;
	
	int totalcount = bd.totalcount();
	
	int startcount = (tpage-1) * countpage+1;
	
	int endcount = tpage * countpage;
	
	int countList = 10;
	
	int totalpage = totalcount / countList;
	
	if(totalcount % countList > 0) {
		totalpage++;
	}
	
	if(totalpage < tpage) {
		tpage = totalpage;
	}
	
	int startpage = ((tpage-1) / 10) * 10 + 1;
	
	int endpage = startpage + countpage - 1;
	
	if(endpage > totalpage) {
		endpage = totalpage;
	}
%>
</head>
<body>
	<table border="1" style="text-align:center; width: 700px; margin:0 auto;">
		<tr>
			<th>글 번호</th><th>제목</th><th>작성자</th><th>날짜</th>
		</tr>
		<%
			ArrayList<boardBean> postList = bd.select(tpage);
			for(boardBean boardbean : postList) {
		%>
			<tr>
				<td><%=boardbean.getNum()%></td>
				<td><a href = "Detail.jsp?num=<%=boardbean.getNum()%>"><%=boardbean.getTitle()%></a></td>
				<td><%=boardbean.getUserid()%></td>
				<td><%=boardbean.getBdate()%></td>
			</tr>
		<%
			}
		%>
		<tr>
			<td colspan="4">
				<input type="button" value="작성" onClick = "location.href='WriteBoard.jsp'"/>
			</td>
		</tr>
	</table>
	<div class = "page">
<%
	
	if(startpage > 1) {
		out.println("<a href ='index.jsp?tpage=1'>처음</a>");
	} 
	
	if(tpage > 1) {
		out.println("<a href ='index.jsp?tpage="+(tpage-1)+"'>이전</a>");
	} else {
		out.println("이전");
	}
	
	for(int i = startpage; i <= endpage; i++) {
		if(i == tpage) {
			out.println("<b>"+i+"</b>");
		} else {
			out.println("<a href ='index.jsp?tpage="+i+"'>"+i+"</a>");
		}
	}
	
	if(tpage < totalpage) {
		out.println("<a href='index.jsp?tpage="+(tpage+1)+"'>다음</a>");
	} else {
		out.println("다음");
	}
	
	if(endpage < totalpage) {
		out.println("<a href='index.jsp?tpage="+totalpage+"'>끝</a>");
	} 
%>
	</div>
</body>
</html>