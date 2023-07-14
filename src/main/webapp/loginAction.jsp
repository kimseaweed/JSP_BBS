<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter,user.UserDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="user" class="user.User" scope="page" /> <!-- 빈즈 객체 생성 -->
<jsp:setProperty name="user" property="userID" />	<!-- setUserID()와 동일 -->
<jsp:setProperty name="user" property="userPassword" /> <!-- setUserPassword()와 동일 -->
<!-- ▲ 자바빈즈인 User클래스를 가져오고 login페이지로 부터 전달된 userID와 userPassword를 user에 셋팅시킴 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>게시판 웹사이트</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" >
</head>
<body>
<% 
	String userID = null;
	
	// ▼ 세션중 "userID"라는 이름의 세션이 비어있지 않다면 userID에 세션의 값을 담는다.
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	// ▼ userID에 값을 담는것을 성공했다면(userID가 비어있지않다면) 이미 로그인되어있다고 안내한뒤 메인으로 돌아간다.
	if(userID != null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인되어있습니다.')");
		script.println("location.href='main.jsp'");
		script.println("</script>");
	}
	
	/*********************************/
	UserDAO userDAO = new UserDAO(); 
	int result = userDAO.login(user.getUserID(), user.getUserPassword());
	//useBean을 통해 셋팅된 userID와 userPassword를 가져와 매개값으로 넣음. 리턴될수있는 수는 1(로그인),0(비번불일치),-1(아이디없음),-2(데이터베이스 오류)
	if(result ==1){
		session.setAttribute("userID",user.getUserID()); 
		//▲ "userID"라는 이름의 세션을 설정하고 로그인한 회원의 아이디를 값으로 지정한다
		PrintWriter script = response.getWriter(); // 객체얻기
		script.println("<script>");
		script.println("location.href='main.jsp';");
		script.println("</script>");
	}else if(result ==0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다.')");
		script.println("history.back();");
		script.println("</script>");
	}else if(result ==-1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 아이디입니다')");
		script.println("history.back();");
		script.println("</script>");
	}else if(result ==-2){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터베이스 오류가 발생했습니다.')");
		script.println("history.back();");
		script.println("</script>");
	}
%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src = "js/bootstrap.js"></script>
</body>
</html>