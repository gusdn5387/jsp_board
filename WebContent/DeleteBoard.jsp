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
	boardBean boardbean = new boardBean();
	int num = Integer.parseInt(request.getParameter("num"));
	boardbean = new boardBean();;
	boardbean.setNum(num);
	if(bd.delete(boardbean) == 1) out.println("<script>alert('삭제 완료.'); location.href = 'index.jsp?tpage=1'</script>");
	else if(bd.delete(boardbean) == 0) out.println("<script>alert('삭제 실패.');</script>");
%>
</head>
<body>
</body>
</html>