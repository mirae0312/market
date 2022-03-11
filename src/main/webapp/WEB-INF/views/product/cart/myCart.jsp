<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="장바구니" name="title"/>
</jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 화면</title>
</head>
<body>
<h1>장바구니</h1>
<input type="checkbox" name="checkBoxController" id="" checked/><label for="checkBoxController">전체 선택(<span id="checkBoxNoti"></span>)</label>
<input type="button" value="선택삭제" id="deleteMultiCart"/>
<table id="fTable">
	<thead>
		<tr>
			<th colspan="6"></th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${cartList }" var="product" >
			<c:if test="${product.TEM_CODE.equals('F') }">
				<tr>
					<td>
						<input type="checkbox" name="pdtChkBox" id="" data-check-val="${product.P_CODE }"/>
					</td>
					<td>
						<span>image</span>
					</td>
					<td>
						[${product.BRANDTITLE }]
						${product.TITLE }
					</td>
					<td>
						<input type="button" value="-" class="minusBtn" data-pdt-id="${product.P_CODE }"/>
						<input type="text" name="" id="${product.P_CODE }" value="${product.COUNT }"/>
						<input type="button" value="+" class="plusBtn" data-pdt-id="${product.P_CODE }"/>
					</td>
					<td>
						<c:if test="${product.DISCOUNT_RATE != null }">
							<span id="${product.P_CODE }_amount">
								<fmt:formatNumber type="number" pattern="#########" value="${Integer.parseInt(product.PRICE)/100 * (100 - Integer.parseInt(product.DISCOUNT_RATE)) * Integer.parseInt(product.COUNT)} "/>
								원
							</span>
							<br />
						</c:if>
						<span id="${product.P_CODE }_ogp">
							<fmt:formatNumber type="number" pattern="#########" value="${Integer.parseInt(product.PRICE) * Integer.parseInt(product.COUNT) }"/>
							원
						</span>
					</td>
					<td>
						<input type="button" value="x" class="deleteBtn" data-delete-code="${product.P_CODE }"/>
					</td>
				</tr>
			</c:if>
		</c:forEach>
	</tbody>
</table>

<table id="rTable">
	<thead>
		<tr>
			<th colspan="6"></th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${cartList }" var="product" >
			<c:if test="${product.TEM_CODE.equals('R') }">
				<tr>
					<td>
						<input type="checkbox" name="pdtChkBox" id="" data-check-val="${product.P_CODE }"/>
					</td>
					<td>
						<span>image</span>
					</td>
					<td>
						[${product.BRANDTITLE }]
						${product.TITLE }
					</td>
					<td>
						<input type="button" value="-" class="minusBtn" data-pdt-id="${product.P_CODE }"/>
						<input type="text" name="" id="${product.P_CODE }" value="${product.COUNT }"/>
						<input type="button" value="+" class="plusBtn" data-pdt-id="${product.P_CODE }"/>
					</td>
					<td>
						<c:if test="${product.DISCOUNT_RATE != null }">
							<span id="${product.P_CODE }_amount">
								<fmt:formatNumber type="number" pattern="#########" value="${Integer.parseInt(product.PRICE)/100 * (100 - Integer.parseInt(product.DISCOUNT_RATE)) * Integer.parseInt(product.COUNT)} "/>
								원
							</span>
							<br />
						</c:if>
						<span id="${product.P_CODE }_ogp">
							<fmt:formatNumber type="number" pattern="#########" value="${Integer.parseInt(product.PRICE) * Integer.parseInt(product.COUNT) }"/>
							원
						</span>
					</td>
					<td>
						<input type="button" value="x" class="deleteBtn" data-delete-code="${product.P_CODE }"/>
					</td>
				</tr>
			</c:if>
		</c:forEach>
	</tbody>
</table>

