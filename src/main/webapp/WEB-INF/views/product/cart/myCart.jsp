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
</style>
<div class="title">
   <h2>장바구니</h2>
</div>
<div class="mycart-container">
   <div class="mycart-wrapper">
   
      <!-- <input type="checkbox" name="checkBoxController" id="" /><label for="checkBoxController">전체 선택(<span id="checkBoxNoti"></span>)</label>
   <input type="button" value="선택삭제" id="deleteMultiCart"/> -->
      <div class="cart_select">
         <div class="inner_select">
            <label class="check"><input type="checkbox" name="checkAll" 
               onclick='selectAll(this)'><span class="ico"></span>전체선택 (<span id="checkBoxNoti"></span>)</label><a
               href="#none" class="btn_delete">선택삭제</a>
         </div>
      </div>
      <br />
      
      <div class="cart-list">
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
                           </c:if> 
                           <span id="${product.P_CODE }_ogp" class="original_price"> <fmt:formatNumber
                                 type="number" pattern="#########"
                                 value="${Integer.parseInt(product.PRICE) * Integer.parseInt(product.COUNT) }" />
                              원
                        </span>
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
                        <td><c:if test="${product.DISCOUNT_RATE != null }">
                              <span id="${product.P_CODE }_amount"> <fmt:formatNumber
                                    type="number" pattern="#########"
                                    value="${Integer.parseInt(product.PRICE)/100 * (100 - Integer.parseInt(product.DISCOUNT_RATE)) * Integer.parseInt(product.COUNT)} " />
                                 원
                              </span>
                              <br />
                           </c:if> <span id="${product.P_CODE }_ogp"> <fmt:formatNumber
                                 type="number" pattern="#########"
                                 value="${Integer.parseInt(product.PRICE) * Integer.parseInt(product.COUNT) }" />
                              원
                        </span></td>
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
                        <td><c:if test="${product.DISCOUNT_RATE != null }">
                              <span id="${product.P_CODE }_amount"> <fmt:formatNumber
                                    type="number" pattern="#########"
                                    value="${Integer.parseInt(product.PRICE)/100 * (100 - Integer.parseInt(product.DISCOUNT_RATE)) * Integer.parseInt(product.COUNT)} " />
                                 원
                              </span>
                              <br />
                           </c:if> <span id="${product.P_CODE }_ogp"> <fmt:formatNumber
                                 type="number" pattern="#########"
                                 value="${Integer.parseInt(product.PRICE) * Integer.parseInt(product.COUNT) }" />
                              원
                        </span></td>
                        <td><input type="button" value="" class="deleteBtn"
                           data-delete-code="${product.P_CODE }" /></td>
                     </tr>
                  </c:if>
               </c:forEach>
            </tbody>
         </table>
      
      </div>
   </div>
   <div class="address-wrapper">
      <span>배송지</span> <br /> <span> <!-- 배송지 있을때 --> <c:if
            test="${address != null }">   
         ${address.ADDRESS },
         ${address.DETAIL_ADDRESS }
      </c:if> <!-- 배송지 없을때 --> <c:if test="${address == null }">
         배송지를 입력하고<br />
         배송유형을 확인해 보세요!
      </c:if>
      </span> <br /> <span> <!-- 샛별배송~ --> ${address.DELIVERY_TYPE }
      </span> <br />
      <!-- 로그인했을때 => 배송지변경 -->
      <sec:authorize access="isAuthenticated()">
         <input type="button" value="배송지 변경" id="changeAddress" />
      </sec:authorize>
   
      <!-- 로그인 x => 주소검색 -->
      <sec:authorize access="isAnonymous()">
         <input type="button" value="주소 검색" id="searchAddress" />
      </sec:authorize>
      <br />
      <br />
   
      <!-- 담은 상품 있으면 총금액, 할인금액 등 계산해줌 -->
      <span>상품금액</span> <br />
      <!-- original price -->
      <input type="text" name="" id="allAmount" value="${ogp }" /> <br /> <span>상품할인금액</span>
      <br />
      <!-- discount price -->
      <input type="text" name="" id="dcAmount" value="${dcp }" /> <br /> <span>배송비</span>
      <br /> <input type="text" name="" id="deliveryAmount" /> <br /> <span>결제예정금액</span>
      <br />
      <!-- 최종결제 금액 original - discount price -->
      <input type="text" name="" id="purchaseAmount" value="${ogp - dcp }" />
      <br />
      <!-- 로그인했을시 적립 포인트  -->
      <sec:authorize access="isAuthenticated()">
         <span>구매 시 ${acp } 원 적립</span>
      </sec:authorize>
      <br />
      <br />
      <!-- cartList 있을 때 주문하기 버튼 -->
      <c:if test="${cartList != null }">
         <input type="button" value="주문하기" id="reqOrder" />
      </c:if>
      <!-- cartList 없으면 상품 담아주세요 -->
      <c:if test="${cartList == null }">
         <input type="button" value="상품을 담아주세요" disabled />
      </c:if>
   </div>

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
      
      console.log(pdtArr == '');
      
      if(pdtArr == ''){
         alert('선택된 상품이 없습니다. \n상품을 선택해 주세요.');
      } else{
         location.href = `${pageContext.request.contextPath}/purchase/orderPage?orderArr=\${pdtArr}`;
      }
      
      
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
   
   $("[name = pdtChkBox]").click((e) => {
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
      $.ajax({
         url : '${pageContext.request.contextPath}/product/cart/getPurchaseAmount',
         success(res){
            $("#allAmount").val(res.ogp);
            $("#dcAmount").val(res.dcp);
            $("#purchaseAmount").val(res.ogp - res.dcp);
         },
         error: console.log
      });      
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
   function checkSelectAll()  {
        // 전체 체크박스
        const checkboxes 
          = document.querySelectorAll('input[name="pdtChkBox"]');
        // 선택된 체크박스
        const checked 
          = document.querySelectorAll('input[name="pdtChkBox"]:checked');
        // select all 체크박스
        const selectAll 
          = document.querySelector('input[name="checkAll"]');
        
        if(checkboxes.length === checked.length)  {
          selectAll.checked = true;
        }else {
          selectAll.checked = false;
        }

      }
   function selectAll(selectAll)  {
        const checkboxes 
           = document.querySelectorAll('input[type="checkbox"]');
        
        checkboxes.forEach((checkbox) => {
          checkbox.checked = selectAll.checked
        })
   }
</script>
    
    
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>