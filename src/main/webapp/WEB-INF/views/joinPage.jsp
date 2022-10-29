<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<style>
	#joinBox {
		
	}

	#joinBox > h3 {
		font-size: 36px;
		text-align: center;
	}
	
	#joinBox > form > table {
		border: 1px solid #787878;
		
	}
	
	#joinBox > form > table > tbody > tr > th {
		padding: 10px;
		border: 1px solid #787878;
		background-color: #f9f9f9;
	}
	
	#joinBox > form > table > tbody > tr > td {
		padding: 10px;
		border: 1px solid #787878;
	}
	
	#joinBox > form > table > tfoot > tr > td {
		padding: 10px;
		text-align: center;
	}
</style>
				<div id="joinBox">
					<h3>회원 가입</h3>
					<form action="join.do" method="POST" onsubmit="return submitCheck()">
						<table>
							<colgroup>
								<col width="180"></col>
								<col width="*"></col>
							</colgroup>
							<tbody>
								<tr>
									<th>아이디</th>
									<td>
										<input type="text" name ="mb_id" id= "id" maxlength="20" />
										<input type="button" value="아이디 중복 확인" class="btn btnChk" onclick="doubleCheckId()" />
										<input type="hidden" id="doublecheckid" />
										<!-- 아이디 중복 확인은 ajax 명령으로 -->
									</td>
								</tr>
								<tr>
									<th>비밀번호</th>
									<td>
										<input type="password"  name = "mb_pw" id="password" maxlength="20"/>
									</td>
								</tr>
								<tr>
									<th>비밀번호 확인</th>
									<td>
										<input type="password"  name = "passwordcheck" id = "passwordcheck" maxlength="20"/>
									</td>
								</tr>
								<tr>
									<th>이메일</th>
									<td>
										<input type="text"  name = "mb_email" id="email" maxlength="20"/>
										<input type="button" value="이메일 중복 확인" class="btn btnChk" onclick="doubleCheckEmail()" />
										<input type="hidden" id="doublecheckemail" />
										<!-- 이메일 중복 확인은 ajax 명령으로 -->
									</td>
								</tr>
								<tr>
									<th>이름</th>
									<td>
										<input type="text"  name = "mb_name" id= "name" maxlength="20"/>
									</td>
								</tr>
								<tr>
									<th>성별</th>
									<td>
										<label><input type="radio" value="남" name = "mb_gender" /> 남 </label>
										<label><input type="radio" value="여" name = "mb_gender" /> 여 </label>
									</td>
								</tr>   
								<tr>
									<th>주소</th>
									<td>
										<input type="text" id="sample6_postcode" name="mb_postcode" placeholder="우편번호" style="width: 30%;" readonly>
										<input type="button" onclick="sample6_execDaumPostcode()" class="btn btnPostCode" value="우편번호 찾기"><br>
										<input type="text" id="sample6_address" name="mb_addr_default" style="width: 99%;" placeholder="주소" readonly><br>
										<input type="text" id="sample6_detailAddress" name="mb_addr_detail" style="width: 99%;" placeholder="상세주소">
										
										<!-- 값을 받아와야되기때문에 hidden 으로 처리 -->
										<input type="hidden" id="sample6_extraAddress" name="sample6_extraAddress" placeholder="참고항목">
										
										<input type="hidden" id="sample6_sido" name="mb_sido" > <!-- 시/도 -->
										<input type="hidden" id="sample6_sigungu" name="mb_sigungu" > <!-- 시/군/구 -->
									</td>
								</tr>
							</tbody>
							<tfoot>
								<tr>
									<td colspan="2">
										<input type="submit" class="btn btnSubmit" value="회원가입" /> <!--  -->
										<input type="button" class="btn btnList" value="취소" onclick="location.href='login.go'" />
									</td>
								</tr>
							</tfoot>
						</table>
					</form>
				</div>

