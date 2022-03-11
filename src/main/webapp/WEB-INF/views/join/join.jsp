<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="마켓" name="title"/>
</jsp:include>
<!-- join css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/join/join.css" /> 
 <style>
/* The Modal (background) */
.modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 3; /* Sit on top */
  padding-top: 250px;
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0,0,0); /* Fallback color */
  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content */
.modal-content {
border-radius: 12px;
    width: 440px;
  background-color: #fefefe;
  margin: auto;
  padding: 20px;
  border: 1px solid #888;
}

/* The Close Button */
.close {
  color: #aaaaaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: #000;
  text-decoration: none;
  cursor: pointer;
}
.btn_agreement{
	cursor: pointer;
}
.modal-header{
    padding: 25px 25px 8px 30px;
    font-weight: 700;
    font-size: 24px;
    line-height: 40px;
    color: #333;
    letter-spacing: -1px;
}
.guide{
	display: none;
	padding-top: 10px;
}
.ok{
	color: #0f851a;
}
.ok:before{
    content: '\2713';
    display: inline-block;
    padding: 0 4px 0 2px;
    font-size: 12px;
    vertical-align: 0;
}
.error, .limit{
	color: #b3130b;
}
.error:before, .limit:before{
    content: '\2715';
    display: inline-block;
    padding-right: 3px;
    font-size: 12px;
    vertical-align: 0;
}

/*타이머*/
.member_join .field_phone .code_num .count_down {
    position: absolute;
    left: 216px;
    top: 21px;
    width: 100px;
    font-size: 14px;
    color: #b3130b;
    line-height: 20px;
    text-align: right;
    letter-spacing: -.5px;
}

.member_join .field_phone .code_num {
    position: relative;
    padding-top: 10px;
}
.code_num{
	display:none;
}
 </style>
 
