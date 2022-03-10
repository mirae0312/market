<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<title>${param.title}</title>
<meta charset="UTF-8">
<!-- 사용자css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/header.css" /> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/footer.css" /> 
<!-- 폰트어썸 -->
<script src="https://kit.fontawesome.com/cd5e4bcf92.js" crossorigin="anonymous"></script>
<!-- 제이쿼리 -->
<script 
src="https://code.jquery.com/jquery-3.6.0.min.js" 
integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" 
crossorigin="anonymous"></script>
</head>
<body>
  <!-- 전체 영역 -->
  <div class="wrapper">
    <!-- 이벤트 배너 -->
    <!-- 사이트 최초 방문시에만 보이도록 처리 -->
    <div class="join-event-bn">
      <p>지금 가입하고 인기 상품 <b>100원</b>에 받아가세요! </p>
      <i class="fas fa-times close-bn-icon"></i>
    </div>
    <!-- 헤더 -->
    <header id="header">
      <!-- 최상단 유저 메뉴 -->
      <div class="info-header">
        <div class="deliver-info">
          <p><span class="point-text">샛별·택배</span> 배송안내</p>
        </div>
        <div class="user-menu">
        <sec:authorize access="isAnonymous()">
        <!-- 비회원/비로그인 -->
          <ul>
            <li class="division-point-line"><a href="${pageContext.request.contextPath}/join/join"><span>회원가입</span></a></li>
            <li class="division-point-line"><a href="${pageContext.request.contextPath}/login/login"><span>로그인</span></a></li>
         </sec:authorize>
        <sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal" var="loginMember"/>
         <!-- 로그인 -->
		  <ul>
		    <li class="member-tab division-point-line">
		    	<span class="member-grade">등급</span>
		    	<span>${loginMember.name} 님</span><i class="fas fa-caret-down">
		    </i>
		  	 	<ul class="member-tab-sub">
		  		  <li><a href="#">주문 내역</a></li>
		  		  <li><a href="#">찜한 상품</a></li>
		  		  <li><a href="#">배송지 관리</a></li>
		  		  <li><a href="#">상품 후기</a></li>
		  		  <li><a href="#">상품 문의</a></li>
		  		  <li><a href="#">개인 정보 수정</a></li>
		  		  <li><a href="${pageContext.request.contextPath}/logout">로그아웃</a>
		  		  </li>
		  		</ul>
		    </li>
		 </sec:authorize>
            <li>
              <a href="#" class="service-tab"><span>고객센터</span><i class="fas fa-caret-down"></i></a>
                <ul class="service-tab-sub">
                  <li><a href="#">공지사항</a></li>
                  <li><a href="#">자주하는 질문</a></li>
                  <li><a href="#">1:1 문의</a></li>
                </ul>
            </li>
          </ul>
        </div>
      </div>
      <!-- 로고 -->
      <div class="mainLogo">
      <a href="${pageContext.request.contextPath}">
        <h1>마켓</h1>
      </a>
      </div>
   	</header>
    <!-- 카테고리 -->
    <nav class="category">
      <div class="product-category">
        <div class="proudct-category-list">
          <div><a href="#"><i class="fas fa-bars"></i><span>전체 카테고리</span></a></div>
          <div><a href="#"><span>신상품</span></a></div>
          <div><a href="#"><span>베스트</span></a></div>
          <div><a href="#"><span>알뜰쇼핑</span></a></div>
          <div><a href="#"><span>특가/혜택</span></a></div>
        </div>
        <!-- 검색창 -->
        <div class="searchKeyword">
          <form 
            action=""
            name="searchFrm">
            <input type="text" name="searchInput" id="searchInput" placeholder="검색어를 입력해주세요.">
            <button class="searchBtn" type="submit"><i class="fas fa-search"></i></button>
          </form>
        </div>
        <div class="personal-product-icon">
          <div class="icon location-icon">
            <i class="fas fa-map-marker-alt"></i>
          </div>
          <div class="location-alert">
          <sec:authorize access="isAnonymous()"> 
          <!-- 비회원/비로그인 -->
              <p><span class="point-text">배송지를 등록</span>하고<br>구매 가능한 상품을 확인하세요!</p>
              <div class="location-alert-btn">
                <div><button class="login-btn" onclick="location.href=`${pageContext.request.contextPath}/login/login`">로그인</button></div>
                <div><button class="search-address-btn"><i class="fas fa-search"></i>주소 검색</button></div>
              </div>
          </sec:authorize> 
          <sec:authorize access="isAuthenticated()">
		  <sec:authentication property="principal" var="loginMember"/>
          <!-- 로그인 -->
              <p><span class="point-text">여기 회원 주소지 나옴</span></p>
              <div class="location-alert-btn">
                <div><button class="address-change-btn">배송지 변경</button></div>
              </div>
          </sec:authorize>
          </div>
          <div class="icon"><a href="#"><i class="far fa-heart"></i></a></div>
          <div class="icon cart-icon"><a href="${pageContext.request.contextPath }/product/cart/myCart"><i class="fas fa-shopping-cart"></i></a></div>
        </div>
      </div>
    </nav>
<script src='${pageContext.request.contextPath}/resources/js/common/header.js'></script>

<!-- 페이지 영역 -->
<section class="contentWrapper">
<!-- footer에 </section>이랑 </div> 하나 추가해야됨~~ (페이지 영역 닫는 section태그랑 전체 wrap div 닫는 태그)-->