<script>

	//다음 우편번호 관련 함수
	function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                // console.log(data.zonecode);
                document.getElementById("sample6_address").value = addr;
                // console.log(addr);
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
                
              
                console.log(data.sido);  // 시/도 (서울, 경기, 경북 등으로 표시)
                document.getElementById('sample6_sido').value = data.sido;
               
              
                //console.log(data.sigungu); // 시/군/구 (서초구, 광명시 , 곡성군 등으로 표시)
                document.getElementById('sample6_sigungu').value = data.sigungu;
                
                if(data.sido == "세종특별자치시") {
    				document.getElementById('sample6_sigungu').value = "세종시";
    			}
                
                console.log(data.sigungu); // 시/군/구 (서초구, 광명시 , 곡성군 등으로 표시)
                
                
            }
        }).open();
    }
	
	var checkId = false; // 아이디 중복체크 여부
	function doubleCheckId() {
		checkId = false;
		
		var regExpId = /^[0-9a-zA-Z\_]{4,20}$/;	//아이디 정규식
		
		var $id = $("#id");
		//console.log($("#id").val());
		
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
		 
		 console.log('아이디 중복 체크 : '+$id.val());		
			$.ajax({
				type:'get',
				url:'doubleCheckId.ajax',
				data:{chkId:$id.val()},
				dataType:'JSON',
				success:function(data){
					// console.log(data);
				 if(data.doubleId){
						alert("이미 사용중인 아이디 입니다.");
						$id.val('').focus();
					}else{
						alert("사용 가능한 아이디 입니다.");
						checkId = true;
						document.getElementById('doublecheckid').value = $id.val();
					}
					 
				},
				error:function(e){
					console.log(e);
				}			
			});
		
	}
	
	
		
	var checkEmail = false; // 이메일 중복체크 여부
	function doubleCheckEmail() {
		checkEmail = false;
		
		var $email = $("#email");
		
		var regExpEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;	//이메일 정규식
		
		if($.trim($email.val()) == '') {
			window.alert("이메일을 입력해 주세요.");
			$email.val('').focus();
			return false;
		}
		 
		if(!regExpEmail.test($email.val())) {
			window.alert("이메일 형식에 맞게 입력해 주세요. ");
			$email.val('').focus();
			return false;
		}
		 
		 console.log('이메일 중복 체크 : '+$email.val());		
			$.ajax({
				type:'get',
				url:'doubleCheckEmail.ajax',
				data:{chkEmail:$email.val()},
				dataType:'JSON',
				success:function(data){
					// console.log(data);
				 if(data.doubleEmail){
						alert("이미 사용중인 이메일 입니다.");
						$email.val('').focus();
					}else{
						alert("사용 가능한 이메일 입니다.");
						checkEmail = true;
						document.getElementById('doublecheckemail').value = $email.val();
					}
					 
				},
				error:function(e){
					console.log(e);
				}			
			});
		
	}
	
	
		function submitCheck() {  //회원가입 하기전 체크
			
			var regExpId = /^[0-9a-zA-Z\_]{4,20}$/;	//아이디 정규식
			
			var regExpPw = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{4,20}$/;	//비밀번호 정규식
			
			var regExpEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;	//이메일 정규식
			
			var $id = $('#id');	// 아이디
			
			var $pw = $('#password'); //비밀번호
			
			var $pwchk = $('#passwordcheck'); //비밀번호 확인
			
			var $email = $('#email'); //이메일
					
			var $name = $('#name'); //이름
			
			var $gender = $('input[name=mb_gender]:checked'); //성별
			
			
			var $postcode = $('input[name=mb_postcode]'); //우편번호
			
			var $addr = $('input[name=mb_addr_default]'); //주소
			
			var $detailaddr = $('input[name=mb_addr_detail]'); //상세주소
			
			var $sido = $("#sample6_sido"); // 시/도 (서울, 경기, 경북 등으로 표시)
			
			var $sigungu = $("#sample6_sigungu"); // 시/군/구 (서초구, 광명시 , 곡성군 등으로 표시)
			
			var $doublenickid = $("#doublecheckid");
			
			var $doublenickemail = $("#doublecheckemail");
			
			var $doublenickname = $("#doublecheckname");
			
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
			
			if(checkId == false) {
				window.alert("아이디 중복확인을 진행해 주세요.");
				return  false;
			 }
			
			if($doublenickid.val() != $id.val()) {
				window.alert("아이디 중복확인을 진행해 주세요.");
				checkId = false;
				// console.log(checkId);
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
			
			if($.trim($pwchk.val()) == '') {
				window.alert("비밀번호 확인을 입력해 주세요.");
				$pwchk.val('').focus();
				return false;
			}
			
			
			if(!regExpPw.test($pwchk.val())) {
				window.alert("비밀번호는 4~20자의 영문과 숫자, 특수문자를 포함해야 합니다. ");
				$pwchk.val('').focus();
				return false;
			}
			
			if($pw.val() != $pwchk.val()) {
				window.alert("비밀번호와 비밀번호 확인이 일치하지 않습니다. ");
				$pwchk.val('').focus();
				return false;
			}
			
			if($.trim($email.val()) == '') {
				window.alert("이메일을 입력해 주세요.");
				$email.val('').focus();
				return false;
			}
			
			if(!regExpEmail.test($email.val())) {
				window.alert("이메일 형식에 맞게 입력해 주세요. ");
				$email.val('').focus();
				return false;
			}
			
			if(checkEmail == false) {
				window.alert("이메일 중복확인을 진행해 주세요.");
				return  false;
			 }
			
			if($doublenickemail.val() != $email.val()) {
				window.alert("이메일 중복확인을 진행해 주세요.");
				checkEmail = false;
				return false;
			}
			
		
			if($.trim($name.val()) == '') {
				window.alert("이름을 입력해 주세요.");
				$name.val('').focus();
				return false;
			}
			
			if($gender.val() == null) {
				window.alert("성별을 체크해 주세요.");
				return false;
			}
			
			
			if($postcode.val() == "" || $postcode.val() == null) {
				window.alert("우편번호 찾기를 진행해 주세요.");
				return false;
			}
			
			if($addr.val() == "" || $addr.val() == null) {
				window.alert("우편번호 찾기를 진행해 주세요.");
				return false;
			}
			
			if($.trim($detailaddr.val()) == '') {
				window.alert("상세주소를 입력해 주세요.");
				$detailaddr.val('').focus();
				return false;
			}
			
			
}


	
	var msg = "${msg}";
	if(msg != "") {
	alert(msg);
	}

</script>
</html>