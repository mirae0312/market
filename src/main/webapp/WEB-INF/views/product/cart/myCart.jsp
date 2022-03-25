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
<style>
.title {
   overflow: hidden;
   width: 1050px;
   margin: 0 auto;
   padding: 50px 0 51px;
}

.title h2 {
   font-weight: 700;
   font-size: 28px;
   color: #333;
   line-height: 35px;
   text-align: center;
   letter-spacing: -1px;
}

/*사이드바 위치조절*/
.mycart-wrapper {
   float: left;
   width: 742px;
}

.address-wrapper {
   position: absolute;
   right: 0px;
   width: 284px;
   background-color: #fff;
}

/**/
.cart_select {
    position: static;
    height: auto;
}
.cart_select .inner_select {
    position: static;
    padding: 0 10px 0 2px;
    border-bottom: none;
}
.cart_select .check {
    padding: 18px 0 17px;
    font-weight: 700;
    font-size: 14px;
    letter-spacing: -.3px;
        float: left;
}
.cart_select .btn_delete:before {
    content: "";
    float: left;
    width: 1px;
    height: 14px;
    margin: 6px 21px 0 0;
    background-color: #ddd;
}
.cart_select .btn_delete {
    float: left;
    padding: 18px 0 17px 20px;
    font-weight: 700;
    line-height: 25px;
}
/*checkbox*/
input[type=checkbox] {
    position: absolute;
    z-index: -1;
    opacity: 0;
}
input[type=checkbox]:checked+.ico {
    background-image: url(https://res.kurly.com/mobile/service/common/2006/ico_checkbox_checked.svg);
    background-color: transparent;
    background-repeat: no-repeat;
    background-size: 24px 24px;
    background-position: 50% 50%;
}
input[type=radio]+.ico, input[type=checkbox]+.ico {
    display: inline-block;
    position: relative;
    width: 24px;
    height: 24px;
    margin-right: 12px;
    border: 0;
    background-image: url(https://res.kurly.com/mobile/service/common/2006/ico_checkbox.svg);
    background-color: transparent;
    background-repeat: no-repeat;
    background-size: 24px 24px;
    background-position: 50% 50%;
    vertical-align: -7px;
}
.cart_select .inner_select {
    position: static;
    padding: 0 10px 0 2px;
    border-bottom: none;
}
.cart-list{
clear: both;
}
#fTable th, #rTable th, #iTable th{
text-align: start;
    border-top: 1px solid #333;
    overflow: hidden;
    height: 60px;
    padding: 14px 5px 15px 0;
}
thead .ico{
float: left;
    width: 30px;
    height: 30px;
    margin: -3px 9px 0 0;
    background-color: transparent;
    background-repeat: no-repeat;
    background-size: 30px 30px;
    background-position: 50% 50%;
}
#fTable thead .ico{
    background-image: url(https://res.kurly.com/pc/service/cart/2007/ico_cold.svg);
}

#rTable thead .ico{
background-image: url(https://res.kurly.com/pc/service/cart/2007/ico_frozen.svg);
}

#iTable thead .ico{
    background-image: url(https://res.kurly.com/pc/service/cart/2009/ico_room_v2.svg?v=1);
}
.deleteBtn{
   right: 5px;
    top: 50%;
    width: 30px;
    height: 30px;
    padding: 0;
    margin-top: -13px;
    border: 0;
    background-image: url(https://res.kurly.com/pc/service/cart/2007/ico_delete.svg);
    background-color: transparent;
    background-repeat: no-repeat;
    background-size: 30px 30px;
    background-position: 50% 50%;
}
table{
width: 100%;
}
#reqOrder{
    border: 1px solid #5f0081;
    background-color: #5f0080;
    color: #fff;
    height: 56px;
    padding-bottom: 2px;
    line-height: 54px;
    border-radius: 6px;
    width: 100%;
    cursor: pointer;
}
.original_price{
padding-left: 6px;
    font-size: 14px;
    color: #999;
    line-height: 20px;
    word-break: break-all;
    text-decoration: line-through;
    vertical-align: 1px;
    display: block;
    padding-top: 4px;
    line-height: 24px;
    text-align: right;
}
.mycart-wrapper{
	margin-bottom: 200px;
}
#empty-txt{
	width: 100%;
    margin-top: 0;
    padding: 115px 0 116px;
    font-weight: 700;
    font-size: 16px;
    color: #333;
    text-align: center;
}
.address-container{
	display: block;
    position: relative;
    float: right;
}
#address-tit{
    padding-left: 24px;
    /* font-weight: 700; */
    font-size: 16px;
    line-height: 20px;
    letter-spacing: -.3px;
    background-image: url(https://res.kurly.com/pc/service/cart/2007/ico_location.svg);
    background-color: transparent;
    background-repeat: no-repeat;
    background-size: 20px 20px;
    background-position: 0 50%;
}
.cart-delivery{
    padding: 23px 19px 20px;
    border: 1px solid #f2f2f2;
    border-bottom: 0;
}
#searchAddress, #changeAddress{
    margin-top: 17px;
    display: block;
    width: 100%;
    height: 36px;
    font-weight: 700;
    font-size: 12px;
    line-height: 34px;
    border: 1px solid #5f0080;
    background-color: #fff;
    border-radius: 6px;
    color: #5f0080;
}
/*주소검색 ico*/
.address-ico{
display: inline-block;
    width: 21px;
    height: 20px;
    margin-left: -14px;
    background-image: url(https://res.kurly.com/pc/service/cart/2007/ico_search.svg);
    background-color: transparent;
    background-repeat: no-repeat;
    background-size: 21px 20px;
    background-position: 0 50%;
    vertical-align: -5px;
}
.amount-div{
    padding: 9px 18px 18px 20px;
    border: 1px solid #f2f2f2;
    background-color: #fafafa;
    font-size: 20px;
}
.amount-div span{
	float: left;
}
.amount-div input{
	width: 50%;
    float: right;
    text-align: right;
    border: none;
    background-color: #fafafa;
    font-size: 20px;
}
.amount-div input:focus{
	border: none;
	outline: none;
}
.point{
	margin-top: 20px;
	display: inline-block;
}
.point span{
	float: none;
}
.mycart-container{
    min-height: 600px;
}
</style>
<div class="title">
   <h2>장바구니</h2>
</div>
<div class="mycart-container">
   <div class="mycart-wrapper">
      <div class="cart_select">
         <div class="inner_select">
            <label class="check"><input type="checkbox" name="checkBoxController" checked><span class="ico"></span>전체선택 (<span id="checkBoxNoti"></span>)</label><a
               href="#none" class="btn_delete" id="deleteMultiCart">선택삭제</a>
         </div>
      </div>
      <br />
      
      <div class="cart-list">
      	 <c:if test="${empty cartList}">
	      	 <div class="empty-div">
	            <p id="empty-txt">장바구니에 담긴 상품이 없습니다.</p>      	 
	      	 </div>
         </c:if>
         <table id="fTable">
            <thead>
               <tr>
               </tr>
            </thead>
            <tbody>
               <c:forEach items="${cartList }" var="product">
                  <c:if test="${product.TEM_CODE.equals('F') }">
                     <tr>
                        <td>
                        <label class="check">
                        <input type="checkbox" name="pdtChkBox" id=""
                           data-check-val="${product.P_CODE }" />
                        <span class="ico"></span>
                        </label>   
                        </td>
                        <td><span>image</span></td>
                        <td>[${product.BRANDTITLE }] ${product.TITLE }</td>
                        <td>
                        
                              <input type="button" value="-" class="minusBtn"
                              data-pdt-id="${product.P_CODE }" /> 
                              <input type="text" name="pCount" class="pCount"
                              id="${product.P_CODE }" value="${product.COUNT }" /> 
                              <input type="button" value="+" class="plusBtn"
                              data-pdt-id="${product.P_CODE }" />
                        </td>
                        <td>
                        <!-- 할인율 있으면  -->
                       	 <c:if test="${product.DISCOUNT_RATE != null }">
                              <span id="${product.P_CODE }_amount" class="discount_price"> <fmt:formatNumber
                                    type="number" pattern="#########"
                                    value="${Integer.parseInt(product.PRICE)/100 * (100 - Integer.parseInt(product.DISCOUNT_RATE)) * Integer.parseInt(product.COUNT)} " />
                                 원
                              </span>
                              <br />
                               <span id="${product.P_CODE }_ogp" class="original_price"> <fmt:formatNumber
                                 type="number" pattern="#########"
                                 value="${Integer.parseInt(product.PRICE) * Integer.parseInt(product.COUNT) }" />
                              원
                       		</span>
                           </c:if> 
                           <c:if test="${product.DISCOUNT_RATE == null }">
                            <span id="${product.P_CODE }_ogp"> <fmt:formatNumber
                                 type="number" pattern="#########"
                                 value="${Integer.parseInt(product.PRICE) * Integer.parseInt(product.COUNT) }" />
                              원
                       		</span>
                           </c:if>
                          
                        </td>
                        <td><input type="button" value="" class="deleteBtn"
                           data-delete-code="${product.P_CODE }" /></td>
                     </tr>
                  </c:if>
               </c:forEach>
            </tbody>
         </table>
         <table id="rTable">
            <thead>
               <tr>
               </tr>
            </thead>
            <tbody>
               <c:forEach items="${cartList }" var="product">
                  <c:if test="${product.TEM_CODE.equals('R') }">
                     <tr>
                        <td>
                        <label class="check">
                        <input type="checkbox" name="pdtChkBox" id=""
                           data-check-val="${product.P_CODE }" />
                        <span class="ico"></span>
                        </label>   
                        </td>
                        <td><span>image</span></td>
                        <td>[${product.BRANDTITLE }] ${product.TITLE }</td>
                        <td><input type="button" value="-" class="minusBtn"
                           data-pdt-id="${product.P_CODE }" /> <input type="text" name=""
                           id="${product.P_CODE }" value="${product.COUNT }" /> <input
                           type="button" value="+" class="plusBtn"
                           data-pdt-id="${product.P_CODE }" /></td>
                        <td><!-- 할인율 있으면  -->
                       	 <c:if test="${product.DISCOUNT_RATE != null }">
                              <span id="${product.P_CODE }_amount" class="discount_price"> <fmt:formatNumber
                                    type="number" pattern="#########"
                                    value="${Integer.parseInt(product.PRICE)/100 * (100 - Integer.parseInt(product.DISCOUNT_RATE)) * Integer.parseInt(product.COUNT)} " />
                                 원
                              </span>
                              <br />
                               <span id="${product.P_CODE }_ogp" class="original_price"> <fmt:formatNumber
                                 type="number" pattern="#########"
                                 value="${Integer.parseInt(product.PRICE) * Integer.parseInt(product.COUNT) }" />
                              원
                       		</span>
                           </c:if> 
                           <c:if test="${product.DISCOUNT_RATE == null }">
                            <span id="${product.P_CODE }_ogp"> <fmt:formatNumber
                                 type="number" pattern="#########"
                                 value="${Integer.parseInt(product.PRICE) * Integer.parseInt(product.COUNT) }" />
                              원
                       		</span>
                           </c:if></td>
                        <td><input type="button" value="" class="deleteBtn"
                           data-delete-code="${product.P_CODE }" /></td>
                     </tr>
                  </c:if>
               </c:forEach>
            </tbody>
         </table>
      
         <table id="iTable">
            <thead>
               <tr>
               </tr>
            </thead>
            <tbody>
               <c:forEach items="${cartList }" var="product" varStatus="vs">
                  <c:if test="${product.TEM_CODE.equals('I') }">
                     <tr>
                        <td>
                        <label class="check">
                        <input type="checkbox" name="pdtChkBox" id=""
                           data-check-val="${product.P_CODE }" />
                        <span class="ico"></span>
                        </label>      
                        </td>
                        <td><span>image</span></td>
                        <td>[${product.BRANDTITLE }] ${product.TITLE }</td>
                        <td><input type="button" value="-" class="minusBtn"
                           data-pdt-id="${product.P_CODE }" /> <input type="text" name="pCount"
                           id="${product.P_CODE }" value="${product.COUNT }" /> <input
                           type="button" value="+" class="plusBtn"
                           data-pdt-id="${product.P_CODE }" /></td>
                        <td><!-- 할인율 있으면  -->
                       	 <c:if test="${product.DISCOUNT_RATE != null }">
                              <span id="${product.P_CODE }_amount" class="discount_price"> <fmt:formatNumber
                                    type="number" pattern="#########"
                                    value="${Integer.parseInt(product.PRICE)/100 * (100 - Integer.parseInt(product.DISCOUNT_RATE)) * Integer.parseInt(product.COUNT)} " />
                                 원
                              </span>
                              <br />
                               <span id="${product.P_CODE }_ogp" class="original_price"> <fmt:formatNumber
                                 type="number" pattern="#########"
                                 value="${Integer.parseInt(product.PRICE) * Integer.parseInt(product.COUNT) }" />
                              원
                       		</span>
                           </c:if> 
                           <c:if test="${product.DISCOUNT_RATE == null }">
                            <span id="${product.P_CODE }_ogp"> <fmt:formatNumber
                                 type="number" pattern="#########"
                                 value="${Integer.parseInt(product.PRICE) * Integer.parseInt(product.COUNT) }" />
                              원
                       		</span>
                           </c:if></td>
                        <td><input type="button" value="" class="deleteBtn"
                           data-delete-code="${product.P_CODE }" /></td>
                     </tr>
                  </c:if>
               </c:forEach>
            </tbody>
         </table>
      
      </div>
   </div>
   <div class="address-container">
	   <div class="address-wrapper">
	      <div class="cart-delivery"> 
	      <span id="address-tit">배송지</span> <br /> 
	      
	      <!-- 배송지 있을때 --> 
	      <c:if test="${address != null }">   
		      <div id="address">
		      ${address.ADDRESS }
		      </div>
		      <div id="detailAddress">
		      ${address.DETAIL_ADDRESS }
		      </div>
	      </c:if> 
	      <!-- 배송지 없을때 --> 
	      <c:if test="${address == null }">
	         <span style="color: #5f0080;">배송지를 입력</span>
	         하고<br />
	         배송유형을 확인해 보세요!
	      </c:if>
	      
	      <br /> <span> 
	      <!-- 샛별배송~ --> ${address.DELIVERY_TYPE }
	      </span> <br />
	      <!-- 로그인했을때 => 배송지변경 -->
	      <sec:authorize access="isAuthenticated()">
	      	<button type="button" id="changeAddress" onclick="popup()"><span class="address-ico"></span>배송지변경</button>
	      </sec:authorize>
	   
	      <!-- 로그인 x => 주소검색 -->
	      <sec:authorize access="isAnonymous()">
	      	<button type="button" id="searchAddress" onclick="popup()"><span class="address-ico"></span>주소 검색</button>
	      </sec:authorize>
	      <br />
	      <br />
	   </div> 
	      <!-- 담은 상품 있으면 총금액, 할인금액 등 계산해줌 -->
	      <div class="amount-div">
		      <span>상품금액</span>
		      <!-- original price -->
		      <input type="text" name="" id="allAmount" value="${ogp }원" readonly>
		       <br />
		      <span>상품할인금액</span>
		      <!-- discount price -->
		      <input type="text" name="" id="dcAmount" value="${dcp }원"  readonly/> <br /> 
		      <span>배송비</span>
		      <input type="text" name="" id="deliveryAmount" readonly /><br />
		      <span>결제예정금액</span>
		      <!-- 최종결제 금액 original - discount price -->
		      <input type="text" name="" id="purchaseAmount" value="${ogp - dcp }원"  readonly/>
		      <br />
		      <!-- 로그인했을시 적립 포인트  -->
		      <sec:authorize access="isAuthenticated()">
		      <div class="point">
		         <span>구매 시 <span id="accumulateAmount">${acp }</span> 원 적립</span>
		      </div>
		      </sec:authorize>
	      </div>
	      <br />
	      <br />
	      <!-- cartList 있을 때 주문하기 버튼 -->
	      <c:if test="${cartList != null }">
	         <input type="button" value="주문하기" id="reqOrder" />
	      </c:if>
	      <!-- cartList 없으면 상품 담아주세요 -->
	      <c:if test="${cartList == null }">
	         <input type="button" value="상품을 담아주세요" id="reqOrder" disabled />
	      </c:if>
	   </div>
	</div>
		<div class="test" style="clear: both;"></div>
</div>
<script>
	
	$(() => {
		let bool = $("#fTable tbody").find('tr').length;
		let bool2 = $("#rTable tbody").find('tr').length;
		let bool3 = $("#iTable tbody").find('tr').length;
		
		if(bool != 0){
			$("#fTable thead tr").append('<th colspan="6"></th>');
			$("#fTable thead th").append('냉동상품');
			$("#fTable thead th").append('<span class="ico"></span>');
		}
		if(bool2 != 0){
			$("#rTable thead tr").append('<th colspan="6"></th>');
	        $("#rTable thead th").append('냉장상품');
	        $("#rTable thead th").append('<span class="ico"></span>');
		}
		if(bool3 != 0){
			$("#iTable thead tr").append('<th colspan="6"></th>');
	        $("#iTable thead th").append('상온상품');
	        $("#iTable thead th").append('<span class="ico"></span>');
		}
		
		/* 체크박스 기본 선택 */
		$("[name = pdtChkBox]").prop('checked', true);
		
		countCheckBoxs();
	});
	
	/* 장바구니 삭제하기 */
	$(".deleteBtn").click((e) => {
		if(!confirm('삭제하시겠습니까?')){
			return false;
		}
		
		let pcode = []; 
		pcode.push($(e.target).data('delete-code'));
		
		deleteCart(pcode);
	});
	
	/* 다중삭제 */
	$("#deleteMultiCart").click((e) => {
		let deleteArr = [];
		$("[name = pdtChkBox]:checked").each(function(i, e) {
			deleteArr.push($(e).data('check-val'));
		});
		
		deleteCart(deleteArr);
	});
	
	/* 장바구니 삭제 ajax */
	function deleteCart(deleteArr){
		$.ajax({
			url : '${pageContext.request.contextPath}/product/cart/deleteCart?${_csrf.parameterName}=${_csrf.token}',
			data : {
				deleteArr
			},
			method : 'DELETE',
			success(res){
				if(res != 0){
					alert("삭제되었습니다.");
					location.reload();
				}
			},
			error: console.log
		})
	}
	/* 주문하기 클릭 시 */
	$("#reqOrder").click((e) => {
		const pdtArr = [];
		
		$("[name = pdtChkBox]:checked").each(function(i, e) {
			pdtArr.push($(e).data('check-val'));
		});
		
		if(pdtArr == ''){
			alert('선택된 상품이 없습니다. \n상품을 선택해 주세요.');
		} else{
			location.href = `${pageContext.request.contextPath}/purchase/orderPage?orderArr=\${pdtArr}`;
		};
	});
	
	/* 체크박스 전체선택 / 해제 */
	$("[name = checkBoxController]").change((e) => {
		if($(e.target).prop('checked') == true){
			$("[name = pdtChkBox]").prop('checked', true);
		} else {
			$("[name = pdtChkBox]").prop('checked', false);
		}
		
		countCheckBoxs();
	});
	
	/* 개별 체크박스 클릭 시 */
	$("[name = pdtChkBox]").click((e) => {
		/* 일부 상품 해제 시 전체 선택 체크 풀리게 */
		if($(e.target).prop('checked') == false){
			$("[name = checkBoxController]").prop('checked', false);
		}
		countCheckBoxs();
	});
	
	/* checkbox count */
	function countCheckBoxs(){
		let countBoxs = 0;
		$("[name = pdtChkBox]").each(function(i, e) {
			countBoxs += 1;
		});
		
		let checkedBoxs = 0;
		$("[name = pdtChkBox]:checked").each(function(i, e) {
			checkedBoxs += 1;
		});
		
		$("#checkBoxNoti").text(`\${checkedBoxs}/\${countBoxs}`);
		
		/* 체크박스 카운트 시 금액영역 변경 */
		getAmount();
	};
	
	
	/* 장바구니 - + 시 DB 반영 */
	function applyCartUpdate(pcode, count){
		$.ajax({
			url : '${pageContext.request.contextPath}/product/addCart?${_csrf.parameterName}=${_csrf.token}',
			method : 'POST',
			data : {
				pcode,
				count
			},
			success(res){
				if(res == 1){
					alert("변경되었습니다.");
					getProductAmount(pcode);
				} else {
					alert("변경되지 않았습니다.");
				}
			},
			complete(){
				getAmount()
			},
			error: console.log
		});
	};
	/* 전체 금액/할인금액 불러오는 함수 */
	function getAmount(){
		let checkedArr = [];
		$("[name = pdtChkBox]:checked").each(function(i, e) {
			checkedArr.push($(e).data('check-val'));
		});
		
		if(checkedArr.length != 0){
			$.ajax({
				url : '${pageContext.request.contextPath}/product/cart/getPurchaseAmount',
				data : {
					checkedArr
				},
				success(res){
					console.log(res.acp);
					$("#allAmount").val(res.ogp);
					$("#dcAmount").val(res.dcp);
					$("#purchaseAmount").val(res.ogp - res.dcp);
					$("#accumulateAmount").text(res.acp);
				},
				error: console.log
			});					
		} else {
			$("#allAmount").val(0);
			$("#dcAmount").val(0);
			$("#purchaseAmount").val(0);
			$("#accumulateAmount").text(0);
		}
	};
	
	/* 개별 상품 금액 불러오는 함수 */
	function getProductAmount(pcode){
		$.ajax({
			url : '${pageContext.request.contextPath}/product/cart/getProductAmount',
			data:{
				pcode
			},
			success(res){
				if(res.dcp != 0){
					$(`#\${pcode}_amount`).text(`\${res.dcp} 원`);
					$(`#\${pcode}_ogp`).text(`\${res.ogp} 원`);					
				} else {
					$(`#\${pcode}_ogp`).text(`\${res.ogp} 원`);
				}
			},
			error: console.log
		});
	};
	$(".minusBtn").click((e) => {
		let targetId = $(e.target).data('pdt-id');
		let targetVal = $(`#\${targetId}`).val();
	
		let changeCount = targetVal - 1;
		if(targetVal != 1){
			$(`#\${targetId}`).val(changeCount);
		};
		
		applyCartUpdate(targetId, -1);
	});
	$(".plusBtn").click((e) => {
		let targetId = $(e.target).data('pdt-id');
		let targetVal = $(`#\${targetId}`).val() * 1;
		
		let changeCount = targetVal + 1;
		
		$(`#\${targetId}`).val(changeCount);		
		
		applyCartUpdate(targetId, 1);
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
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />