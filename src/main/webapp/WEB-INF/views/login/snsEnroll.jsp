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
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/login/snsEnroll.css" />
<div class="tit_page">
	<h2 class="tit">${userInfo.type}회원가입</h2>
</div>
<div id="main">
	<div id="content">
		<div class="page_aticle">
			<div class="type_form member_join ">
				<form id="joinFrm"
					action="${pageContext.request.contextPath}/join/join" method="POST">
					<p class="page_sub">
						<span class="ico">*</span>필수입력사항
					</p>
					<table class="tbl_comm">
						<tbody>
							<c:if test="${userInfo.type eq 'naver' || 'google'}">
								<tr>
									<th>이름<span class="ico">*<span class="screen_out">필수항목</span></span></th>
									<td><input type="text" name="name"
										value="${userInfo.name}" required="" fld_esssential=""
										label="이름" readonly placeholder="이름을 입력해주세요"></td>
								</tr>
							</c:if>
							<tr>
								<th>이름<span class="ico">*<span class="screen_out">필수항목</span></span></th>
								<td><input type="text" name="name" value="희연" required=""
									fld_esssential="" label="이름" placeholder="이름을 입력해주세요">
								</td>
							</tr>
							<c:if test="${userInfo.type eq 'naver' || 'google'}">
								<tr>
									<th>이메일<span class="ico">*<span class="screen_out">필수항목</span></span></th>
									<td><input type="text" name="email" id="email"
										value="${userInfo.email}" size="30" option="regEmail"
										label="이메일" readonly> <input type="hidden"
										name="chk_email" label="이메일중복체크">
										<button type="button" class="white-btn email-btn">중복확인</button>
									</td>
								</tr>
							</c:if>
							<tr>
								<th>이메일<span class="ico">*<span class="screen_out">필수항목</span></span></th>
								<td><input type="text" name="email" id="email"
									value="sp5na92@gmail.com" size="30" option="regEmail"
									label="이메일" placeholder="예: marketkurly@kurly.com"> <input
									type="hidden" name="chk_email" label="이메일중복체크">
									<button type="button" class="white-btn email-btn">중복확인</button>
								</td>
							</tr>
							<c:if test="${userInfo.type eq 'naver'}">
								<tr class="field_phone">
									<th>휴대폰<span class="ico">*<span class="screen_out">필수항목</span></span></th>
									<td>
										<div class="phone_num">
											<input type="text" value="${userInfo.phone}" name="phone"
												id="phone" readonly />
										</div>
									</td>
								</tr>
							</c:if>
							<tr class="field_phone">
								<th>휴대폰<span class="ico">*<span class="screen_out">필수항목</span></span></th>
								<td>
									<div class="phone_num">
										<input type="text" value="01021443418" pattern="[0-9]*"
											name="phone" id="phone" placeholder="숫자만 입력해주세요">
										<button type="button" class="white-btn phone-btn">인증번호
											받기</button>
									</div>
									<div id="codeNum" class="code_num">
										<input type="text" name="phone_code" id="phone_code" value=""
											size="6" maxlength="6" pattern="[0-9]*"
											placeholder="인증번호 숫자 6자리">
										<button id="phone_confirm_btn" class="btn default"
											type="button">인증번호 확인</button>
										<p id="countdown" class="count_down"></p>
									</div>
								</td>
							</tr>
							<tr>
								<th>주소<span class="ico">*<span class="screen_out">필수항목</span></span></th>
								<td class="field_address"><input type="text" id="postcode"
									placeholder="우편번호" value="06234"> <input type="button"
									id="addressNo" class="white-btn" onclick="findAddress()"
									value="주소검색"><br> <input type="text" id="address"
									placeholder="주소" value="서울 강남구 논현로85길 58"><br> <input
									type="text" id="detailAddress" placeholder="상세주소" value="5층">
									<input type="hidden" name="addAddress"
									class="form-control addAddress" required /></td>
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
											type="text" name="birth[]" id="birth_month" pattern="[0-9]*"
											value="" label="생년월일" size="2" maxlength="2" placeholder="MM">
										<span class="bar"></span> <input type="text" name="birth[]"
											id="birth_day" pattern="[0-9]*" value="" label="생년월일"
											size="2" maxlength="2" placeholder="DD">
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
											<input type="checkbox" name="agree_allcheck"
											onclick='selectAll(this)'> <span class="ico"></span>전체
											동의합니다.
										</label>
										<p class="sub">선택항목에 동의하지 않은 경우도 회원가입 및 일반적인 서비스를 이용할 수
											있습니다.</p>
									</div>
									<div class="check_view">
										<label class="check_agree label_block"> <input
											type="checkbox" value="" name="agree" required=""
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
											type="checkbox" id="private1" name="private1" value=""
											required="" label="개인정보 수집·이용"> <span class="ico"></span>개인정보
											수집·이용 동의 <span class="sub">(필수)</span>
										</label> <a href="#none" class="link btn_link btn_essential">약관보기
										</a>
									</div>

									<div class="check_view">
										<input type="hidden" id="consentHidden" name="consent[1]"
											value=""> <label class=" check_agree label_block">
											<input type="checkbox" name="hiddenCheck"> <span
											class="ico"></span>개인정보 수집·이용 동의 <span class="sub">(선택)</span>
										</label> <a href="#none" class="link btn_link btn_choice">약관보기 </a>
									</div>
									<div class="check_view">
										<label class=" check_agree label_block"> <input
											type="checkbox" value="n" name="fourteen_chk" required=""
											label="만 14세 이상"> <span class="ico"></span>본인은 만 14세
											이상입니다. <span class="sub">(필수)</span>
										</label>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
					<c:if test="${userInfo.type eq 'kakao'}">
						<input type="hidden" name="id" value="${userInfo.id}" />
						<input type="hidden" name="password" value="${userInfo.password}" />
						<input type="hidden" name="loginType" value="K" />
					</c:if>
					<c:if test="${userInfo.type eq 'naver'}">
						<input type="hidden" name="id" value="${userInfo.id}" />
						<input type="hidden" name="password" value="${userInfo.password}" />
						<input type="hidden" name="loginType" value="N" />
					</c:if>
					<c:if test="${userInfo.type eq 'google'}">
						<input type="hidden" name="id" value="${userInfo.id}" />
						<input type="hidden" name="password" value="${userInfo.password}" />
						<input type="hidden" name="loginType" value="G" />
					</c:if>
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />
					<div id="formSubmit" class="form_footer">
						<button type="submit" class="btn active" id="join_btn">가입하기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
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
	$(detailAddress).blur((e) => {
		$(".addAddress").val($(address).val() + ' ' + $(detailAddress).val());
		console.log($(".addAddress").val());
	});
</script>
<script src="https://kit.fontawesome.com/4123702f4b.js"
	crossorigin="anonymous"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function findAddress() {
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
                    document.getElementById("extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("extraAddress").value = '';
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

<jsp:include page="/WEB-INF/views/common/footer.jsp" />