<table id="iTable">
	<thead>
		<tr>
			<th colspan="6"></th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${cartList }" var="product" varStatus="vs">
			<c:if test="${product.TEM_CODE.equals('I') }">
				<tr>
					<td>
						<input type="checkbox" name="pdtChkBox" id="" data-check-val="${product.P_CODE }"/>
					</td>
					<td>
						<span>image</span>
					</td>
					<td>
						[${product.BRANDTITLE }]
						${product.TITLE }
					</td>
					<td>
						<input type="button" value="-" class="minusBtn" data-pdt-id="${product.P_CODE }"/>
						<input type="text" name="" id="${product.P_CODE }" value="${product.COUNT }"/>
						<input type="button" value="+" class="plusBtn" data-pdt-id="${product.P_CODE }"/>
					</td>
					<td>
						<c:if test="${product.DISCOUNT_RATE != null }">
							<span id="${product.P_CODE }_amount">
								<fmt:formatNumber type="number" pattern="#########" value="${Integer.parseInt(product.PRICE)/100 * (100 - Integer.parseInt(product.DISCOUNT_RATE)) * Integer.parseInt(product.COUNT)} "/>
								원
							</span>
							<br />
						</c:if>
						<span id="${product.P_CODE }_ogp">
							<fmt:formatNumber type="number" pattern="#########" value="${Integer.parseInt(product.PRICE) * Integer.parseInt(product.COUNT) }"/>
							원
						</span>
					</td>
					<td>
						<input type="button" value="x" class="deleteBtn" data-delete-code="${product.P_CODE }"/>
					</td>
				</tr>
			</c:if>
		</c:forEach>
	</tbody>
</table>

<br /><br />
<span>배송지</span>
<br />
<span>
	<c:if test="${address != null }">	
		${address.ADDRESS },
		${address.DETAIL_ADDRESS }
	</c:if>	
	<c:if test="${address == null }">
		배송지를 입력하고<br />
		배송유형을 확인해 보세요!
	</c:if>
</span>
<br />
<span>
	${address.DELIVERY_TYPE }
</span>
<br />
	<sec:authorize access="isAuthenticated()">
		<input type="button" value="배송지 변경" id="changeAddress" />
	</sec:authorize>
	<sec:authorize access="isAnonymous()">
		<input type="button" value="주소 검색" id="searchAddress" />
	</sec:authorize>
<br /><br />

<span>상품금액</span>
<br />
<input type="text" name="" id="allAmount" value="${ogp }"/>
<br />
<span>상품할인금액</span>
<br />
<input type="text" name="" id="dcAmount" value="${dcp }"/>
<br />
<span>배송비</span>
<br />
<input type="text" name="" id="deliveryAmount" />
<br />
<span>결제예정금액</span>
<br />
<input type="text" name="" id="purchaseAmount" value="${ogp - dcp }"/>
<br />
<sec:authorize access="isAuthenticated()">
<span>구매 시 ${acp } 원 적립</span>
</sec:authorize>
<br /><br />
<c:if test="${cartList != null }">
<input type="button" value="주문하기" id="reqOrder" />
</c:if>
<c:if test="${cartList == null }">
<input type="button" value="상품을 담아주세요" disabled />
</c:if>

<script>
	
	$(() => {
		let bool = $("#fTable tbody").find('tr').length;
		let bool2 = $("#rTable tbody").find('tr').length;
		let bool3 = $("#iTable tbody").find('tr').length;
		
		if(bool != 0){
			$("#fTable thead th").append('냉동상품');
		}
		if(bool2 != 0){
			$("#rTable thead th").append('냉장상품');
		}
		if(bool3 != 0){
			$("#iTable thead th").append('상온상품');
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
					$("#allAmount").val(res.ogp);
					$("#dcAmount").val(res.dcp);
					$("#purchaseAmount").val(res.ogp - res.dcp);
				},
				error: console.log
			});					
		} else {
			$("#allAmount").val(0);
			$("#dcAmount").val(0);
			$("#purchaseAmount").val(0);
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

</body>
</html>