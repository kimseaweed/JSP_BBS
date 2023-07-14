<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter,bbs.*" %>
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
	
	int bbsID = 0;
	if(request.getParameter("bbsID")!=null){
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}else{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href='bbs.jsp'");
		script.println("</script>");
	}
	BbsDAO bbsDAO = new BbsDAO();
	Bbs bbs = bbsDAO.getBbs(bbsID);
	//빈즈로 얻어온 값이 아닌 실제 입력한 값을 getParameter로 값을 검증한다.
	if(!userID.equals(bbs.getUserID())){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("location.href='bbs.jsp'");
		script.println("</script>");
	}else{
		if(request.getParameter("bbsTitle")==null|request.getParameter("bbsContent")==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력 안된 사항이 있습니다.')");
			script.println("history.back();");
			script.println("</script>");
		}else{
			int result = bbsDAO.getUpdate(bbsID,request.getParameter("bbsTitle"),request.getParameter("bbsContent"));
			if(result==-1){ //데이터베이스 오류
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기에 실패했습니다.')");
				script.println("history.back();");
				script.println("</script>");
			}else{
				PrintWriter script = response.getWriter(); 
				script.println("<script>");
				script.println("location.href='bbs.jsp'");
				script.println("</script>");				
				}
			}
		} %>	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src = "js/bootstrap.js"></script>
</body>
</html>