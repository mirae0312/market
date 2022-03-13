<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<fmt:requestEncoding value="utf-8" />
<meta charset="UTF-8">
<title>주소찾기</title>
<iframe frameborder="0" title="카카오 주소찾기"
	id="__daum__viewerFrame_1"
	src="http://postcode.map.daum.net/search?origin=http%3A%2F%2Flocalhost%3A10000&indaum=off&banner=on&ubl=on&mode=transmit&vt=popup&amr=on&amj=on&ani=off&sd=on&fi=on&fc=on&plrg=&plrgt=1.5&hmb=off&heb=off&asea=off&smh=off&zo=on&us=on&msi=10&ahs=off&whas=500&sm=on&a51=off&zn=Y&fullpath=%2Fmarket%2Fproduct%2Fcart%2FmyCart"
	style="border: 0 none; margin: 0; width: 100%; height: 70%; min-width: 300px; overflow: hidden; padding: 0"></iframe>
<div class="address_search" style="display: block;">
	<div class="layer_prev">
		<img
			src="https://res.kurly.com/mobile/service/common/1908/ico_prev_333_100x100.png"
			alt="" class="ico"><span class="tit">주소 재검색</span>
	</div>
</div>
<script src="https://kit.fontawesome.com/4123702f4b.js"
	crossorigin="anonymous"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
