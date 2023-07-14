<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>게시판 웹사이트</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

</head>
<body>
<%@ include file="nav.jsp" %>
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top:20px;">
				<form action="joinAction.jsp" method="post">
					<h3 style="text-align:center;">회원가입 화면</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20"/>
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20"/>
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="이름" name="userName" maxlength="20"/>
					</div>
					<div class="form-group" style="text-align:center;">
						<div class="btn-group" data-toggle="buttons">
							<label class="btn btn-primary active">
							<input type="radio" name="userGender" autocomplete="off" value="남자" checked/>남자
							</label>
							<label class="btn btn-primary">
							<input type="radio" name="userGender" autocomplete="off" value="여자" checked/>여자
							</label>
						</div>
					</div>
					<div class="form-group">
						<input type="email" class="form-control" placeholder="이메일" name="userEmail" maxlength="50"/>
					</div>
					<input type="submit" class="btn btn-primary form-control" value="회원가입" />
				</form>
			</div>
		</div>
		<div class="col-lg-4"></div>
	</div>
	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src = "js/bootstrap.js"></script>
<script type="text/javascript">
$(".dropdown-menu").children().last().addClass("active")
</script>
</body>
</html>