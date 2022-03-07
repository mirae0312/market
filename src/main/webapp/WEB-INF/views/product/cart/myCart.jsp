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

<table id="fTable">
	<thead>
		<tr>
			<th colspan="6">냉동 상품</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${cartList }" var="product" >
			<c:if test="${product.TEM_CODE.equals('F') }">
				<tr>
					<td>
						<input type="checkbox" name="" id="" />
					</td>
					<td>
						<span>image</span>
					</td>
					<td>
						[${product.BRANDTITLE }]
						${product.TITLE }
					</td>
					<td>
						<input type="button" value="-" class="minusBtn" data-pdt-id="${product.P_CODE }" data-ogp="${product.PRICE }" data-dcr="${product.DISCOUNT_RATE }"/>
						<input type="text" name="" id="${product.P_CODE }" value="${product.COUNT }"/>
						<input type="button" value="+" class="plusBtn" data-pdt-id="${product.P_CODE }" data-ogp="${product.PRICE }" data-dcr="${product.DISCOUNT_RATE }"/>
					</td>
					<td>
						<span id="${product.P_CODE }_amount">
							<c:if test="${product.DISCOUNT_RATE != null }">
								<fmt:formatNumber type="number" pattern="#########" value="${Integer.parseInt(product.PRICE)/100 * (100 - Integer.parseInt(product.DISCOUNT_RATE)) * Integer.parseInt(product.COUNT)} "/>
								<br />
								정가 : ${Integer.parseInt(product.PRICE) * Integer.parseInt(product.COUNT) }
							</c:if>
							<c:if test="${product.DISCOUNT_RATE == null }">
								<fmt:formatNumber type="number" pattern="#########" value="${Integer.parseInt(product.PRICE) * Integer.parseInt(product.COUNT) }"/>
							</c:if>
						</span>
					</td>
					<td>
						<input type="button" value="x" class="deleteBtn" />
					</td>
				</tr>
			</c:if>
		</c:forEach>
	</tbody>
</table>

<table id=rTable">
	<thead>
		<tr>
			<th colspan="6">냉장 상품</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${cartList }" var="product" >
			<c:if test="${product.TEM_CODE.equals('R') }">
				<tr>
					<td>
						<input type="checkbox" name="" id="" />
					</td>
					<td>
						<span>image</span>
					</td>
					<td>
						[${product.BRANDTITLE }]
						${product.TITLE }
					</td>
					<td>
						<input type="button" value="-" class="minusBtn" data-pdt-id="${product.P_CODE }" data-ogp="${product.PRICE }" data-dcr="${product.DISCOUNT_RATE }"/>
						<input type="text" name="" id="${product.P_CODE }" value="${product.COUNT }"/>
						<input type="button" value="+" class="plusBtn" data-pdt-id="${product.P_CODE }" data-ogp="${product.PRICE }" data-dcr="${product.DISCOUNT_RATE }"/>
					</td>
					<td>
						<span id="${product.P_CODE }_amount">
							<c:if test="${product.DISCOUNT_RATE != null }">
								<fmt:formatNumber type="number" pattern="#########" value="${Integer.parseInt(product.PRICE)/100 * (100 - Integer.parseInt(product.DISCOUNT_RATE)) * Integer.parseInt(product.COUNT)} "/>
								<br />
								정가 : ${Integer.parseInt(product.PRICE) * Integer.parseInt(product.COUNT) }
							</c:if>
							<c:if test="${product.DISCOUNT_RATE == null }">
								<fmt:formatNumber type="number" pattern="#########" value="${Integer.parseInt(product.PRICE) * Integer.parseInt(product.COUNT) }"/>
							</c:if>
						</span>
					</td>
					<td>
						<input type="button" value="x" class="deleteBtn" />
					</td>
				</tr>
			</c:if>
		</c:forEach>
	</tbody>
</table>

