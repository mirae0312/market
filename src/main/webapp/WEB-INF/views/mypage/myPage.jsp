<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="tarr4h main link" name="title"/>
</jsp:include>

	<h1>화면 구현 전 작업용 링크연결 페이지</h1>
	
	
	<p>회원 쿠폰 등록</p>
	<span>쿠폰입력란</span><input type="text" name="" id="writeCoupon" />
	<br />
	<span>쿠폰등록</span><input type="button" value="useCoupon" id="useCoupon"/>
	<br />
	
	<span>-----------------------------------------------</span>
	<br />
	<span>내 쿠폰</span>
	<br />
	

	
	<c:forEach var="list" items="${couponList }">
        <tr>
            <%-- 유효기간 남아있는 쿠폰들 --%>
        	<c:if test="${nowDate < list.expiration}">
	            <td><span>쿠폰 코드 </span>${list.code }</td>
	            <td><span>할인률 </span>${list.discountRate }%</td>
	            <td><span>만료일자 </span><fmt:formatDate value="${list.expiration}" pattern="yyyy/MM/dd일"/></td>
	            <br/>
            </c:if>
            
            <%-- 만료된 쿠폰들 --%>
           	<div style="color:gray">
	            <c:if test="${nowDate > list.expiration}"> 
		            <td><span>쿠폰 코드 </span>${list.code }</td>
		            <td><span>할인률 </span>${list.discountRate }%</td>
		            <td><span>만료일자 </span><fmt:formatDate value="${list.expiration}" pattern="yyyy/MM/dd일"/></td>
		            <td><span>만료된 쿠폰입니다. </span></td>
		            <br/>
	            </c:if>
         	</div>
        </tr>
    </c:forEach>
    
    <span>-----------------------------------------------</span>
    <p>개인 정보 수정</p>
    <span>아이디</span><input type="id" name="" id="" value="${userId}"/>
    <br />
    <span>비밀번호</span><input type="password" name="" id="changePw"/>
    <br /> 
    <input id="token" type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    <input type="button" value="확인" id="changePwBtn"/>
    
    <span>-----------------------------------------------</span>
    <div>Company Address</div>
    <input type="button" value="새 배송지 추가" id="" onclick="findAddr()"/>
    <br />
	<input id="member_post"  type="text" placeholder="Zip Code" readonly>
	<br />
	<input id="member_addr" type="text" placeholder="Address" readonly>
	<br />
	<input type="text" id="member_detail_addr" placeholder="Detailed Address" required>
    <input type="button" value="등록" id="addAddr"/>
    
    <span>-----------------------------------------------</span>
	<br />
	<span>내 배송지목록</span>
	<br />
	
	
	<c:forEach var="listaddr" items="${addressList }" varStatus="status">
        <tr>
         
        	<c:if test="${listaddr.defaultAddress eq'D'.charAt( 0)}">
        	   <div style="color:gray">
	           	<td><span>기본 배송지</span></td>
	           </div>
	           	<td>${listaddr.zipCode} ${listaddr.address} ${listaddr.detailAddress}</td>
	            <td>${listaddr.deliveryType }</td>
	            <td><a class="movetodetail" href="${pageContext.request.contextPath}/mypage/myPageDetail.do?no=${listaddr.no}" onclick="window.open(this.href, '_blank', 'width=1200,height=800,left=400,top=200,toolbars=no,scrollbars=no,'); return false;">버튼${listaddr.no}</a></td>
	           
	            <br/>
            </c:if>
   
	           <c:if test="${listaddr.defaultAddress eq 'X'.charAt(0)}">
		           <td>${listaddr.zipCode} ${listaddr.address} ${listaddr.detailAddress}</td>
	           	   <td>${listaddr.deliveryType }</td>
	           	   <td><input type="button" value="수정" class="updateAddr" onclick="countIndex(${status.index})" /></td>
	           	   
		            <br/>
	           </c:if>
         
        </tr>
    </c:forEach>
    <div id="my_modal">
    <span>모달창</span>
    <a class="modal_close_btn">닫기</a>
	</div>
    


<script>


$("#useCoupon").click((e) => {
		console.log("쿠폰 등록");
		$.ajax({
			url: '${pageContext.request.contextPath}/mypage/useCoupon',
			data : {
				writeCoupon: $("#writeCoupon").val()
			},
			success(res){
				if(res == 2){
					alert("쿠폰 등록 성공!");
					location.href='${pageContext.request.contextPath}/mypage/myPage';
				}
				else if(res == 1){
					alert("유효기간이 만료된 쿠폰입니다.");
				}
				else if(res == 0){
					alert("쿠폰 등록 실패!");
				}
			},
			error: console.log
		});
});

$("#changePwBtn").click((e) => {
	console.log("비밀번호 변경");
	const csrfHeader = "${_csrf.headerName}";
    const csrfToken = "${_csrf.token}";
    const headers = {};
    headers[csrfHeader] = csrfToken;
    const changePw = $("#changePw").val();
    
    if(! /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,15}$/.test(changePw)){
        alert("비밀번호는 숫자와 영문이 포함된 8~15자리입니다");
		$("#changePw").focus();
		return false;
    }
    
	$.ajax({
		url: '${pageContext.request.contextPath}/mypage/changePw',
		method: "POST",
		headers : headers,
		data : {
			changePw: $("#changePw").val()
		},
		success(res){
			if(res == 0){
				alert("비밀번호 변경 성공!");
				location.href='${pageContext.request.contextPath}/mypage/myPage';
			}
			
			
		},
		error: console.log
	});
});

function findAddr(){
	new daum.Postcode({
        oncomplete: function(data) {
        	
        	console.log(data);
        	
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var jibunAddr = data.jibunAddress; // 지번 주소 변수
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('member_post').value = data.zonecode;
            if(roadAddr !== ''){
                document.getElementById("member_addr").value = roadAddr;
            } 
            else if(jibunAddr !== ''){
                document.getElementById("member_addr").value = jibunAddr;
            }
        }
    }).open();
}

$("#addAddr").click((e) => {

	console.log("배송지 등록");
	var member_post_check = $("#member_post").val();
	if(member_post_check == ''){

		alert("새 배송지 추가 버튼을 먼저 눌러주세요!.");
	
	}
	else{
		
		$.ajax({
			url: '${pageContext.request.contextPath}/mypage/addAddr',
			data : {
				member_post: $("#member_post").val(),
				member_addr: $("#member_addr").val(),
				member_detail_addr: $("#member_detail_addr").val()
			},
			success(res){
				
				if(res == 1){
					alert("배송지 등록 성공!");
					location.href='${pageContext.request.contextPath}/mypage/myPage';
				}
				else if(res == 0){
					alert("배송지 등록 실패!");
				}
			
				
			},
			error: console.log
		});
		
	}
});


function countIndex(e){
	console.log(e);
	
}





</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</body>
</html>