<body>
    <div class="tit_page">
        <h2 class="tit">회원가입</h2>
    </div>
    <div id="main">
        <div id="content">
            <div class="page_aticle">
                <div class="type_form member_join ">
                    <form id="join_form">
                        <p class="page_sub"><span class="ico">*</span>필수입력사항</p>
                        <table class="tbl_comm">
                            <tbody>
                                <tr class="fst">
                                    <th>아이디<span class="ico">*<span class="screen_out">필수항목</span></span></th>
                                    <td>
                                        <input type="text" name="id" id="id" value="jbomb99" maxlength="15" required=""
                                            fld_esssential="" option="regId" label="아이디"
                                            placeholder="6~10자 사이의 아이디를 입력해주세요.">
                                        <button type="button" class="white-btn id-btn">중복확인</button>
                                        <p class="txt_guide square" style="display: block;">
                                            <p class="text-success guide ok" >이 아이디는 사용가능합니다.</p>
											<p class="text-danger guide error" >이미 존재하는 아이디입니다.</p>
											<p class="text-danger guide limit">아이디는 6자 이상 10자 이하여야 합니다.</p>
											<input type="hidden" name="idVal"id="idVal" value="0" />
                                            <br />
                                        </p>
                                    </td>
                                </tr>
                                <tr>
                                    <th>비밀번호<span class="ico">*<span class="screen_out">필수항목</span></span></th>
                                    <td>
                                        <input type="password" name="password" id="password" required="" fld_esssential="" 
                                            option="regPass" label="비밀번호" maxlength="16" class="reg_pw" value="gmldus1234"
                                            placeholder="8~15자 사이의 비밀번호를 입력해주세요">
                                        <p class="txt_guide square">
                                            <span class="guide pwd-ok">이 비밀번호는 사용가능합니다.</span>
                                            <span class="guide pwd-error">비밀번호는 8자 이상 15자 이하여야 합니다.</span>
                                        </p>
                                    </td>
                                </tr>
                                <tr class="member_pwd">
                                    <th>비밀번호확인<span class="ico">*<span class="screen_out">필수항목</span></span></th>
                                    <td>
                                        <input type="password" name="password2" id="password2" required="" fld_esssential=""
                                            option="regPass" label="비밀번호" maxlength="16" class="confirm_pw" value="gmldus1234"
                                            placeholder="비밀번호를 한번 더 입력해주세요"> 
                                        <p class="txt_guide square">
                                            <span class="guide pwd2-error">비밀번호가 일치하지 않습니다.</span>
                                            <span class="guide pwd2-ok">비밀번호가 일치합니다.</span>
                                        </p>
                                    </td>
                                </tr>
                                <tr>
                                    <th>이름<span class="ico">*<span class="screen_out">필수항목</span></span></th>
                                    <td>
                                        <input type="text" name="name" value="희연" required="" fld_esssential="" label="이름"
                                            placeholder="이름을 입력해주세요">
                                    </td>
                                </tr>
                                <tr>
                                    <th>이메일<span class="ico">*<span class="screen_out">필수항목</span></span></th>
                                    <td>
                                        <input type="text" name="email" id="email" value="sp5na92@gmail.com"  size="30"  option="regEmail" label="이메일"
                                            placeholder="예: marketkurly@kurly.com">
                                        <input type="hidden" name="chk_email"
                                            label="이메일중복체크" >
                                            <button type="button" class="white-btn email-btn">중복확인</button>
                                    </td>
                                </tr>
                                <tr class="field_phone">
                                    <th>휴대폰<span class="ico">*<span class="screen_out">필수항목</span></span></th>
                                    <td>
                                        <div class="phone_num">
                                            <input type="text" value="01012341234" pattern="[0-9]*" name="phone" id="phone"
                                                placeholder="숫자만 입력해주세요" >
                                            <button type="button" class="white-btn phone-btn">인증번호 받기</button>
                                        </div>
                                        <div id="codeNum" class="code_num" >
											<input type="text" name="auth_code" id="auth_code" value="" size="6" maxlength="6" pattern="[0-9]*" label="인증번호 확인" class="inp_confirm" >
											<button id="btn_cert_confirm" class="btn default" type="button">인증번호 확인</button>
											<p id="countdown" class="count_down">3 : 00</p>
										</div>
                                    </td>
                                </tr>
                                <tr>
                                    <th>주소<span class="ico">*<span class="screen_out">필수항목</span></span></th>
                                    <td class="field_address">
                                        <input type="text" id="postcode" placeholder="우편번호" value="06234">
                                        <input type="button" id="addressNo" class="white-btn" onclick="findAddress()" value="주소검색"><br>
										<input type="text" id="address" placeholder="주소" value="서울 강남구 논현로85길 58"><br>
										<input type="text" id="detailAddress" placeholder="상세주소" value="5층">
										<input type="hidden" name="addAddress" class="form-control addAddress" required />
										
                                    </td>
                                </tr>
                                <tr class="select_gender">
                                    <th>성별</th>
                                    <td>
                                        <label class="">
                                            <input type="radio" name="gender" value="m">
                                            <span class="ico"></span>남자
                                        </label>
                                        <label class="">
                                            <input type="radio" name="gender" value="w" checked>
                                            <span class="ico"></span>여자
                                        </label>
                                        <label class="checked">
                                            <input type="radio" name="gender" value="n" >
                                            <span class="ico"></span>선택안함
                                        </label>
                                    </td>
                                </tr>
                                <tr class="birth field_birth">
                                    <th>생년월일</th>
                                    <td>
                                        <div class="birth_day">
                                            <input type="text" name="birth_year" id="birth_year" pattern="[0-9]*"
                                                value="" label="생년월일" size="4" maxlength="4" placeholder="YYYY">
                                            <span class="bar"></span>
                                            <input type="text" name="birth[]" id="birth_month" pattern="[0-9]*" value=""
                                                label="생년월일" size="2" maxlength="2" placeholder="MM">
                                            <span class="bar"></span>
                                            <input type="text" name="birth[]" id="birth_day" pattern="[0-9]*" value=""
                                                label="생년월일" size="2" maxlength="2" placeholder="DD">
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
                                            <span class="radio_wrapper">
                                                <label for="recommendId">
                                                    <input type="radio" name="recommend" id="recommendId"
                                                        label="추천인아이디">
                                                    <span class="ico"></span>추천인 아이디
                                                </label>
                                            </span>
                                        </div>
                                        <div class="input_wrapper">
                                            <input type="text" name="recommid" value="" class="inp"
                                                placeholder="추천인 아이디를 입력해주세요.">
                                            <p class="txt_guide">
                                                <br>
                                                가입 이후, 수정이 불가합니다.
                                                <br>
                                                대소문자 및 띄어쓰기에 유의해주세요.
                                            </p>
                                        </div>
                                    </td>
                                </tr>
                                <tr class="reg_agree">
                                    <th>이용약관동의 <span class="ico">*<span class="screen_out">필수항목</span></span></th>
                                    <td>
                                        <div class="bg_dim"></div>
                                        <div class="check">
                                            <label class="check_agree label_all_check label_block">
                                                <input type="checkbox" name="agree_allcheck" onclick='selectAll(this)'>
                                                <span class="ico"></span>전체 동의합니다.
                                            </label>
                                            <p class="sub">선택항목에 동의하지 않은 경우도 회원가입 및 일반적인 서비스를 이용할 수 있습니다.</p>
                                        </div>
                                        <div class="check_view">
                                            <label class="check_agree label_block">
                                                <input type="checkbox" value="" name="agree" required="" label="이용약관">
                                                <span class="ico"></span>이용약관 동의 <span class="sub">(필수)</span>
                                            </label>
                                            <a onclick="open_modal();" class="link btn_link btn_agreement">약관보기 </a>
                                        </div> 
                                        <!-- The Modal -->
										<div id="modal_1" class="modal">
										  <div class="modal-content">
										    <div class="modal-header">
										      <span class="close">&times;</span>
										      <h4>개인정보 수집 이용 동의</h4>
										    </div>
										    <div class="modal-body">
										      <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ab quod alias at perspiciatis consequatur cupiditate non veniam illo voluptatum ratione ex dolor inventore voluptas odit consequuntur a commodi quos sequi.</p>
										      
										    </div>
										    <div class="modal-footer">
										      <h3>확인</h3>
										    </div>
										  </div>
										</div>


										<div class="check_view">
                                            <label class="check_agree label_block">
                                                <input type="checkbox" id="private1" name="private1" value=""
                                                    required="" label="개인정보 수집·이용">
                                                <span class="ico"></span>개인정보 수집·이용 동의 <span class="sub">(필수)</span>
                                            </label>
                                            <a href="#none" class="link btn_link btn_essential">약관보기 </a>
                                        </div>

                                        <div class="check_view">
                                            <input type="hidden" id="consentHidden" name="consent[1]" value="">
                                            <label class=" check_agree label_block">
                                                <input type="checkbox" name="hiddenCheck" >
                                                <span class="ico"></span>개인정보 수집·이용 동의 <span class="sub">(선택)</span>
                                            </label>
                                            <a href="#none" class="link btn_link btn_choice">약관보기 </a>
                                        </div>
                                        <div class="check_view">
                                            <label class=" check_agree label_block">
                                                <input type="checkbox" value="n" name="fourteen_chk" required=""
                                                    label="만 14세 이상">
                                                <span class="ico"></span>본인은 만 14세 이상입니다. <span class="sub">(필수)</span>
                                            </label>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <div id="formSubmit" class="form_footer">
                            <button type="submit" class="btn active" id="join_btn" >가입하기</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
