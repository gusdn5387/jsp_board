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
<%
	boardDAO bd = new boardDAO();
	int num = Integer.parseInt(request.getParameter("num"));
	boardBean boardbean = bd.selectDetail(num);
	String title = request.getParameter("title");
	String userid = request.getParameter("userid");
	String content = request.getParameter("content");
	if(title!=null && userid!=null && content!=null) {
		boardbean = new boardBean();
		boardbean.setTitle(title);
		boardbean.setUserid(userid);
		boardbean.setContent(content);
		boardbean.setNum(num);
		if(bd.update(boardbean) == 1) out.println("<script>alert('수정 완료.'); location.href = 'index.jsp?tpage=1'</script>");
		else if(bd.update(boardbean) == 0) out.println("<script>alert('수정 실패.');</script>");
	}
%>
</head>
<body>
	<form>
		<table border = "1" style="text-align:center; width:700px; margin:0 auto;">
			<input type = "hidden" value ="<%=num %>" name="num"/>
			<tr>
				<th style="width:10%;">제목</th>
				<td><input type = "text" name="title" maxlength="50" style="width:100%; padding:5% 0% 5% 0%; border:0;" value ="<%=boardbean.getTitle() %>"required/></td>
			</tr>
			<tr>
				<th style="width:10%;">작성자</th>
				<td><input type = "text" name="userid" maxlength="50" style="width:100%; padding:5% 0% 5% 0%; border:0;" value ="<%=boardbean.getUserid() %>" required/></td>
			</tr>
			<tr>
				<th style="width:10%;">글내용</th>
				<td><textarea name="content" rows="30" cols="85" style="border:0;" required><%=boardbean.getContent().replace("\r\n", "<br>") %></textarea></td>
			</tr>
			<tr>
				<td colspan= "2">
					<input type = "submit" value="수정"/>
					<input type="reset" value="취소"/>
					<input type="button" value="목록" onClick = "location.href='index.jsp?tpage=1'"/>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>