<table id="iTable">
	<thead>
		<tr>
			<th colspan="6">상온 상품</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${cartList }" var="product" varStatus="vs">
			<c:if test="${product.TEM_CODE.equals('I') }">
				<tr>
					<td>
						<input type="checkbox" name="" id="" />
					</td>
					<td>
						<span>image</span>
					</td>
					<td>
						[${product.BRANDTITLE }]
						${product.TITLE }
					</td>
					<td>
						<input type="button" value="-" class="minusBtn" data-pdt-id="${product.P_CODE }" data-ogp="${product.PRICE }" data-dcr="${product.DISCOUNT_RATE }"/>
						<input type="text" name="" id="${product.P_CODE }" value="${product.COUNT }"/>
						<input type="button" value="+" class="plusBtn" data-pdt-id="${product.P_CODE }" data-ogp="${product.PRICE }" data-dcr="${product.DISCOUNT_RATE }"/>
					</td>
					<td>
						<span id="${product.P_CODE }_amount">
							<c:if test="${product.DISCOUNT_RATE != null }">
								<fmt:formatNumber type="number" pattern="#########" value="${Integer.parseInt(product.PRICE)/100 * (100 - Integer.parseInt(product.DISCOUNT_RATE))} "/>
								<br />
								정가 : ${Integer.parseInt(product.PRICE) * Integer.parseInt(product.COUNT) }
							</c:if>
							<c:if test="${product.DISCOUNT_RATE == null }">
								<fmt:formatNumber type="number" pattern="#########" value="${Integer.parseInt(product.PRICE) * Integer.parseInt(product.COUNT) }"/>
							</c:if>
						</span>
					</td>
					<td>
						<input type="button" value="x" class="deleteBtn" />
					</td>
				</tr>
			</c:if>
		</c:forEach>
	</tbody>
</table>

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
<span>결제예정금액</span>
<br />
<input type="text" name="" id="purchaseAmount" value="${ogp - dcp }"/>

<script>
	$(".minusBtn").click((e) => {
		let targetId = $(e.target).data('pdt-id');
		let targetVal = $(`#\${targetId}`).val();
	
		let changeCount = targetVal - 1;
		if(targetVal != 1){
			$(`#\${targetId}`).val(changeCount);
		};
		
		let ogp = $(e.target).data('ogp');
		let dcr = $(e.target).data('dcr');
		
		let changeAmount = (ogp/100) * (100 - dcr) * changeCount;
		let changeOgAmount = ogp * changeCount;
		
		let inputText = `
			\${changeAmount}
			<br/>
			정가 : \${changeOgAmount}
		`;
		
		if(targetVal != 1){
			if(dcr != ''){
				$(`#\${targetId}_amount`).text('');
				$(`#\${targetId}_amount`).append(inputText);						
			} else {
				$(`#\${targetId}_amount`).text('');
				$(`#\${targetId}_amount`).append(changeOgAmount);
			}		
		}
		
		let ogpVal = $("#allAmount").val();
		let dcpVal = $("#dcAmount").val();
		let pcsVal = $("#purchaseAmount").val();
		
		let changeDcVal = ogp - ((ogp/100) * (100 - dcr));
		
		if(targetVal != 1){
			$("#allAmount").val(ogpVal - ogp);
			$("#dcAmount").val(dcpVal - changeDcVal);			
			$("#purchaseAmount").val($("#allAmount").val() - $("#dcAmount").val());
		}
		
		
	});
	$(".plusBtn").click((e) => {
		let targetId = $(e.target).data('pdt-id');
		let targetVal = $(`#\${targetId}`).val() * 1;
		
		let changeCount = targetVal + 1;
		
		$(`#\${targetId}`).val(changeCount);		
		
		let ogp = $(e.target).data('ogp');
		let dcr = $(e.target).data('dcr');
		
		let changeAmount = (ogp/100) * (100 - dcr) * changeCount;
		let changeOgAmount = ogp * changeCount;
		
		let inputText = `
			\${changeAmount}
			<br/>
			정가 : \${changeOgAmount}
		`;
		
		if(dcr != ''){
			$(`#\${targetId}_amount`).text('');
			$(`#\${targetId}_amount`).append(inputText);						
		} else {
			$(`#\${targetId}_amount`).text('');
			$(`#\${targetId}_amount`).append(changeOgAmount);
		}
	
		
		let ogpVal = $("#allAmount").val() * 1;
		let dcpVal = $("#dcAmount").val() * 1;
		let pcsVal = $("#purchaseAmount").val() * 1;
		
		let changeDcVal = ogp - ((ogp/100) * (100 - dcr));
		
		$("#allAmount").val(ogpVal + ogp);
		$("#dcAmount").val(dcpVal + changeDcVal);			
		$("#purchaseAmount").val($("#allAmount").val() - $("#dcAmount").val());
		
	});

</script>

</body>
</html>