<script>

	$("#join_btn").click((e) => {
		const $password = $(password);
		const $passwordCheck = $(password2);
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
	});
	

	$(".id-btn").click((e) => {
		const type = "id";
		const id = $("#id").val();
		
		$.ajax({
			url: "${pageContext.request.contextPath}/join/checkDuplicate",
			data:{
				type: type,
				id: id
			},
			success(resp){
				console.log(resp);
				const {available} = resp;
				
				if(available){
					alert("이 아이디는 사용가능합니다.");
				}
				else{
					alert("이미 존재하는 아이디입니다.");
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
		
		$.ajax({
			url: "${pageContext.request.contextPath}/join/checkPhone,
			data:{
				type: type,
				phone: phone
			},
			success(resp){
				console.log(resp);
				const {available} = resp;
				
				if(available){
					alert("인증번호가 발송되었습니다.");
					$phoneCheck.show();
				}
				else{
					alert("이미 가입한 전화번호입니다.");
				}
			},
			error: console.log
		});
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
	$(detailAddress).blur((e) => {
		$(".addAddress").val($(address).val() + ' ' + $(detailAddress).val());
		console.log($(".addAddress").val());
	});
</script>
<script src="https://kit.fontawesome.com/4123702f4b.js" crossorigin="anonymous"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>