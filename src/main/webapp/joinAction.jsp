<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter,user.UserDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />
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
	if(userID != null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인되어있습니다.')");
		script.println("location.href='main.jsp'");
		script.println("</script>");
	}
	if(user.getUserID()==null|user.getUserPassword()==null|user.getUserName()==null|user.getUserGender()==null|user.getUserEmail()==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력 안된 사항이 있습니다.')");
		script.println("history.back();");
		script.println("</script>");
	}else{
		UserDAO userDAO = new UserDAO();
		int result = userDAO.join(user);
		// 경우의수는 -1(데이터베이스 오류), 1(회원가입완료)가 있다.
		// 데이터베이스 오류가 난다는것은 쿼리문을 실행하다가 막혔다는 뜻인데, 이미 존재하는 아이디로 가입시 primary key 제약사항에 막혀 오류가 발생하게된다.
		
		if(result == 1){
			session.setAttribute("userID",user.getUserID()); 
			//▲ "userID"라는 이름의 세션을 설정하고 회원가입한 회원의 아이디를 값으로 지정한다 
			PrintWriter script = response.getWriter(); // 객체얻기
			script.println("<script>");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		}else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 존재하는 아이디입니다.')");
			script.println("history.back();");
			script.println("</script>");
		}
	}
%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src = "js/bootstrap.js"></script>
</body>
</html>