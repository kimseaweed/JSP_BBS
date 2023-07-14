<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter,bbs.BbsDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>게시판 웹사이트</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css">
</head>
<body>
<% 	
	String userID = null;
	
	// ▼ 세션중 "userID"라는 이름의 세션이 비어있지 않다면 userID에 세션의 값을 담는다.
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	// ▼ userID에 값을 담는것을 성공했다면(userID가 비어있지않다면) 이미 로그인되어있다고 안내한뒤 메인으로 돌아간다.
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 해주세요.')");
		script.println("location.href='login.jsp'");
		script.println("</script>");
	}else{	
		int bbsID =  Integer.parseInt(request.getParameter("bbsID"));
		BbsDAO bbsDAO = new BbsDAO();
		int result = bbsDAO.getDelete(bbsID);
		if(result==-1){ //데이터베이스 오류
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('삭제에 실패했습니다.')");
			script.println("history.back();");
			script.println("</script>");
		}else{
			PrintWriter script = response.getWriter(); 
			script.println("<script>");
			script.println("alert('삭제했습니다.')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");			
		}
	}
%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src = "js/bootstrap.js"></script>
</body>
</html>