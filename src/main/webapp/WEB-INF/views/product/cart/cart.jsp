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
        .tit_page {
            overflow: hidden;
            width: 1050px;
            margin: 0 auto;
            padding: 50px 0 51px;
        }

        .tit_page h2.tit {
            font-weight: 700;
            font-size: 28px;
            color: #333;
            line-height: 35px;
            text-align: center;
            letter-spacing: -1px;
        }

        .only_pc#cartItemList {
            min-height: 545px;
        }

        .only_pc {
            width: 1050px;
            margin: 0 auto;
        }

        .only_pc .cart_item {
            float: left;
            width: 742px;
        }

        .cart_item.no_item {
            overflow: visible;
        }

        .only_pc .empty .cart_result,
        .only_pc .empty .cart_select {
            display: block;
        }

        .only_pc .cart_select {
            position: static;
            height: auto;
        }
        .only_pc .cart_select .inner_select {
    position: static;
    padding: 0 10px 0 2px;
    border-bottom: none;
}
.cart_select .inner_select {
    overflow: hidden;
    position: absolute;
    left: 0;
    top: 0;
    width: 100%;
    padding: 0 20px;
    border-bottom: 1px solid #ddd;
    background-color: #fff;
}
.only_pc .cart_delivery {
    padding: 23px 19px 20px;
    border: 1px solid #f2f2f2;
    border-bottom: 0;
}
.only_pc .amount_view {
    padding: 9px 18px 18px 20px;
    border: 1px solid #f2f2f2;
    background-color: #fafafa;
}
.only_pc .cart_result .inner_result {
    position: absolute;
    right: 0;
    width: 284px;
    background-color: #fff;
}

.only_pc .empty .inner_empty .txt {
    width: 100%;
    margin-top: 0;
    padding: 115px 0 116px;
    font-weight: 700;
    font-size: 16px;
    color: #333;
}
.only_pc .empty .inner_empty {
    border-top: 1px solid #333;
    border-bottom: 1px solid #f4f4f4;
}
.only_pc .empty .inner_empty .txt {
    width: 100%;
    margin-top: 0;
    padding: 115px 0 116px;
    font-weight: 700;
    font-size: 16px;
    color: #333;
}
.cart_main{
	position: relative;
}
    </style>
    <div class="tit_page">
        <h2 class="tit">장바구니</h2>
    </div>
    <div class="cart_main">
    	<form>
        <div id="cartItemList" class="only_pc" style="min-height: 562px;">
            <div class="empty">
                <div class="cart_item no_item">
                    <div class="cart_select">
                        <div class="inner_select"><label class="check"><input type="checkbox" name="checkAll"
                                    disabled="" checked=""><span class="ico"></span>전체선택 (0/0)</label><a href="#none"
                                class="btn_delete">선택삭제</a></div>
                    </div>
                    <div class="inner_empty"><span class="bg"></span>
                        <p class="txt">장바구니에 담긴 상품이 없습니다</p>
                        <div class="btn_submit"><button type="button" class="btn disabled">상품을 담아주세요</button></div>
                    </div>
                    <div class="cart_select">
                        <div class="inner_select"><label class="check"><input type="checkbox" name="checkAll"
                                    disabled="" checked=""><span class="ico"></span>전체선택 (0/0)</label><a href="#none"
                                class="btn_delete">선택삭제</a></div>
                    </div>
                </div>
                <div class="cart_result">
                    <div class="inner_result">
                        <div class="cart_delivery">
                            <h3 class="tit">배송지</h3>
                            <div class="no_address"><span class="emph">배송지를 입력</span>하고<br>배송유형을 확인해 보세요!<a href="#"
                                    class="btn default"><span class="ico"></span>주소 검색</a></div>
                        </div>
                        <div class="amount_view">
                            <dl class="amount">
                                <dt class="tit">상품금액</dt>
                                <dd class="price"><span class="num">0</span><span class="won">원</span></dd>
                            </dl>
                            <dl class="amount">
                                <dt class="tit">상품할인금액</dt>
                                <dd class="price"><span class="num">0</span><span class="won">원</span></dd>
                            </dl>
                            <dl class="amount">
                                <dt class="tit">배송비</dt>
                                <dd class="price"><span class="num">0</span><span class="won">원</span></dd>
                            </dl>
                            <dl class="amount lst">
                                <dt class="tit">결제예정금액</dt>
                                <dd class="price"><span class="num">0</span><span class="won">원</span></dd>
                            </dl>
                            <div class="reserve"></div>
                        </div>
                        <div class="btn_submit"><button type="submit" class="btn disabled">상품을 담아주세요</button></div>
                        <div class="notice"><span class="txt"><span class="ico">·</span>[배송준비중] 이전까지 주문 취소
                                가능합니다.</span><span class="txt"><span class="ico">·</span>[마이컬리 &gt; 주문내역 상세페이지] 에서 직접
                                취소하실 수 있습니다.</span></div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    </div>
    
    
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>