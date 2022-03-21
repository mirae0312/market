<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="마켓" name="title" />
</jsp:include>
<!-- join css -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/join/join.css" />
<div class="tit_page">
	<h2 class="tit">회원가입</h2>
</div>
<div id="main">
	<div id="content">
		<div class="page_aticle">
			<div class="type_form member_join ">
				<form id="join_form"
					action="${pageContext.request.contextPath}/join/join" method="POST">
					<p class="page_sub">
						<span class="ico">*</span>필수입력사항
					</p>
					<table class="tbl_comm">
						<tbody>
							<tr class="fst">
								<th>아이디<span class="ico">*<span class="screen_out">필수항목</span></span></th>
								<td><input type="text" name="id" id="id" value="jbomb99"
									maxlength="15" required="" fld_esssential="" option="regId"
									label="아이디" placeholder="6~10자 사이의 아이디를 입력해주세요.">
									<button type="button" class="white-btn id-btn">중복확인</button>
									<p class="txt_guide square" style="display: block;"></p>
									<input type="hidden" name="idVal" id="idVal" value="0" /> <br />
								</td>
							</tr>
							<tr>
								<th>비밀번호<span class="ico">*<span class="screen_out">필수항목</span></span></th>
								<td><input type="password" name="password" id="password"
									required="" fld_esssential="" option="regPass" label="비밀번호"
									maxlength="16" class="reg_pw" value="gmldus1234"
									placeholder="8~15자 사이의 비밀번호를 입력해주세요">
									<p class="txt_guide square">
										<span class="guide pwd-ok">이 비밀번호는 사용가능합니다.</span> <span
											class="guide pwd-error">비밀번호는 8자 이상 15자 이하여야 합니다.</span>
									</p></td>
							</tr>
							<tr class="member_pwd">
								<th>비밀번호확인<span class="ico">*<span
										class="screen_out">필수항목</span></span></th>
								<td><input type="password" name="password2" id="password2"
									required="" fld_esssential="" option="regPass" label="비밀번호"
									maxlength="16" class="confirm_pw" value="gmldus1234"
									placeholder="비밀번호를 한번 더 입력해주세요">
									<p class="txt_guide square">
										<span class="guide pwd2-error">비밀번호가 일치하지 않습니다.</span> <span
											class="guide pwd2-ok">비밀번호가 일치합니다.</span>
									</p></td>
							</tr>
							<tr>
								<th>이름<span class="ico">*<span class="screen_out">필수항목</span></span></th>
								<td><input type="text" name="name" value="희연" required=""
									fld_esssential="" label="이름" placeholder="이름을 입력해주세요">
								</td>
							</tr>
							<tr>
								<th>이메일<span class="ico">*<span class="screen_out">필수항목</span></span></th>
								<td><input type="text" name="email" id="email"
									value="sp5na92@gmail.com" size="30" option="regEmail"
									label="이메일" placeholder="예: marketkurly@kurly.com"> <input
									type="hidden" name="chk_email" label="이메일중복체크">
									<input type="hidden" name="emailVal" id="emailVal" value="0" />
									<button type="button" class="white-btn email-btn">중복확인</button>
								</td>
							</tr>
							<tr class="field_phone">
								<th>휴대폰<span class="ico">*<span class="screen_out">필수항목</span></span></th>
								<td>
									<div class="phone_num">
										<input type="text" value="01021443418" pattern="[0-9]*"
											name="phone" id="phone" placeholder="숫자만 입력해주세요">
										<input type="hidden" name="phoneVal" id="phoneVal" value="1" />
										<button type="button" class="white-btn phone-btn">인증번호
											받기</button>
									</div>
									<div id="codeNum" class="code_num">
										<input type="text" name="phone_code" id="phone_code" value=""
											size="6" maxlength="6" pattern="[0-9]*"
											placeholder="인증번호 숫자 6자리">
										<button id="phone_confirm_btn" class="btn default"
											type="button">재발송</button>
										<p id="countdown" class="count_down"></p>
									</div>
								</td>
							</tr>
							<tr>
								<th>주소<span class="ico">*<span class="screen_out">필수항목</span></span></th>
								<td class="field_address"><input type="text" id="postcode"
									placeholder="우편번호" value="06234"> <input type="button"
									id="addressNo" class="white-btn" onclick="findAddress()" value="주소검색"><br>
									<input type="text" id="address" placeholder="주소"
									value="서울 강남구 논현로85길 58"><br> <input type="text"
									id="detailAddress" placeholder="상세주소" value="5층"> <input
									type="hidden" name="addAddress" class="form-control addAddress"
									required /></td>
							</tr>
							<tr class="select_gender">
								<th>성별</th>
								<td><label class=""> <input type="radio"
										name="gender" value="m"> <span class="ico"></span>남자
								</label> <label class=""> <input type="radio" name="gender"
										value="w" checked> <span class="ico"></span>여자
								</label> <label class="checked"> <input type="radio"
										name="gender" value="n"> <span class="ico"></span>선택안함
								</label></td>
							</tr>
							<tr class="birth field_birth">
								<th>생년월일</th>
								<td>
									<div class="birth_day">
										<input type="text" name="birth_year" id="birth_year"
											pattern="[0-9]*" value="" label="생년월일" size="4" maxlength="4"
											placeholder="YYYY"> <span class="bar"></span> <input
											type="text" name="birth_month" id="birth_month"
											pattern="[0-9]*" value="" label="생년월일" size="2" maxlength="2"
											placeholder="MM"> <span class="bar"></span> <input
											type="text" name="birth_day" id="birth_day" pattern="[0-9]*"
											value="" label="생년월일" size="2" maxlength="2" placeholder="DD">
										<input type="hidden" name="addBirth"
											class="form-control addBirth" required />
									</div>
									<p class="txt_guide">
										<span class="txt bad"></span>
									</p>
								</td>
							</tr>
							<tr class="route" id="selectRecommend">
								<th>추가입력 사항</th>
								<td>
									<div class="group_radio">
										<span class="radio_wrapper"> <label for="recommendId">
												<input type="radio" name="recommend" id="recommendId"
												label="추천인아이디"> <span class="ico"></span>추천인 아이디
										</label>
										</span>
									</div>
									<div class="input_wrapper">
										<input type="text" name="recommid" value="" class="inp"
											placeholder="추천인 아이디를 입력해주세요.">
										<p class="txt_guide">
											<br> 가입 이후, 수정이 불가합니다. <br> 대소문자 및 띄어쓰기에 유의해주세요.
										</p>
									</div>
								</td>
							</tr>
							<tr class="reg_agree">
								<th>이용약관동의 <span class="ico">*<span
										class="screen_out">필수항목</span></span></th>
								<td>
									<div class="bg_dim"></div>
									<div class="check">
										<label class="check_agree label_all_check label_block">
											<input type="checkbox" name="selectAll"
											onclick='selectAll(this)'> <span class="ico"></span>전체
											동의합니다.
										</label>
										<p class="sub">선택항목에 동의하지 않은 경우도 회원가입 및 일반적인 서비스를 이용할 수
											있습니다.</p>
									</div>
									<div class="check_view">
										<label class="check_agree label_block"> <input
											type="checkbox" value="" name="agree_ck" required=""
											label="이용약관"> <span class="ico"></span>이용약관 동의 <span
											class="sub">(필수)</span>
										</label> <a onclick="open_modal();"
											class="link btn_link btn_agreement">약관보기 </a>
									</div> <!-- The Modal -->
									<div id="modal_1" class="modal">
										<div class="modal-content">
											<div class="modal-header">
												<span class="close">&times;</span>
												<h4>개인정보 수집 이용 동의</h4>
											</div>
											<div class="modal-body">
												<p>Lorem ipsum dolor sit amet, consectetur adipisicing
													elit. Ab quod alias at perspiciatis consequatur cupiditate
													non veniam illo voluptatum ratione ex dolor inventore
													voluptas odit consequuntur a commodi quos sequi.</p>

											</div>
											<div class="modal-footer">
												<h3>확인</h3>
											</div>
										</div>
									</div>


									<div class="check_view">
										<label class="check_agree label_block"> <input
											type="checkbox" id="private1" name="agree_ck"" value=""
											required="" label="개인정보 수집·이용"> <span class="ico"></span>개인정보
											수집·이용 동의 <span class="sub">(필수)</span>
										</label> <a href="#none" class="link btn_link btn_essential">약관보기
										</a>
									</div>

									<div class="check_view">
										<input type="hidden" id="consentHidden" name="consent[1]"
											value=""> <label class=" check_agree label_block">
											<input type="checkbox" name="agree_ck"> <span
											class="ico"></span>개인정보 수집·이용 동의 <span class="sub">(선택)</span>
										</label> <a href="#none" class="link btn_link btn_choice">약관보기 </a>
									</div>
									<div class="check_view">
										<label class=" check_agree label_block"> <input
											type="checkbox" value="n" name="agree_ck" required=""
											label="만 14세 이상"> <span class="ico"></span>본인은 만 14세
											이상입니다. <span class="sub">(필수)</span>
										</label>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" /> <input type="hidden" name="loginType"
						value="D" />
					<div id="formSubmit" class="form_footer">
						<button type="submit" class="btn active" id="join_btn">가입하기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<script>
	//유효성 검사
	$("#join_btn").click((e) => {
		const $id = $("#id").val();
		const $idVal = $("#idVal").val();

		const $password = $(password);
		const $passwordCheck = $(password2);
		
		const $emailVal = $("#emailVal").val();
		const $phoneVal = $("#phoneVal").val();
		
		var idReg = /^[a-zA-z0-9]{4,12}$/;
		 if (!idReg.test($id)) {
	        alert("아이디는 영문 대소문자와 숫자 4~12자리로 입력해주세요.");
	        $(id).focus();
	        return false;
	    }

		// 아이디
		if($idVal == '0'){
			alert("아이디를 중복확인해주세요.");
			$(id).focus();
			return false;
		}
		
		// 이메일
		if($emailVal == '0'){
			alert("이메일을 중복확인해주세요.");
			$(email).focus();
			return false;
		}
		
		// 핸드폰 번호
		if($phoneVal == '0'){
			alert("휴대폰번호를 인증해주세요.");
			$(phone).focus();
			return false;
		}
		
		// 비밀번호	
		if(! /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,15}$/.test($password.val())){
	        alert("비밀번호는 숫자와 영문이 포함된 8~15자리입니다");
			$password.focus();
			return false;
	    }
		
		// 비밀번호 일치 확인
		if($password.val() != $passwordCheck.val()){
	    	alert("비밀번호가 일치하지 않습니다.");
			$passwordCheck.focus();
			return false;
		}
		
		alert("회원가입 성공!")
		return true;
	});
	

	$(".id-btn").click((e) => {
		const type = "id";
		const id = $("#id").val();
		var idReg = /^[a-zA-z0-9]{4,12}$/;
		
		$.ajax({
			url: "${pageContext.request.contextPath}/join/checkDuplicate",
			data:{
				type: type,
				id: id
			},
			success(resp){
				console.log(resp);
				const {available} = resp;
				
				if (!idReg.test(id)) {
			        alert("아이디는 영문 대소문자와 숫자 4~12자리로 입력해주세요.");
			    }
				else{
					if(available){
						alert("이 아이디는 사용가능합니다.");
						$("#idVal").val(1);
					}
					else{
						alert("이미 존재하는 아이디입니다.");
					}
				}
				
			},
			error: console.log
		});
	});
	
	$(".email-btn").click((e) => {
		const type = "email";
		const email = $("#email").val();
		
		$.ajax({
			url: "${pageContext.request.contextPath}/join/checkDuplicate",
			data:{
				type: type,
				email: email
			},
			success(resp){
				console.log(resp);
				const {available} = resp;
				
				if(available){
					alert("사용가능한 이메일입니다.");
					$("#emailVal").val(1);
				}
				else{
					alert("이미 가입한 이메일입니다.");
				}
			},
			error: console.log
		});
	});
	
	$(".phone-btn").click((e) => {
		const type = "phone";
		const phone = $("#phone").val();
		const $phoneCheck = $(".code_num");
		
		//인증번호 타이머
		var count_down = $(".count_down");
		var timer = null;
		var isRunning = false;
		
		$.ajax({
			url: "${pageContext.request.contextPath}/join/checkPhone",
			data:{
				type: type,
				phone: phone
			},
			success(resp){
				console.log(resp);
				const {available} = resp;
				const {num} = resp;
				
				if(available){
					alert("인증번호가 발송되었습니다.");
					$phoneCheck.show();
					  // 유효시간 설정
					 var leftSec = 180;

					  // 버튼 클릭 시 시간 연장
					  if (isRunning){ 
					    clearInterval(timer);
					    count_down.html("");
					    startTimer(leftSec, count_down);
					  }else{
					  	startTimer(leftSec, count_down);
					  }
					  
					$("#phone_confirm_btn").click((e) =>{
						
						const phone_code = $("#phone_code").val();
						console.log(phone_code);
						if(num == phone_code){
							alert("핸드폰 인증에 성공하였습니다.");
							clearInterval(timer);
						    count_down.html("");
							$("#phoneVal").val(1);
							console.log($("#phoneVal").val());
						}
						else{
							alert("인증번호 6자리를 정확히 입력해주세요.");
						}
					})
					
				}
				else{
					alert("이미 가입한 전화번호입니다.");
				}
			},
			error: console.log 
		});
		
		function startTimer(count, display) {  
			  var minutes, seconds;
			  timer = setInterval(function () {
			    minutes = parseInt(count / 60, 10);
			    seconds = parseInt(count % 60, 10);

			    minutes = minutes < 10 ? "0" + minutes : minutes;
			    seconds = seconds < 10 ? "0" + seconds : seconds;

			    count_down.html(minutes + ":" + seconds);

			    // 타이머 끝
			    if (--count < 0) {
			      clearInterval(timer);
			      alert("인증시간이 만료되었습니다.");
			      count_down.html("인증시간 만료");
			      $(".phone_confirm_btn").attr("disabled", true);
			      isRunning = false;
			    }
			  }, 1000);
			  isRunning = true;
		}
	});
	
	
