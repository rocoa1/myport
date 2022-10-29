<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
	#loginBox {
		margin: 120px auto 0 auto;
		max-width: 360px;
		width: 100%;
	}

	#loginBox > h3 {
		font-size: 36px;
		text-align: center;
	}
	
	#loginBox > form > input[type="text"], #loginBox > form > input[type="password"] {
		margin-bottom: 10px;
		padding: 20px;
		width: 100%;
		box-sizing: border-box;
	}
	
	#loginBox > form > input[type="submit"] {
		margin: 20px 0;
		padding: 20px;
		width: 100%;
		outline: none;
		cursor: pointer;
		box-sizing: border-box;
		color: #fff;
		background-color: #32405d;
	}
	
	#loginBox > form > a.right {
		margin-left: 10px;
		float: right;
	}
</style>
				<div id="loginBox">
					<h3>로그인</h3>
					<form action="login.do" method="POST" onsubmit="return submitCheck()">
						<input type="text" name="id" id="id" placeholder="아이디" maxlength="20"/>
						<input type="password" name="pw" id="pw" placeholder="비밀번호" maxlength="20"/>
						<input type="submit" id="login" value="로그인" />
						<a href="join.go">회원가입</a>
						<a href="pwFind.go" class="right">비밀번호 찾기</a>
						<a href="idFind.go" class="right">아이디 찾기</a>
					</form>
				</div>
	<script>
		function submitCheck() {
			
			var $id = $('#id');
			var $pw = $('#pw');
			
			var regExpId = /^[0-9a-zA-Z\_]{4,20}$/;	//아이디 정규식
			
			var regExpPw = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{4,20}$/;	//비밀번호 정규식
			
			var regExpEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;	//이메일 정규식
			
			if($.trim($id.val()) == '') {
				window.alert("아이디를 입력해 주세요.");
				$id.val('').focus();
				return false;
			}
			
			if(!regExpId.test($id.val())) {
				window.alert("아이디는 4~20자의 영문과 숫자, _ 조합만 가능합니다.");
				$id.val('').focus();
				return false;
			}
			
			if($.trim($pw.val()) == '') {
				window.alert("비밀번호를 입력해 주세요.");
				$pw.val('').focus();
				return false;
			}
			
			if(!regExpPw.test($pw.val())) {
				window.alert("비밀번호는 4~20자의 영문과 숫자, 특수문자를 포함해야 합니다. ");
				$pw.val('').focus();
				return false;
			}
			
			
			
			
		}
	
		var msg = "${msg}"
	    if (msg != "") {
	        alert(msg);
	    }
	</script>
</html>