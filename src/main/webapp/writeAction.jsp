<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter,bbs.BbsDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />
<!-- ▲ 자바빈즈인 User클래스를 가져오고 join페이지로 부터 전달된 정보를 user에 셋팅시킴 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>게시판 웹사이트</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
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
		if(bbs.getBbsTitle()==null|bbs.getBbsTitle()==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력 안된 사항이 있습니다.')");
			script.println("history.back();");
			script.println("</script>");
		}else{
			BbsDAO bbsDAO = new BbsDAO();
			int result = bbsDAO.write(bbs.getBbsTitle(),userID,bbs.getBbsContent());
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
	}
%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src = "js/bootstrap.js"></script>
</body>
</html>