</script>
<script>

	function selectAll(selectAll)  {
		  const checkboxes 
		     = document.querySelectorAll('input[type="checkbox"]');
		  
		  checkboxes.forEach((checkbox) => {
		    checkbox.checked = selectAll.checked
		  })
	}
</script>
<script>
	
	//Get the modal
	var modal = document.getElementById("modal_1");
	
	//Get the <span> element that closes the modal
	var span = document.getElementsByClassName("close")[0];
	
	//When the user clicks the button, open the modal 
	function open_modal(){
		modal.style.display = "block";
	}
	//When the user clicks on <span> (x), close the modal
	span.onclick = function() {
		modal.style.display = "none";
	}
	
	//When the user clicks anywhere outside of the modal, close it
	window.onclick = function(event) {
		if (event.target == modal) {
		 modal.style.display = "none";
		}
	}
</script>
<script>
	//생일, 주소 합치기
	$("#birth_day").blur((e) => {
		$(".addBirth").val($("#birth_year").val() + '/' + $("#birth_month").val() + '/' + $("#birth_day").val());
		console.log($(".addBirth").val());
	})
	$(detailAddress).blur((e) => {
		$(".addAddress").val($(address).val() + ' ' + $(detailAddress).val());
		console.log($(".addAddress").val());
	});
</script>

<!-- 다움 주소검색 API -->
<script src="https://kit.fontawesome.com/4123702f4b.js"
	crossorigin="anonymous"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function popup(){
	    var url = '${pageContext.request.contextPath}/product/cart/findAddress';
	    var name = "popup test";
	    var option = "width = 500, height = 500, top = 100, left = 200, location = no"
	    window.open(url, name, option);
	}
    function findAddress() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
            }
        }).open();
    }
</script>
<script>
function noEvent() {
    if (event.keyCode == 116) {
        event.keyCode= 2;
        return false;
    }
    else if(event.ctrlKey && (event.keyCode==78 || event.keyCode == 82))
    {
        return false;
    }
}
document.onkeydown = noEvent;

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />